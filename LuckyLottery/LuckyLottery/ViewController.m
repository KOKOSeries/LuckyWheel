//
//  ViewController.m
//  LuckyLottery
//
//  Created by JOY CHOW on 2020/12/5.
//

#import "ViewController.h"
#import "KOKLuckyLotteryView.h"
#import "KOKLotteryWheelView.h"
#import "KOKResultView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = UIColorFromRGB(0x2e1a3d);
//    KOKLuckyLotteryView * view = [KOKLuckyLotteryView newView];
//    [self.view addSubview:view];
//    view.backgroundColor =  UIColorFromRGB(0x2e1a3d);
    
    UIImageView * img = [[UIImageView alloc] initWithFrame:self.view.bounds];
    img.image = [UIImage imageNamed:@"bgBack"];
    [self.view addSubview:img];
    
    KOKLotteryWheelView * view = [KOKLotteryWheelView newView];
    [self.view addSubview:view];
    
    KOKResultView * result = [KOKResultView newView];
    [self.view addSubview:result];
    view.vc = self;
    view.resultView = result;
    
}


@end
