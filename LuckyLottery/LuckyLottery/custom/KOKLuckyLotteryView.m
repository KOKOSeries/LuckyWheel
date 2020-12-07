//
//  KOKLuckyLotteryView.m
//  LuckyLottery
//
//  Created by JOY CHOW on 2020/12/5.
//

#import "KOKLuckyLotteryView.h"

@implementation KOKLuckyLotteryView

+ (instancetype)newView
{
    KOKLuckyLotteryView * view  = [[NSBundle mainBundle] loadNibNamed:@"KOKLuckyLotteryView" owner:nil options:nil].firstObject;
    view.frame = CGRectMake(0, SCREEN_HEIGHT/2 - 150, SCREEN_WIDTH, 295);
    return view;
}
- (IBAction)startClick:(UIButton *)sender {
    sender.enabled = NO;
    int x = 48 + (arc4random() % 24);
    _xTime = (float)x/10;
    if (_btnOld) {
        _btnOld.selected = NO;
    }
    [self animationWheel];
}

- (void)animationWheel {
    WEAKSELF
    __block double second = 0;
    //(1)
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //(2)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, quene);
    //(3)
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //(4)
    dispatch_source_set_event_handler(timer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (second >= weakSelf.xTime) {
                NSLog(@"----------end");
                weakSelf.startBtn.enabled = YES;
//                second = 60;
                //(6)
                dispatch_cancel(timer);
            } else {
                double x = (second / 0.2);
                NSString * str = [NSString stringWithFormat:@"%f",x];
                int i = str.intValue % 12;
                NSLog(@"----------sc-%f-%d",x,i);
                UIButton * btn = weakSelf.itemArray[i];
                btn.selected = YES;
                if (second != 0) {
                    weakSelf.btnOld.selected = NO;
                }
                weakSelf.btnOld = btn;
                
                second += 0.2;
            }
        });
    });
    //(5)
    dispatch_resume(timer);
}

@end
