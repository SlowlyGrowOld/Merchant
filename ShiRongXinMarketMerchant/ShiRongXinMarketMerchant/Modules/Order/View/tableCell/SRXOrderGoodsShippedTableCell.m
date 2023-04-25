//
//  SRXOrderGoodsShippedTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/21.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXOrderGoodsShippedTableCell.h"
#import "SRXOrderShippedGoodsTableView.h"

#define degreesToRadinas(x) (M_PI * (x)/180.0)

@interface SRXOrderGoodsShippedTableCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *unfold_image;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *logisticsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConsH;
@property (weak, nonatomic) IBOutlet SRXOrderShippedGoodsTableView *tableView;

@end

@implementation SRXOrderGoodsShippedTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tableView.datas = @[@"",@""];
    self.tableViewConsH.constant = 2 * 30 + 10;
    self.lineView.hidden = YES;
    self.logisticsView.hidden = YES;
    self.tableView.superview.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SRXOrderGoodsShippedModel *)model {
    _model = model;
    self.titleLb.text = model.title;
    self.imgView.image = [UIImage imageNamed:model.is_select?@"checkbox_blue_selected":@"checkbox_nomal"];
    self.lineView.hidden = !model.is_select;
    self.logisticsView.hidden = !model.is_select;
    if ([model.title isEqualToString:@"按订单发货"]) {
        self.tableView.superview.hidden = YES;
    } else {
        self.tableView.superview.hidden = !model.is_select;
    }
    if (model.is_select) {
        self.unfold_image.transform = CGAffineTransformMakeRotation(degreesToRadinas(90));
    } else {
        self.unfold_image.transform = CGAffineTransformIdentity;
    }
    
}

@end
