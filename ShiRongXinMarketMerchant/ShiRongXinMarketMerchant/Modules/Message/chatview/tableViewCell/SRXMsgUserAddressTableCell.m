//
//  SRXMsgShopAddressTableCell.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/10/18.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXMsgUserAddressTableCell.h"
#import "SRXMsgGoodsPicsCollectionCell.h"
#import "SRXOrderDetailsVC.h"

@interface SRXMsgUserAddressTableCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *shop_icon;
@property (weak, nonatomic) IBOutlet UILabel *shop_name;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *singleGoodView;
@property (weak, nonatomic) IBOutlet UIImageView *good_image;
@property (weak, nonatomic) IBOutlet UILabel *good_name;
@property (weak, nonatomic) IBOutlet UILabel *good_num;
@property (weak, nonatomic) IBOutlet UILabel *good_price;
@property (weak, nonatomic) IBOutlet UIView *multiGoodsView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *goods_number;
@property (weak, nonatomic) IBOutlet UILabel *user_name;
@property (weak, nonatomic) IBOutlet UILabel *user_mobile;
@property (weak, nonatomic) IBOutlet UILabel *user_address;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *sureLb;

@end

@implementation SRXMsgUserAddressTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 20);
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(50, 50);
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SRXMsgGoodsPicsCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"SRXMsgGoodsPicsCollectionCell"];
    
    [self.bgView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        [self jumpOrderDetails];
    }];
}

- (void)jumpOrderDetails {

    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Order" bundle:nil];
    SRXOrderDetailsVC *vc = [sb instantiateViewControllerWithIdentifier:@"SRXOrderDetailsVC"];
    vc.shop_id = self.shop_id;
    vc.order_id = self.model.params;
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)updateAddressBtnClick:(id)sender {
//   NSInteger timestamp = [NSDate lc_getTimestamp];
//    if (timestamp > self.model.order_address_info.create_time.integerValue + 2*60*60) {
//        [SVProgressHUD showInfoWithStatus:@"订单已超2个小时，不能更改地址"];
//        self.addressBtn.hidden = YES;
//        return;
//    }
}

- (IBAction)sureBtnClick:(id)sender {
//    [[NetworkManager sharedClient] getWithURLString:@"v2/orderAddressConfirm" parameters:@{@"order_id":self.model.order_address_info.order_id} isNeedSVP:YES success:^(NSDictionary *messageDic) {
//        self.model.order_address_info.is_sure_address = 1;
//        if (self.updateBlock) {
//            self.updateBlock();
//        }
//    } failure:^(NSString *error) {
//
//    }];
}

- (void)setModel:(SRXMsgChatModel *)model {
    _model = model;
    [_shop_icon sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    _shop_name.text = model.nickname;
    _user_name.text = model.order_address_info.consignee;
    _user_mobile.text = model.order_address_info.mobile;
    _user_address.text = model.order_address_info.full_address;
    if (model.order_address_info.goods_count>1) {
        _singleGoodView.hidden = YES;
        _multiGoodsView.hidden = NO;
        _goods_number.text = [NSString stringWithFormat:@"共%ld件",(long)model.order_address_info.goods_info.count];
        [_collectionView reloadData];
    }else if (model.order_address_info.goods_count==1) {
        _singleGoodView.hidden = NO;
        _multiGoodsView.hidden = YES;
        SRXMsgGoodsInfoItem *item = model.order_address_info.goods_info.firstObject;
        [_good_image sd_setImageWithURL:[NSURL URLWithString:item.image]];
        _good_name.text = item.goods_name;
        _good_price.text = model.order_address_info.pay_amount;
        _good_num.text = [NSString stringWithFormat:@"数量 x%ld",(long)model.order_address_info.goods_count];
    }else {
        _singleGoodView.hidden = YES;
        _multiGoodsView.hidden = YES;
    }
    if (model.order_address_info.is_sure_address==1) {
        _sureLb.text = @"已确认";
//        _addressBtn.hidden = YES;
//        [_sureBtn setTitle:@"已确认" forState:UIControlStateNormal];
//        _sureBtn.backgroundColor = UIColorHex(0xcdcdcd);
//        _sureBtn.enabled = NO;
    }else {
        _sureLb.text = @"未确认";
//        if (model.order_address_info.is_change_address) {
//            _addressBtn.hidden = YES;
//        } else if (model.order_address_info.can_change_address) {
//            _addressBtn.hidden = NO;
//        }else {
//            _addressBtn.hidden = YES;
//        }
//        [_sureBtn setTitle:@"确认订单" forState:UIControlStateNormal];
//        _sureBtn.backgroundColor = COrange;
//        _sureBtn.enabled = YES;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.order_address_info.goods_info.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SRXMsgGoodsPicsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SRXMsgGoodsPicsCollectionCell" forIndexPath:indexPath];
    SRXMsgGoodsInfoItem *item = self.model.order_address_info.goods_info[indexPath.item];
    [cell.good_image sd_setImageWithURL:[NSURL URLWithString:item.image]];
    return cell;
}

@end
