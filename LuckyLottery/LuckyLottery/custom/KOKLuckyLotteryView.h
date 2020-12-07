//
//  KOKLuckyLotteryView.h
//  LuckyLottery
//
//  Created by JOY CHOW on 2020/12/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KOKLuckyLotteryView : UIView
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *itemArray;
@property (nonatomic, strong) UIButton * btnOld;
@property (nonatomic, assign) float xTime;
+ (instancetype)newView;
@end

NS_ASSUME_NONNULL_END
