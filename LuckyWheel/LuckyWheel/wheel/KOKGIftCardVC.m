//
//  KOKGIftCardVC.m
//  LuckyWheel
//
//  Created by KOK on 14/12/2020.
//

#import "KOKGIftCardVC.h"
#import "WMDragView.h"
#import "WeiboLikeMenu.h"
#import "PreViewController.h"
//#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define radians(degrees) (degrees * M_PI/180)

@interface KOKGIftCardVC ()<PreViewControllerDelegate>
{
    WeiboLikeMenu *weibo;
    WeiboLikeMenu *weibo2;
}
@property (weak, nonatomic) IBOutlet UIImageView *giftBackImageView;
@property(nonatomic,strong)WMDragView *dragViewM;
@property(nonatomic,strong)WMDragView *dragView;
@property(nonatomic,strong)WMDragView *dragView2;
@property(nonatomic,strong)WMDragView *dragViews;
@property (strong,nonatomic) NSMutableArray *backArray;


@end

@implementation KOKGIftCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak __typeof(self)weakSelf = self;
    self.backArray = [NSMutableArray arrayWithArray:@[@"back1",
                                                      @"back2",
                                                      @"back3",
                                                      @"back4",
                                                      @"back5",
                                                      @"back6",
                                                      @"back7",
                                                      @"back8",
                                                      @"back9"]];
    
    
    self.dragViewM = [[WMDragView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 80,[UIScreen mainScreen].bounds.size.height -80, 40, 40)];
    self.dragViewM.imageView.image =  [self zd_imageWithColor:[UIColor redColor]
                                                        size:CGSizeMake(40, 40)
                                                        text:@"Editor"
                                              textAttributes:nil
                                                    circular:YES];
    self.dragViewM.button.titleLabel.font = [UIFont systemFontOfSize:15.0];

  
    self.dragViewM.backgroundColor = [UIColor clearColor];
    self.dragViewM.clickDragViewBlock = ^(WMDragView *dragView) {
        [weakSelf weibolikeMenu];
    };
    [self.view addSubview:self.dragViewM];
//    self.dragViewM.center = self.view.center;
    
    
    self.dragView = [[WMDragView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    self.dragView.imageView.image = [self reverseImageByScalingToSize:CGSizeMake(80, 80) :[UIImage imageNamed:self.giftDic[@"giftImage"]]];
    self.dragView.button.titleLabel.font = [UIFont systemFontOfSize:15.0];
//    [self.dragView.button setTitle:@"Drag" forState:UIControlStateNormal];
//    [self.dragView.button setTitle:@"Don`t Drag" forState:UIControlStateSelected];
  
    self.dragView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.dragView];
    self.dragView.center = self.view.center;
    
    
    UILabel *label = [[UILabel alloc]init];
    label.text = self.giftDic[@"giftDescriptiion"];
    label.numberOfLines = 0;
    CGSize size = [label sizeThatFits:CGSizeZero];
    
//    [label setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    
    label.frame = CGRectMake(0, 0,size.width, size.height);
    self.dragView2 = [[WMDragView alloc] initWithFrame:CGRectMake(0, 0,size.height,size.width)];
//    [self.dragView2 setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    UIImage *image = [self zd_imageWithColor:[UIColor clearColor]
                                        size:size
                                        text:self.giftDic[@"giftDescriptiion"]
                              textAttributes:nil
                                    circular:NO];
    

    self.dragView2.imageView.image = image;
    [self.dragView2.imageView setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
//    [self reverseImageByScalingToSize:CGSizeMake(80, 80) :image];
    
    self.dragView2.button.titleLabel.font = [UIFont systemFontOfSize:15.0];
//    [self.dragView2.button setTitle:@"Drag" forState:UIControlStateNormal];
//    [self.dragView2.button setTitle:@"Don`t Drag" forState:UIControlStateSelected];
//
//    [self.dragView2 addSubview:label];
    
    
    self.dragView2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.dragView2];
    self.dragView2.center = self.view.center;
    
    self.dragViews = [[WMDragView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 120,[UIScreen mainScreen].bounds.size.height -80, 40, 40)];
    self.dragViews.imageView.image =  [self zd_imageWithColor:[UIColor redColor]
                                                        size:CGSizeMake(40, 40)
                                                        text:@"Save"
                                              textAttributes:nil
                                                    circular:YES];
    self.dragViews.button.titleLabel.font = [UIFont systemFontOfSize:15.0];

  
    self.dragViews.backgroundColor = [UIColor clearColor];
    self.dragViews.clickDragViewBlock = ^(WMDragView *dragView) {
        
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    [self.view addSubview:self.dragViews];
}
#pragma mark -  image 旋转 90 度
-(UIImage*)reverseImageByScalingToSize:(CGSize)targetSize:(UIImage*)anImage
{
    UIImage* sourceImage = anImage;
    CGFloat targetWidth = targetSize.height;
    CGFloat targetHeight = targetSize.width;

    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);

    if (bitmapInfo == kCGImageAlphaNone) {
        bitmapInfo = kCGImageAlphaNoneSkipLast;
    }

    CGContextRef bitmap;

    if (sourceImage.imageOrientation == UIImageOrientationUp || sourceImage.imageOrientation == UIImageOrientationDown) {
        bitmap = CGBitmapContextCreate(NULL, targetHeight, targetWidth, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);

    } else {


        bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);

    }


    if (sourceImage.imageOrientation == UIImageOrientationRight) {
        CGContextRotateCTM (bitmap, radians(90));
        CGContextTranslateCTM (bitmap, 0, -targetHeight);

    } else if (sourceImage.imageOrientation == UIImageOrientationLeft) {
        CGContextRotateCTM (bitmap, radians(-90));
        CGContextTranslateCTM (bitmap, -targetWidth, 0);

    } else if (sourceImage.imageOrientation == UIImageOrientationDown) {
        // NOTHING
    } else if (sourceImage.imageOrientation == UIImageOrientationUp) {
        CGContextRotateCTM (bitmap, radians(90));
        CGContextTranslateCTM (bitmap, 0, -targetHeight);
    }

    CGContextDrawImage(bitmap, CGRectMake(0, 0, targetWidth, targetHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref];

    CGContextRelease(bitmap);
    CGImageRelease(ref);

    return newImage;
}
#pragma mark -  文字生成图片
- (UIImage *)zd_imageWithColor:(UIColor *)color
                          size:(CGSize)size
                          text:(NSString *)text
                textAttributes:(NSDictionary *)textAttributes
                      circular:(BOOL)isCircular
{
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // circular
    if (isCircular) {
        CGPathRef path = CGPathCreateWithEllipseInRect(rect, NULL);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    
    // color
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    // text
    CGSize textSize = [text sizeWithAttributes:textAttributes];
    [text drawInRect:CGRectMake((size.width - textSize.width) / 2, (size.height - textSize.height) / 2, textSize.width, textSize.height) withAttributes:textAttributes];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark -  图片横向展示
- (NSString *)VerticalString{
    NSMutableString * str = [[NSMutableString alloc] initWithString:self];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2 - 1];
    }
    return str;
}
#pragma mark - weibolikemenu
- (void)weibolikeMenu{
    PreViewController *vc = [[PreViewController alloc]initWithNibName:@"PreViewController" bundle:nil];
    vc.titles = self.backArray;
    vc.images = self.backArray;
    vc.mkDelegate = self;
//    vc.modalPresentationStyle = UIModalPresentationCurrentContext;
//    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    __weak __typeof(self)weakSelf = self;
//    vc.introduceCycleScrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
//        __strong __typeof(weakSelf)strongSelf = weakSelf;
//
//        strongSelf.giftBackImageView.image = [UIImage imageNamed:self.backArray[currentIndex]];
//    };
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)clickDelegateBack:(NSInteger)index{
    self.giftBackImageView.image = [UIImage imageNamed:self.backArray[index]];
}
@end
