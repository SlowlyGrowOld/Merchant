//
//  SRXGoodsListNewTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/7/3.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsListNewTableCell.h"

#import "SRXShelfReviewAlertVC.h"
#import "SRXGoodsInfoEditPageVC.h"
#import "SRXGoodsSpecSetTableVC.h"

#import "NetworkManager+Goods.h"
//#import "NetworkManager+GoodUpdate.h"

@interface SRXGoodsListNewTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goods_image;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *goods_salenum;
@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet UILabel *statusLb;
@property (weak, nonatomic) IBOutlet UILabel *reasonLb;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *addedBtn;

@end

@implementation SRXGoodsListNewTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SRXGoodsListModel *)model {
    _model = model;
    [_goods_image sd_setImageWithURL:[NSURL URLWithString:model.image]];
    _goods_name.text = model.goods_name;
    _goods_salenum.text = [NSString stringWithFormat:@"销量：%zd",model.sales_sum];

    self.submitBtn.backgroundColor = self.model.is_editing==0?C43B8F6:CFont99;
    if (model.status == 0) {
        self.btnView.hidden = YES;
        self.reasonLb.superview.hidden = YES;
        self.statusLb.superview.hidden = NO;
        self.statusLb.text = @"审核中";
        self.statusLb.textColor = C43B8F6;
        [self.submitBtn setTitle:@"提交审核" forState:UIControlStateNormal];
        self.submitBtn.backgroundColor = C43B8F6;
    } else if (model.status == 2) {
        self.btnView.hidden = NO;
        self.reasonLb.superview.hidden = NO;
        self.statusLb.superview.hidden = NO;
        self.statusLb.text = @"未通过";
        self.statusLb.textColor = CRed;
        self.reasonLb.text = model.refuse_reason;
        [self.submitBtn setTitle:@"重新提交" forState:UIControlStateNormal];
        self.submitBtn.backgroundColor = UIColorHex(0xFF8455);
        self.submitBtn.backgroundColor = self.model.is_editing==0?UIColorHex(0xFF8455):CFont99;
    }

}

- (void)setGoods_status:(NSString *)goods_status {
    _goods_status = goods_status;
    if (goods_status.intValue == 1) {
        
    } else if (goods_status.intValue == 2) {
        self.btnView.hidden = NO;
        self.reasonLb.superview.hidden = YES;
        self.statusLb.superview.hidden = YES;
        self.submitBtn.hidden = NO;
        self.addedBtn.hidden = YES;
    } else if (goods_status.intValue == 4) {
        self.btnView.hidden = NO;
        self.reasonLb.superview.hidden = YES;
        self.statusLb.superview.hidden = YES;
        self.submitBtn.hidden = YES;
        self.addedBtn.hidden = NO;
    }
}

//编辑
- (IBAction)editBtnClick:(id)sender {
    SRXGoodsInfoEditPageVC *vc = [[SRXGoodsInfoEditPageVC alloc] init];
    vc.goods_id = self.model.goods_id;
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}
//规格
- (IBAction)specBtnClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Goods" bundle:nil];
    SRXGoodsSpecSetTableVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXGoodsSpecSetTableVC"];
    vc.goods_id = self.model.goods_id;
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

//提交审核
- (IBAction)submitBtnClick:(id)sender {
    if (self.model.is_editing==1) {
        return;
    }
    SRXShelfReviewAlertVC *vc = [[SRXShelfReviewAlertVC alloc] init];
    vc.type = SRXShelfReviewAlertTypeAudit;
    vc.block = ^(BOOL isSure) {
        [NetworkManager reviewGoodsWithGoods_id:self.model.goods_id is_audit_show:isSure?@"1":@"0" success:^(NSString *message) {
            dispatch_async(dispatch_get_main_queue(), ^{
                KPostNotification(KNotificationGoodsInfoChange, nil);
            });
        } failure:^(NSString *message) {
            
        }];
    };
    [[UIViewController jk_currentViewController] presentViewController:vc animated:YES completion:nil];
}

//上架
- (IBAction)addedBtnClick:(id)sender {
    SRXShelfReviewAlertVC *vc = [[SRXShelfReviewAlertVC alloc] init];
    vc.type = SRXShelfReviewAlertTypeAdded;
    MJWeakSelf;
    vc.block = ^(BOOL isSure) {
        if (isSure) {
            [NetworkManager shelfGoodsWithGoods_id:weakSelf.model.goods_id success:^(NSString *message) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    KPostNotification(KNotificationGoodsInfoChange, nil);
                });
            } failure:^(NSString *message) {
                
            }];
        }
    };
    [[UIViewController jk_currentViewController] presentViewController:vc animated:YES completion:nil];
}

@end
