//
//  FirstViewController.h
//  McUnit
//
//  Created by kid chiu on 2015/7/22.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>{

    
}

@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property (weak, nonatomic) IBOutlet UILabel *cell1;
@property (weak, nonatomic) IBOutlet UILabel *cell2;
@property (weak, nonatomic) IBOutlet UILabel *cell3;
@property (weak, nonatomic) IBOutlet UILabel *cell4;
@property (weak, nonatomic) IBOutlet UILabel *cell5;

@property (weak, nonatomic) IBOutlet UITextField *text1;
@property (weak, nonatomic) IBOutlet UITextField *text2;
@property (weak, nonatomic) IBOutlet UITextField *text3;
@property (weak, nonatomic) IBOutlet UITextField *text4;
@property (weak, nonatomic) IBOutlet UITextField *text5;



@end

