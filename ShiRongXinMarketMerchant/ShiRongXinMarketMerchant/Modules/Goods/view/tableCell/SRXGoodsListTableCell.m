//
//  SRXGoodsListTableCell.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/4/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsListTableCell.h"
#import "SRXGoodsSpecUpdateVC.h"

@interface SRXGoodsListTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *goods_image;
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UILabel *goods_salenum;

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

- (IBAction)menuBtnClick:(id)sender {
}

- (IBAction)editBtnClick:(id)sender {
}

- (IBAction)specBtnClick:(id)sender {
    
}

- (IBAction)storeNumBtnClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Goods" bundle:nil];
    SRXGoodsSpecUpdateVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXGoodsSpecUpdateVC"];
    vc.isStore = YES;
    [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:NO completion:nil];
}

- (IBAction)priceBtnClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Goods" bundle:nil];
    SRXGoodsSpecUpdateVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXGoodsSpecUpdateVC"];
    [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:NO completion:nil];
}

- (IBAction)moreBtnClick:(id)sender {
    
}


@end
