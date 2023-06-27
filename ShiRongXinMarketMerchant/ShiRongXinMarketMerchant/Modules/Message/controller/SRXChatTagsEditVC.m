//
//  SRXChatTagsEditVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/13.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatTagsEditVC.h"
#import "NetworkManager+MsgSet.h"
#import "UIColor+JHExt.h"

@interface SRXChatTagsEditVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *numberLb;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, copy) NSString *label_color;
@end

@implementation SRXChatTagsEditVC

- (void)dealloc {
    [self.textField removeAllTargets];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.cancelBtn setTitle:self.item?@"删除":@"取消" forState:UIControlStateNormal];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    if (self.item) {
        self.title = @"编辑标签";
        UIImage *image = [UIImage imageNamed:@"star_yellow"];
        self.imgView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.imgView setTintColor:[UIColor colorWithHexString:self.item.label_color_number alpha:1]];
        self.textField.text = self.item.label_name;
        self.label_color = self.item.label_color_number;
    } else {
        self.title = @"新增标签";
        self.label_color = @"#FF0000";
        UIImage *image = [UIImage imageNamed:@"star_yellow"];
        self.imgView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.imgView setTintColor:[UIColor colorWithHexString:self.label_color alpha:1]];
    }
    [self.textField addTarget:self action:@selector(textFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
}

- (IBAction)saveBtnClick:(id)sender {
    [NetworkManager setShopLabelsWithType:self.item?@"2":@"1" label_name:self.textField.text label_color_number:self.label_color label_id:self.item.label_id shop_id:self.shop_id success:^(NSString *message) {
        [SVProgressHUD showSuccessWithStatus:self.item?@"编辑成功":@"新增标签成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.refreshBlock){self.refreshBlock();};
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(NSString *message) {
        
    }];
}

- (IBAction)cancelBtnClick:(id)sender {
    if ([self.cancelBtn.titleLabel.text isEqualToString:@"删除"]) {
        [NetworkManager setShopLabelsWithType:@"3" label_name:self.textField.text label_color_number:self.label_color label_id:self.item.label_id shop_id:self.shop_id success:^(NSString *message) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.refreshBlock){self.refreshBlock();};
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(NSString *message) {
            
        }];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITextField 监听
- (void)textFieldValueChange:(UITextField *)textField {
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textField positionFromPosition:selectedRange.start offset:0];
    if (selectedRange && pos) {
        return;
    }
    if (textField.text.length>4) {
        textField.text = [textField.text substringToIndex:4];
    }
    self.numberLb.text = [NSString stringWithFormat:@"%zd/4",textField.text.length];
}

#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHexString:self.datas[indexPath.row] alpha:1];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth-60)/7, 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.label_color = self.datas[indexPath.row];
    UIImage *image = [UIImage imageNamed:@"star_yellow"];
    self.imgView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.imgView setTintColor:[UIColor colorWithHexString:self.label_color alpha:1]];
}

- (NSArray *)datas {
    if (!_datas) {
        _datas = @[@"#000000",@"#708069",@"#808A87",@"#808080",@"#C0C0C0",@"#DCDCDC",@"#F5F5F5",@"#FAEBD7",@"#F0FFFF",@"#FFFFCD",@"#FFF8DC",@"#FCE6C9",@"#FFFAF0",@"#F0FFF0",@"#FAFFF0",@"#FAF0E6",@"#FFDEAD",@"#FFF5EE",@"#FF0000",@"#9C661F",@"#E3170D",@"#FF7F50",@"#B22222",@"#B0171F",@"#B03060",@"#FFC0CB",@"#872657",@"#FA8072",@"#FF6347",@"#FF4500",@"#EA33F7",@"#FF00FF",@"#A020F0",@"#800080",@"#A066D3",@"#9933FA",@"#DA70D6",@"#DDA0DD",@"#FFFF00",@"#E3CF57",@"#FF9912",@"#EB8E55",@"#FFE384",@"#FFD700",@"#DAA569",@"#E3A869",@"#FF6100",@"#ED9121",@"#FF8000",@"#F5DEB3",@"#802A2A",@"#A39480",@"#8A360F",@"#D2691E",@"#FF7D40",@"#F0E68C",@"#BC8F8F",@"#C76114",@"#734A12",@"#5E2612",@"#A0522D",@"#8B4513",@"#F4A460",@"#D2B48C",@"#0000FF",@"#3D59AB",@"#1E90FF",@"#0B1746",@"#03A89E",@"#191970",@"#33A1C9",@"#B0E0E6",@"#4169E1",@"#6A5ACD",@"#87CEEB",@"#00FFFF",@"#385E0F",@"#082E54",@"#7FFFD4",@"#40E0D0",@"#00FF00",@"#7FFF00",@"#3D9140",@"#00C957",@"#228B22",@"#7CFC00",@"#32CD32",@"#BDFCC9",@"#6B8E23",@"#308014",@"#00FF7F"];
    }
    return _datas;
}
@end
