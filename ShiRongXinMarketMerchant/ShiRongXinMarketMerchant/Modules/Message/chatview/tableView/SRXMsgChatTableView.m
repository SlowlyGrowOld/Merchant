//
//  SRXMsgChatTableView.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/20.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXMsgChatTableView.h"
#import "SRXMsgTimeTableCell.h"
#import "SRXMsgUserTextTableCell.h"
#import "SRXMsgUserImageTableCell.h"
#import "SRXMsgUserGoodsTableCell.h"
#import "SRXMsgUserOrderTableCell.h"
#import "SRXMsgUserCouponTableCell.h"
#import "SRXMsgUserAudioTableCell.h"
#import "SRXMsgUserChargeOrderTableCell.h"
#import "SRXMsgShopTextTableCell.h"
#import "SRXMsgShopImageTableCell.h"
#import "SRXMsgShopGoodsTableCell.h"
#import "SRXMsgUserAddressTableCell.h"
#import "SRXMsgShopOrderTableCell.h"
#import "SRXMsgShopAudioTableCell.h"
#import "SRXMsgEvaluateTableCell.h"
#import "SRXMsgChatModel.h"

#import "SHAudioPlayerHelper.h"
#import "JYBubbleMenuView.h"

@interface SRXMsgChatTableView ()<UITableViewDelegate,UITableViewDataSource,SHAudioPlayerHelperDelegate>
/**长按菜单点击的操作按钮*/
@property (nonatomic, copy) NSString *text_type;
/**长按菜单点击的操作那行chat_id*/
@property (nonatomic, copy) NSString *text_chat_id;
/**举报的内容*/
@property (nonatomic, copy) NSString *text_content;
@end

@implementation SRXMsgChatTableView

// 从xib/sb加载调用的方法. mark byKing
-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        [self initWithTableView];
    }
    return self;
}
- (void)initWithTableView{
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = UIColorHex(0xf3f3f3);
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"SRXMsgTimeTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgTimeTableCell"];
    
    [self registerNib:[UINib nibWithNibName:@"SRXMsgUserTextTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgUserTextTableCell"];
    [self registerNib:[UINib nibWithNibName:@"SRXMsgUserGoodsTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgUserGoodsTableCell"];
    [self registerNib:[UINib nibWithNibName:@"SRXMsgUserImageTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgUserImageTableCell"];
    [self registerNib:[UINib nibWithNibName:@"SRXMsgUserOrderTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgUserOrderTableCell"];
    [self registerNib:[UINib nibWithNibName:@"SRXMsgUserAddressTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgUserAddressTableCell"];
    [self registerNib:[UINib nibWithNibName:@"SRXMsgUserCouponTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgUserCouponTableCell"];
    [self registerNib:[UINib nibWithNibName:@"SRXMsgUserAudioTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgUserAudioTableCell"];
    [self registerNib:[UINib nibWithNibName:@"SRXMsgUserChargeOrderTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgUserChargeOrderTableCell"];
    [self registerNib:[UINib nibWithNibName:@"SRXMsgEvaluateTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgEvaluateTableCell"];
    
    [self registerNib:[UINib nibWithNibName:@"SRXMsgShopTextTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgShopTextTableCell"];
    [self registerNib:[UINib nibWithNibName:@"SRXMsgShopImageTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgShopImageTableCell"];
    [self registerNib:[UINib nibWithNibName:@"SRXMsgShopGoodsTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgShopGoodsTableCell"];
    [self registerNib:[UINib nibWithNibName:@"SRXMsgShopOrderTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgShopOrderTableCell"];
    [self registerNib:[UINib nibWithNibName:@"SRXMsgShopAudioTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXMsgShopAudioTableCell"];
    
    [kNotificationCenter addObserver:self selector:@selector(chatTextMenuAction:) name:KNotiChatTextMenuAction object:nil];
}

- (void)chatTextMenuAction:(NSNotification *)notification {
    NSDictionary *dic = notification.userInfo;
    self.text_chat_id = dic[@"id"];
    self.text_type = dic[@"type"];
    if ([self.text_type isEqualToString:@"report"]) {
        self.text_content = dic[@"content"];
        [self reportTextModel];
    }
}

- (void)reportTextModel {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否举报该条消息？" preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NetworkManager sharedClient] postWithURLString:@"v2/user_chat_report" parameters:@{@"chat_id":self.text_chat_id,@"shop_id":self.shop_id,@"content":self.text_content} isNeedSVP:NO success:^(NSDictionary *messageDic) {
            NSMutableArray *mArr = [NSMutableArray array];
            for (SRXMsgChatModel *model in self.datas) {
                if (model._id.integerValue == self.text_chat_id.integerValue) {
                    model.is_report = 1;
                }
                [mArr addObject:model];
            }
            self.datas = mArr.copy;
            [self reportSuccess];
        } failure:^(NSString *error) {
            
        }];
    }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
    }]];
    [[UIViewController jk_currentViewController] presentViewController:alertC animated:YES completion:nil];
}

- (void)reportSuccess {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的反馈够容易已经记录，将由审核团队进行审核。" preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
    }]];
    [[UIViewController jk_currentViewController] presentViewController:alertC animated:YES completion:nil];
}

- (void)setDatas:(NSArray *)datas {
    _datas = datas;
    [self reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count * 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXMsgChatModel *model = self.datas[indexPath.section/2];
    if (indexPath.section%2==0) {
        SRXMsgTimeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgTimeTableCell" forIndexPath:indexPath];
        cell.timeLb.text = model.send_time;
        return cell;
    }else {
        if ([model.who_send isEqualToString:@"shop"]) {
            if ([model.msg_type isEqualToString:@"goods_link"]) {
                SRXMsgUserGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgUserGoodsTableCell" forIndexPath:indexPath];
                cell.model = model;
                return cell;
            }else if ([model.msg_type isEqualToString:@"image"]){
                SRXMsgUserImageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgUserImageTableCell" forIndexPath:indexPath];
                cell.model = model;
                return cell;
            }else if ([model.msg_type isEqualToString:@"user_order"]){
                SRXMsgUserOrderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgUserOrderTableCell" forIndexPath:indexPath];
                cell.model = model;
                return cell;
            }else if ([model.msg_type isEqualToString:@"order_address"]) {
                SRXMsgUserAddressTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgUserAddressTableCell" forIndexPath:indexPath];
                cell.model = model;
                return cell;
            }else if ([model.msg_type isEqualToString:@"coupon"]){
                SRXMsgUserCouponTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgUserCouponTableCell" forIndexPath:indexPath];
                cell.model = model;
                return cell;
            }else if ([model.msg_type isEqualToString:@"voice"]){
                SRXMsgUserAudioTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgUserAudioTableCell" forIndexPath:indexPath];
                cell.model = model;
                MJWeakSelf;
                cell.playBlock = ^{
                    [weakSelf didPlayVioce:model];
                };
                return cell;
            }else if ([model.msg_type isEqualToString:@"fulu_order"]){
                SRXMsgUserChargeOrderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgUserChargeOrderTableCell" forIndexPath:indexPath];
                cell.model = model;
                return cell;
            }else if ([model.msg_type isEqualToString:@"invite_evaluate"]){
                SRXMsgEvaluateTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgEvaluateTableCell" forIndexPath:indexPath];
                cell.model = model;
                return cell;
            }else if ([model.msg_type isEqualToString:@"end_evaluate"]){
                SRXMsgEvaluateTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgEvaluateTableCell" forIndexPath:indexPath];
                cell.model = model;
                return cell;
            }else if ([model.msg_type isEqualToString:@"transfer"]){
                SRXMsgTimeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgTimeTableCell" forIndexPath:indexPath];
                cell.timeLb.text = [NSString stringWithFormat:@"- 已转接了客服%@为您服务 -",model.transfer_info.nickname];
                cell.timeLb.font = [UIFont systemFontOfSize:12];
                return cell;
            } else {
                SRXMsgUserTextTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgUserTextTableCell" forIndexPath:indexPath];
                cell.model = model;
                return cell;
            }
        }else {
            if ([model.msg_type isEqualToString:@"goods_link"] && [model.who_send isEqualToString:@"user"]) {
                SRXMsgShopGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgShopGoodsTableCell" forIndexPath:indexPath];
                cell.model = model;
                return cell;
            }else if ([model.msg_type isEqualToString:@"image"] && [model.who_send isEqualToString:@"user"]){
                SRXMsgShopImageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgShopImageTableCell" forIndexPath:indexPath];
                cell.model = model;
                return cell;
            }else if ([model.msg_type isEqualToString:@"user_order"] && [model.who_send isEqualToString:@"user"]) {
                SRXMsgShopOrderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgShopOrderTableCell" forIndexPath:indexPath];
                cell.model = model;
                return cell;
            }else if ([model.msg_type isEqualToString:@"voice"] && [model.who_send isEqualToString:@"user"]){
                SRXMsgShopAudioTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgShopAudioTableCell" forIndexPath:indexPath];
                cell.model = model;
                MJWeakSelf;
                cell.playBlock = ^{
                    [weakSelf didPlayVioce:model];
                };
                return cell;
            }else {
                SRXMsgShopTextTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXMsgShopTextTableCell" forIndexPath:indexPath];
                cell.model = model;
                return cell;
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)didPlayVioce:(SRXMsgChatModel *)model {
    DLog(@"点击了 --- 语音消息");
    SHAudioPlayerHelper *audio = [SHAudioPlayerHelper shareInstance];
    audio.delegate = self;

    //如果此条正在播放则停止
    if (model.isPlaying) {
        model.isPlaying = NO;
        //正在播放、停止
        [audio stopAudio];
    } else {
        model.isPlaying = YES;
        //未播放、播放
        [audio managerAudioWithFileArr:@[ model ] isClear:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    KPostNotification(@"JKTextViewHideTextSelection", nil);
    [JYBubbleMenuView.shareMenuView removeFromSuperview];
}

#pragma mark - SHAudioPlayerHelperDelegate
#pragma mark 开始播放
- (void)audioPlayerStartPlay:(NSString *)playMark {
    for (UITableViewCell *cell in self.visibleCells) {
        if ([cell isKindOfClass:[SRXMsgUserAudioTableCell class]]) {
            SRXMsgUserAudioTableCell *userCell = (SRXMsgUserAudioTableCell *)cell;
            //获取数据源
            NSIndexPath *indexPath = [self indexPathForCell:userCell];
            SRXMsgChatModel *model = self.datas[indexPath.section/2];

            if ([userCell.model.params isEqualToString:playMark] || [userCell.model.voice isEqualToString:playMark]) {
                model.isPlaying = YES;
                [userCell playVoiceAnimation];
            } else {
                model.isPlaying = NO;
                [userCell stopVoiceAnimation];
            }
        }
        if ([cell isKindOfClass:[SRXMsgShopAudioTableCell class]]) {
            SRXMsgShopAudioTableCell *shopCell = (SRXMsgShopAudioTableCell *)cell;
            //获取数据源
            NSIndexPath *indexPath = [self indexPathForCell:cell];
            SRXMsgChatModel *model = self.datas[indexPath.section/2];

            if ([shopCell.model.params isEqualToString:playMark] || [shopCell.model.voice isEqualToString:playMark]) {
                model.isPlaying = YES;
                [shopCell playVoiceAnimation];
            } else {
                model.isPlaying = NO;
                [shopCell stopVoiceAnimation];
            }
        }
    }
}

#pragma mark 结束播放
- (void)audioPlayerEndPlay:(NSString *)playMark error:(NSError *)error {
    if (error) {
        NSLog(@"音频播放错误：%@", error.description);
    }
    for (UITableViewCell *cell in self.visibleCells) {
        if ([cell isKindOfClass:[SRXMsgUserAudioTableCell class]]) {
            SRXMsgUserAudioTableCell *userCell = (SRXMsgUserAudioTableCell *)cell;
            //获取数据源
            NSIndexPath *indexPath = [self indexPathForCell:cell];
            SRXMsgChatModel *model = self.datas[indexPath.section/2];

            if ([userCell.model.params isEqualToString:playMark] || [userCell.model.voice isEqualToString:playMark]) {
                model.isPlaying = NO;
                [userCell stopVoiceAnimation];
            }
        }
        if ([cell isKindOfClass:[SRXMsgShopAudioTableCell class]]) {
            SRXMsgShopAudioTableCell *shopCell = (SRXMsgShopAudioTableCell *)cell;
            //获取数据源
            NSIndexPath *indexPath = [self indexPathForCell:cell];
            SRXMsgChatModel *model = self.datas[indexPath.section/2];

            if ([shopCell.model.params isEqualToString:playMark] || [shopCell.model.voice isEqualToString:playMark]) {
                model.isPlaying = NO;
                [shopCell stopVoiceAnimation];
            }
        }
    }
}

@end
