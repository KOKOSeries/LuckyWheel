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
    
    UIView * viewLabel = [[UIView alloc] initWithFrame:CGRectMake(20, SCREEN_HEIGHT - 100, SCREEN_WIDTH - 40, 50)];
    [self.view addSubview:viewLabel];
    viewLabel.backgroundColor = UIColorFromRGB(0x294d10);
    viewLabel.layer.cornerRadius = 8;
    viewLabel.layer.masksToBounds = YES;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 60, 50)];
    [viewLabel addSubview:label];
    label.textColor = UIColor.whiteColor;
    label.numberOfLines = 0;
    label.text = @"it is only for playing and entertainment，we don't give you the real things";
}


@end
