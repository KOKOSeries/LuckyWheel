//
//  KOKRecordsCell.h
//  LuckyLottery
//
//  Created by JOY CHOW on 2020/12/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KOKRecordsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewBack;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *labelSlogan;
@property (nonatomic, strong) NSDictionary * dic;
@end

NS_ASSUME_NONNULL_END
