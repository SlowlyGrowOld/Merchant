//
//  SRXGDEvaluationTableView.m
//  ShiRongXinMarketMallProject
//
//  Created by 王先生 on 2022/8/30.
//  Copyright © 2022 Alucardulad. All rights reserved.
//

#import "SRXGDEvaluationTableView.h"
#import "SRXGDEvaluationTableCell.h"

@interface SRXGDEvaluationTableView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) CGFloat contentSizeHeight;
@end

@implementation SRXGDEvaluationTableView

-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
        [self initWithTableView];
    }
    return self;
}
#pragma mark —————评价列表—————
- (void)initWithTableView{
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"SRXGDEvaluationTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SRXGDEvaluationTableCell"];
    self.estimatedRowHeight = 100;
    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)contex {
    if ([keyPath isEqualToString:@"contentSize"]) {
        if (self.contentSizeHeight != self.contentSize.height) {
            NSLog(@"%f",self.contentSize.height);
            self.contentSizeHeight = self.contentSize.height;
            self.heightBlock(self.contentSizeHeight);
        }
    }
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"contentSize"];
}

- (void)setDatas:(NSArray<SRXGELDataItem *> *)datas {
    _datas = datas;
    [self reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SRXGDEvaluationTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SRXGDEvaluationTableCell" forIndexPath:indexPath];
    cell.dataItem = self.datas[indexPath.row];
    return cell;
}

@end
