//
//  WeiboLikeMenu.m
//  TumblrLikeMenu
//
//  Created by hy on 14-1-6.
//  Copyright (c) 2014年 Tu You. All rights reserved.
//

#import "WeiboLikeMenu.h"
#import "UIView+CommonAnimation.h"

#define kStringWeiboMenuItemAppearKey   @"kStringMenuWeiboItemAppearKey"
#define kFloatMenuItemAppearDuration    (0.25f)
#define kFloatTipLabelAppearDuration    (0.20f)
#define kFloatTipLabelHeight            (50.0f)

@interface WeiboLikeMenu()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *magicBgImageView;
@property (nonatomic, strong) NSArray *delayAppearArray;
@property (nonatomic, strong) NSArray *delayDisappearArray;

@end

@implementation WeiboLikeMenu
{
    NSInteger scollerPageCount;
    NSInteger lines;
}


#pragma mark - System Defualt Code.

- (id)initWithFrame:(CGRect)frame WithMenuItems:(NSArray *)menus
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.delegate = self;
        
        // set the contentSize.
        lines = ceil([menus count]/3.0);
        scollerPageCount = ceil([menus count]/6.0);
        self.contentSize = CGSizeMake(CGRectGetWidth(frame)*scollerPageCount, CGRectGetHeight(frame));
        self.pagingEnabled = YES;
        self.scrollEnabled = NO; // Enable Scroll.
        
        
        if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1)
        {
            self.magicBgImageView = [[UIImageView alloc] initWithFrame:frame];
            self.magicBgImageView.userInteractionEnabled = YES;
            self.magicBgImageView.backgroundColor = [UIColor colorWithWhite:0.22 alpha:0.9];
        }
        else
        {
            // use tool bar in iOS 7 to blur the backgroud
            self.magicBgImageView = [[UIToolbar alloc] initWithFrame:frame];
            ((UIToolbar *)self.magicBgImageView).barStyle = UIBarStyleBlackTranslucent;
        }
        CGRect magicFrame =  self.magicBgImageView.frame;
        magicFrame.size = self.contentSize;
        magicFrame.size.width += frame.size.width/2.0; // add a half width
        self.magicBgImageView.frame = magicFrame;
        
        [self addSubview:self.magicBgImageView];
        
        
        self.submenus = menus;
        
        [self setupSubmenus];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self.magicBgImageView addGestureRecognizer:tapGestureRecognizer];

        
        self.delayAppearArray = @[@(0.0), @(0.1), @(0.2), @(0.05), @(0.15), @(0.25)];
        
        self.delayDisappearArray = @[@(0.25), @(0.15), @(0.05), @(0.2), @(0.1), @(0.0)];
        
    }
    return self;
}

#pragma mark - set up SubMenus
- (void)setupSubmenus
{
    NSInteger currentPage = 0;
    for (int i = 0; i < lines; ++i)
    {
        for (int j = 0; j < [self getRowsAtLine:i+1]; ++j)
        {
            
            WeiboLikeMenuItem *subMenu = self.submenus[i * 3 + j];
            
            if (currentPage == 0)
            {
                subMenu.center = CGPointMake(100 * j + 62 + CGRectGetWidth(self.bounds)*(currentPage), CGRectGetHeight(self.frame) + i * 125 + 90);
            }
            else
            {
                if (i <= 1)
                {
                    subMenu.center = CGPointMake(100 * j + 62 + CGRectGetWidth(self.bounds)*(currentPage), CGRectGetHeight(self.frame) + i * 125 + 90 - CGRectGetHeight(self.bounds) / 2 - 120);
                }
                else
                {
                    int temp = (i %2 == 0) ? 0 : 1;
                    subMenu.center = CGPointMake(100 * j + 62 + CGRectGetWidth(self.bounds)*(currentPage), CGRectGetHeight(self.frame) + temp * 125 + 90 - CGRectGetHeight(self.bounds) / 2 - 120);
                }
                
                NSLog(@"y:%f", subMenu.center.y);
                
            }
            
            if (NULL == subMenu.selectBlock)
            {
                __weak WeiboLikeMenu *weakSelf = self;
                subMenu.selectBlock = ^(WeiboLikeMenuItem *item)
                {
                    NSUInteger index = [weakSelf.submenus indexOfObject:item];
                    if (index != NSNotFound) {
                        [weakSelf handleSelectAtIndex:index];
                    }
                };
            }
            
            [self addSubview:subMenu];
        }
        
        
        if (i != 0)
        {
            if(((i+1) % 2) == 0)
            {
                currentPage++;
            }
        }
    }
}

#pragma mark - handle Select
- (void)handleSelectAtIndex:(NSUInteger)index
{
    if (self.selectBlock)
    {
        self.selectBlock(index);
    }
    if (index != 5)
    {
         [self disappear];
    }
   
}

#pragma mark - appear
- (void)appear
{
    [self.magicBgImageView.layer addAnimation:[self fadeIn] forKey:@"fadeIn"];
    
    for (int i = 0; i < 6; ++i)
    {
        double delayInSeconds = [self.delayAppearArray[i] doubleValue];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            WeiboLikeMenuItem *item = (WeiboLikeMenuItem *)self.submenus[i];
            [self appearMenuItem:item animated:YES];
        });
    }

}

- (void)disappear
{
    
    // get the current page subItems Index.
    int currentPage = self.contentOffset.x / self.frame.size.width + 1;

    NSIndexSet *resultIndexSet;
    if (currentPage < scollerPageCount)
    {
        resultIndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange((currentPage - 1)*6, 6)];
    }
    else if (currentPage == scollerPageCount)
    {
        resultIndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange((currentPage - 1)*6, [_submenus count] - (currentPage - 1)*6)];
    }
    
    NSArray *res = [_submenus objectsAtIndexes:resultIndexSet];
    
    // remove the current page subItems.
    for (int i = 0; i < [res count]; ++i)
    {
        double delayInSeconds = [(NSNumber *)self.delayDisappearArray[i] doubleValue];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            WeiboLikeMenuItem *item = (WeiboLikeMenuItem *)res[i];
            [self disappearMenuItem:item animated:YES];
        });
    }
    
    [UIView animateWithDuration:0.2 delay:0.32 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.magicBgImageView.alpha = 0.7;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}

#pragma mark - get current page itemsIndex

- (NSIndexSet *) getCurrentPageItemsIndex:(NSUInteger) currentPage
{
    
    NSMutableIndexSet *ret;
    
    
    
    return ret;
}

#pragma mark - disappear appear menu item
- (void)disappearMenuItem:(WeiboLikeMenuItem *)item animated:(BOOL )animted
{
    CGPoint point = item.center;
    CGPoint finalPoint = CGPointMake(point.x, point.y + CGRectGetHeight(self.bounds) / 2 + 80);
    if (animted) {
        CABasicAnimation *disappear = [CABasicAnimation animationWithKeyPath:@"position"];
        disappear.duration = 0.2;
        disappear.fromValue = [NSValue valueWithCGPoint:point];
        disappear.toValue = [NSValue valueWithCGPoint:finalPoint];
        disappear.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [item.layer addAnimation:disappear forKey:kStringWeiboMenuItemAppearKey];
    }
    item.layer.position = finalPoint;
}

- (void)appearMenuItem:(WeiboLikeMenuItem *)item animated:(BOOL )animated
{
    CGPoint point0 = item.center;
    CGPoint point1 = CGPointMake(point0.x, point0.y - CGRectGetHeight(self.bounds) / 2 - 120);
    CGPoint point2 = CGPointMake(point1.x, point1.y + 10);
    
    if (animated)
    {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        animation.values = @[[NSValue valueWithCGPoint:point0], [NSValue valueWithCGPoint:point1], [NSValue valueWithCGPoint:point2]];
        animation.keyTimes = @[@(0), @(0.6), @(1)];
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.10 :0.87 :0.68 :1.0], [CAMediaTimingFunction functionWithControlPoints:0.66 :0.37 :0.70 :0.95]];
        animation.duration = kFloatMenuItemAppearDuration;
        [item.layer addAnimation:animation forKey:kStringWeiboMenuItemAppearKey];
    }
    item.layer.position = point2;
}

- (void)tapped:(UIGestureRecognizer *)gesture
{
    [self disappear];
}

#pragma mark - show weiboLikeMenu.
- (void)show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    [self appear];
    
    
    
    
}

#pragma mark - Show More
- (void) showMore
{
    CGRect frame = self.frame;
    frame.origin.x = frame.size.width * 1;
    self.scrollEnabled = YES;
    [self scrollRectToVisible:frame animated:YES];
}


#pragma mark - get rows at some line

- (NSInteger) getRowsAtLine:(NSInteger) currentLine
{
    if (currentLine > lines)
    {
        return 0;
    }
    
    int rows = 0;
    if (currentLine == lines)
    {
        if ([_submenus count] % 3 == 0)
        {
            rows = 3;
        }
        else
        {
            rows = [_submenus count] - floor([_submenus count]/3.0) * 3;
        }
        
    }
    else
    {
        rows = 3;
    }
    
    
    return rows;
}


#pragma mark - UIScollerView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentPage = self.contentOffset.x / self.frame.size.width + 1;
    
    if (currentPage == 1)
    {
        scrollView.scrollEnabled = NO;
    }
    else
    {
        scrollView.scrollEnabled = YES;
    }
}

@end
