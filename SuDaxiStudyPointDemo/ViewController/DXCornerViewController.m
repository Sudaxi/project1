//
//  DXCornerViewController.m
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/30.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXCornerViewController.h"

@interface DXCornerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong , nonatomic) UITableView *tableview;

@end

@implementation DXCornerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CornerRadius";
    [self dx_setLeftBarButtonItem];
    
    [self configTableview];
    
}

-(void)configTableview{
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(UITableView *)tableview
{
    if (_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.backgroundColor = UIColorFromRGB(0xf9f9f9);
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.sectionHeaderHeight = 0;
        _tableview.sectionFooterHeight = 0;
//        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.showsVerticalScrollIndicator = NO;
    }
    return _tableview;
}

#pragma mark - tableviewdatasoure && tableviewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *tableviewcell = @"tableviewcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableviewcell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tableviewcell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (NSUInteger i = 0; i < 4; i ++) {
            
        }
    }
    return cell;
}

-(void)addUIImageView:(UIImageView *)imageV index:(NSUInteger)index{
    UIImageView *imagev = [[UIImageView alloc] init];
    imagev.backgroundColor = [UIColor magentaColor];
    
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
