//
//  SuperTableViewController.h
//  DisplayLayout
//
//  Created by Mr.LuDashi on 16/9/9.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestDataModel.h"

@interface SuperTableViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *dataSource;
- (void)addTestData;
@end
