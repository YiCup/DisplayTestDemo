//
//  AutolayoutTableViewController.m
//  DisplayLayout
//
//  Created by Mr.LuDashi on 16/9/8.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import "AutolayoutTableViewController.h"
#import "AutolayoutTableViewCell.h"
#import "TestDataModel.h"

#define contentText @"成长是一场冒险，勇敢的人先上路，代价是错过风景，不能回头，成长是一场游戏，勇敢的人先开始，不管难过与快乐，不能回头，行歌，在草长莺飞的季节里喃喃低唱，到处人潮汹涌还会孤独怎么，在灯火阑珊处竟然会觉得荒芜，从前轻狂绕过时光，成长是一场冒险，勇敢的人先上路，代价是错过风景，不能回头，成长是一场游戏，勇敢的人先开始，不管难过与快乐，不能回头，行歌，谁在一边走一边唱一边回头张望，那些苦涩始终都要去尝，怎么，长大后不会大笑也不会再大哭了，从前轻狂绕过时光，让我们彼此分享互相陪伴吧，一起面对人生这一刻的孤独吧，行歌，在草长莺飞的季节里喃喃低唱，从前轻狂绕过时光"

@interface AutolayoutTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation AutolayoutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableView.estimatedRowHeight = 100.0;
    [self addTestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;       //自动调整约束，性能非常低，灰常的卡
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AutolayoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AutolayoutTableViewCell" forIndexPath:indexPath];
    [cell configCellData:self.dataSource[indexPath.row]];
    
    if (indexPath.row == self.dataSource.count - 30) {
        [self addTestData];
    }
    return cell;
}

#pragma mark - Prevate Method
- (void)addTestData {
    if (self.dataSource == nil) {
        self.dataSource = [[NSMutableArray alloc] initWithCapacity:50];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 50; i ++) {
            TestDataModel * model = [[TestDataModel alloc] init];
            model.title = @"行歌";
            NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
            [dataFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            model.time = [dataFormatter stringFromDate:[NSDate date]];
            
            NSString *imageName = [NSString stringWithFormat:@"%d.jpg", arc4random()%5];
            model.imageName =imageName;
            model.content = [contentText substringFromIndex:arc4random()%contentText.length];
            [self.dataSource addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    
}


- (void)dealloc {
    NSLog(@"释放");
}
@end
