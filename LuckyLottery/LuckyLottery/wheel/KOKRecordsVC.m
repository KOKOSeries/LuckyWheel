//
//  KOKRecordsVC.m
//  LuckyLottery
//
//  Created by JOY CHOW on 2020/12/7.
//

#import "KOKRecordsVC.h"
#import "KOKRecordsCell.h"
@interface KOKRecordsVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;@end
@implementation KOKRecordsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTable];
}

- (void)createTable
{
    UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableView.separatorInset = UIEdgeInsetsZero;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [self.tableView registerNib:[UINib nibWithNibName:@"KOKRecordsCell" bundle:nil] forCellReuseIdentifier:@"KOKRecordsCell"];
    self.dataArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"records"];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KOKRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"KOKRecordsCell"];
    cell.dic = _dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}


@end
