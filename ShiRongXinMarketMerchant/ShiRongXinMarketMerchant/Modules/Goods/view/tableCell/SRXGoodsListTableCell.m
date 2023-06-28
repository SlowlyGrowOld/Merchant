//
//  SRXGoodsListTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsListTableCell.h"
#import "SRXGoodsSpecUpdateVC.h"
#import "SRXGoodsSpecSetTableVC.h"
#import "SRXGoodsInfoEditPageVC.h"
#import "YBPopupMenu.h"

#import "NetworkManager+Goods.h"
#import "NetworkManager+GoodUpdate.h"

@interface SRXGoodsListTableCell ()<YBPopupMenuDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *goods_image;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *goods_salenum;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIStackView *btnStack;
@property (nonatomic, strong) NSArray *moreArray;
@end

@implementation SRXGoodsListTableCell

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
}

- (void)setGoods_status:(NSString *)goods_status {
    _goods_status = goods_status;
    _moreBtn.hidden = NO;
    _btnStack.hidden = NO;
    if (goods_status.intValue == 1) {
        self.moreArray = @[@"下架"];
    } else if (goods_status.intValue == 2) {
        self.moreArray = @[@"提交审核"];
    } else if (goods_status.intValue == 4) {
        self.moreArray = @[@"上架"];
    } else {
        self.moreArray = @[];
        _moreBtn.hidden = YES;
        _btnStack.hidden = YES;
    }
}

- (IBAction)menuBtnClick:(id)sender {

}

- (IBAction)editBtnClick:(id)sender {
    SRXGoodsInfoEditPageVC *vc = [[SRXGoodsInfoEditPageVC alloc] init];
    vc.goods_id = self.model.goods_id;
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (IBAction)specBtnClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Goods" bundle:nil];
    SRXGoodsSpecSetTableVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXGoodsSpecSetTableVC"];
    vc.goods_id = self.model.goods_id;
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (IBAction)storeNumBtnClick:(id)sender {
    [NetworkManager getGoodsFateInfoWithGoods_id:self.model.goods_id success:^(NSArray *modelList) {
        if (modelList.count==0) {
            [SVProgressHUD showInfoWithStatus:@"请先设置规格"];
        } else {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Goods" bundle:nil];
            SRXGoodsSpecUpdateVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXGoodsSpecUpdateVC"];
            vc.goods_id = self.model.goods_id;
            vc.isStore = YES;
            vc.datas = modelList;
            [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:NO completion:nil];
        }
    } failure:^(NSString *message) {
        
    }];
}

- (IBAction)priceBtnClick:(id)sender {
    [NetworkManager getGoodsFateInfoWithGoods_id:self.model.goods_id success:^(NSArray *modelList) {
        if (modelList.count==0) {
            [SVProgressHUD showInfoWithStatus:@"请先设置规格"];
        } else {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Goods" bundle:nil];
            SRXGoodsSpecUpdateVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXGoodsSpecUpdateVC"];
            vc.goods_id = self.model.goods_id;
            vc.datas = modelList;
            [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:NO completion:nil];
        }
    } failure:^(NSString *message) {
        
    }];
}

- (IBAction)moreBtnClick:(id)sender {
    [YBPopupMenu showRelyOnView:self.moreBtn titles:self.moreArray icons:nil menuWidth:100 delegate:self];
}

- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index {
    DLog(@"%zd",index);
    NSString *string = self.moreArray[index];
    if ([string isEqualToString:@"下架"]) {
        [NetworkManager batchGoodsTakeOffWithIDS:self.model.goods_id success:^(NSString *message) {
            dispatch_async(dispatch_get_main_queue(), ^{
                KPostNotification(KNotificationGoodsInfoChange, nil);
            });
        } failure:^(NSString *message) {
            
        }];
    } else if ([string isEqualToString:@"上架"]) {
        [NetworkManager shelfGoodsWithGoods_id:self.model.goods_id success:^(NSString *message) {
            dispatch_async(dispatch_get_main_queue(), ^{
                KPostNotification(KNotificationGoodsInfoChange, nil);
            });
        } failure:^(NSString *message) {
            
        }];
    } else if ([string isEqualToString:@"提交审核"]) {
        [NetworkManager reviewGoodsWithGoods_id:self.model.goods_id success:^(NSString *message) {
            dispatch_async(dispatch_get_main_queue(), ^{
                KPostNotification(KNotificationGoodsInfoChange, nil);
            });
        } failure:^(NSString *message) {
            
        }];
    } else{
        
    }
}
@end
