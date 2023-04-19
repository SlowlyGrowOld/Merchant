//
//  SRXImageTextView.h
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2022/11/22.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRXHtmlTextView : UITextView
@property (nonatomic, assign) CGFloat maxWidth;
@property (nonatomic, copy) NSString *content;
- (CGFloat)getHtmlHeight:(NSString *)content;
- (void)clearContainerInset;
@end

NS_ASSUME_NONNULL_END
