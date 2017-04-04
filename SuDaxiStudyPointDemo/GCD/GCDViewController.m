//
//  ViewController.m
//  EffectiveRangeBtn
//
//  Created by SYQ on 2017/3/1.
//  Copyright © 2017年 SYQ. All rights reserved.
//

#import "GCDViewController.h"
#import "Person+PersonExtention.h"
@interface GCDViewController ()

@property (nonatomic, strong) ClickBtn *btn;

@property (nonatomic, strong) NSArray *array0;
@property (nonatomic ,copy) NSArray *array1;
@property (nonatomic, strong) NSMutableArray *array2;
@property (nonatomic, copy) NSMutableArray *array3;


@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self.array0 mutableCopy];
    ClickBtn *btn = [[ClickBtn alloc] init];
//    WithFrame:CGRectMake((self.view.width - 250)/2, self.view.height*0.5 - 30, 250, 60)
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btn = btn;
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40);
        make.centerX.equalTo(self.view);
//        make.width.height.equalTo(@30);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}

-(void)click{
    
    NSLog(@"点击到了区域");
    //类别
    /*
     Person *p = [Person new];
     p.age = 18;
     [p saySex];
     */

    //masonry用来做动画的时候，首先需要强制刷新写动画，使其生成约束后再直接跑动画。
    /*
     //如果其约束还没有生成的时候需要动画的话，请先强制刷新后才写动画，否则所有没生成的约束会直接跑动画
     [self.btn.superview layoutIfNeeded];
     
     [UIView animateWithDuration:3 animations:^{
     [self.btn mas_updateConstraints:^(MASConstraintMaker *make) {
     make.top.equalTo(self.view).offset(300);
     }];
     }];
     //强制绘制
     [self.btn.superview layoutIfNeeded];
     */
  
}
-(void)blcokProblem{
    
    void (^block)(void) = ^{
        NSLog(@"block get called");
    };
    block();
    [self blockProblemAnswer0:block];
}

-(void)blockProblemAnswer0:(void (^)(void))block{
    [UIView animateWithDuration:0 animations:block];
    
    dispatch_async(dispatch_get_main_queue(), block);
}

-(void)blockProblemAnswer1:(void (^)(void))block{
    [[NSBlockOperation blockOperationWithBlock:block] start];
}
-(void)blockProblemAnswer2:(void (^)(void))block{
    [[NSInvocation invocationWithMethodSignature:[NSMethodSignature signatureWithObjCTypes:"v@?"]] invokeWithTarget:block];
}
-(void)blockProblemAnswer3:(void (^)(void))block{
    [block invoke];
}

-(void)blockProblemAnswer4:(void (^)(void))block{
    void *pBlock = (__bridge void *)block;
    void (*invoke)(void *, ...) = *((void **)pBlock + 2);
    invoke(pBlock);
}

/*
 使用GCD就是队列+任务
 * 串行队列+同步执行
 * 串行队列+异步执行
 * 并发队列+同步执行
 * 并发队列+异步执行
 * 主队列+同步执行
 * 主队列+异步执行
 补充说明:主队列属于串行队列，但因其特殊性单独列出来。
 
 归纳注意事项：
 （1）创建一个队列与创建一个线程是不同的两件事。
 （2）在一个线程内可能会有多个队列，混杂有串行队列和并行队列。
 （3）是否创建新线程，取决于队列是同步执行还是异步执行。
 （4）死锁问题。
 
 */
//-(void)click{
//    NSLog(@"点击到了区域");
//    [self KSserialQueueSync];//串行队列+同步执行
//    [self KSserialQueueAsync]; //串行队列+异步执行
//    [self KSconcurrentQueueSync];//并发队列+同步执行
//    [self KSconcurrentQueueAsync];//并发队列+异步执行
//    [self KSmainQueueSync];//主队列+同步执行
    //KSmainQueueSync在主线程执行，KSmainQueueSync里面属于主队列+同步。
    /*
    dispatch_queue_t queue = dispatch_queue_create("ks.serialQueue", NULL);
    dispatch_async(queue, ^{
        [self KSmainQueueSync];
    });
    */
//    [self KSmainQueueAsync];//主队列+异步执行
//    [self KSGroupAsync];//dispatch_group_async的使用,监听一组任务是否完成，完成后得到通知执行其他的操作
//    [self KSBarrierAsync];//栅栏函数
//    [self KSBarrierSync];//栅栏函数
//    [self KSapplyAsync];
//    [self KSapplySync];

//}
-(void)KSapplySync{
    NSLog(@"test start");
    NSArray *array = [NSArray arrayWithObjects:@"/Users/chentao/Desktop/copy_res/gelato.ds",
                      @"/Users/chentao/Desktop/copy_res/jason.ds",
                      @"/Users/chentao/Desktop/copy_res/jikejunyi.ds",
                      @"/Users/chentao/Desktop/copy_res/molly.ds",
                      @"/Users/chentao/Desktop/copy_res/zhangdachuan.ds",
                      nil];
    NSString *copyDes = @"/Users/chentao/Desktop/copy_des";
    NSFileManager *filemanager = [NSFileManager defaultManager];
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        dispatch_apply([array count], dispatch_get_global_queue(0, 0), ^(size_t index){
            NSLog(@"copy--%ld",index);
            NSString *sourcePath = [array objectAtIndex:index];
            NSString *desPath = [NSString stringWithFormat:@"%@ %@",copyDes,[sourcePath lastPathComponent]];
            [filemanager copyItemAtPath:sourcePath toPath:desPath error:nil];
        });
        NSLog(@"done");
    });
    
    NSLog(@"test over");
    /*
     2017-03-02 17:14:05.207854 [23542:7561263] test start
     2017-03-02 17:14:05.208091 [23542:7561263] copy--0
     2017-03-02 17:14:05.209369 [23542:7561263] copy--1
     2017-03-02 17:14:05.209743 [23542:7561263] copy--2
     2017-03-02 17:14:05.210013 [23542:7561263] copy--3
     2017-03-02 17:14:05.210271 [23542:7561263] copy--4
     2017-03-02 17:14:05.210520 [23542:7561263] done
     2017-03-02 17:14:05.210634 [23542:7561263] test over
    
     这里 dispatch_apply如果换成串行队列上，则会依次输出index，但这样违背了我们想并行提高执行效率的初衷。
     */
}
-(void)KSapplyAsync{
    NSLog(@"test start");
    NSArray *array = [NSArray arrayWithObjects:@"/Users/chentao/Desktop/copy_res/gelato.ds",
                      @"/Users/chentao/Desktop/copy_res/jason.ds",
                      @"/Users/chentao/Desktop/copy_res/jikejunyi.ds",
                      @"/Users/chentao/Desktop/copy_res/molly.ds",
                      @"/Users/chentao/Desktop/copy_res/zhangdachuan.ds",
                      nil];
    NSString *copyDes = @"/Users/chentao/Desktop/copy_des";
    NSFileManager *filemanager = [NSFileManager defaultManager];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_apply([array count], dispatch_get_global_queue(0, 0), ^(size_t index){
            NSLog(@"copy--%ld",index);
            NSString *sourcePath = [array objectAtIndex:index];
            NSString *desPath = [NSString stringWithFormat:@"%@ %@",copyDes,[sourcePath lastPathComponent]];
            [filemanager copyItemAtPath:sourcePath toPath:desPath error:nil];
        });
        NSLog(@"done");
    });

    NSLog(@"test over");
    
     /*
     输出结果
     2017-03-02 17:10:42.559368 [23539:7559508] test start
     2017-03-02 17:10:42.559540 [23539:7559508] test over
     2017-03-02 17:10:42.559740 [23539:7560427] copy--0
     2017-03-02 17:10:42.560077 [23539:7559696] copy--1
     2017-03-02 17:10:42.560125 [23539:7560427] copy--2
     2017-03-02 17:10:42.560382 [23539:7559696] copy--3
     2017-03-02 17:10:42.560425 [23539:7560427] copy--4
     2017-03-02 17:10:42.560700 [23539:7560427] done
     输出结果分析：
     输出 copy-index 顺序不确定，因为它是并行执行的（dispatch_get_global_queue是并行队列），
     但是done是在以上拷贝操作完成后才会执行，因此,它一般都是放在dispatch_async里面（异步）
     这里 dispatch_apply如果换成串行队列上，则会依次输出index，但这样违背了我们想并行提高执行效率的初衷。
     */
}
//dispatch_apply
//执行某个代码片段N次。
//dispatch_apply(5, globalQ, ^(size_t index) {
//    // 执行5次
//    
//});

-(void)KSBarrierSync//栅栏函数
{
    NSLog(@"test start");
    //同dispatch_queue_create函数生成的concurrent Dispatch Queue队列一起使用
    dispatch_queue_t queue = dispatch_queue_create("ks.barrier", DISPATCH_QUEUE_CONCURRENT);
    
    //异步执行
    dispatch_sync(queue, ^{
        NSLog(@"dispatch_sync1");
    });
    dispatch_sync(queue, ^{
        NSLog(@"dispatch_sync2");
    });
    dispatch_barrier_sync(queue, ^{
        NSLog(@"dispatch_barrier_sync");
    });
    dispatch_sync(queue, ^{
        NSLog(@"dispatch_sync3");
    });
    NSLog(@"test over");
    /*
     输出结果
     2017-03-02 16:06:54.617367 [23467:7533386] test start
     2017-03-02 16:06:54.617537 [23467:7533386] dispatch_sync1
     2017-03-02 16:06:54.617666 [23467:7533386] dispatch_sync2
     2017-03-02 16:06:54.617795 [23467:7533386] dispatch_barrier_sync
     2017-03-02 16:06:54.617904 [23467:7533386] dispatch_sync3
     2017-03-02 16:06:54.618010 [23467:7533386] test over
     输出结果分析：
     同步执行，不创建新的线程，在主线程中执行。
     虽然是并发队列，但因为是同步执行，没有体现出并发性，任务还是一个接一个执行。
     因为所有的任务都在test start 和 test over之间执行，所以说明任务一加入队列就马上执行。
     当dispatch_group_notify监听dispatch_group_t任务组事件的执行完毕，就执行notify里面的函数。
     dispatch_barrier_async函数的作用与barrier的意思相同,在进程管理中起到一个栅栏的作用。
     它等待所有位于barrier函数之前的操作执行完毕后执行,并且在barrier函数执行之后,barrier函数之后的操作才会得到执行。
     该函数需要同dispatch_queue_create函数生成的concurrent Dispatch Queue队列一起使用
     */
    
}
-(void)KSBarrierAsync//栅栏函数
{
    NSLog(@"test start");
    //同dispatch_queue_create函数生成的concurrent Dispatch Queue队列一起使用
    dispatch_queue_t queue = dispatch_queue_create("ks.barrier", DISPATCH_QUEUE_CONCURRENT);
    
    //异步执行
    dispatch_async(queue, ^{
        NSLog(@"dispatch_async1");
    });
    dispatch_async(queue, ^{
        NSLog(@"dispatch_async2");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"dispatch_barrier_async");
    });
    dispatch_async(queue, ^{
        NSLog(@"dispatch_async3");
    });
    NSLog(@"test over");
    /*
     输出结果
     2017-03-02 15:51:57.976431 [23450:7528400] test start
     2017-03-02 15:51:57.976816 [23450:7528400] test over
     2017-03-02 15:51:59.980996 [23450:7528479] dispatch_async2
     2017-03-02 15:51:59.981086 [23450:7528434] dispatch_async1
     2017-03-02 15:52:03.985603 [23450:7528434] dispatch_barrier_async
     2017-03-02 15:52:04.987255 [23450:7528434] dispatch_async3
     输出结果分析：
     因为异步执行，所以创建了新的线程。dispatch_async1、dispatch_async2顺序不确定。
     因为所有队列任务执行在test start和test over之后，说明任务不是添加到队列之后立马执行，而是当所有任务添加到队列之后再执行。
     当dispatch_group_notify监听dispatch_group_t任务组事件的执行完毕，就执行notify里面的函数。
     dispatch_barrier_async函数的作用与barrier的意思相同,在进程管理中起到一个栅栏的作用。
     它等待所有位于barrier函数之前的操作执行完毕后执行,并且在barrier函数执行之后,barrier函数之后的操作才会得到执行。
     该函数需要同dispatch_queue_create函数生成的concurrent Dispatch Queue队列一起使用
     */
    
}

//dispatch_group_async的使用,监听一组任务是否完成，完成后得到通知执行其他的操作
-(void)KSGroupAsync{
    NSLog(@"test start");
    //dispatch_get_global_queue属于系统的，直接拿过来（GET）用就可以。与并行队列类似，但调试时，无法确认操作所在队列。
    //创建全局队列 调度任务组
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建队列组
    dispatch_group_t group = dispatch_group_create();
    //异步执/
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"group1");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"group2");
    });
    dispatch_group_async(group, queue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"group3");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"updateUi");
    });
    
    NSLog(@"test over");
    /*
     输出结果
     2017-03-02 12:03:49.497041 [23247:7454402] test start
     2017-03-02 12:03:49.498019 [23247:7454402] test over
     2017-03-02 12:03:50.502968 [23247:7454433] group1
     2017-03-02 12:03:51.502366 [23247:7454528] group2
     2017-03-02 12:03:52.503071 [23247:7454533] group3
     2017-03-02 12:03:52.503386 [23247:7454402] updateUi
     
     如果注释掉[NSThread sleepForTimeInterval:time];的方法
     输出结果：
     2017-03-02 12:04:52.419193 [23249:7454819] test start
     2017-03-02 12:04:52.419472 [23249:7454819] test over
     2017-03-02 12:04:52.420302 [23249:7454849] group1
     2017-03-02 12:04:52.420440 [23249:7454849] group2
     2017-03-02 12:04:52.420562 [23249:7454849] group3
     2017-03-02 12:04:52.420750 [23249:7454819] updateUi
     
     输出结果分析：
     因为异步执行，所以创建了新的线程。
     因为所有队列任务执行在test start和test over之后，说明任务不是添加到队列之后立马执行，而是当所有任务添加到队列之后再执行。
     当dispatch_group_notify监听dispatch_group_t任务组事件的执行完毕，就执行notify里面的函数。
     */
    
}

//主队列+异步执行
-(void)KSmainQueueAsync{
    NSLog(@"test start");
    //1创建主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //2异步执行
    dispatch_async(mainQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"block1 %@", [NSThread currentThread]);
        }
    });
    dispatch_async(mainQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"block2 %@", [NSThread currentThread]);
        }
    });
    dispatch_async(mainQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"block3 %@", [NSThread currentThread]);
        }
    });
    NSLog(@"test over");
    /*
     输出结果
     [23239:7447294] test start
     [23239:7447294] test over
     [23239:7447294] block1 <NSThread: 0x17007e480>{number = 1, name = main}
     [23239:7447294] block1 <NSThread: 0x17007e480>{number = 1, name = main}
     [23239:7447294] block2 <NSThread: 0x17007e480>{number = 1, name = main}
     [23239:7447294] block2 <NSThread: 0x17007e480>{number = 1, name = main}
     [23239:7447294] block3 <NSThread: 0x17007e480>{number = 1, name = main}
     [23239:7447294] block3 <NSThread: 0x17007e480>{number = 1, name = main}
     输出结果分析：
     虽然是异步执行，可以开启新的线程，但因为是主队列，它只会在主线程中执行。
     因为主队列是特殊的串行队列，所以队列的任务一个接着一个执行。
     因为所有队列任务执行在test start和test over之后，说明任务不是添加到队列之后立马执行，而是当所有任务添加到队列之后再执行。
     */
}

//主队列+同步执行
-(void)KSmainQueueSync{
    NSLog(@"test start");
    //1创建主队列
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    //2同步执行
    dispatch_sync(mainQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"block1 %@", [NSThread currentThread]);
        }
    });
    dispatch_sync(mainQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"block2 %@", [NSThread currentThread]);
        }
    });
    dispatch_sync(mainQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"block3 %@", [NSThread currentThread]);
        }
    });
    
    NSLog(@"test over");
    /*
     输出结果
     [23233:7441638] test start
     (lldb)//然后程序crash。
     只输出一条语句，之后的语句都没有执行。
     主队列是主线程的一条队列。
     发生死锁：我们知道同步执行，不创建新的线程，在主线程中执行，就是要立马执行。
     但是现在主队列无法立马执行，因为当前主线程正在执行的任务是KSmainQueueSync这个方法，需要等待这个方法执行完；
     但是KSmainQueueSync这个方法又要等待第一个、第二个、第三个任务执行完。相互等待而造成死锁。
     
     这种情况下，只要在另一条线程上调用就好了，利用串行队列+异步执行来创建一条新的线程。
     dispatch_queue_t queue = dispatch_queue_create("ks.serialQueue", NULL); 
     dispatch_async(queue, ^{
             [self KSmainQueueSync];
     });
     
     这时候KSmainQueueSync里面属于串行队列+同步执行，在新的线程中执行KSmainQueueSync里面的方法。
     输出日志
     [23236:7445732] test start
     [23236:7445702] block1 <NSThread: 0x170077400>{number = 1, name = main}
     [23236:7445702] block1 <NSThread: 0x170077400>{number = 1, name = main}
     [23236:7445702] block2 <NSThread: 0x170077400>{number = 1, name = main}
     [23236:7445702] block2 <NSThread: 0x170077400>{number = 1, name = main}
     [23236:7445702] block3 <NSThread: 0x170077400>{number = 1, name = main}
     [23236:7445702] block3 <NSThread: 0x170077400>{number = 1, name = main}
     [23236:7445732] test over
     
     输出结果分析：主队列是串行队列的一种，所以之前对串行队列的分析这里也适用
     * 因为是同步执行，所以不创建新的线程，在主线程中执行。
     * 因为是串行队列，所以队列的任务一个接一个地执行。
     * 因为所有任务都在test start和test over之间执行，所以说明任务一加入队列就立马执行。

     */
}
//并发队列+异步执行
-(void)KSconcurrentQueueAsync{
    NSLog(@"test start");
    //1创建并发队列 DISPATCH_QUEUE_CONCURRENT
    dispatch_queue_t concurrentQueue = dispatch_queue_create("ks.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    //2异步执行
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"block1 %@", [NSThread currentThread]);
        }
    });
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"block2 %@", [NSThread currentThread]);
        }
    });
    dispatch_async(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"block3 %@", [NSThread currentThread]);
        }
    });
    NSLog(@"test over");
    
    /*
     输出结果
     [23230:7436402] test start
     [23230:7436402] test over
     [23230:7436427] block2 <NSThread: 0x1740788c0>{number = 4, name = (null)}
     [23230:7436428] block1 <NSThread: 0x17006fb00>{number = 3, name = (null)}
     [23230:7436427] block2 <NSThread: 0x1740788c0>{number = 4, name = (null)}
     [23230:7436427] block3 <NSThread: 0x1740788c0>{number = 4, name = (null)}
     [23230:7436428] block1 <NSThread: 0x17006fb00>{number = 3, name = (null)}
     [23230:7436427] block3 <NSThread: 0x1740788c0>{number = 4, name = (null)}
     输出结果分析：
     因为异步执行，所以创建了新的线程。
     因为并发队列，异步执行时体现其并发性，任务之间交替着同时执行。
     因为所有队列任务执行在test start 和 test over之后，说明任务不是添加到队列之后立马执行，而是当所有任务添加到队列后再执行。
     */
}

//并发队列+同步执行
-(void)KSconcurrentQueueSync{
    NSLog(@"test start");
    //1创建并发队列 DISPATCH_QUEUE_CONCURRENT
    dispatch_queue_t concurrentQueue = dispatch_queue_create("ks.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    //2同步执行
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"block1 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"block2 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"block3 %@", [NSThread currentThread]);
        }
    });
    
    NSLog(@"test over");
    /*
     输出结果
     2017-03-01 17:03:53.202160 EffectiveRangeBtn[22431:7129494] test start
     2017-03-01 17:03:53.202635 EffectiveRangeBtn[22431:7129494] block1 <NSThread: 0x170260240>{number = 1, name = main}
     2017-03-01 17:03:53.202990 EffectiveRangeBtn[22431:7129494] block1 <NSThread: 0x170260240>{number = 1, name = main}
     2017-03-01 17:03:53.203272 EffectiveRangeBtn[22431:7129494] block2 <NSThread: 0x170260240>{number = 1, name = main}
     2017-03-01 17:03:53.203543 EffectiveRangeBtn[22431:7129494] block2 <NSThread: 0x170260240>{number = 1, name = main}
     2017-03-01 17:03:53.203816 EffectiveRangeBtn[22431:7129494] block3 <NSThread: 0x170260240>{number = 1, name = main}
     2017-03-01 17:03:53.204083 EffectiveRangeBtn[22431:7129494] block3 <NSThread: 0x170260240>{number = 1, name = main}
     2017-03-01 17:03:53.204209 EffectiveRangeBtn[22431:7129494] test over
     输出结果分析：
     同步执行，不创建新的线程，在主线程中执行。
     虽然是并发队列，但因为是同步执行，没有体现出并发性，任务还是一个接一个执行。
     因为所有的任务都在test start 和 test over之间执行，所以说明任务一加入队列就马上执行。
     */
}

//串行队列+异步执行
-(void)KSserialQueueAsync{
    NSLog(@"test start");
    //1创建串行队列 NULL 或者 DISPATCH_QUEUE_SERIAL
    dispatch_queue_t serialQueue = dispatch_queue_create("ks.serialQueue", NULL);
    //2、异步执行
    dispatch_async(serialQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"block1 %@",[NSThread currentThread]);
        }
    });
    dispatch_async(serialQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"block2 %@",[NSThread currentThread]);
        }
    });
    dispatch_async(serialQueue, ^{
        for (int i = 0; i < 2; i++) {
            NSLog(@"block3 %@",[NSThread currentThread]);
        }
    });
    NSLog(@"test over");
    
    /*
     输出结果
     [22416:7125131] test start
     [22416:7125131] test over
     [22416:7125175] block1 <NSThread: 0x17407e100>{number = 3, name = (null)}
     [22416:7125175] block1 <NSThread: 0x17407e100>{number = 3, name = (null)}
     [22416:7125175] block2 <NSThread: 0x17407e100>{number = 3, name = (null)}
     [22416:7125175] block2 <NSThread: 0x17407e100>{number = 3, name = (null)}
     [22416:7125175] block3 <NSThread: 0x17407e100>{number = 3, name = (null)}
     [22416:7125175] block3 <NSThread: 0x17407e100>{number = 3, name = (null)}
     输出结果分析
     异步执行，所以创建了新的线程。
     串行队列，所以队列的任务一个接一个地执行。
     因为所有的队列任务执行在test start 和 test over之后，所以说明任务不是添加到队列之后立马执行，而是当所有的任务添加到队列后在执行。
     */
}

//串行队列+同步执行
-(void)KSserialQueueSync{
    NSLog(@"test start");
    //1创建串行队列 NULL 或者 DISPATCH_QUEUE_SERIAL
    dispatch_queue_t serialQueue = dispatch_queue_create("ks.serialQueue", NULL);
//   dispatch_queue_t serialQueue = dispatch_queue_create("ks.serialQueue", DISPATCH_QUEUE_SERIAL);
    //2同步执行
    dispatch_sync(serialQueue, ^{
        for (int i = 0; i < 2; i++) {
        NSLog(@"block1 %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(serialQueue, ^{
        for (int i = 0; i < 2; i++) {
        NSLog(@"block2 %@",[NSThread currentThread]);
        }
    });
    dispatch_sync(serialQueue, ^{
        for (int i = 0; i < 2; i++) {
        NSLog(@"block3 %@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"test over");
    /*
     输出结果
     [22412:7123817] test start
     [22412:7123817] block1 <NSThread: 0x170263300>{number = 1, name = main}
     [22412:7123817] block1 <NSThread: 0x170263300>{number = 1, name = main}
     [22412:7123817] block2 <NSThread: 0x170263300>{number = 1, name = main}
     [22412:7123817] block2 <NSThread: 0x170263300>{number = 1, name = main}
     [22412:7123817] block3 <NSThread: 0x170263300>{number = 1, name = main}
     [22412:7123817] block3 <NSThread: 0x170263300>{number = 1, name = main}
     [22412:7123817] test over
     输出结果分析
     同步执行，所以不创建新的线程，在主线程中执行。
     串行队列，所以队列的任务一个接一个地执行。
     因为所有的任务都在test start 和 test over之间执行，所以说明任务一加入队列就立马执行。
     */
    
}
@end
