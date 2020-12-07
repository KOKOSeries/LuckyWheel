//
//  KOKLotteryWheelView.h
//  LuckyLottery
//
//  Created by JOY CHOW on 2020/12/7.
//

#import <UIKit/UIKit.h>
#import "TurntableView.h"
#import "KOKResultView.h"
NS_ASSUME_NONNULL_BEGIN

@interface KOKLotteryWheelView : UIView<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgBack;
@property (weak, nonatomic) IBOutlet UIButton *recordsBtn;

@property (nonatomic,strong) TurntableView * turntable;
@property (nonatomic,strong) KOKResultView * resultView;
@property (nonatomic,strong) UIViewController * vc;
@property (nonatomic,assign) int num;
+ (instancetype)newView;
@end

NS_ASSUME_NONNULL_END
