//
//  JHWebSocketManager.h
//  003--WebSocket
//
//  Created by 王先生 on 2022/10/14.
//  Copyright © 2022 vampire. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JHWebSocketManagerDelegate <NSObject>
- (void)receiveMessageWithDic:(NSDictionary *)dic;
@end

typedef void(^JHWebSocketBlock)(NSDictionary *dic);

@interface JHWebSocketManager : NSObject
//代理
@property (nonatomic, weak) id<JHWebSocketManagerDelegate> delegate;
@property (nonatomic, copy) JHWebSocketBlock receiveBlock;
//服务器返回的client_id
@property (nonatomic, copy) NSString *client_id;
//是否绑定uid client_id
@property (nonatomic, copy) NSString *uid;
//是否绑定uid client_id
@property (nonatomic, assign) BOOL isBindUid;
+ (JHWebSocketManager *)shareInstance;
- (void)initWebSocket;
- (void)bindClienIdAndUid;
@end

NS_ASSUME_NONNULL_END
