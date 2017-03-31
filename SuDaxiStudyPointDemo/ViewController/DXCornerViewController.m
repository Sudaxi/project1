//
//  DXCornerViewController.m
//  SuDaxiStudyPointDemo
//
//  Created by SYQ on 2017/3/30.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXCornerViewController.h"

@interface DXCornerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong ,nonatomic) UITableView *tableview;

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
    if (!_tableview) {
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
    return 50;
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
//        cell.textLabel.text = @"sjskkd";
        /*
         int:当使用int类型定义变量的时候，可以像写C程序一样，用int也可以用NSInteger，推荐使用NSInteger ，因为这样就不用考虑设备是32位还是64位了。
         NSUInteger是无符号的，即没有负数，NSInteger是有符号的。
         NSInteger是基础类型，NSNumber是一个类，如果需要存储一个数值，直接使用NSInteger是不行的
         */
        for (NSUInteger i = 0; i < 4; i ++) {
            UIImageView *imagev = [[UIImageView alloc] init];
            NSString *imageN = [NSString stringWithFormat:@"image%ld",i];
            [imagev setImage:[UIImage imageNamed:imageN]];
            imagev.size = CGSizeMake(45, 45);
            //帧数杀手，很耗性能
//            imagev.layer.cornerRadius = 45/2.0;
//            imagev.layer.masksToBounds = YES;
           //采用图层画圆角
            CAShapeLayer *layer = [CAShapeLayer layer];
            UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect:imagev.bounds];
            layer.path = aPath.CGPath;
            imagev.layer.mask = layer;
            
            /*
             总结
             上面拖慢帧率的原因其实都是Off-Screen Rendering（离屏渲染）的原因。离屏渲染是个好东西，但是频繁发生离屏渲染是非常耗时的。
             离屏渲染，指的是GPU在当前屏幕缓冲区以外新开辟一个缓冲区进行渲染操作。由上面的一个结论视图和圆角的大小对帧率并没有什么卵影响，数量才是伤害的核心输出啊。可以知道离屏渲染耗时是发生在离屏这个动作上面，而不是渲染。为什么离屏这么耗时？原因主要有创建缓冲区和上下文切换。创建新的缓冲区代价都不算大，付出最大代价的是上下文切换。
             
             */
            
            [cell.contentView addSubview:imagev];
            [imagev mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(45);
                make.centerY.equalTo(cell.contentView);
                make.left.equalTo(cell.contentView).mas_offset((12+45)*i + 12);
            }];
        }
    }
    return cell;
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
