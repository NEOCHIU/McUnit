//
//  SecondViewController.h
//  McUnit
//
//  Created by kid chiu on 2015/7/22.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondViewCell.h"
#import "CuttingConditonViewController.h"


@interface SecondViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *list;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

