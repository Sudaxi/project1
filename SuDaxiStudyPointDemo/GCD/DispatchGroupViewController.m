//
//  DispatchGroupViewController.m
//  SuDaxiStudyPointDemo
//
//  Created by SuDaxi on 2017/4/4.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "DispatchGroupViewController.h"

@interface DispatchGroupViewController ()
@property (nonatomic, strong) UIImageView *imageView1;
@property (nonatomic, strong) UIImageView *imageView2;
@end

@implementation DispatchGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DispatchGroup";
    [self initSubViews];
}

-(void)click{
    NSLog(@"点击到了区域");
//    [self downLoadImages];
    [self downLoadImageWithGroup];
}
-(void)initSubViews{
    ClickBtn *btn = [[ClickBtn alloc] init];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.imageView1 = ({
        UIImageView *img = [UIImageView new];
        img.layer.masksToBounds = YES;
        img.layer.cornerRadius = 10;
        img.layer.borderColor = [UIColor blackColor].CGColor;
        img.layer.borderWidth = 0.5;
        img.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:img];
         img;
    });
    
    self.imageView2 = ({
        UIImageView *img = [UIImageView new];
        img.layer.masksToBounds = YES;
        img.layer.cornerRadius = 10;
        img.layer.borderColor = [UIColor blackColor].CGColor;
        img.layer.borderWidth = 0.5;
        img.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:img];
        img;
    });
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(140);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).offset(24);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.right.mas_equalTo(self.view.mas_centerX).offset(-24);
    }];
    
    [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).offset(24);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.left.mas_equalTo(self.view.mas_centerX).offset(24);
    }];
}
-(UIImage *)imageWithURLString:(NSString *)urlString{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    return [UIImage imageWithData:data];
}

-(void)downLoadImages{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //下载第一张图片
        NSString *url1 = @"http://car0.autoimg.cn/upload/spec/9579/u_20120110174805627264.jpg";
        UIImage *image1 = [self imageWithURLString:url1];
        //下载第二张图片
        NSString *url2 = @"http://hiphotos.baidu.com/lvpics/pic/item/3a86813d1fa41768bba16746.jpg";
        UIImage *image2 = [self imageWithURLString:url2];
        
        //回到主线程显示图片
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView1.image = image1;
            self.imageView2.image = image2;
            NSLog(@"图片1---%@",image1);
            NSLog(@"图片1---%@",image2);
        });
        
    });
}
/*
 虽然这种方案可以解决问题，但其实两张图片的下载过程并不需要按顺序执行，并发执行它们可以提高执行速度。有个注意点就是必须等两张图片都下载完毕后才能回到主线程显示图片。Dispatch Group能够在这种情况下帮我们提升性能。下面先看看Dispatch Group的用处
 我们可以使用dispatch_group_async函数将多个任务关联到一个Dispatch Group和相应的queue中，group会并发地同时执行这些任务。而且Dispatch Group可以用来阻塞一个线程, 直到group关联的所有的任务完成执行。有时候你必须等待任务完成的结果,然后才能继续后面的处理。
 下面用Dispatch Group优化上面的代码：
 */
-(UIImage *)imageGroupWithURLString:(NSString *)urlString{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    return [[UIImage alloc] initWithData:data];
}

-(void)downLoadImageWithGroup{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //异步下载图片
    dispatch_async(queue, ^{
        //create new group
        dispatch_group_t group = dispatch_group_create();
        
        __block UIImage *image1 = nil;
        __block UIImage *image2 = nil;
        
        //关联一个任务到group
        dispatch_group_async(group, queue, ^{
            //下载第一张图片
            NSString *url1 = @"http://car0.autoimg.cn/upload/spec/9579/u_20120110174805627264.jpg";
            image1 = [self imageGroupWithURLString:url1];
        });
        
        //关联一个任务到group
        dispatch_group_async(group, queue, ^{
            //下载图片
            NSString *url2 = @"http://hiphotos.baidu.com/lvpics/pic/item/3a86813d1fa41768bba16746.jpg";
            image2 = [self imageGroupWithURLString:url2];
        });
        //等待组中的任务执行完毕，回到主线程执行block
        dispatch_group_notify(group, queue, ^{
            self.imageView1.image = image1;
            self.imageView2.image = image2;
            NSLog(@"图片1---%@",image1);
            NSLog(@"图片1---%@",image2);
        });
    });
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
