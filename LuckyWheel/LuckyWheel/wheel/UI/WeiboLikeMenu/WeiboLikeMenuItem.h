//
//  WeiboLikeMenuItem.h
//  SinaWeiboLikeMenu
//
//  Created by hy on 14-1-8.
//
//

#import <UIKit/UIKit.h>

@class WeiboLikeMenuItem;

typedef void (^WeiboLikeMenuItemSelectBlock)(WeiboLikeMenuItem *item);


@interface WeiboLikeMenuItem : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *highlightedImage;
@property (nonatomic, copy) WeiboLikeMenuItemSelectBlock selectBlock;

- (id)initWithImage:(UIImage *)image
   highlightedImage:(UIImage *)highlightedImage
               text:(NSString *)text;

@end
