//
//  SRXGoodsSpecTableCell.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/26.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRXGoodsSpecModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^SRXGoodsSpecBlock)(void);
@interface SRXGoodsSpecTableCell : UITableViewCell
@property (nonatomic, strong) SRXGoodsSpecAttrItem *item;
@property (nonatomic, copy) dispatch_block_t refreshBlock;
@property (nonatomic, copy) SRXGoodsSpecBlock selectBlock;
@property (nonatomic, copy) SRXGoodsSpecBlock deleteBlock;
@end

NS_ASSUME_NONNULL_END
