//
//  SRXChatQuickReplyVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/13.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatQuickReplyVC.h"
#import "SRXChatFastTextVC.h"
#import "SRXTextFieldAlertVC.h"
#import "NetworkManager+MsgSet.h"
#import "SRXMessageSetModel.h"
#import "SRXQuickReplyPhraseTableCell.h"
#import "SRXQuickReplyGroupNameTableCell.h"

@interface SRXChatQuickReplyVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *groupTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *groupTableConsW;
@property (weak, nonatomic) IBOutlet UITableView *phraseTableView;
@property (weak, nonatomic) IBOutlet UIButton *addGroupBtn;
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) SRXMsgReplysGroupItem *currentGroup;
@property (nonatomic, strong) UIButton *rightBtn;
@end

@implementation SRXChatQuickReplyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"编辑回复短语";
    [self.addGroupBtn setImagePosition:LXMImagePositionLeft spacing:4];
    self.groupTableView.rowHeight = 40;
    [self.groupTableView registerNib:[UINib nibWithNibName:@"SRXQuickReplyGroupNameTableCell" bundle:nil] forCellReuseIdentifier:@"SRXQuickReplyGroupNameTableCell"];
    [self.phraseTableView registerNib:[UINib nibWithNibName:@"SRXQuickReplyPhraseTableCell" bundle:nil] forCellReuseIdentifier:@"SRXQuickReplyPhraseTableCell"];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 44);
    btn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    [btn setTitle:@"编辑分组" forState:UIControlStateNormal];
    [btn setTitleColor:CFont3D forState:UIControlStateNormal];
    [btn setTitle:@"完成" forState:UIControlStateSelected];
    [btn setTitleColor:CFont3D forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.rightBtn = btn;
    
    [self requestData];
}

- (void)editBtnClick {
    self.rightBtn.selected = !self.rightBtn.isSelected;
    self.groupTableConsW.constant = self.rightBtn.isSelected?146:94;
    [self.groupTableView reloadData];
}

- (void)setCurrentGroup:(SRXMsgReplysGroupItem *)currentGroup {
    _currentGroup = currentGroup;
    if(currentGroup.replys.count==0) {
        [self showNoDataImageToView:self.phraseTableView];
    }else {
        [self removeNoDataImage];
    }
}

#pragma mark - request
- (void)requestData {
    [NetworkManager getQuickReplyGroupWithWithShop_id:@"" success:^(NSArray *modelList) {
        self.datas = modelList;
        [self.groupTableView reloadData];
        if (self.datas.count>0) {
            if (self.currentGroup) {
                for (SRXMsgReplysGroupItem *item in self.datas) {
                    if ([item.group_id isEqualToString:self.currentGroup.group_id]) {
                        self.currentGroup = item;
                    }
                }
            }else {
                self.currentGroup = self.datas.firstObject;
            }
            self.currentGroup.is_select = YES;
            [self.phraseTableView reloadData];
        }
    } failure:^(NSString *message) {
        
    }];
}

- (void)setGroupNameWithName:(NSString *)name type:(NSString *)type group_id:(NSString *)group_id{
    [NetworkManager setQuickReplyGroupWithType:type group_id:group_id group_name:name shop_id:@"" success:^(NSString *message) {
        [self requestData];
    } failure:^(NSString *message) {
        
    }];
}

#pragma mark - UIButton event
- (IBAction)addPhraseBtnClick:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
    SRXChatFastTextVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXChatFastTextVC"];
    vc.type = SRXChatFastTextTypePhrase;
    vc.group_id = self.currentGroup.group_id;
    vc.group_name = self.currentGroup.group_name;
    MJWeakSelf;
    vc.refreshBlock = ^{
        [weakSelf requestData];
    };
    [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
}

- (IBAction)addGroupBtnClick:(id)sender {
    SRXTextFieldAlertVC *vc = [[SRXTextFieldAlertVC alloc] init];
    vc.placeholder = @"请输入分组名";
    MJWeakSelf;
    vc.block = ^(NSString * _Nonnull nickname) {
        [weakSelf setGroupNameWithName:nickname type:@"1" group_id:@""];
    };
    [[UIViewController jk_currentViewController] presentViewController:vc animated:YES completion:nil];
}

#pragma mark - request
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.groupTableView) {
        return self.datas.count;
    } else {
        return self.currentGroup.replys.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.groupTableView) {
        SRXQuickReplyGroupNameTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXQuickReplyGroupNameTableCell" forIndexPath:indexPath];
        SRXMsgReplysGroupItem *item = self.datas[indexPath.row];
        cell.nameLb.text = item.group_name;
        cell.backgroundColor = item.is_select?UIColor.whiteColor:CViewBgColor;
        if (self.rightBtn.isSelected) {
            cell.imgView.hidden = NO;
            cell.delBtn.hidden = NO;
        } else {
            cell.imgView.hidden = YES;
            cell.delBtn.hidden = YES;
        }
        MJWeakSelf;
        [cell.delBtn addCallBackAction:^(UIButton *button) {
            [NetworkManager setQuickReplyGroupWithType:@"3" group_id:item.group_id group_name:item.group_name shop_id:@"" success:^(NSString *message) {
                [weakSelf requestData];
            } failure:^(NSString *message) {
                
            }];
        }];
        return cell;
    } else {
        SRXQuickReplyPhraseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXQuickReplyPhraseTableCell" forIndexPath:indexPath];
        SRXMsgReplysItem *item = self.currentGroup.replys[indexPath.row];
        cell.titleLb.text = item.reply_content;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.groupTableView) {
        if (self.rightBtn.isSelected) {
            SRXMsgReplysGroupItem *item = self.datas[indexPath.row];
            SRXTextFieldAlertVC *vc = [[SRXTextFieldAlertVC alloc] init];
            vc.default_text = item.group_name;
            vc.placeholder = @"请输入分组名";
            MJWeakSelf;
            vc.block = ^(NSString * _Nonnull nickname) {
                [weakSelf setGroupNameWithName:nickname type:@"2" group_id:item.group_id];
            };
            [[UIViewController jk_currentViewController] presentViewController:vc animated:YES completion:nil];
        } else {
            for (SRXMsgReplysGroupItem *item in self.datas) {
                item.is_select = NO;
            }
            SRXMsgReplysGroupItem *item = self.datas[indexPath.row];
            item.is_select = YES;
            self.currentGroup = item;
            [self.groupTableView reloadData];
            [self.phraseTableView reloadData];
        }
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Message" bundle:nil];
        SRXChatFastTextVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"SRXChatFastTextVC"];
        vc.type = SRXChatFastTextTypePhrase;
        vc.group_id = self.currentGroup.group_id;
        vc.group_name = self.currentGroup.group_name;
        vc.replys = self.currentGroup.replys[indexPath.row];
        MJWeakSelf;
        vc.refreshBlock = ^{
            [weakSelf requestData];
        };
        [[UIViewController jk_currentNavigatonController] pushViewController:vc animated:YES];
    }
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
