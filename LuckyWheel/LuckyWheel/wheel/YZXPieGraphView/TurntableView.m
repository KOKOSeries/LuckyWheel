//
//  TurntableView.m
//  YDXTurntable
//
//  Created by LIN on 16/11/26.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "TurntableView.h"
#import "Masonry.h"
#define turnScale_W self.bounds.size.width/300
#define turnScale_H self.bounds.size.height/300
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@implementation TurntableView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    // 转盘
    self.rotateWheel = [[UIImageView alloc]initWithFrame:self.bounds];
    [self addSubview:self.rotateWheel];
    self.rotateWheel.image = [UIImage imageNamed:@"qiandao_0008_yy"];
    _colorView = [[UIView alloc] initWithFrame:self.bounds];
    [self.rotateWheel addSubview:_colorView];
    // 抽奖按钮
    self.playButton = [[UIButton alloc]initWithFrame:
                       CGRectMake(0,
                                  0,
                                  CGRectGetWidth(self.bounds)/3,
                                  CGRectGetHeight(self.bounds)/3)];
    self.playButton.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetWidth(self.bounds)/2);
    self.playButton.layer.cornerRadius = CGRectGetWidth(self.bounds)/3/2;
    [self.playButton setImage:[UIImage imageNamed:@"ic_turntable_start_btn"] forState:0];
    [self addSubview:self.playButton];
    
    // 外围装饰背景图
    UIImageView * backImageView = [UIImageView new];
    backImageView.image = [UIImage imageNamed:@"2_0000_up"];
    [self addSubview:backImageView];
    
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rotateWheel.mas_centerX).with.offset(-1*turnScale_W);
        make.centerY.mas_equalTo(self.rotateWheel.mas_centerY).with.offset(-13*turnScale_H);
        make.size.mas_equalTo(CGSizeMake(330*turnScale_W, 345*turnScale_H));
    }];
    
    // 在转盘上添加图片和文字
    NSArray * imageArray = @[@"ic_tb_item_not_winning",@"ic_tb_item_1",@"ic_tb_item_2",@"ic_tb_item_3",@"ic_tb_item_4",@"ic_tb_item_5"];
    self.numberArray = @[@"",@"Merry",@"Chrismas",@"give",@"your",@"gift!"];
    _labelArray = [NSMutableArray array];
    for (int i = 0; i < 6; i ++) {
//        NSDictionary * dic = _numberArray[i];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,M_PI * CGRectGetHeight(self.bounds)/6,
                                                                  CGRectGetHeight(self.bounds)/2)];
        label.layer.anchorPoint = CGPointMake(0.5, 1);
        label.center = CGPointMake(CGRectGetHeight(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
        label.text = _numberArray[i];
        CGFloat angle = M_PI * 2 / 6 * i;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = UIColorFromRGB(0xFA632D);
        label.transform = CGAffineTransformMakeRotation(angle);
        [self.rotateWheel addSubview:label];
//        label.backgroundColor = randomColor;
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(35*turnScale_W + 4, 12, M_PI * CGRectGetHeight(self.bounds)/6 - 90*turnScale_W, 20*turnScale_H)];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        [label addSubview:imageView];
        [_labelArray addObject:label];
//        imageView.backgroundColor = randomColor;
        if (i == 0) {
            UIImageView * img = [[UIImageView alloc] initWithFrame:CGRectMake(35*turnScale_W + 10, 40, M_PI * CGRectGetHeight(self.bounds)/6 - 100*turnScale_W, 40*turnScale_H)];
            img.image = [UIImage imageNamed:@"ic_not_winning"];
            [label addSubview:img];
        }
        if (i == 5) {
            _lastImg = imageView;
        }
    }
    
}

- (void)setNumberArray:(NSArray *)numberArray
{
    _numberArray = numberArray;
    NSDictionary * dic = _numberArray.lastObject;
    UIColor * color = UIColorFromRGB(0xeeb8b9);
//    self.pieGraphView.
    _pieGraphView = [[YZXPieGraphView alloc] initWithFrame:self.bounds
                                             withTitleData:nil
                                        withPercentageData:@[@"16.667",@"16.667",@"16.667",@"16.667",@"16.667",@"16.667"]
                                                withColors:@[color,
                                                             UIColor.whiteColor,
                                                              UIColorFromRGB(0xeeb8b9),
                                                              UIColorFromRGB(0xc7f3fe),
                                                              UIColorFromRGB(0xeeb8b9),
                                                              UIColorFromRGB(0xc7f3fe)]];
    _pieGraphView.center = self.center;
    _pieGraphView.backgroundColor = [UIColor clearColor];
    _pieGraphView.circleRadius = 100;
    _pieGraphView.hideTitlt = YES;
    _pieGraphView.hideAnnotation = YES;
    [_colorView addSubview:_pieGraphView];
    for (int i = 0; i< 6; i++) {
        UILabel * lbl = _labelArray[i];
        if (i != 0) {
//            NSDictionary * dic = _numberArray[i - 1];
            lbl.text =  _numberArray[i - 1];
        }
    }
}
@end
