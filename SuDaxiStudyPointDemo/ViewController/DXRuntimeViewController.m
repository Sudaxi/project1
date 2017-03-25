//
//  DXRuntimeViewController.m
//  SuDaxiStudyPointDemo
//
//  Created by SuDaxi on 2017/3/25.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DXRuntimeViewController.h"

@interface DXRuntimeViewController ()

@end

@implementation DXRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"runtime";
    [self dx_setLeftBarButtonItem];
    // Do any additional setup after loading the view.
}
-(void)initNav{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
