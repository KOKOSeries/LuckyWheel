//
//  PreViewController.h
//  KOKTemplateApp
//
//  Created by KOK on 13/12/2020.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@protocol PreViewControllerDelegate <NSObject>

- (void)clickDelegateBack:(NSInteger)index;

@end
NS_ASSUME_NONNULL_BEGIN

@interface PreViewController : UIViewController
@property (strong,nonatomic) NSArray  *images;
@property (strong,nonatomic) NSArray  *titles;
@property (assign,nonatomic) NSInteger currentIndex;
@property (strong,nonatomic) SDCycleScrollView *introduceCycleScrollView;
@property (weak,nonatomic) id<PreViewControllerDelegate> mkDelegate;



@end

NS_ASSUME_NONNULL_END
