//
//  ViewController.m
//  LuckyWheel
//
//  Created by JOY CHOW on 2020/12/7.
//

#import "ViewController.h"
#import "KOKLotteryWheelView.h"
#import "KOKResultView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
