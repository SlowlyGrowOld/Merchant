//
//  JHWebSocketManager.m
//  003--WebSocket
//
//  Created by 王先生 on 2022/10/14.
//  Copyright © 2022 vampire. All rights reserved.
//

#import "JHWebSocketManager.h"
#import "SocketRocket.h"
#import "NetworkManager+Message.h"

@interface JHWebSocketManager ()<SRWebSocketDelegate>

@property (strong, nonatomic) SRWebSocket *socket;
@property (strong, nonatomic) NSTimer *heatBeat;
@property (assign, nonatomic) NSTimeInterval reConnectTime;
@property (assign, nonatomic) BOOL isNetWork;
@end

@implementation JHWebSocketManager

static JHWebSocketManager *manager = nil;
+ (JHWebSocketManager *)shareInstance {
    static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [[JHWebSocketManager alloc] init];
        });
    return manager;
}

- (void)netWorkStateChange:(NSNotification *)notification
{
   self.isNetWork = [notification.object boolValue];
    
    if (self.isNetWork) {//有网络
        if (self.socket.readyState != SR_OPEN) {
            self.socket = nil;
            [self reConnect];
        }
    }else {//登陆失败加载登陆页面控制器
        [SVProgressHUD showInfoWithStatus:@"网络断开！"];
        [self destoryHeart];
    }
}

#pragma mark -- WebSocket

//初始化 WebSocket
- (void)initWebSocket{
    if (_socket) {
        return;
    }
    [[NSNotificationCenter defaultCenter] addObserver:manager
                                             selector:@selector(netWorkStateChange:)
                                                 name:KNotificationNetWorkStateChange
                                               object:nil];
    //Url
    NSURL *url = [NSURL URLWithString:[UserAccount sharedAccount].isOnline ?kWebSockerServer_ip:kDebugWebSockerServer_ip];
    //请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //初始化请求`
    _socket = [[SRWebSocket alloc] initWithURLRequest:request];
    //代理协议`
    _socket.delegate = self;
    // 实现这个 SRWebSocketDelegate 协议啊`
    //直接连接`
    [_socket open];    // open 就是直接连接了
}

//绑定cliend_id、uid  未登录请设置uid = @""; 防止切换账号未执行
- (void)bindClienIdAndUid {
    if (self.client_id.length>0 && [UserManager sharedUserManager].curUserInfo._id.length>0) {
        NSString *uid = [UserManager sharedUserManager].curUserInfo._id;
        DLog(@"用户ID：%@",uid);
        [NetworkManager bindWSSWithClient_id:self.client_id uid:uid success:^(NSString *message) {
            [JHWebSocketManager shareInstance].isBindUid = YES;
            self.uid = uid;
            DLog(@"绑定成功");
        } failure:^(NSString *message) {
            [JHWebSocketManager shareInstance].isBindUid = NO;
            self.uid = @"";
        }];
    }
}

#pragma mark -- SRWebSocketDelegate
//收到服务器消息是回调
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSDictionary *dic = [self dictionaryWithJsonString:message];
    if ([dic[@"msg_type"] isEqualToString:@"login"]) {
        self.client_id = dic[@"data"][@"client_id"];
        [self bindClienIdAndUid];
    }
    if ([self.delegate respondsToSelector:@selector(receiveMessageWithDic:)]) {
        [self.delegate receiveMessageWithDic:dic];
    }
    if (self.receiveBlock) {
        self.receiveBlock(dic);
    }
    DLog(@"收到服务器返回消息：%@",message);
}

//连接成功
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    DLog(@"连接成功，可以立刻登录你公司后台的服务器了，还有开启心跳");
    [self initHeart];
    
    
    if (self.socket != nil) {
        // 只有 SR_OPEN 开启状态才能调 send 方法啊，不然要崩
        if (_socket.readyState == SR_OPEN) {
            NSString *jsonString = @"{\"sid\": \"13b313a3-fea9-4e28-9e56-352458f7007f\"}";
            [_socket sendString:jsonString error:nil];   //发送数据包
            
        } else if (_socket.readyState == SR_CONNECTING) {
            DLog(@"正在连接中，重连后其他方法会去自动同步数据");
            // 每隔2秒检测一次 socket.readyState 状态，检测 10 次左右
            // 只要有一次状态是 SR_OPEN 的就调用 [ws.socket send:data] 发送数据
            // 如果 10 次都还是没连上的，那这个发送请求就丢失了，这种情况是服务器的问题了，小概率的
            // 代码有点长，我就写个逻辑在这里好了
            
        } else if (_socket.readyState == SR_CLOSING || _socket.readyState == SR_CLOSED) {
            // websocket 断开了，调用 reConnect 方法重连
        }
    } else {
        DLog(@"没网络，发送失败，一旦断网 socket 会被我设置 nil 的");
        DLog(@"其实最好是发送前判断一下网络状态比较好，我写的有点晦涩，socket==nil来表示断网");
    }
}


//连接失败的回调
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"连接失败，这里可以实现掉线自动重连，要注意以下几点");
    NSLog(@"1.判断当前网络环境，如果断网了就不要连了，等待网络到来，在发起重连");
    NSLog(@"2.判断调用层是否需要连接，例如用户都没在聊天界面，连接上去浪费流量");
    //关闭心跳包
    [webSocket close];
    
    [self reConnect];
}

//连接断开的回调
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"Close");
    [self reConnect];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload;
{
    NSLog(@"Pong");
}

#pragma mark -- Private Method
//保活机制  探测包
- (void)initHeart{
    __weak typeof(self) weakSelf = self;
    _heatBeat = [NSTimer scheduledTimerWithTimeInterval:30 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf.socket sendString:@"heart" error:nil];
        NSLog(@"已发送");
    }];
    [[NSRunLoop currentRunLoop] addTimer:_heatBeat forMode:NSRunLoopCommonModes];
}

//断开连接时销毁心跳
- (void)destoryHeart{
    [self.socket close];
    self.socket = nil;
    [self.heatBeat invalidate];
    self.heatBeat = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//重连机制
- (void)reConnect{
    //每隔一段时间重连一次
    //规定64不在重连,2的指数级
    BOOL isNet = [[NSUserDefaults standardUserDefaults] boolForKey:KNotificationNetWorkState];
    if (!isNet) {
        return;
    }
    if (self.socket.readyState == SR_OPEN) {
        return;
    }
    if (_reConnectTime > 60) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.socket = nil;
        [self initWebSocket];
    });
    
    if (_reConnectTime == 0) {
        _reConnectTime = 2;
    }else{
        _reConnectTime *= 2;
    }
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
