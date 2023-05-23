//
//  SRXOrderLogisticsListTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/23.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderLogisticsListTableCell.h"
#import "SRXOrderListGoodsTableView.h"
#import "SRXOrdersListGoodsTableCell.h"

#import "SRXOrderLogisticsDetailsVC.h"

@interface SRXOrderLogisticsListTableCell ()
@property (weak, nonatomic) IBOutlet SRXOrderListGoodsTableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;
@property (weak, nonatomic) IBOutlet UILabel *ship_type;
@property (weak, nonatomic) IBOutlet UILabel *ship_sn;
@property (weak, nonatomic) IBOutlet UILabel *ship_time;

@end

@implementation SRXOrderLogisticsListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SRXOrderDeliveryModel *)model {
    _model = model;
    self.tableViewConsH.constant = 80 * model.goods.count;
    self.tableView.datas = model.goods;
    _ship_type.text = model.express_name;
    _ship_sn.text = model.express_sn;
    _ship_time.text = model.create_time;
}
- (IBAction)lookShipDetailsBtnClick:(id)sender {
    
    SRXOrderLogisticsDetailsVC *vc = [[SRXOrderLogisticsDetailsVC alloc] init];
    vc.order_id = self.model.order_id;
    vc.express_sn = self.model.express_sn;
    vc.order_type = @"1";
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}
- (IBAction)copyShipSNBtnClick:(id)sender {
    [AppHandyMethods theCopyActionWith:self.model.express_sn];
}

@end
