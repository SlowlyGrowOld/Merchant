//
//  SRXPopFeatureSelectionVC.m
//  ShiRongXinMarketMallProject
//
//  Created by 薛静鹏 on 2020/3/18.
//  Copyright © 2020 Alucardulad. All rights reserved.
//

#import "SRXPopFeatureSelectionVC.h"
#import "SRXCommonYellowGradientBtn.h"
#import "SRXFeatureSelectionCollectionView.h"
#import "SRXResultModel.h"
#import "NSMutableAttributedString+JHExt.h"

@interface SRXPopFeatureSelectionVC ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *spec_img;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *market_price;
@property (weak, nonatomic) IBOutlet UILabel *discount_price;
@property (weak, nonatomic) IBOutlet UILabel *key_name;
@property (weak, nonatomic) IBOutlet SRXFeatureSelectionCollectionView *specCollectionView;
/** 选中的规格 */
@property (nonatomic,strong) SRXSpecGoodsPriceModel *selectSpec;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewConsH;


- (IBAction)onclickSure:(SRXCommonYellowGradientBtn *)sender;

@end

@implementation SRXPopFeatureSelectionVC

- (IBAction)closeBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)configData {

    [self.spec_img sd_setImageWithURL:[NSURL URLWithString:self.goodsModel.image==nil?self.goodsModel.images.firstObject:self.goodsModel.image]];
    
    if(self.isGroup) {
        
        self.price.text = [NSString stringWithFormat:@"%@", self.isHeader ? self.goodsModel.head_price : self.goodsModel.group_price];
        
        if(self.type == 0) { // 秒杀的时候都是团购加
            self.price.text = [NSString stringWithFormat:@"%@", self.goodsModel.group_price];
        }
        
        NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",self.goodsModel.price]];
        [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
        self.market_price.attributedText = newPrice;
    } else {
        self.specCollectionView.is_package_edit_num = self.goodsModel.is_package_edit_num;
        self.price.attributedText = [NSMutableAttributedString setPriceText:self.goodsModel.price frontFont:22 behindFont:18 textColor:UIColor.redColor];
        if (self.goodsModel.market_price.doubleValue==0) {
            self.market_price.text = @"";
        } else {
            NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",self.goodsModel.market_price]];
            [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
            self.market_price.attributedText = newPrice;
        }
    }
    if (self.goodsModel.spec.count==0) {
        if(self.isGroup) {
            self.key_name.text = @"已选: 默认";
        } else {
            self.key_name.text = @"";
        }
        
    }
    else {
        self.key_name.text = @"未选";
    }
    self.market_price.hidden = YES;
    if (self.goodsModel.after_coupon_price > 0) {
        self.discount_price.superview.hidden = NO;
        self.discount_price.text = [NSString stringWithNumber:@(self.goodsModel.after_coupon_price) formatter:@"券后价¥###.##"];
    }else if (self.goodsModel.member_price.floatValue > 0 && self.goodsModel.is_member) {
        self.discount_price.superview.hidden = NO;
        self.discount_price.text = [NSString stringWithNumber:@(self.goodsModel.member_price.floatValue) formatter:@"会员价¥###.##"];
    }else {
        self.market_price.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.sureBtn jk_setGradientBackgroundWithColors:@[UIColorHex(#E48458),UIColorHex(#CC602D)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];
    
//    self.specCollectionView.is_package_edit_num = self.goodsModel.is_package_edit_num;
    [self.contentView settingRadius:10 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
    [self.specCollectionView.specArray removeAllObjects];
    //如果只有一行规格，判断存量是够可以点击
    for (SRXSpecModel *model in self.goodsModel.spec) {
        for (SRXSpecValueModel *v in model.spec_value) {
            v.isDisabled = NO;
            if (self.goodsModel.spec.count== 1) {
                for (SRXSpecGoodsPriceModel *goods in self.goodsModel.spec_goods_price) {
                    if ([goods.spec_key isEqualToString:v._id]) {
                        v.isDisabled = goods.store_count.intValue==0?YES:NO;
                        break;
                    }
                }
            }
        }
    }
    [self.specCollectionView.specArray addObjectsFromArray:self.goodsModel.spec];
    [self.specCollectionView.specGoods removeAllObjects];
    [self.specCollectionView.specGoods addObjectsFromArray:self.goodsModel.spec_goods_price];
    
    [self configData];
    
    [self.specCollectionView.seleDic removeAllObjects];
    if (self.specCollectionView.specArray.count!=0) {
        if (self.goodsModel.selectSpec!=nil) {
            NSArray *IDS = [self.goodsModel.selectSpec.spec_key componentsSeparatedByString:@"_"];
            for (int i=0; i<IDS.count; i++) {
                SRXSpecModel *model = self.goodsModel.spec[i];
                NSString *ID = IDS[i];
                for (SRXSpecValueModel *value in model.spec_value) {
                    if ([value._id isEqualToString:ID]) {
                        [self.specCollectionView.seleDic setValue:value forKey:model.name];
                        break;
                    }
                }
            }
            self.specCollectionView.max_number = self.goodsModel.selectSpec.store_count.integerValue;
            [self.specCollectionView reloadData];
        }
    }
    if(self.isGroup) {
        self.specCollectionView.max_number = self.goodsModel.limit_number;
    } else {
        if (!self.goodsModel.selectSpec) {
            self.specCollectionView.max_number = self.goodsModel.store_count.integerValue;
        }
        self.specCollectionView.current_number = self.goodsModel.goods_num.integerValue;
    }
    
    kWeakSelf;
    self.specCollectionView.block = ^(NSDictionary * _Nullable seleSpecDic) {
        if (!seleSpecDic) {
            self.selectSpec = nil;
            [self configData];
            return;
        }
        NSMutableArray *IDs = [NSMutableArray array];
        for (NSString *key in seleSpecDic.allKeys) {
            SRXSpecValueModel *value = seleSpecDic[key];
            [IDs addObject:value._id];
        }
        NSComparator finderSort = ^(id string1,id string2){

            if ([string1 integerValue] > [string2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }else if ([string1 integerValue] < [string2 integerValue]){
                return (NSComparisonResult)NSOrderedAscending;
            }
            else
            return (NSComparisonResult)NSOrderedSame;
        };
        NSArray *resultArray = [IDs sortedArrayUsingComparator:finderSort];
        NSString *IDsStr = [resultArray componentsJoinedByString:@"_"];
        for (SRXSpecGoodsPriceModel *data in weakSelf.goodsModel.spec_goods_price) {
            SRXSpecGoodsPriceModel *model = [SRXSpecGoodsPriceModel mj_objectWithKeyValues:data];
            NSArray *keys = [[model.spec_key componentsSeparatedByString:@"_"] sortedArrayUsingComparator:finderSort];
            NSString *keysStr = [keys componentsJoinedByString:@"_"];
            if ([keysStr isEqualToString:IDsStr]) {
                weakSelf.selectSpec = model;
                if ([weakSelf.selectSpec.spec_img isEqualToString:@""]) {
                    [weakSelf.spec_img sd_setImageWithURL:[NSURL URLWithString:self.goodsModel.image==nil?self.goodsModel.images.firstObject:self.goodsModel.image]];
                }
                else {
                    [weakSelf.spec_img sd_setImageWithURL:[NSURL URLWithString:weakSelf.selectSpec.spec_img]];
                }
                if(weakSelf.isGroup) {
                    //TODO: 价格为0情况下,没有处理.
                    weakSelf.price.text = [NSString stringWithFormat:@"¥%@", weakSelf.isHeader ? weakSelf.selectSpec.head_price : weakSelf.selectSpec.group_price];
                    if(weakSelf.type == 0) { // 秒杀的时候都是团购加
                        weakSelf.price.text = [NSString stringWithFormat:@"¥%@", weakSelf.selectSpec.group_price];
                    }
                    
                    weakSelf.market_price.text =  weakSelf.selectSpec.single_price.doubleValue==0?@"":weakSelf.selectSpec.single_price;
                    NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",weakSelf.market_price.text]]; [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
                    weakSelf.market_price.attributedText = newPrice;
                } else {
                    weakSelf.price.text = weakSelf.selectSpec.price ?: weakSelf.selectSpec.group_price;
                    weakSelf.price.attributedText = [NSMutableAttributedString setPriceText:weakSelf.price.text frontFont:22 behindFont:18 textColor:UIColor.redColor];
                    if (weakSelf.selectSpec.market_price.doubleValue==0) {
                        weakSelf.market_price.text = @"";
                    } else {
                        NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",weakSelf.selectSpec.market_price]];
                        [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
                        weakSelf.market_price.attributedText = newPrice;
                    }
                }
                
                weakSelf.key_name.text = weakSelf.selectSpec.key_name;
                weakSelf.specCollectionView.max_number = [weakSelf.selectSpec.store_count integerValue];
                weakSelf.market_price.hidden = YES;
                if (weakSelf.selectSpec.after_coupon_price > 0) {
                    weakSelf.discount_price.superview.hidden = NO;
                    weakSelf.discount_price.text = [NSString stringWithNumber:@(weakSelf.selectSpec.after_coupon_price) formatter:@"券后价¥###.##"];
                }else if (weakSelf.selectSpec.member_price > 0 && weakSelf.goodsModel.is_member) {
                    weakSelf.discount_price.superview.hidden = NO;
                    weakSelf.discount_price.text = [NSString stringWithNumber:@(weakSelf.selectSpec.member_price) formatter:@"会员价¥###.##"];
                }else {
                    weakSelf.market_price.hidden = NO;
                }
            }
        }
    };
    
    //修复下次进来数据错误
    if (self.goodsModel.selectSpec) {
        self.selectSpec = self.goodsModel.selectSpec;
        if ([self.selectSpec.spec_img isEqualToString:@""]) {
            [self.spec_img sd_setImageWithURL:[NSURL URLWithString:self.goodsModel.image==nil?self.goodsModel.images.firstObject:self.goodsModel.image]];
        }
        else {
            [self.spec_img sd_setImageWithURL:[NSURL URLWithString:self.selectSpec.spec_img]];
        }
        self.price.text = self.selectSpec.price ?: self.selectSpec.group_price;//self.selectSpec.package_price;
        self.price.attributedText = [NSMutableAttributedString setPriceText:self.price.text frontFont:22 behindFont:18 textColor:UIColor.redColor];
        if (self.selectSpec.market_price.doubleValue==0) {
            self.market_price.text = @"";
        } else {
            NSMutableAttributedString *newPrice = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",self.selectSpec.market_price]];
            [newPrice addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, newPrice.length)];
            self.market_price.attributedText = newPrice;
        }
        self.key_name.text = self.selectSpec.key_name;
        self.specCollectionView.max_number = [self.selectSpec.store_count integerValue];
        self.market_price.hidden = YES;
        if (self.selectSpec.after_coupon_price > 0) {
            self.discount_price.superview.hidden = NO;
            self.discount_price.text = [NSString stringWithNumber:@(self.selectSpec.after_coupon_price) formatter:@"券后价¥###.##"];
        }else if (self.selectSpec.member_price > 0 && self.goodsModel.is_member) {
            self.discount_price.superview.hidden = NO;
            self.discount_price.text = [NSString stringWithNumber:@(self.selectSpec.member_price) formatter:@"会员价¥###.##"];
        }else {
            self.market_price.hidden = NO;
        }
    }
    
    if (self.type == SRXPopFeatureSelectionTypeBuy) {
        [self.sureBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    }else if (self.type == SRXPopFeatureSelectionTypeShoppingCar) {
        [self.sureBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    }else if (self.type == SRXPopFeatureSelectionTypeCartChange) {
        self.specCollectionView.is_hidden_num = YES;
    }
    
    self.specCollectionView.heightBlock = ^(CGFloat height) {
        if (height + 220 > kScreenHeight - 100){
            weakSelf.bgViewConsH.constant = kScreenHeight - 100;
        }else {
            weakSelf.bgViewConsH.constant = height + 220;
        }
    };
}


- (IBAction)onclickSure:(SRXCommonYellowGradientBtn *)sender {
    if (self.goodsModel.spec.count!=0) {
        if (self.selectSpec==nil) {
            [SVProgressHUD showInfoWithStatus:@"请把规格选全"];
            return;
        }
    }
    
    if (self.selectBlock) {
        self.selectBlock(self.goodsModel);
    }

    if (self.type==SRXPopFeatureSelectionTypeShoppingCar) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if (self.type==SRXPopFeatureSelectionTypeSelectFeature) {
        if (self.goodsModel.spec.count!=0) {
            if (self.selectSpec.store_count.intValue < self.specCollectionView.numberView.currentNumber) {
                [SVProgressHUD showErrorWithStatus:@"超过库存上限"];
                return;
            }
        }else {
            if (self.goodsModel.store_count.intValue < self.specCollectionView.numberView.currentNumber) {
                [SVProgressHUD showErrorWithStatus:@"超过库存上限"];
                return;
            }
        }
        self.goodsModel.selectSpec = self.selectSpec;
        self.goodsModel.goods_num = [NSString stringWithFormat:@"%ld",self.specCollectionView.numberView.currentNumber];
        if (self.changeBlock) {
            self.changeBlock(self.goodsModel);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (self.type == SRXPopFeatureSelectionTypeCartChange) {
        self.goodsModel.selectSpec = self.selectSpec;
        self.goodsModel.goods_num = [NSString stringWithFormat:@"%ld",self.specCollectionView.numberView.currentNumber];
        if (self.changeBlock) {
            self.changeBlock(self.goodsModel);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    } else if (self.type==SRXPopFeatureSelectionTypeAddOrderList) {

    } else if (self.type==SRXPopFeatureSelectionTypeBecomeAgentAdd) {

    } else if (self.type==SRXPopFeatureSelectionTypeBecomeAgent) {
        
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
        if(self.goodsModel._id) {

        } else { // 团购相关预览.
            if(self.selectSpec.store_count.integerValue == 0 && self.selectSpec) {
                [SVProgressHUD showInfoWithStatus:@"商品库存不足"];
                return;
            }

        }
    }
    
}
@end
