//
//  SRXImageTextView.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2022/11/22.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXHtmlTextView.h"

@implementation SRXHtmlTextView

- (CGFloat)maxWidth {
    if (_maxWidth>0) {
        return _maxWidth;
    }
    return KScreenWidth;
}


- (void)setContent:(NSString *)content {
    self.editable = NO;
    self.scrollEnabled = NO;
    _content = content;
    if (content.length==0) {
        self.text = @"";
        return;
    }
    NSString *str = content;//@"<p><img src=""http://app.goeasy.vip/uploads/image/20200807/1596770957775237.jpg"" title=""1596770957775237.jpg"" alt=""黑金88会员节VIP特权3.jpg""/></p>";
            
    NSString *str2 = [NSString stringWithFormat:@"<head><style> img{width:%f !important;height:auto;display:block;font-size:1px;} </style></head><body>%@</body>",self.maxWidth,str];
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    NSData *data = [str2 dataUsingEncoding:NSUTF8StringEncoding];
   
    self.attributedText = [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}

- (CGFloat )getHtmlHeight:(NSString *)content {
    if (content.length==0) {
        return 0;
    }
    NSString *str = content;
//        NSString *str = @"<p><img src=""http://app.goeasy.vip/uploads/image/20200807/1596770957775237.jpg"" title=""1596770957775237.jpg"" alt=""黑金88会员节VIP特权3.jpg""/></p>";
            
    NSString *str2 = [NSString stringWithFormat:@"<head><style> img{width:%f !important;height:auto;display:block;font-size:1px;} </style></head><body>%@</body>",self.maxWidth,str];
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    NSData *data = [str2 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSAttributedString *html = [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    
    CGFloat h = [JKTextExtension jk_sizeAttributedTextContentToFit:[[NSMutableAttributedString alloc] initWithAttributedString:html] withMaxSize:CGSizeMake(self.maxWidth, CGFLOAT_MAX)].height;
    return h;
}

- (void)clearContainerInset {
    self.textContainerInset = UIEdgeInsetsZero;
    self.textContainer.lineFragmentPadding = 0;
}

@end
