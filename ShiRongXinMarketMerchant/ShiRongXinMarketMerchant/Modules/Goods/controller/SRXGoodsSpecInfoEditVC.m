//
//  SRXGoodsSpecInfoEditVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/5/27.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXGoodsSpecInfoEditVC.h"

@interface SRXGoodsSpecInfoEditVC ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewConsH;
@property (weak, nonatomic) IBOutlet UILabel *sepc_name;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UITextField *package_price;
@property (weak, nonatomic) IBOutlet UITextField *score;
@property (weak, nonatomic) IBOutlet UITextField *profit;
@property (weak, nonatomic) IBOutlet UITextField *market_price;
@property (weak, nonatomic) IBOutlet UITextField *store_count;
@property (weak, nonatomic) IBOutlet UITextField *weight;
@property (weak, nonatomic) IBOutlet UIImageView *spec_img;
@end

@implementation SRXGoodsSpecInfoEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.isBgClose = YES;
    self.contentViewConsH.constant = (kScreenHeight - TopHeight>660)?660:(kScreenHeight - TopHeight);
    [self.contentView settingRadius:20 corner:UIRectCornerTopLeft|UIRectCornerTopRight];
    
    if (self.item) {
        _sepc_name.text = self.item.spec_key_name;
        _price.text = [NSString stringWithNumber:@(self.item.form.price) formatter:@"###.##"];
        _package_price.text = [NSString stringWithNumber:@(self.item.form.package_price) formatter:@"###.##"];
        _market_price.text = [NSString stringWithNumber:@(self.item.form.market_price) formatter:@"###.##"];
        _profit.text = [NSString stringWithNumber:@(self.item.form.profit) formatter:@"###.##"];
        _score.text = @(self.item.form.score).stringValue;
        _store_count.text = @(self.item.form.store_count).stringValue;
        _weight.text = [NSString stringWithNumber:@(self.item.form.weight) formatter:@"###.##"];
        [_spec_img sd_setImageWithURL:[NSURL URLWithString:self.item.form.spec_img] placeholderImage:[UIImage imageNamed:@""]];
    }
}

- (IBAction)resetBtnClick:(id)sender {
}

- (IBAction)saveBtnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
