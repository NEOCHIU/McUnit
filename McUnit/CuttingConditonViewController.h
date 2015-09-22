//
//  CuttingConditonViewController.h
//  McUnit
//
//  Created by kid chiu on 2015/8/14.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CuttingConditonModel.h"
#import "AppDelegate.h"

@interface CuttingConditonViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *categoryField;
@property (weak, nonatomic) IBOutlet UITextField *msizeField;
@property (weak, nonatomic) IBOutlet UIImageView *msizePicView;
@property (weak, nonatomic) IBOutlet UITextField *countryField;
@property (weak, nonatomic) IBOutlet UITextField *meterialField;
@property (weak, nonatomic) IBOutlet UITextField *rateValueField;
@property (weak, nonatomic) IBOutlet UITextField *timeValueField;
@property (weak, nonatomic) IBOutlet UILabel *msizeAreaLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;





@end
