//
//  PreViewController.m
//  KOKTemplateApp
//
//  Created by KOK on 13/12/2020.
//

#import "PreViewController.h"
#import <Masonry/Masonry.h>

@interface PreViewController ()

@end

@implementation PreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.introduceCycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - self.view.bounds.size.width ,[UIScreen mainScreen].bounds.size.height - self.view.bounds.size.height,self.view.bounds.size.width,self.view.bounds.size.height)
                                                                           shouldInfiniteLoop:YES imageNamesGroup:self.images];
    self.introduceCycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.introduceCycleScrollView.titlesGroup = self.titles;
    [self.introduceCycleScrollView makeScrollViewScrollToIndex:self.currentIndex];
    self.introduceCycleScrollView.layer.maskedCorners =  kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner | kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
    __weak __typeof(self)weakSelf = self;
    self.introduceCycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
        if (weakSelf.mkDelegate && [weakSelf.mkDelegate respondsToSelector:@selector(clickDelegateBack:)]) {
            
            [weakSelf.mkDelegate clickDelegateBack:currentIndex];
        }

    };
    
    [self.view addSubview: self.introduceCycleScrollView];
   
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:^{
            
    }];
}
@end
