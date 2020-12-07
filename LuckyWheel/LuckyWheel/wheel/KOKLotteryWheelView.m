//
//  KOKLotteryWheelView.m
//  LuckyLottery
//
//  Created by JOY CHOW on 2020/12/7.
//

#import "KOKLotteryWheelView.h"
#import "KOKRecordsVC.h"
@implementation KOKLotteryWheelView

+ (instancetype)newView
{
    KOKLotteryWheelView * view  = [[NSBundle mainBundle] loadNibNamed:@"KOKLotteryWheelView" owner:nil options:nil].firstObject;
    view.frame = CGRectMake(0, SCREEN_HEIGHT/2 - 500, SCREEN_WIDTH, 600);
    return view;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.recordsBtn.layer.cornerRadius = 20;
    self.recordsBtn.layer.masksToBounds = YES;
    
    UIView * view = [[UIView alloc] initWithFrame:_imgBack.frame];
//    view.backgroundColor = UIColor.redColor;
    [self addSubview:view];
    
    // 转盘View
    self.turntable = [[TurntableView alloc] initWithFrame:view.bounds];
    [self.turntable.playButton addTarget:self action:@selector(startAnimaition) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.turntable];
}

-(void)startAnimaition
{
    NSInteger turnAngle;
    NSInteger randomNum = arc4random()%100;//控制概率
    NSInteger turnsNum = 4;//控制圈数
   
    _num = arc4random() % 10;
    turnAngle = 360 - 60 * _num;//60的倍数
//    NSLog(@"randomNum = %ld , angle = %ld , turnsNum = %ld",randomNum,turnAngle,turnsNum);
    CGFloat perAngle = M_PI/180.0;
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:turnAngle * perAngle + 360 * perAngle * turnsNum];
    rotationAnimation.duration = 3.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [self.turntable.rotateWheel.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    // 转盘结束后调用，显示获得的对应奖励
//    self.label.text = [NSString stringWithFormat:@"恭喜您抽中%@",self.labelText];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.resultView show];
    });
    
}

- (IBAction)recordsBtnClick:(id)sender {
    [self.vc presentViewController:[KOKRecordsVC new] animated:YES completion:nil];
}

@end
