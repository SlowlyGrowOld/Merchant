//
//  SRXChatFastTextVC.m
//  ShiRongXinMarketMerchant
//
//  Created by 王先生 on 2023/6/12.
//  Copyright © 2023 Alucardulad. All rights reserved.
//

#import "SRXChatFastTextVC.h"

#import "TZImagePickerController.h"
#import "NetworkManager+Common.h"
#import "NetworkManager+MsgSet.h"
#import "SRXArrayTitlesAlertVC.h"

@interface SRXChatFastTextVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *switchView;
@property (weak, nonatomic) IBOutlet UILabel *switch_title;
@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;
@property (weak, nonatomic) IBOutlet UIView *groupView;
@property (weak, nonatomic) IBOutlet UILabel *group_nameLb;
@property (weak, nonatomic) IBOutlet UILabel *tv_title;
@property (weak, nonatomic) IBOutlet UILabel *tv_hint;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *tv_number;
@property (weak, nonatomic) IBOutlet UIView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (nonatomic, assign) NSUInteger limit_number;
@property (nonatomic, copy) NSString *imageUrl;
@end

@implementation SRXChatFastTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textView.textContainer.lineFragmentPadding = 0;
    self.textView.textContainerInset = UIEdgeInsetsZero;
    if (self.type == SRXChatFastTextTypePhrase) {
        self.switchView.hidden = YES;
        self.tv_title.text = @"短语内容";
        self.tv_hint.text = @"请输入正文";
        self.tv_number.text = @"0/300";
        self.limit_number = 300;
        [self.cancelBtn setTitle:self.replys?@"删除":@"取消" forState:UIControlStateNormal];
        if (self.replys) {
            self.title = @"编辑短语";
            self.cancelBtn.hidden = NO;
        }else {
            self.title = @"新增短语";
            self.cancelBtn.hidden = YES;
        }
    } else if (self.type == SRXChatFastTextTypeWelcome) {
        self.title = @"新增欢迎语";
        self.groupView.hidden = YES;
        self.switch_title.text = @"是否启用欢迎语";
        self.tv_title.text = @"欢迎语";
        self.tv_hint.text = @"请输入欢迎语";
        self.tv_number.text = @"0/100";
        self.limit_number = 100;
    } else if (self.type == SRXChatFastTextTypeEvaluate) {
        self.title = @"客户评价设置";
        self.groupView.hidden = YES;
        self.imageView.hidden = YES;
        self.switch_title.text = @"自动邀请评价";
        self.tv_title.text = @"邀请文本";
        self.tv_hint.text = @"请输入邀请评价文本";
        self.tv_number.text = @"0/20";
        self.limit_number = 20;
    }
    
    [self.imgView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
        imagePickerVc.allowPickingVideo = NO;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            [NetworkManager commonUploadsImages:photos
                                      isNeedHUD:YES
                                        success:^(NSDictionary * _Nonnull messageDic) {
                self.imageUrl = messageDic[@"data"];
                [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
            }failure:^(NSString * _Nonnull error) {
                
            }];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
    }];
    
    [self.groupView jk_addTapActionWithBlock:^(UITapGestureRecognizer * _Nonnull gestureRecoginzer) {
        SRXArrayTitlesAlertVC *vc = [[SRXArrayTitlesAlertVC alloc] init];
        vc.type = SRXArrayTitlesTypeGroup;
        MJWeakSelf;
        vc.selectBlock = ^(SRXArrayTitlesModel * _Nonnull model) {
            weakSelf.group_id = model._id;
            weakSelf.group_name = model.name;
            weakSelf.group_nameLb.text = model.name;
            weakSelf.group_nameLb.textColor = CFont3D;
        };
        [[UIViewController jk_currentNavigatonController] presentViewController:vc animated:YES completion:nil];
    }];
    
    [self requestData];
}

- (void)requestData {
    if (self.type == SRXChatFastTextTypePhrase) {
        if (self.replys) {
            self.textView.text = self.replys.reply_content;
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.replys.reply_img] placeholderImage:[UIImage imageNamed:@"image_load_icon"]];
            self.tv_hint.hidden = self.replys.reply_content.length>0?YES:NO;
            self.imageUrl = self.replys.reply_img;
            self.tv_number.text = [NSString stringWithFormat:@"%zd/%zd",self.textView.text.length,self.limit_number];
            self.group_nameLb.text = self.replys.group_name;
            self.group_nameLb.textColor = CFont3D;
        }else {
            self.group_nameLb.text = self.group_name;
            self.group_nameLb.textColor = CFont3D;
        }
    } else if (self.type == SRXChatFastTextTypeWelcome) {
        [NetworkManager getChatWelcomeWithShop_id:@"" success:^(SRXMsgChatWelcome * _Nonnull welcome) {
            self.switchBtn.on = welcome.is_auto_welcome;
            self.textView.text = welcome.welcome_content;
            self.tv_hint.hidden = welcome.welcome_content.length>0?YES:NO;
            self.tv_number.text = [NSString stringWithFormat:@"%zd/%zd",self.textView.text.length,self.limit_number];
            self.imageUrl = welcome.welcome_img;
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:welcome.welcome_img] placeholderImage:[UIImage imageNamed:@"image_load_icon"]];
        } failure:^(NSString *message) {
            
        }];
    } else if (self.type == SRXChatFastTextTypeEvaluate) {
        [NetworkManager getChatInviteEvaluateWithShop_id:@"" success:^(SRXMsgChatEvaluate * _Nonnull evaluate) {
            self.switchBtn.on = evaluate.is_auto_invite;
            self.textView.text = evaluate.invite_content;
            self.tv_hint.hidden = evaluate.invite_content.length>0?YES:NO;
            self.tv_number.text = [NSString stringWithFormat:@"%zd/%zd",self.textView.text.length,self.limit_number];
        } failure:^(NSString *message) {
            
        }];
    }
}

#pragma mark - UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView {
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    if (selectedRange && pos) {
        return;
    }
    if (textView.text.length>self.limit_number) {
        textView.text = [textView.text substringToIndex:self.limit_number];
    }
    self.tv_number.text = [NSString stringWithFormat:@"%zd/%zd",textView.text.length,self.limit_number];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.tv_hint.hidden = YES;
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    self.tv_hint.hidden = textView.text.length>0?YES:NO;
    return YES;
}

- (IBAction)switchBtnClick:(UISwitch *)sender {
//    sender.on = !sender.isOn;
}

- (IBAction)cancelBtnClick:(id)sender {
    if ([self.cancelBtn.titleLabel.text isEqualToString:@"删除"]) {
        [NetworkManager setQuickReplyPhraseWithType:@"3" group_id:self.replys.group_id replay_content:self.textView.text reply_img:self.imageUrl reply_id:self.replys.reply_id success:^(NSString *message) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.refreshBlock){self.refreshBlock();};
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(NSString *message) {
            
        }];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)saveBtnClick:(id)sender {
    if (self.type == SRXChatFastTextTypePhrase) {
        [NetworkManager setQuickReplyPhraseWithType:self.replys?@"2":@"1" group_id:self.group_id replay_content:self.textView.text reply_img:self.imageUrl reply_id:self.replys.reply_id success:^(NSString *message) {
            [SVProgressHUD showSuccessWithStatus:@"编辑成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.refreshBlock){self.refreshBlock();};
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(NSString *message) {
            
        }];
    } else if (self.type == SRXChatFastTextTypeWelcome) {
        [NetworkManager setChatWelcomeWithShop_id:@"" is_auto_welcome:self.switchBtn.isOn?@"1":@"0" welcome_content:self.textView.text welcome_img:self.imageUrl success:^(NSString *message) {
            [SVProgressHUD showSuccessWithStatus:@"编辑成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(NSString *message) {
            
        }];
    } else if (self.type == SRXChatFastTextTypeEvaluate) {
        [NetworkManager setChatInviteEvaluateWithShop_id:@"" is_auto_invite:self.switchBtn.isOn?@"1":@"0" invite_content:self.textView.text success:^(NSString *message) {
            [SVProgressHUD showSuccessWithStatus:@"编辑成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } failure:^(NSString *message) {
            
        }];
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
