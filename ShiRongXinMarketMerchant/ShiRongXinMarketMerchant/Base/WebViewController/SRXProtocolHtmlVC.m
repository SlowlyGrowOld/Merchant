//
//  SRXMemberCenterImageVC.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/11/16.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXProtocolHtmlVC.h"
#import "SRXHtmlTextView.h"

@interface SRXProtocolHtmlVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation SRXProtocolHtmlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollView.backgroundColor = UIColor.whiteColor;
    self.textView.backgroundColor = UIColor.whiteColor;
    if (self.type == SRXProtocolHtmlTypeUserProtocol) {
        self.title = @"用户协议";
        [self requestUserProtocol];
    }else if (self.type == SRXProtocolHtmlTypePrivacyPolicy) {
        self.title = @"隐私政策";
        [self requestUserProtocol];
    }
}

//用户协议 隐私政策
- (void)requestUserProtocol {
    [SVProgressHUD show];
    NSDictionary *dic;
    if (self.type == SRXProtocolHtmlTypeUserProtocol) {
        dic = @{@"agreement_type":@"user_protocol"};
    }else {
        dic = @{@"agreement_type":@"privacy_policy"};
    }
    [[NetworkManager sharedClient] getWithURLString:@"shop/get_agreement" parameters:dic isNeedSVP:nil success:^(NSDictionary *messageDic) {
        self.content = messageDic[@"data"];
    } failure:^(NSString *error) {
        
    }];
}

- (void)setContent:(NSString *)content {
    _content = content;
    if (content.length==0) {
        self.textView.text = @"";
        return;
    }
    NSString *str = content;//@"<p><img src=""http://app.goeasy.vip/uploads/image/20200807/1596770957775237.jpg"" title=""1596770957775237.jpg"" alt=""黑金88会员节VIP特权3.jpg""/></p>";
            
    NSString *str2 = [NSString stringWithFormat:@"<head><style> img{width:%f !important;height:auto;display:block;font-size:1px;} </style></head><body>%@</body>",kScreenWidth,str];
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    NSData *data = [str2 dataUsingEncoding:NSUTF8StringEncoding];
   
    self.textView.attributedText = [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}
@end
