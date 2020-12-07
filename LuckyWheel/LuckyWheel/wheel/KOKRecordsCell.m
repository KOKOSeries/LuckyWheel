//
//  KOKRecordsCell.m
//  LuckyLottery
//
//  Created by JOY CHOW on 2020/12/7.
//

#import "KOKRecordsCell.h"

@implementation KOKRecordsCell

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    self.img.image = [UIImage imageNamed:dic[@"giftImage"]];
    self.label1.text = dic[@"gittName"];
    self.label2.text = [self time_timestampToString:dic[@"time"]];
    self.labelSlogan.text = dic[@"giftDescriptiion"];
}

//时间戳转字符串
- (NSString *)time_timestampToString:(NSString *)timestamp{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp.integerValue];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
     [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString* string=[dateFormat stringFromDate:confromTimesp];
    return string;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _viewBack.layer.cornerRadius = 8;
    _viewBack.layer.masksToBounds = YES;
}

@end
