//
//  SRXMsgChatVC.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/20.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXMsgChatVC.h"
#import "SRXMsgChatTableView.h"
#import "SHMessageInputView.h"
#import "TZImagePickerController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "SRXMessage.h"
#import "JHWebSocketManager.h"
#import "NetworkManager+Common.h"
#import "NetworkManager+Message.h"
#import "SHFileHelper.h"
#import "SHMessageHelper.h"
#import "SHAudioPlayerHelper.h"
#import "JYBubbleMenuView.h"
#import "SRXChatCheckOrdersVC.h"
#import "SRXChatCouponListVC.h"
#import "SRXChatRecommentGoodsVC.h"
#import "SRXChatTransferServiceVC.h"
#import "SRXChatQuickReplyTableView.h"
#import "SRXChatUserInfoHeadView.h"
#import "SRXChatTagsListVC.h"

@interface SRXMsgChatVC ()<SHMessageInputViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,JHWebSocketManagerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *shop_image;
@property (weak, nonatomic) IBOutlet UILabel *shop_name;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;
@property (weak, nonatomic) IBOutlet SRXMsgChatTableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsTop;
//咨询商品弹窗
@property (weak, nonatomic) IBOutlet UIView *goodConsultView;
@property (weak, nonatomic) IBOutlet UILabel *c_titleLb;
@property (weak, nonatomic) IBOutlet UIImageView *c_good_image;
@property (weak, nonatomic) IBOutlet UILabel *c_good_name;
@property (weak, nonatomic) IBOutlet UILabel *c_good_price;
@property (weak, nonatomic) IBOutlet UIButton *c_sendBtn;
@property (weak, nonatomic) IBOutlet UILabel *c_goods_num;
//底部按钮视图
@property (weak, nonatomic) IBOutlet UIView *bottom_btns;
@property (weak, nonatomic) IBOutlet UIButton *nav_tags;
@property (weak, nonatomic) IBOutlet UIButton *nav_orders;
//快捷回复
@property (weak, nonatomic) IBOutlet SRXChatQuickReplyTableView *replyTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ReplyTableViewConsH;

@property (nonatomic, strong) SRXChatUserInfoHeadView *headView;

//下方工具栏
@property (nonatomic, strong) SHMessageInputView *chatInputView;
@property (nonatomic, strong) NSMutableArray *dataSources;
@property (nonatomic, assign) NSUInteger pageNo;
@property (nonatomic, assign) NSUInteger pageSize;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, assign) BOOL loadMore;

@property (nonatomic, copy) NSString *chat_id;
//发送引用文本所需chat_id
@property (nonatomic, copy) NSString *text_chat_id;
//转接其他客服后禁止发送消息
@property (nonatomic, assign) BOOL isTransfer;
@end

@implementation SRXMsgChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.isHidenNaviBar = YES;
    self.view.backgroundColor = CViewBgColor;
    self.tableViewConsH.constant = kScreenHeight - TopHeight - 48 - BottomSafeHeight - 36 - 73;
    self.pageNo = 1;
    self.pageSize = 15;
    [self setMj_header];
    
    self.shop_name.text = self.item.nickname;
    [self.shop_image sd_setImageWithURL:[NSURL URLWithString:self.item.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    
    if (self.orderInfo) {
        self.c_titleLb.text = @"您想咨询该订单";
        [self.c_sendBtn setTitle:@"发送订单" forState:UIControlStateNormal];
        self.goodInfo = self.orderInfo.goods_info.firstObject;
        if (self.orderInfo.goods_info.count>1) {
            self.c_goods_num.hidden = YES;
            self.c_goods_num.text = [NSString stringWithFormat:@"共%zd件",self.orderInfo.goods_info.count];
        }
        
    }
    if (self.goodInfo) {
        self.goodConsultView.hidden = NO;
        self.c_good_name.text = self.goodInfo.goods_name;
        if (self.goodInfo.price) {
            self.c_good_price.attributedText = [NSMutableAttributedString setPriceText:self.goodInfo.price frontFont:12 behindFont:10 textColor:UIColor.redColor];
        }
        [self.c_good_image sd_setImageWithURL:[NSURL URLWithString:self.goodInfo.image]];

    }else {
        self.goodConsultView.hidden = YES;
    }
    
    [self requestTableData];
    
    //添加下方输入框
    [self.view addSubview:self.chatInputView];
    self.tableView.delegate = self;
    
    MJWeakSelf;
    self.replyTableView.selectBlock = ^(SRXMsgReplysItem * _Nonnull item) {
        weakSelf.replyTableView.superview.hidden = YES;
    };
    
    [JHWebSocketManager shareInstance].delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendFailToResendMsg:) name:KNotificationMsgSendFail object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatTextMenuAction:) name:KNotiChatTextMenuAction object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickTableViewAction) name:@"JKTextViewHideTextSelection" object:nil];
    [[JHWebSocketManager shareInstance] initWebSocket];
    
    [self requestOtherData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if ([[SHAudioPlayerHelper shareInstance] isPlaying]) {
        [[SHAudioPlayerHelper shareInstance] deallocAudio];
    }
    [JYBubbleMenuView.shareMenuView removeFromSuperview];
}

- (void)sendFailToResendMsg:(NSNotification *)noti {
    DLog(@"%@",noti.userInfo);
    SRXMsgChatModel *model = noti.userInfo[@"info"];
    [self againSendMessageWith:model];
}

- (void)chatTextMenuAction:(NSNotification *)noti {
    DLog(@"%@",noti.userInfo);
    NSDictionary *dic = noti.userInfo;
    self.text_chat_id = [NSString stringWithFormat:@"%@",dic[@"id"]];
    NSString *text_type = dic[@"type"];
    NSString *text_content = dic[@"content"];
    if ([text_type isEqualToString:@"quote"]) {
        _chatInputView.quoteText = text_content;
    }else if ([text_type isEqualToString:@"delete"]) {
        [self deleteTextModel];
    }
}

- (void)deleteTextModel {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除该条消息？" preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NetworkManager sharedClient] getWithURLString:@"v2/user_chat_del" parameters:@{@"chat_id":self.text_chat_id} isNeedSVP:NO success:^(NSDictionary *messageDic) {
            for (SRXMsgChatModel *model in self.dataSources) {
                if (model._id.integerValue == self.text_chat_id.integerValue) {
                    [self.dataSources removeObject:model];
                    break;
                }
            }
            self.tableView.datas = self.dataSources.copy;
        } failure:^(NSString *error) {
            
        }];
    }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
    }]];
    [[UIViewController jk_currentViewController] presentViewController:alertC animated:YES completion:nil];
}

#pragma mark - UIButton event
- (void)clickTableViewAction {
    if (!self.replyTableView.superview.isHidden) {
        self.replyTableView.superview.hidden = YES;
        return;
    }
}

- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tagsListBtnClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    SRXChatTagsListVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXChatTagsListVC"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)orderListBtnClick:(id)sender {
    SRXChatCheckOrdersVC *vc = [[SRXChatCheckOrdersVC alloc] init];
    vc.user_id = self.item.user_id;
    MJWeakSelf;
    vc.selectBlock = ^(SRXOrderListModel * _Nonnull model) {
        [weakSelf sendChatMessageWithOrder:model];
    };
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (IBAction)closeGoodConsultViewBtnClick:(id)sender {
//    self.goodConsultView.hidden = YES;
}

- (IBAction)sendGoodInfoBtnClick:(id)sender {
//    self.goodConsultView.hidden = YES;
//    if (self.orderInfo) {
//        [self sendChatMessageWithOrder:self.orderInfo];
//    }else {
//        [self sendChatMessageWithGoods];
//    }
}

- (IBAction)quickReplyBtnClick:(id)sender {
    self.chatInputView.inputType = SHInputViewType_default;
    if (!self.replyTableView.superview.isHidden) {
        self.replyTableView.superview.hidden = YES;
        return;
    }
    if (self.replyTableView.datas.count>0) {
        self.replyTableView.superview.hidden = NO;
        if (self.replyTableView.datas.count*36 > self.tableView.jk_height) {
            self.ReplyTableViewConsH.constant = self.tableView.jk_height;
        } else {
            self.ReplyTableViewConsH.constant = self.replyTableView.datas.count*36;
        }
    }
    [NetworkManager getQuickReplyWithShop_id:@"" success:^(NSArray *modelList) {
        if (modelList.count>0) {
            self.replyTableView.superview.hidden = NO;
            self.replyTableView.datas = modelList;
            if (modelList.count*36 > self.tableView.jk_height) {
                self.ReplyTableViewConsH.constant = self.tableView.jk_height;
            } else {
                self.ReplyTableViewConsH.constant = modelList.count*36;
            }
        }
    } failure:^(NSString *message) {
        
    }];
}

- (IBAction)InviteEvaluationBtnClick:(id)sender {
    if (!self.replyTableView.superview.isHidden) {
        self.replyTableView.superview.hidden = YES;
    }
    self.chatInputView.inputType = SHInputViewType_default;
    [self sendChatMessageWithEvaluate];
}

- (IBAction)transferBtnClick:(id)sender {
    if (!self.replyTableView.superview.isHidden) {
        self.replyTableView.superview.hidden = YES;
    }
    self.chatInputView.inputType = SHInputViewType_default;
    SRXChatTransferServiceVC *vc = [[SRXChatTransferServiceVC alloc] init];
    MJWeakSelf;
    vc.serviceBlock = ^(SRXMsgChatServiceItem * _Nonnull item) {
        [NetworkManager transferChatServiceWithUser_id:[UserManager sharedUserManager].curUserInfo._id shop_user_id:item.shop_user_id shop_id:self.shop_id success:^(NSString *message) {
            [weakSelf sendChatMessageWithTransfer:item];
        } failure:^(NSString *message) {
            
        }];
    };
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)recommendGoodsBtnClick:(id)sender {
    if (!self.replyTableView.superview.isHidden) {
        self.replyTableView.superview.hidden = YES;
    }
    self.chatInputView.inputType = SHInputViewType_default;
    SRXChatRecommentGoodsVC *vc = [SRXChatRecommentGoodsVC new];
    vc.shop_id = self.shop_id;
    MJWeakSelf;
    vc.clickBlock = ^(SRXMsgGoodsInfoItem * _Nonnull goods, BOOL isSendGoods) {
        if (isSendGoods) {
            [weakSelf sendChatMessageWithGoods:goods];
        } else {
            [weakSelf sendChatMessageWithCoupon:goods.coupon];
        }
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - requestTableData
- (void)requestTableData {
    [NetworkManager getChatContentWithUser_id:self.item.user_id shop_id:self.shop_id page:self.pageNo pageSize:self.pageSize success:^(NSArray *modelList) {
        [self requestTableDataSuccessWithArray:modelList];
        if (self.dataSources.count>0) {
           SRXMsgChatModel *model = self.dataSources.lastObject;
           self.isTransfer = [model.msg_type isEqualToString:@"transfer"]?YES:NO;
        }
    } failure:^(NSString *message) {
        [self requestTableDataFailed];
    }];
}

- (void)setIsTransfer:(BOOL)isTransfer {
    if (self.isTransfer == isTransfer) {
        return;
    }
    _isTransfer = isTransfer;
    self.bottom_btns.hidden = self.isTransfer;
    self.chatInputView.isDisenable = self.isTransfer;
    self.nav_tags.hidden = self.isTransfer;
    self.nav_orders.hidden = self.isTransfer;
}

- (NSMutableArray *)dataSources{
    
    if (_dataSources == nil) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}

- (SRXChatUserInfoHeadView *)headView {
    if(!_headView) {
        _headView = [[NSBundle mainBundle] loadNibNamed:@"SRXChatUserInfoHeadView" owner:nil options:nil].firstObject;
    }
    _headView.user_id = self.item.user_id;
    MJWeakSelf;
    _headView.refreshBlock = ^{
        weakSelf.headView.frame = CGRectMake(0, TopHeight, kScreenWidth, 44);
        weakSelf.tableViewConsTop.constant = 44;
        weakSelf.tableViewConsH.constant = kScreenHeight - TopHeight - 48 - BottomSafeHeight - 36 - 44;
    };
    return _headView;
}

- (void)requestOtherData {
    [NetworkManager getChatOtherWithUser_id:self.item.user_id shop_id:self.shop_id success:^(SRXMsgChatOther * _Nonnull other) {
        if (other.user_labels.count==0) {
            self.headView.frame = CGRectMake(0, TopHeight, kScreenWidth, 44);
            self.tableViewConsTop.constant = 44;
            self.tableViewConsH.constant = kScreenHeight - TopHeight - 48 - BottomSafeHeight - 36 - 44;
        } else {
            self.headView.frame = CGRectMake(0, TopHeight, kScreenWidth, 76);
            self.tableViewConsTop.constant = 76;
            self.tableViewConsH.constant = kScreenHeight - TopHeight - 48 - BottomSafeHeight - 36 - 76;
        }
        self.headView.other = other;
        [self.view addSubview:self.headView];
    } failure:^(NSString *message) {
        self.tableViewConsH.constant = kScreenHeight - TopHeight - 48 - BottomSafeHeight - 36;
    }];
}

#pragma mark 滚动最下方
- (void)tableViewScrollToBottom {
    if (self.dataSources.count>1) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.dataSources.count*2-1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

#pragma mark 发送文本  SHMessageInputViewDelegate
- (void)chatMessageWithSendText:(NSString *)text {
    
    SRXMsgChatModel *message = [[SRXMsgChatModel alloc] init];
    
    message.msg_type = @"text";
    message.content = text;
    if (_chatInputView.quoteText.length>0) {
        message.reference_chat_id = self.text_chat_id;
        message.reference_chat_content = _chatInputView.quoteText;
        SRXMsgReferenceInfo *info = [SRXMsgReferenceInfo new];
        info.reference_chat_id = self.text_chat_id;
        info.reference_chat_content = _chatInputView.quoteText;
        message.reference_info = info;
    }
    message.messageKey = [SHMessageHelper getTimeWithZone];
    //添加到聊天界面
    [self addChatMessageWithMessage:message isBottom:YES];
}

#pragma mark 发送音频   SHMessageInputViewDelegate
- (void)chatMessageWithSendAudio:(NSString *)audioName duration:(NSInteger)duration {
    SRXMsgChatModel *message = [SRXMsgChatModel new];

    message.msg_type = @"voice";
    message.voice = audioName;
    message.duration = @(duration).stringValue;
    message.messageKey = [SHMessageHelper getTimeWithZone];
    //添加到聊天界面
    [self addChatMessageWithMessage:message isBottom:YES];
}

#pragma mark 发送图片
- (void)sendMessageWithImage:(UIImage *)image {
    SRXMsgChatModel *message = [SRXMsgChatModel new];
    
    message.msg_type = @"image";
    message.image = image;
    message.messageKey = [SHMessageHelper getTimeWithZone];
    //添加到聊天界面
    [self addChatMessageWithMessage:message isBottom:YES];
}

#pragma mark 发送商品
- (void)sendChatMessageWithGoods:(SRXMsgGoodsInfoItem *)goods {
    SRXMsgChatModel *message = [SRXMsgChatModel new];

    message.msg_type = @"goods_link";
    message.params = goods.goods_id;
    message.goods_info = goods;
    message.messageKey = [SHMessageHelper getTimeWithZone];
    //添加到聊天界面
    [self addChatMessageWithMessage:message isBottom:YES];
}

#pragma mark 发送优惠券
- (void)sendChatMessageWithCoupon:(SRXMsgChatCoupnItem *)coupon {
    SRXMsgChatModel *message = [SRXMsgChatModel new];

    message.msg_type = @"coupon";
    message.params = coupon.coupon_id;
    message.coupon_info = coupon;
    message.messageKey = [SHMessageHelper getTimeWithZone];
    //添加到聊天界面
    [self addChatMessageWithMessage:message isBottom:YES];
}

#pragma mark 发送邀请评价
- (void)sendChatMessageWithEvaluate {
    SRXMsgChatModel *message = [SRXMsgChatModel new];

    message.msg_type = @"invite_evaluate";
    message.messageKey = [SHMessageHelper getTimeWithZone];
    //添加到聊天界面
    [self addChatMessageWithMessage:message isBottom:YES];
}

#pragma mark 发送转接客服
- (void)sendChatMessageWithTransfer:(SRXMsgChatServiceItem *)service {
    SRXMsgChatModel *message = [SRXMsgChatModel new];

    message.msg_type = @"transfer";
    message.params = service.shop_user_id;
    message.transfer_info = service;
    message.messageKey = [SHMessageHelper getTimeWithZone];
    //添加到聊天界面
    [self addChatMessageWithMessage:message isBottom:YES];
}

#pragma mark 发送我的订单
- (void)sendChatMessageWithOrder:(SRXOrderListModel *)order {
    SRXMsgChatModel *message = [SRXMsgChatModel new];

    message.msg_type = @"user_order";
    message.params = order.order_id;
    SRXMsgOrderInfo *orderinfo = [SRXMsgOrderInfo new];
    orderinfo.order_id = order.order_id;
    orderinfo.pay_amount = @(order.pay_amount).stringValue;
    NSMutableArray *marr = [NSMutableArray array];
    for (SRXOrderGoodsItem *item in order.order_goods) {
        SRXMsgGoodsInfoItem *goods = [SRXMsgGoodsInfoItem new];
        goods.spec_key_name = item.spec_key_name;
        goods.goods_name = item.goods_name;
        goods.goods_id = item.goods_id;
        goods.image = item.image;
        [marr addObject:goods];
    }
    orderinfo.goods_info = marr.copy;
    message.order_info = orderinfo;
    message.messageKey = [SHMessageHelper getTimeWithZone];

    //添加到聊天界面
    [self addChatMessageWithMessage:message isBottom:YES];
}

#pragma mark 添加到下方聊天界面  
- (void)addChatMessageWithMessage:(SRXMsgChatModel *)message isBottom:(BOOL)isBottom {
    message.who_send = @"shop";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    message.send_time = [dateFormatter stringFromDate:[NSDate date]];
    message.user_id = self.item.user_id;
    message.avatar = [UserManager sharedUserManager].curUserInfo.avatar;
    message.nickname = [UserManager sharedUserManager].curUserInfo.nickname;
    message.messageState = SRXSendMessageType_Sending;
    [self.dataSources addObject:message];
    self.tableView.datas = self.dataSources.copy;
    [self.tableView reloadData];
    [self tableViewScrollToBottom];
    [self dealSendMessage:message];
}

- (void)dealSendMessage:(SRXMsgChatModel *)message {
    if ([message.msg_type isEqualToString:@"image"]) {
        [NetworkManager commonUploadsImages:@[message.image] isNeedHUD:NO success:^(NSDictionary * _Nonnull messageDic) {
            message.params = messageDic[@"data"];
            [self sendDataToServiceWithMessage:message];
        } failure:^(NSString * _Nonnull error) {
            message.messageState = SRXSendMessageType_Failed;
            [self.tableView reloadData];
        }];
    }else if ([message.msg_type isEqualToString:@"voice"]) {
        NSString *aacFile = [SHFileHelper getFilePathWithName:message.voice type:SHMessageFileType_aac];
        NSData *data = [NSData dataWithContentsOfFile:aacFile];
        [NetworkManager commonUploadsVideo:data type:2 isNeedHUD:NO success:^(NSDictionary * _Nonnull messageDic) {
            DLog(@"url:%@",messageDic);
            message.params = messageDic[@"data"];
            [self sendDataToServiceWithMessage:message];
        } failure:^(NSString * _Nonnull error) {
            message.messageState = SRXSendMessageType_Failed;
            [self.tableView reloadData];
        }];
    }else {
        [self sendDataToServiceWithMessage:message];
    }
}

#pragma mark 发送消息到服务器
- (void)sendDataToServiceWithMessage:(SRXMsgChatModel *)model {
    
    NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
    dicM[@"user_id"] = model.user_id;
    dicM[@"msg_type"] = model.msg_type;
    dicM[@"params"] = model.params;
    dicM[@"content"] = model.content;
    dicM[@"duration"] = model.duration;
    if ([model.msg_type isEqualToString:@"text"] && model.reference_chat_content.length>0) {
        dicM[@"reference_chat_id"] = model.reference_chat_id;
        dicM[@"reference_chat_content"] = model.reference_chat_content;
    }
    [NetworkManager sentChatMsgWithParameters:dicM.copy shop_id:self.shop_id success:^(NSString *message) {
        model.messageState = SRXSendMessageType_Successed;
        model._id = message;
        [self.tableView reloadData];
    } failure:^(NSString *message) {
        model.messageState = SRXSendMessageType_Failed;
        [self.tableView reloadData];
    }];
}

#pragma mark 发送失败重新发送
- (void)againSendMessageWith:(SRXMsgChatModel *)message {
    for (SRXMsgChatModel *model in self.dataSources) {
        if ([model.messageKey isEqualToString:message.messageKey]) {
            [self.dataSources removeObject:model];
            break;
        }
    }
    [self.dataSources addObject:message];
    self.tableView.datas = self.dataSources.copy;
    [self.tableView reloadData];
    [self tableViewScrollToBottom];
    [self dealSendMessage:message];
}

#pragma mark 收到消息  JHWebSocketManagerDelegate
- (void)receiveMessageWithDic:(NSDictionary *)dic {
    if ([dic[@"msg_type"] isEqualToString:@"login"]) {
        NSString *client_id = dic[@"data"][@"client_id"];
        NSString *uid = [UserManager sharedUserManager].curUserInfo._id;
        DLog(@"用户ID：%@",uid);
        [NetworkManager bindWSSWithClient_id:client_id uid:uid success:^(NSString *message) {
            [JHWebSocketManager shareInstance].isBindUid = YES;
            DLog(@"绑定成功");
        } failure:^(NSString *message) {
            [JHWebSocketManager shareInstance].isBindUid = NO;
        }];
    }else {
        SRXMsgChatModel *message = [SRXMsgChatModel receiveMessageWithDic:dic];
        if ([message.user_id isEqualToString:self.item.user_id] && [self.shop_id isEqualToString:message.shop_id]) {
            self.isTransfer = [message.msg_type isEqualToString:@"transfer"]?YES:NO;
            [self.dataSources addObject:message];
            self.tableView.datas = self.dataSources.copy;
            [self.tableView reloadData];
            [self tableViewScrollToBottom];
        }
    }
}

#pragma mark 工具栏高度改变  SHMessageInputViewDelegate
- (void)toolbarHeightChange {
    //改变聊天界面高度
    self.tableViewConsH.constant = self.chatInputView.jk_y-TopHeight-36-self.headView.jk_height;
    [self.view layoutIfNeeded];
//    //滚动到底部
    [self tableViewScrollToBottom];
}

#pragma mark 下方菜单点击   SHMessageInputViewDelegate
- (void)didSelecteMenuItem:(SHShareMenuItem *)menuItem index:(NSInteger)index {
    if ([menuItem.title isEqualToString:@"图片"]) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowTakePicture = NO; // 在内部显示拍照按钮
        imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            [self sendMessageWithImage:photos.firstObject];
        }];
        imagePickerVc.modalPresentationStyle = 0;
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    } else if ([menuItem.title isEqualToString:@"拍摄"]) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
            // 无相机权限 做一个友好的提示
            [SVProgressHUD showInfoWithStatus:@"无法使用相机,请在iPhone的""设置-隐私-相机""中允许访问相机"];
        } else if (authStatus == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                        picker.view.backgroundColor = [UIColor whiteColor];
                        picker.delegate = self;
                        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//                        picker.allowsEditing = YES;
                        [self.navigationController presentViewController:picker animated:YES completion:nil];
                    });
                }
            }];
        }else {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.view.backgroundColor = [UIColor whiteColor];
                picker.delegate = self;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//                picker.allowsEditing = YES;
                [self.navigationController presentViewController:picker animated:YES completion:nil];
            }
        }
    }else if ([menuItem.title isEqualToString:@"核对订单"]) {
        SRXChatCheckOrdersVC *vc = [[SRXChatCheckOrdersVC alloc] init];
        vc.user_id = self.item.user_id;
        MJWeakSelf;
        vc.selectBlock = ^(SRXOrderListModel * _Nonnull model) {
            [weakSelf sendChatMessageWithOrder:model];
        };
        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    }else if ([menuItem.title isEqualToString:@"优惠券"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
        SRXChatCouponListVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXChatCouponListVC"];
        vc.shop_id = self.shop_id;
        MJWeakSelf;
        vc.selectBlock = ^(SRXMsgChatCoupnItem * _Nonnull model) {
            [weakSelf sendChatMessageWithCoupon:model];
        };
        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *, id> *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = nil;
        //如果允许编辑则获得编辑后的照片，否则获取原始照片
        if (picker.allowsEditing) {
            image = [info objectForKey:UIImagePickerControllerEditedImage]; //获取编辑后的照片
        } else {
            image = [info objectForKey:UIImagePickerControllerOriginalImage]; //获取原始照片
        }
        //发送图片与照片
        [self sendMessageWithImage:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    DLog(@"Dragging");
    self.chatInputView.inputType = SHInputViewType_default;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    KPostNotification(@"JKTextViewHideTextSelection", nil);
    [JYBubbleMenuView.shareMenuView removeFromSuperview];
}

#pragma mark 下方输入框
- (SHMessageInputView *)chatInputView {
    if (!_chatInputView) {
        _chatInputView = [[SHMessageInputView alloc] init];
        _chatInputView.frame = CGRectMake(0, kScreenHeight - kSHInPutHeight - kSHBottomSafe, kScreenWidth, kSHInPutHeight);
        _chatInputView.delegate = self;
        _chatInputView.supVC = self;

        NSArray *moreItem = @[
            @{@"chat_menu_picture" : @"图片"},
            @{@"chat_menu_camera" : @"拍摄"},
            @{@"chat_menu_coupon" : @"优惠券"},
            @{@"chat_menu_order" : @"核对订单"},
//            @{@"chat_more_red" : @"红包"},
//            @{@"chat_more_card" : @"名片"},
//            @{@"chat_more_file" : @"文件"},
        ];

        // 添加第三方接入数据
        NSMutableArray *shareMenuItems = [NSMutableArray array];

        //配置Item按钮
        [moreItem enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *_Nonnull stop) {
          SHShareMenuItem *item = [SHShareMenuItem new];
          item.icon = [UIImage imageNamed:obj.allKeys[0]];
          item.title = obj.allValues[0];
          [shareMenuItems addObject:item];
        }];

        _chatInputView.shareMenuItems = shareMenuItems;
        [_chatInputView reloadView];
    }
    return _chatInputView;
}

#pragma mark - private & public methods
- (void)setMj_header{
    
    MJWeakSelf
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageNo ++;
        weakSelf.currentPage = weakSelf.pageNo;
        weakSelf.loadMore = YES;
        [weakSelf requestTableData];
    }];
    [header setTitle:@"" forState:MJRefreshStateRefreshing];
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
}

- (void)requestTableDataSuccessWithArray:(NSArray *)modelList{
    
    for (SRXMsgChatModel *model in modelList) {
        [self.dataSources insertObject:model atIndex:0];
    }
    [self.tableView.mj_header endRefreshing];
    self.tableView.datas = self.dataSources.copy;
    [self.tableView reloadData];
    [self tableViewScrollToIndex:modelList.count];
    if (modelList.count<self.pageSize) {
        self.tableView.mj_header.hidden = YES;
    }
    SRXMsgChatModel *model = self.dataSources.firstObject;
    self.chat_id = model._id;
}


- (void)requestTableDataFailed{
    
    if (!self.loadMore) {
        self.pageNo = 1;
        [self reloadData];
        return;
    }
    self.pageNo --;
    [self.tableView.mj_header endRefreshing];
}

- (void)reloadData {
    self.tableView.datas = self.dataSources.copy;
    [self.tableView reloadData];
}
//滚动到底部
- (void)tableViewScrollToIndex:(NSInteger)index {
    if (index==0) {
        return;
    }
    @synchronized(self.dataSources) {
        if (self.dataSources.count > index) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index*2] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }else {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index*2-1] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }
}

#pragma mark - 销毁
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.chatInputView clear];
}
@end
