//
//  WeiboLikeMenu.h
//  TumblrLikeMenu
//
//  Created by hy on 14-1-6.
//  Copyright (c) 2014年 Tu You. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WeiboLikeMenuItem.h"

typedef void (^WeiboLikeMenuSelectBlock)(NSUInteger index);

@interface WeiboLikeMenu : UIScrollView

@property(nonatomic, copy) WeiboLikeMenuSelectBlock selectBlock;
@property (nonatomic, strong) NSArray *submenus;



- (id) initWithFrame:(CGRect)frame WithMenuItems:(NSArray *)items;

- (void) show;

- (void) disappear;

- (void) showMore;

@end
