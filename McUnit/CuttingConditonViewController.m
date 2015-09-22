//
//  CuttingConditonViewController.m
//  McUnit
//
//  Created by kid chiu on 2015/8/14.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import "CuttingConditonViewController.h"


@interface CuttingConditonViewController ()
{
    
}
@property (nonatomic,strong)NSMutableArray *cuntry;
@property (nonatomic,strong)NSMutableArray *meteria;
@property (nonatomic,strong)NSMutableArray *category;
@property (nonatomic,strong)NSMutableArray *msize;
@property (nonatomic,strong)NSMutableArray *rateValue;
@property (nonatomic,strong)NSMutableArray *timeValue;
@property (nonatomic,strong)NSMutableArray *speedValue;


@property(nonatomic,retain)UIPickerView *countryPickView;
@property(nonatomic,retain)UIPickerView *meterialPickView;
@property(nonatomic,retain)UIPickerView *categoryPickView;
@property(nonatomic,retain)UIPickerView *msizePickView;
@property(nonatomic,retain)UIPickerView *ratealuePickView;
@property(nonatomic,retain)UIPickerView *timeValuePickView;
@property(nonatomic,retain)UIToolbar *keybordToolbar;


@property(nonatomic, strong) NSString *nsCuntry; //儲存cuntry 的字串與sql條件值，暫無用處
@property(nonatomic, strong) NSString *nsMetrial; //儲存Metrial 的字串sql條件值，暫無用處
@property(nonatomic, strong) NSString *nsCategory; //儲存Category 的字串sql條件值，暫無用處
@property(nonatomic, strong) NSString *nsMsName; //儲存size 的字串sql條件值，暫無用處
@property(nonatomic, strong) NSString *nsMsSizeName;//sql 尺寸條件式
@property(nonatomic, strong) NSString *nsMeterialName;//sq 材料名字條件式
@property(nonatomic, strong) NSString *nsRate; //儲存rate 的字串，暫無用處
@property(nonatomic, strong) NSString *nsTime;//儲存time 的字串，暫無用處


@end

@implementation CuttingConditonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 改變tab bar 圖示
     self.tabBarItem.title = @"換算表";
    [self.tabBarItem setImage:[[UIImage imageNamed:@"tab-iconB.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab-iconB-1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    
    //初始給予cuntry值
    self.countryField.text = @"JIS";
    self.nsCuntry=self.countryField.text;
    //初始給予meteria值
    self.meterialField.text = @"S20C";
    
    //將meterialField欄位為area 與 time 的sql初始化條件值
    self.nsMeterialName =  self.meterialField.text;
    
    //初始給予category值
    self.categoryField.text = @"H-beam";
    self.msizeField.text = @"200X150";
    
    //將msizeField欄位為area 與 time 的sql初始化條件值
    self.nsMsSizeName = self.msizeField.text;
    
    self.nsMsName=self.categoryField.text;
    
//    //初始給予misize與area與Pic的值
    self.msizeAreaLabel.text=@"39";
    self.msizePicView.contentMode = UIViewContentModeRedraw;
    self.msizePicView.image =[UIImage imageNamed:@"1.png"];
//    //初始speed值
    self.speedLabel.text = @"48~72";
    self.rateValueField.text=@"16";
    self.timeValueField.text=@"2.4";
    
    
    //將cuntry欄位值放入陣列並初始化
    self.cuntry = [[NSMutableArray alloc]init];
    self.meteria = [[NSMutableArray alloc]init];
    self.category = [[NSMutableArray alloc]init];
    self.msize = [[NSMutableArray alloc]init];
    self.rateValue = [[NSMutableArray alloc]init];
    self.timeValue = [[NSMutableArray alloc]init];
    self.speedValue = [[NSMutableArray alloc]init];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    sqlite3 *db = [delegate getDB];
    
    if(db != nil)
    {
        NSLog(@"有抓到資料庫");
        //cuntry 欄位 SQL command
        const char *countrySql = "SELECT * FROM cuntry ";
        
        //msterial 欄位 SQL command
        NSString *meterial =[[NSString alloc]initWithFormat:@"SELECT * FROM meterial WHERE c_name = '%@' ORDER BY m_id",self.nsCuntry];
        NSLog(@"meterial:%@",meterial);
        const char *meterialSql =[meterial UTF8String];
        
        //msterial 欄位 SQL command
        const char *categorySql ="SELECT * FROM category";
        
        //msize 欄位 SQL command
        NSString *msize =[[NSString alloc]initWithFormat:@"SELECT * FROM msize WHERE ca_name = '%@' ORDER BY ms_id",self.nsMsName];
        NSLog(@"meterial:%@",msize);
        const char *msizeSql =[msize UTF8String];
        
        //area 欄位 SQL command
        NSString *rate =[[NSString alloc]initWithFormat:@"SELECT * FROM cut_value WHERE ms_size = '%@' AND m_name = '%@' ORDER BY cv_id",self.nsMsSizeName,self.nsMeterialName];
        NSLog(@"meterial:%@",msize);
        const char *rateSql =[rate UTF8String];
        NSLog(@"%@",rate);
        
        
        
        //statement //儲存cuntrySql執行結果;
        sqlite3_stmt *statement_cuntry;
        
        //statement //儲存meterialySql執行結果;
        sqlite3_stmt *statement_meterial;
        
        //statement //儲存categorySql執行結果;
        sqlite3_stmt *statement_category;
        
        //statement //儲存msizeSql執行結果;
        sqlite3_stmt *statement_msize;
        
        //statement //儲存areaSql執行結果;
        sqlite3_stmt *statement_rate;
        
        
        sqlite3_prepare(db, countrySql, -1, &statement_cuntry, NULL);
        sqlite3_prepare(db, meterialSql, -1, &statement_meterial, NULL);
        sqlite3_prepare(db, categorySql, -1, &statement_category, NULL);
        sqlite3_prepare(db, msizeSql, -1, &statement_msize, NULL);
        sqlite3_prepare(db, rateSql, -1, &statement_rate, NULL);
        
        //cuntry while 迴圈查詢結果
        while (sqlite3_step(statement_cuntry) == SQLITE_ROW) {
            char *cname = (char *)sqlite3_column_text(statement_cuntry,1);
            NSString *nsCuntry = [NSString stringWithCString:cname encoding:NSUTF8StringEncoding];
            [_cuntry addObject:nsCuntry];
           // NSLog(@"C_NAME: %@",[NSString stringWithCString:cname encoding:NSUTF8StringEncoding]);
        }
        
        //msetrial while 迴圈查詢結果
        while (sqlite3_step(statement_meterial) == SQLITE_ROW) {
            char *caname = (char *)sqlite3_column_text(statement_meterial,1);
           //  NSLog(@"caname:%s",caname);
            NSString *nsMeterial= [NSString stringWithCString:caname encoding:NSUTF8StringEncoding];
            [_meteria addObject:nsMeterial];
            //NSLog(@"CA_NAME: %@",[NSString stringWithCString:caname encoding:NSUTF8StringEncoding]);
        }
        //category while 迴圈查詢結果
        while (sqlite3_step(statement_category) == SQLITE_ROW) {
            char *casname = (char *)sqlite3_column_text(statement_category,1);
            NSString *nscategory= [NSString stringWithCString:casname encoding:NSUTF8StringEncoding];
            [_category addObject:nscategory];
          //  NSLog(@"CA_NAME: %@",[NSString stringWithCString:casname encoding:NSUTF8StringEncoding]);
        }
        
        //msize while 迴圈查詢結果
        while (sqlite3_step(statement_msize) == SQLITE_ROW) {
            char *msSize = (char *)sqlite3_column_text(statement_msize,1);
            NSLog(@"msname:%s",msSize);
            NSString *mssSize= [NSString stringWithCString:msSize encoding:NSUTF8StringEncoding];
            [_msize addObject:mssSize];
           // NSLog(@"msName: %@",[NSString stringWithCString:msSize encoding:NSUTF8StringEncoding]);
         
        }
        
        //Area while 迴圈查詢結果
        while (sqlite3_step(statement_rate) == SQLITE_ROW) {
            char *cvRate = (char *)sqlite3_column_text(statement_rate,1);
            char *cvTime = (char *)sqlite3_column_text(statement_rate,2);
            char *cvsPeed = (char *)sqlite3_column_text(statement_rate,5);
            NSLog(@"msname:%s",cvRate);
            NSLog(@"msname:%s",cvTime);
            NSLog(@"msname:%s",cvsPeed);
            
            NSString *msRate= [NSString stringWithCString:cvRate encoding:NSUTF8StringEncoding];
            NSString *msTime= [NSString stringWithCString:cvTime encoding:NSUTF8StringEncoding];
            NSString *msSpeed= [NSString stringWithCString:cvsPeed encoding:NSUTF8StringEncoding];
            [_rateValue addObject:msRate];
            [_timeValue addObject:msTime];
            [_speedValue addObject:msSpeed];

            NSLog(@"msRate: %@",[NSString stringWithCString:cvRate encoding:NSUTF8StringEncoding]);
            NSLog(@"msRate: %@",[NSString stringWithCString:cvTime encoding:NSUTF8StringEncoding]);
            NSLog(@"msRate: %@",[NSString stringWithCString:cvsPeed encoding:NSUTF8StringEncoding]);
            
        }
        
        
        
        
        //關閉sqlite
        sqlite3_finalize(statement_cuntry);
        sqlite3_finalize(statement_meterial);
        sqlite3_finalize(statement_category);
        sqlite3_finalize(statement_msize);
        sqlite3_finalize(statement_rate);
//        
//        NSLog(@"cuntry陣列為：%@",_cuntry);
//        NSLog(@"meteria陣列為：%@",_meteria);
//        NSLog(@"category陣列為：%@",_category);
//        NSLog(@"msize陣列為：%@",_msize);
        NSLog(@"timeValue陣列為：%@",_timeValue);
        NSLog(@"rateValue陣列為：%@",_rateValue);
        NSLog(@"speedValue陣列為：%@",_speedValue);
    }
    
    //所有 欄位初始化呈現
    self.countryField.inputView=[[UIView alloc] init];
    self.countryField.tag = 1;
    self.countryField.delegate =self;
    
    self.meterialField.inputView=[[UIView alloc] init];
    self.meterialField.tag = 2;
    self.meterialField.delegate =self;
    
    self.categoryField.inputView=[[UIView alloc] init];
    self.categoryField.tag = 3;
    self.categoryField.delegate =self;
    
    self.msizeField.inputView=[[UIView alloc] init];
    self.msizeField.tag = 4;
    self.msizeField.delegate =self;
    
    self.rateValueField.inputView=[[UIView alloc] init];
    self.rateValueField.tag = 5;
    self.rateValueField.delegate =self;
    
    self.timeValueField.inputView=[[UIView alloc] init];
    self.timeValueField.tag = 6;
    self.timeValueField.delegate =self;
    
    
     //country pickerview初始化呈現
    self.countryPickView = [[UIPickerView alloc]init];
    self.countryPickView.delegate = self;
    self.countryPickView.tag=1;
    self.countryPickView.shouldGroupAccessibilityChildren=YES;
    
    //meterial pickerview初始化呈現
    self.meterialPickView = [[UIPickerView alloc]init];
    self.meterialPickView.delegate = self;
    self.meterialPickView.tag=2;
    self.meterialPickView.shouldGroupAccessibilityChildren=YES;
    
    //category pickerview初始化呈現
    self.categoryPickView = [[UIPickerView alloc]init];
    self.categoryPickView.delegate = self;
    self.categoryPickView.tag=3;
    self.categoryPickView.shouldGroupAccessibilityChildren=YES;
    
    //msize pickerview初始化呈現
    self.msizePickView = [[UIPickerView alloc]init];
    self.msizePickView.delegate = self;
    self.msizePickView.tag=4;
    self.msizePickView.shouldGroupAccessibilityChildren=YES;
    
    //areaValue pickerview初始化呈現
    self.ratealuePickView = [[UIPickerView alloc]init];
    self.ratealuePickView.delegate = self;
    self.ratealuePickView.tag=5;
    self.ratealuePickView.shouldGroupAccessibilityChildren=YES;
    
    //timeValue pickerview初始化呈現
    self.timeValuePickView = [[UIPickerView alloc]init];
    self.timeValuePickView.delegate = self;
    self.timeValuePickView.tag=6;
    self.timeValuePickView.shouldGroupAccessibilityChildren=YES;
    
    //keybord toolbar
    self.keybordToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width, 38.0f)];
    self.keybordToolbar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc]initWithTitle:@"確定" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard:)];
    [self.keybordToolbar setItems:@[spaceBarItem,doneBarItem]];
    
    self.countryField.inputAccessoryView = self.keybordToolbar;
    self.countryField.inputView = self.countryPickView;
    
    self.meterialField.inputAccessoryView = self.keybordToolbar;
    self.meterialField.inputView = self.meterialPickView;
    
    self.categoryField.inputAccessoryView = self.keybordToolbar;
    self.categoryField.inputView = self.categoryPickView;
    
    self.msizeField.inputAccessoryView = self.keybordToolbar;
    self.msizeField.inputView = self.msizePickView;
    
    self.rateValueField.inputAccessoryView = self.keybordToolbar;
    self.rateValueField.inputView = self.ratealuePickView;
    
    self.timeValueField.inputAccessoryView = self.keybordToolbar;
    self.timeValueField.inputView = self.timeValuePickView;
    
    
}

- (void)resignKeyboard:(id)sender
{
    id firstResponder = [self getFirstResponder];
    if ([firstResponder isKindOfClass:[UITextField class]]) {
        [firstResponder resignFirstResponder];
    }
    
    
    NSString *size = self.msizeField.text;
    if ([size isEqualToString:@"200X150"]) {
        self.msizeAreaLabel.text=@"39";
        self.msizePicView.contentMode = UIViewContentModeRedraw;
        self.msizePicView.image =[UIImage imageNamed:@"1.png"];
    }else if ([size isEqualToString:@"600X200"]){
        self.msizeAreaLabel.text=@"134";
        self.msizePicView.contentMode = UIViewContentModeRedraw;
        self.msizePicView.image =[UIImage imageNamed:@"2.png"];
    }else if ([size isEqualToString:@"100X5t"]){
        self.msizeAreaLabel.text=@"15";
        self.msizePicView.contentMode = UIViewContentModeRedraw;
        self.msizePicView.image =[UIImage imageNamed:@"3.png"];
    }else if ([size isEqualToString:@"50x3t"]){
        self.msizeAreaLabel.text=@"40";
        self.msizePicView.contentMode = UIViewContentModeRedraw;
        self.msizePicView.image =[UIImage imageNamed:@"4.png"];
    }else if ([size isEqualToString:@"50"]){
        self.msizeAreaLabel.text=@"117";
        self.msizePicView.contentMode = UIViewContentModeRedraw;
        self.msizePicView.image =[UIImage imageNamed:@"5.png"];
    }else if ([size isEqualToString:@"100"]){
        self.msizeAreaLabel.text=@"79";
        self.msizePicView.contentMode = UIViewContentModeRedraw;
        self.msizePicView.image =[UIImage imageNamed:@"6.png"];
    }else if ([size isEqualToString:@"200"]){
        self.msizeAreaLabel.text=@"314";
        self.msizePicView.contentMode = UIViewContentModeRedraw;
        self.msizePicView.image =[UIImage imageNamed:@"7.png"];
    }else if ([size isEqualToString:@"300"]){
        self.msizeAreaLabel.text=@"707";
        self.msizePicView.contentMode = UIViewContentModeRedraw;
        self.msizePicView.image =[UIImage imageNamed:@"8.png"];
    }else if ([size isEqualToString:@"400"]){
        self.msizeAreaLabel.text=@"1257";
        self.msizePicView.contentMode = UIViewContentModeRedraw;
        self.msizePicView.image =[UIImage imageNamed:@"9.png"];
    }else if ([size isEqualToString:@"500"]){
        self.msizeAreaLabel.text=@"1963";
        self.msizePicView.contentMode = UIViewContentModeRedraw;
        self.msizePicView.image =[UIImage imageNamed:@"10.png"];
    }else if ([size isEqualToString:@"700"]){
        self.msizeAreaLabel.text=@"3848";
        self.msizePicView.contentMode = UIViewContentModeRedraw;
        self.msizePicView.image =[UIImage imageNamed:@"11.png"];
    }else if ([size isEqualToString:@"1000"]){
        self.msizeAreaLabel.text=@"7854";
        self.msizePicView.contentMode = UIViewContentModeRedraw;
        self.msizePicView.image =[UIImage imageNamed:@"12.png"];
    }

  
    
}

- (id)getFirstResponder
{
    NSUInteger index = 0;
    while (index <= 6) {
        UITextField *textField = (UITextField *)[self.view viewWithTag:index];
        if ([textField isFirstResponder]) {
            return textField;
        }
        index++;
    }
    return 0;
}
- (void)checkSpecialFields:(NSUInteger)tag
{
    
    if (tag == 1 && [self.countryField.text isEqualToString:@""]) {
        [self setCuntryData];
    } else if (tag == 2 && [self.meterialField.text isEqualToString:@""]) {
        [self setMeterialData];
    }else if (tag == 3 && [self.categoryField.text isEqualToString:@""]) {
        [self setCategorylData];
    }
    else if (tag == 4 && [self.msizeField.text isEqualToString:@""]) {
        [self setMsizelData];
    }else if (tag == 5 && [self.rateValueField.text isEqualToString:@""]) {
        [self setRateData];
    }else if (tag == 6 && [self.timeValueField.text isEqualToString:@""]) {
        [self setTimeData];
    }

}

//儲存picker資料
- (void)setCuntryData
{
    NSInteger row = [self.countryPickView selectedRowInComponent:0];
    self.countryField.text = self.cuntry[row];
    self.nsCuntry = self.cuntry[row];
}

- (void)setMeterialData
{
    NSInteger row = [self.meterialPickView selectedRowInComponent:0];
    self.meterialField.text= self.meteria[row];
    self.nsMetrial = self.meteria[row];
   
}

- (void)setCategorylData
{
    NSInteger row = [self.categoryPickView selectedRowInComponent:0];
    self.categoryField.text= self.category[row];
    self.nsCategory = self.category[row];
}

- (void)setMsizelData
{
    NSInteger row = [self.categoryPickView selectedRowInComponent:0];
    self.msizeField.text= self.msize[row];
    self.nsMsName = self.msize[row];
}

- (void)setRateData
{
    NSInteger row = [self.ratealuePickView selectedRowInComponent:0];
    self.msizeField.text= self.rateValue[row];
    self.nsRate = self.rateValue[row];
}

- (void)setTimeData
{
    NSInteger row = [self.timeValuePickView selectedRowInComponent:0];
    self.timeValueField.text= self.timeValue[row];
    self.nsTime = self.timeValue[row];
}

//textField 委任
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSUInteger tag = [textField tag];
    [self checkSpecialFields:tag];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger tag = [textField tag];
    if (tag == 1 || tag == 2 || tag == 3 || tag == 4 || tag == 5 || tag == 6) {
        return NO;
    }
    return YES;
}



// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
     NSUInteger tag = [pickerView tag];
    
    if (tag == 1){
        NSLog(@"countryField 1");
        return [self.cuntry count];
       
    }else if (tag == 2){
        
        NSLog(@"meterialField 1");
         return [self.meteria count];
    }else if (tag == 3){
        NSLog(@"categorylField 1");
        return [self.category count];
    }else if (tag == 4){
        NSLog(@"msizelField 1");
        return [self.msize count];
    }else if (tag == 5){
        NSLog(@"rateField 1");
        return [self.rateValue count];
    }else if (tag == 6){
        NSLog(@"rateField 1");
        return [self.timeValue count];
    }
    
     return 0;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
      NSUInteger tag = [pickerView tag];
   // self.meteria = [[NSMutableArray alloc]init];
    if (tag ==1) {
         NSLog(@"countryField 2");
       //self.meteria = [[NSMutableArray alloc]init];
       return _cuntry[row];
    }else if (tag == 2){
    
        NSLog(@"meterialField 2");
        NSLog(@"_meteria[row] %@", _meteria[row]);
       return _meteria[row];
    }else if (tag == 3){
        NSLog(@"categorylField 2");
        return self.category[row];
    }else if (tag == 4){
        NSLog(@"msizelField 2");
        return self.msize[row];
    }else if (tag == 5){
        NSLog(@"rateField 2");
        return self.rateValue[row];
    }else if (tag == 6){
        NSLog(@"rateField 2");
        return self.timeValue[row];
    }

    

    return 0;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSUInteger tag = [pickerView tag];
     if (tag ==1) {
         NSLog(@"countryField 3");
        self.countryField.text = _cuntry[row];
        self.nsCuntry=self.countryField.text;
        [self.meterialPickView reloadAllComponents];
         
     }else if (tag == 2){
         NSLog(@"meterialField 3");
        self.meterialField.text = _meteria[row];
        self.nsMeterialName = self.meterialField.text;
        [self.ratealuePickView reloadAllComponents];
        [self.timeValuePickView reloadAllComponents];
     }else if (tag == 3){
         NSLog(@"categorylField 3");
         self.categoryField.text=_category[row];
         self.nsMsName=self.categoryField.text;
         [self.msizePickView reloadAllComponents];
         
     }else if (tag == 4){
         NSLog(@"msizeField 3");
         self.msizeField.text=_msize[row];
         self.nsMsSizeName = self.msizeField.text;
         [self.ratealuePickView reloadAllComponents];
         [self.timeValuePickView reloadAllComponents];
     }else if (tag == 5){
         NSLog(@"rateField 3");
         self.rateValueField.text=_rateValue[row];
         self.speedLabel.text = [self.speedValue objectAtIndex:row];
         self.timeValueField.text = [self.timeValue objectAtIndex:row];
        NSLog(@"＊＊＊＊＊＊速度變換：%@",[self.speedValue objectAtIndex:row]);
        NSLog(@"＊＊＊＊＊＊時間變換：%@",[self.timeValue objectAtIndex:row]);
        [self.ratealuePickView reloadAllComponents];
         
     }else if (tag == 6){
         NSLog(@"rateField 3");
         self.timeValueField.text=_timeValue[row];
         self.speedLabel.text = [self.speedValue objectAtIndex:row];
         self.rateValueField.text = [self.rateValue objectAtIndex:row];
         NSLog(@"＊＊＊＊＊＊速度變換：%@",[self.speedValue objectAtIndex:row]);
         NSLog(@"＊＊＊＊＊＊rate變換：%@",[self.rateValue objectAtIndex:row]);
         [self.timeValuePickView reloadAllComponents];
     }


    NSLog(@"變換nsCuntry:%@",_nsCuntry);
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    sqlite3 *db = [delegate getDB];
    if(db != nil)
    {
        
        NSLog(@"有抓到資料庫");
        //cuntry 欄位 SQL command
        const char *countrySql = "SELECT * FROM cuntry";
        //msterial 欄位 SQL command
        NSString *meterial =[[NSString alloc]initWithFormat:@"SELECT * FROM meterial WHERE c_name = '%@' ORDER BY m_id" ,self.nsCuntry];
       // NSLog(@"變換meterial:%@",meterial);
        const char *meterialSql =[meterial UTF8String];
        
        //msterial 欄位 SQL command
        const char *categorySql ="SELECT * FROM category";
        
        
        //msize 欄位 SQL command
        NSString *msize =[[NSString alloc]initWithFormat:@"SELECT * FROM msize WHERE ca_name = '%@' ORDER BY ms_id",self.nsMsName];
        NSLog(@"meterial:%@",meterial);
        const char *msizeSql =[msize UTF8String];
        
        //rate 欄位 SQL command
        NSString *rate =[[NSString alloc]initWithFormat:@"SELECT * FROM cut_value WHERE ms_size = '%@' AND m_name = '%@' ORDER BY cv_id",self.nsMsSizeName,self.nsMeterialName];
        NSLog(@"meterial:%@",msize);
        const char *rateSql =[rate UTF8String];
        NSLog(@"變換後Rate%@",rate);

        
        //statement //儲存cuntrySql執行結果;
        sqlite3_stmt *statement_cuntry;
        
        //statement //儲存meteriaSql執行結果;
        sqlite3_stmt *statement_meterial;
        
        //statement //儲存categorylySql執行結果;
        sqlite3_stmt *statement_category;
        
        //statement //儲存msizeSql執行結果;
        sqlite3_stmt *statement_msize;
        
        //statement //儲存areaSql執行結果;
        sqlite3_stmt *statement_rate;
        
        sqlite3_prepare(db, countrySql, -1, &statement_cuntry, NULL);
        sqlite3_prepare(db, meterialSql, -1, &statement_meterial, NULL);
        sqlite3_prepare(db, categorySql, -1, &statement_category, NULL);
        sqlite3_prepare(db, msizeSql, -1, &statement_msize, NULL);
        sqlite3_prepare(db, rateSql, -1, &statement_rate, NULL);

        
        //msetrial while 迴圈查詢結果
        //再選擇時候將msetrial初始化
        self.meteria = [[NSMutableArray alloc]init];
        while (sqlite3_step(statement_meterial) == SQLITE_ROW) {
            char *caname = (char *)sqlite3_column_text(statement_meterial,1);
            NSString *nsMeterial= [NSString stringWithCString:caname encoding:NSUTF8StringEncoding];
            [_meteria addObject:nsMeterial];
            NSLog(@"選擇時變動CA_NAME: %@",[NSString stringWithCString:caname encoding:NSUTF8StringEncoding]);
        }
        //msize 迴圈查詢結果
        //再選擇時候將msize初始化
         self.msize = [[NSMutableArray alloc]init];
        while (sqlite3_step(statement_msize) == SQLITE_ROW) {
            char *msSize = (char *)sqlite3_column_text(statement_msize,1);
            
            NSLog(@"msname:%s",msSize);

            
            NSString *mssSize= [NSString stringWithCString:msSize encoding:NSUTF8StringEncoding];
            [_msize addObject:mssSize];
            
            NSLog(@"msName: %@",[NSString stringWithCString:msSize encoding:NSUTF8StringEncoding]);
        }
        
        //rate while 迴圈查詢結果
        self.rateValue = [[NSMutableArray alloc]init];
        self.speedValue = [[NSMutableArray alloc]init];
        self.timeValue = [[NSMutableArray alloc]init];
        while (sqlite3_step(statement_rate) == SQLITE_ROW) {
            char *cvRate = (char *)sqlite3_column_text(statement_rate,1);
            char *cvTime = (char *)sqlite3_column_text(statement_rate,2);
            char *cvsPeed = (char *)sqlite3_column_text(statement_rate,5);
            NSLog(@"msname:%s",cvRate);
            NSLog(@"msname:%s",cvTime);
            NSLog(@"msname:%s",cvsPeed);
            
            NSString *msRate= [NSString stringWithCString:cvRate encoding:NSUTF8StringEncoding];
            NSString *msTime= [NSString stringWithCString:cvTime encoding:NSUTF8StringEncoding];
            NSString *msSpeed= [NSString stringWithCString:cvsPeed encoding:NSUTF8StringEncoding];
            [_rateValue addObject:msRate];
            [_timeValue addObject:msTime];
            [_speedValue addObject:msSpeed];
            
            NSLog(@"msRate: %@",[NSString stringWithCString:cvRate encoding:NSUTF8StringEncoding]);
            NSLog(@"msRate: %@",[NSString stringWithCString:cvTime encoding:NSUTF8StringEncoding]);
            NSLog(@"msRate: %@",[NSString stringWithCString:cvsPeed encoding:NSUTF8StringEncoding]);
            
        }
         NSLog(@"變換後speedValue陣列為：%@",_speedValue);
        NSLog(@"變換後timeValue陣列為：%@",_timeValue);
        
        sqlite3_finalize(statement_cuntry);
        sqlite3_finalize(statement_meterial);
        sqlite3_finalize(statement_msize);
        sqlite3_finalize(statement_rate);
       // NSLog(@"選擇後的meteria陣列:%@", _meteria);
    }
    //判斷msize的ms_size為何給予值
    
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
