//
//  SecondViewController.m
//  McUnit
//
//  Created by kid chiu on 2015/7/22.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import "SecondViewController.h"



@interface SecondViewController (){
    id listTitle;
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    list = [[NSMutableArray alloc]init];
    [list addObject:[NSArray arrayWithObjects: @"切削率",nil]];
      
}





-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *indicator = @"Cell";
    SecondViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indicator];
   
    if (cell == nil) {
        NSArray *views = [[NSBundle mainBundle]loadNibNamed:@"SecondViewCell" owner:nil options:nil];
        for (UIView *view in views) {
            if ([view isKindOfClass:[SecondViewCell class]]) {
                cell = (SecondViewCell *)view;
                
            }
        }
    }
    cell.NameLabel.text = [[list objectAtIndex:indexPath.row]objectAtIndex:0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
    
}

@end
