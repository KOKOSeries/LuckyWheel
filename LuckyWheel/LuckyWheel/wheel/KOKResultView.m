//
//  KOKResultView.m
//  LuckyLottery
//
//  Created by JOY CHOW on 2020/12/7.
//

#import "KOKResultView.h"

@implementation KOKResultView

+ (instancetype)newView
{
    KOKResultView * view  = [[NSBundle mainBundle] loadNibNamed:@"KOKResultView" owner:nil options:nil].firstObject;
    view.frame = CGRectMake(SCREEN_WIDTH/2 - 150, SCREEN_HEIGHT, 300, 410);
    return view;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)show
{
    [UIView animateWithDuration:0.3 animations:^{
        self.y = SCREEN_HEIGHT/2 - 410/2;
    }];
    int y =(arc4random() % self.array.count);
    NSDictionary *image = self.array[y];
    self.img.image = [UIImage imageNamed:image[@"giftImage"]];
    [self saveData:image];
    
}

//获取当前时间戳
- (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970];// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

-(void)saveData:(NSDictionary *)dic
{
    NSMutableDictionary * data = [NSMutableDictionary dictionaryWithDictionary:dic];
    [data setValue:[self currentTimeStr] forKey:@"time"];
    NSArray * arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"records"];
    NSMutableArray * array = [NSMutableArray arrayWithArray:arr];
    if (array.count < 1) {
        array = [NSMutableArray array];
    }
    [array addObject:data];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"records"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.y  = SCREEN_HEIGHT;
    }];
}
- (IBAction)deleteClick:(id)sender {
    [self dismiss];
}


- (NSMutableDictionary * )getDataFromPlist{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"giftList" ofType:@"plist"];
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
//    NSLog(@"%@",dataDic);//直接打印数据
    return dataDic;
}

- (NSMutableArray *)array{
    if (!_array) {
        NSMutableDictionary *dictiony =  [self getDataFromPlist];
        NSArray *array = dictiony[@"gifts"];
        _array = [NSMutableArray arrayWithArray:array];
    }
    return _array;
}
@end
