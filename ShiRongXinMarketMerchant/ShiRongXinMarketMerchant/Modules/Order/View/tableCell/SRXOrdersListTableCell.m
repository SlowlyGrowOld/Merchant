//
//  SRXOrdersListTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/20.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrdersListTableCell.h"
#import "SRXOrderListGoodsTableView.h"

#import "SRXOrdersRemarkVC.h"
#import "SRXOrderGoodsShippedVC.h"
#import "SRXOrderLogisticsDetailsVC.h"
#import "SRXOrderLogisticsListVC.h"
#import "SRXMsgChatVC.h"

@interface SRXOrdersListTableCell ()
@property (weak, nonatomic) IBOutlet SRXOrderListGoodsTableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;
@property (weak, nonatomic) IBOutlet UIImageView *user_avatar;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *create_time;
@property (weak, nonatomic) IBOutlet UILabel *statusLb;
@property (weak, nonatomic) IBOutlet UILabel *shipping_amount;
@property (weak, nonatomic) IBOutlet UILabel *deduct_amount;
@property (weak, nonatomic) IBOutlet UILabel *pay_amount;
@property (weak, nonatomic) IBOutlet UILabel *consignee;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *address_status;
@property (weak, nonatomic) IBOutlet UILabel *user_remark;
@property (weak, nonatomic) IBOutlet UILabel *order_remark;
@property (weak, nonatomic) IBOutlet UIButton *erp_btn;
@property (weak, nonatomic) IBOutlet UIButton *ship_btn;
@property (weak, nonatomic) IBOutlet UIButton *sendgoods_btn;

@end

@implementation SRXOrdersListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SRXOrderListModel *)model {
    _model = model;
    [_user_avatar sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    _user_name.text = model.nickname;
    _create_time.text = model.create_time;
    _shipping_amount.text = [NSString stringWithNumber:@(model.shipping_amount) formatter:@"¥##.##"];
    _deduct_amount.text = model.deduct_amount;
    _pay_amount.text = [NSString stringWithNumber:@(model.pay_amount) formatter:@"¥##.##"];
    _consignee.text = model.consignee;
    _address.text = model.full_address;
    _user_remark.text = model.remark;
    _order_remark.text = model.admin_note;
    _address_status.hidden = !model.is_sure_address;

    self.tableView.datas = model.order_goods;
    self.tableViewConsH.constant = model.order_goods.count * 80;
    
    if(self.order_type==1){[self checkLookExpress];}
}

- (void)setOrder_type:(NSInteger)order_type {
    _order_type = order_type;
    //1=待发货 2=待付款 3=待收货 4=已完成
    if (order_type == 1) {
        self.erp_btn.hidden = NO;
        self.ship_btn.hidden = YES;
        self.sendgoods_btn.hidden = NO;
        [self checkLookExpress];
    } else if (order_type == 2) {
        self.erp_btn.hidden = YES;
        self.ship_btn.hidden = YES;
        self.sendgoods_btn.hidden = YES;
    } else{
        self.erp_btn.hidden = YES;
        self.ship_btn.hidden = NO;
        self.sendgoods_btn.hidden = YES;
    }
    switch (order_type) {
        case 1:
        {
            self.statusLb.text = @"待发货";
            self.statusLb.textColor = UIColorHex(0x5DE0A1);
        }
            break;
        case 2:
        {
            self.statusLb.text = @"待付款";
            self.statusLb.textColor = UIColorHex(0x5DE0A1);
        }
            break;
        case 3:
        {
            self.statusLb.text = @"待收货";
            self.statusLb.textColor = UIColorHex(0xEAC547);
        }
            break;
        case 4:
        {
            self.statusLb.text = @"已完成";
            self.statusLb.textColor = UIColorHex(0x43B8F6);
        }
            break;
            
        default:
            break;
    }
}

- (void)checkLookExpress {
    for (SRXOrderGoodsItem *item in self.model.order_goods) {
        if (item.order_delivery_id>0) {
            self.ship_btn.hidden= NO;
        }
    }
}

- (IBAction)menuBtnClick:(id)sender {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertC addAction:[UIAlertAction actionWithTitle:@"订单备注" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SRXOrdersRemarkVC *vc = [[SRXOrdersRemarkVC alloc] init];
        vc.model = self.model;
        [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:nil];
    }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [[UIViewController jk_currentViewController] presentViewController:alertC animated:YES completion:nil];
}

- (IBAction)shippedBtnClick:(id)sender {
    UIStoryboard *order = [UIStoryboard storyboardWithName:@"Order" bundle:Nil];
    SRXOrderGoodsShippedVC *vc = [order instantiateViewControllerWithIdentifier:@"SRXOrderGoodsShippedVC"];
    vc.order_id = self.model.order_id;
    for (SRXOrderGoodsItem *item in self.model.order_goods) {
        if (item.order_delivery_id>0) {
            vc.is_distribute = YES;
        }
    }
    vc.is_single = self.model.goods_count==1?YES:NO;
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (IBAction)lookLogistcsBtnClick:(id)sender {
    
    if (self.model.express_sn.length==0) {
        SRXOrderLogisticsListVC *vc = [[SRXOrderLogisticsListVC alloc] init];
        vc.order_id = self.model.order_id;
        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    } else {
        SRXOrderLogisticsDetailsVC *vc = [[SRXOrderLogisticsDetailsVC alloc] init];
        vc.order_id = self.model.order_id;
        vc.express_sn = self.model.express_sn;
        vc.order_type = @"1";
        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    }
}

- (IBAction)erpBtnClick:(id)sender {
    
}

- (IBAction)contactBuyerBtnClick:(id)sender {
    SRXMsgChatVC *vc = [[SRXMsgChatVC alloc] init];
    SRXMessageListModel *item = [SRXMessageListModel new];
    item.nickname = self.model.nickname;
    item.avatar =  self.model.avatar;
    item.user_id =  self.model.user_id;
    vc.item = item;
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (IBAction)copyBtnClick:(id)sender {
    [AppHandyMethods theCopyActionWith:self.model.full_address];
}

@end
