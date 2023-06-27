//
//  SRXSearchView.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SRXSearchViewBlock)(NSString *search_key);

@interface SRXSearchView : UIView
@property (nonatomic, copy) SRXSearchViewBlock searchBlock;
@property (nonatomic, copy) NSString *placeholder_text;
@end

NS_ASSUME_NONNULL_END
