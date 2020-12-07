//
//  KOKResultView.h
//  LuckyLottery
//
//  Created by JOY CHOW on 2020/12/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KOKResultView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (strong,nonatomic) NSMutableArray *array;
- (void)show;
- (void)dismiss;
+ (instancetype)newView;
@end

NS_ASSUME_NONNULL_END
