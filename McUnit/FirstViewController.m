//
//  FirstViewController.m
//  McUnit
//
//  Created by kid chiu on 2015/7/22.
//  Copyright (c) 2015年 kidmac. All rights reserved.
// test

#import "FirstViewController.h"

@interface FirstViewController (){
    NSArray * _pickerData;
    NSMutableDictionary *_pickSelect;
    NSMutableDictionary * pickValue;
    NSString *unitName;
    NSMutableArray * unitValue;
    NSInteger unitRow;
    NSInteger rowOne;
    NSInteger rowTow;
    NSInteger rowThree;
    NSInteger rowFour;
    NSInteger rowFive;
    BOOL textBool1;
    BOOL textBool2;
    BOOL textBool3;
    BOOL textBool4;
    BOOL textBool5;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     //改變tab bar 圖示
    self.tabBarItem.title = @"單位換算";
    [self.tabBarItem setImage:[[UIImage imageNamed:@"tab-iconA.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab-iconA-1.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    //設置鍵盤格式
 self.text1.keyboardType = UIKeyboardTypeDecimalPad;
 self.text2.keyboardType = UIKeyboardTypeDecimalPad;
 self.text3.keyboardType = UIKeyboardTypeDecimalPad;
 self.text4.keyboardType = UIKeyboardTypeDecimalPad;
 self.text5.keyboardType = UIKeyboardTypeDecimalPad;
    typedef enum {
        UIKeyboardTypeDefault,                //預設鍵盤
        UIKeyboardTypeASCIICapable,           //支援ASCII的键盘
        UIKeyboardTypeNumbersAndPunctuation,  //標準電話號碼，含＋＊＃符號
        UIKeyboardTypeURL,                      //URL鍵盤，含com按鈕 支援URL符號
        UIKeyboardTypeNumberPad,              //數字鍵盤
        UIKeyboardTypePhonePad,             //電話鍵盤
        UIKeyboardTypeNamePhonePad,           //電話鍵盤，支援輸入人名
        UIKeyboardTypeEmailAddress,           //用在輸入電子郵件的鍵盤
        UIKeyboardTypeDecimalPad,            //數字鍵盤 有數字與小數點        UIKeyboardTypeTwitter,               //優化鍵盤，方便輸入
        UIKeyboardTypeAlphabet = UIKeyboardTypeASCIICapable,
    } UIKeyboardType;
    
    //再次編輯就清空
self.text1.clearsOnBeginEditing = YES;
self.text2.clearsOnBeginEditing = YES;
self.text3.clearsOnBeginEditing = YES;
self.text4.clearsOnBeginEditing = YES;
self.text5.clearsOnBeginEditing = YES;
    
    //預設欄位值
    self.text1.text =  @"0";
    self.text2.text =  @"0";
    self.text3.text =  @"0";
    self.text4.text =  @"0";
    self.text5.text =  @"0";
    
    //委任pick
    self.picker.dataSource = self;
    self.picker.delegate = self;
    //委任text
//    self.text1.delegate = self;
////    self.text2.delegate = self;
////    self.text3.delegate = self;
////    self.text4.delegate = self;
////    self.text5.delegate = self;
    // Connect data
   
    [_picker setShowsSelectionIndicator:YES];
    [self loadPickerData];
}
- (void)loadPickerData
{
    
    self.cell1.text =  @"m";
    self.cell2.text =  @"m";
    self.cell3.text =  @"m";
    self.cell4.text =  @"m";
    self.cell5.text =  @"m";
    
    _pickerData = @[@"長度", @"重力", @"速度", @"時間", @"溫度"];
    _pickSelect = [NSMutableDictionary dictionary];
    pickValue = [NSMutableDictionary dictionary];
    
    NSArray *unit1 = @[@"cm", @"m", @"km", @"in", @"ft", @"尺"];
    [_pickSelect setValue:unit1 forKey:@"長度"];

     NSArray *unit2 = @[@"gr", @"dyne", @"kg", @"lb", @"poundal"];
    [_pickSelect setValue:unit2 forKey:@"重力"];
    [pickValue setValue:unitValue forKey:@"重力"];
    
    NSArray *unit3 = @[@"m/s", @"m/hr", @"km/hr", @"ft/sec", @"ft/min", @"mil/hr"];
    [_pickSelect setValue:unit3 forKey:@"速度"];
    
    NSArray *unit4 = @[@"sec", @"min", @"hr", @"d", @"yr"];
    [_pickSelect setValue:unit4 forKey:@"時間"];
    
    NSArray *unit5 = @[@"°C", @"°F"];
    [_pickSelect setValue:unit5 forKey:@"溫度"];
    
    [self.text1 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.text2 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.text3 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.text4 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.text5 addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.text1 resignFirstResponder];
    [self.text2 resignFirstResponder];
    [self.text3 resignFirstResponder];
    [self.text4 resignFirstResponder];
    [self.text5 resignFirstResponder];
}

- (BOOL) textFieldDidChange:(UITextField*)textField {
    unitValue = [[NSMutableArray alloc]init];
    
//    NSLog(@"textFieldDidChange unitValue%@",unitValue);
//    NSLog(@"qqqqqq%@",textField);
    double gr = 0,dyne = 0,kg = 0,lb = 0,poundal = 0;
    double cm=0,m=0,km=0,inv=0,ft=0,mm=0 ;
    double msec=0,mhr=0,kmhr=0,ftsec=0,ftmin=0,milehr=0;
    double sec=0,min=0,hr=0,d=0,yr=0;
    double cv=0,fv=0;
    
    NSNumber *unitvs1 = [[NSNumber alloc]init];
    NSNumber *unitvs2 = [[NSNumber alloc]init];
    NSNumber *unitvs3 = [[NSNumber alloc]init];
    NSNumber *unitvs4 = [[NSNumber alloc]init];
    NSNumber *unitvs5 = [[NSNumber alloc]init];
    NSNumber *unitvs6 = [[NSNumber alloc]init];
    
    if ([unitName containsString:@"重力"] ) {
         NSLog(@"現在為%@",_pickerData[1]);
        if (textField == _text1) {
            textBool1 = true;
            textBool2 = false;
            textBool3 = false;
            textBool4 = false;
            textBool5 = false;
            
            switch(rowOne) {
                case 0:
                    gr = [self.text1.text doubleValue]*1;
                    dyne = gr*980.6;
                    kg = gr*0.001;
                    lb = gr*0.002205;
                    poundal = gr*0.07092;
                    NSLog(@"gr:%f",gr);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    dyne = [self.text1.text doubleValue]*1;
                    gr = dyne*0.00102;
                    kg = dyne*0.00000102;
                    lb = dyne*0.000002248;
                    poundal = dyne*0.00007233;
                    NSLog(@"gr:%f",dyne);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    kg = [self.text1.text doubleValue]*1;
                    dyne = kg*980600;
                    gr = kg*1000;
                    lb = kg*2.20462;
                    poundal = kg*70.9119;
                    NSLog(@"gr:%f",kg);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    lb = [self.text1.text doubleValue]*1;
                    dyne = lb*444.792;
                    kg = lb*0.45359;
                    gr = lb*453.59;
                    poundal = lb*32.17;
                    NSLog(@"gr:%f",lb);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                default:
                    poundal = [self.text1.text doubleValue]*1;
                    dyne = poundal*13.825;
                    kg = poundal*0.014102;
                    lb = poundal*0.03109;
                    gr = poundal*14.102;
                    NSLog(@"gr:%f",poundal);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
            
        }else if (textField == _text2) {
            //重量 欄位二 rowTow 換算
            textBool2 = true;
            textBool1 = false;
            textBool3 = false;
            textBool4 = false;
            textBool5 = false;
            NSLog(@"text2 被選中,值：%@",self.text2.text);
            switch(rowTow) {
                case 0:
                    gr = [self.text2.text doubleValue]*1;
                    dyne = gr*980.6;
                    kg = gr*0.001;
                    lb = gr*0.002205;
                    poundal = gr*0.07092;
                    NSLog(@"gr:%f",gr);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }

                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    dyne = [self.text2.text doubleValue]*1;
                    gr = dyne*0.00102;
                    kg = dyne*0.00000102;
                    lb = dyne*0.000002248;
                    poundal = dyne*0.00007233;
                    NSLog(@"gr:%f",dyne);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    NSLog(@"unitVale: %@",unitValue);
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    break;
                case 2:
                    kg = [self.text2.text doubleValue]*1;
                    dyne = kg*980600;
                    gr = kg*1000;
                    lb = kg*2.20462;
                    poundal = kg*70.9119;
                    NSLog(@"gr:%f",kg);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    lb = [self.text2.text doubleValue]*1;
                    dyne = lb*444.792;
                    kg = lb*0.45359;
                    gr = lb*453.59;
                    poundal = lb*32.17;
                    NSLog(@"gr:%f",lb);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                default:
                    poundal = [self.text2.text doubleValue]*1;
                    dyne = poundal*13.825;
                    kg = poundal*0.014102;
                    lb = poundal*0.03109;
                    gr = poundal*14.102;
                    NSLog(@"gr:%f",poundal);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
            
        }else if (textField == _text3) {
            //重量 欄位二 rowTow 換算
            textBool3 = true;
            textBool2 = false;
            textBool1 = false;
            textBool4 = false;
            textBool5 = false;
           NSLog(@"text3 被選中,值：%@",self.text3.text);
            switch(rowThree) {
                case 0:
                    gr = [self.text3.text doubleValue]*1;
                    dyne = gr*980.6;
                    kg = gr*0.001;
                    lb = gr*0.002205;
                    poundal = gr*0.07092;
                    NSLog(@"gr:%f",gr);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    dyne = [self.text3.text doubleValue]*1;
                    gr = dyne*0.00102;
                    kg = dyne*0.00000102;
                    lb = dyne*0.000002248;
                    poundal = dyne*0.00007233;
                    NSLog(@"gr:%f",dyne);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    kg = [self.text3.text doubleValue]*1;
                    dyne = kg*980600;
                    gr = kg*1000;
                    lb = kg*2.20462;
                    poundal = kg*70.9119;
                    NSLog(@"gr:%f",kg);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    lb = [self.text3.text doubleValue]*1;
                    dyne = lb*444.792;
                    kg = lb*0.45359;
                    gr = lb*453.59;
                    poundal = lb*32.17;
                    NSLog(@"gr:%f",lb);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                default:
                    poundal = [self.text3.text doubleValue]*1;
                    dyne = poundal*13.825;
                    kg = poundal*0.014102;
                    lb = poundal*0.03109;
                    gr = poundal*14.102;
                    NSLog(@"gr:%f",poundal);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }

            
        }else if (textField == _text4) {                        //重量 欄位二 rowTow 換算
            textBool4 = true;
            textBool3=false;
            textBool2=false;
            textBool1 = false;
            textBool5 = false;
           NSLog(@"text4 被選中,值：%@",self.text4.text);
            switch(rowFour) {
                case 0:
                    gr = [self.text4.text doubleValue]*1;
                    dyne = gr*980.6;
                    kg = gr*0.001;
                    lb = gr*0.002205;
                    poundal = gr*0.07092;
                    NSLog(@"gr:%f",gr);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }

                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    dyne = [self.text4.text doubleValue]*1;
                    gr = dyne*0.00102;
                    kg = dyne*0.00000102;
                    lb = dyne*0.000002248;
                    poundal = dyne*0.00007233;
                    NSLog(@"gr:%f",dyne);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    kg = [self.text4.text doubleValue]*1;
                    dyne = kg*980600;
                    gr = kg*1000;
                    lb = kg*2.20462;
                    poundal = kg*70.9119;
                    NSLog(@"gr:%f",kg);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    lb = [self.text4.text doubleValue]*1;
                    dyne = lb*444.792;
                    kg = lb*0.45359;
                    gr = lb*453.59;
                    poundal = lb*32.17;
                    NSLog(@"gr:%f",lb);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }

                    NSLog(@"unitVale: %@",unitValue);
                    break;
                default:
                    poundal = [self.text4.text doubleValue]*1;
                    dyne = poundal*13.825;
                    kg = poundal*0.014102;
                    lb = poundal*0.03109;
                    gr = poundal*14.102;
                    NSLog(@"gr:%f",poundal);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }

                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }

            
        }else {
            textBool5 = true;
            textBool4=false;
            textBool3=false;
            textBool2 = false;
            textBool1 = false;
           NSLog(@"text5 被選中,值：%@",self.text5.text);
            switch(rowFive) {
                case 0:
                    gr = [self.text5.text doubleValue]*1;
                    dyne = gr*980.6;
                    kg = gr*0.001;
                    lb = gr*0.002205;
                    poundal = gr*0.07092;
                    NSLog(@"gr:%f",gr);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }

                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    dyne = [self.text5.text doubleValue]*1;
                    gr = dyne*0.00102;
                    kg = dyne*0.00000102;
                    lb = dyne*0.000002248;
                    poundal = dyne*0.00007233;
                    NSLog(@"gr:%f",dyne);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                    }
                    
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    kg = [self.text5.text doubleValue]*1;
                    dyne = kg*980600;
                    gr = kg*1000;
                    lb = kg*2.20462;
                    poundal = kg*70.9119;
                    NSLog(@"gr:%f",kg);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    

                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    lb = [self.text5.text doubleValue]*1;
                    dyne = lb*444.792;
                    kg = lb*0.45359;
                    gr = lb*453.59;
                    poundal = lb*32.17;
                    NSLog(@"gr:%f",lb);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    

                    NSLog(@"unitVale: %@",unitValue);
                    break;
                default:
                    poundal = [self.text5.text doubleValue]*1;
                    dyne = poundal*13.825;
                    kg = poundal*0.014102;
                    lb = poundal*0.03109;
                    gr = poundal*14.102;
                    NSLog(@"gr:%f",poundal);
                    unitvs1 = [NSNumber numberWithDouble:gr];
                    unitvs2 = [NSNumber numberWithDouble:dyne];
                    unitvs3 = [NSNumber numberWithDouble:kg];
                    unitvs4 = [NSNumber numberWithDouble:lb];
                    unitvs5 = [NSNumber numberWithDouble:poundal];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                    }
                    

                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
        }
    
    }else if([unitName containsString:@"速度"] ){
          NSLog(@"now1%@",_pickerData[2]);
        if (textField == _text1) {
            textBool1 = true;
            textBool2 = false;
            textBool3 = false;
            textBool4 = false;
            textBool5 = false;
            switch(rowOne) {
                case 0:
                    msec = [self.text1.text doubleValue]*1;
                    mhr = msec*3600;
                    kmhr = msec*3.6;
                    ftsec = msec*3.281;
                    ftmin = msec*196.85;
                    milehr = msec*2.2370;
                    NSLog(@"gr:%f",msec);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    mhr = [self.text1.text doubleValue]*1;
                    msec = mhr*0.0002778;
                    kmhr = mhr*0.001;
                    ftsec = mhr*0.0009114;
                    ftmin = mhr*0.05468;
                    milehr = mhr*0.000621;
                    NSLog(@"gr:%f",mhr);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    kmhr = [self.text1.text doubleValue]*1;
                    msec = kmhr*0.2778;
                    mhr = kmhr*1000;
                    ftsec = kmhr*0.9114;
                    ftmin = kmhr*54.682;
                    milehr = kmhr*0.6214;
                    NSLog(@"gr:%f",kmhr);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    ftsec = [self.text1.text doubleValue]*1;
                    msec = ftsec*0.3048;
                    mhr = ftsec*1097.25;
                    kmhr = ftsec*1.0973;
                    ftmin = ftsec*60;
                    milehr = ftsec*0.68182;
                    NSLog(@"gr:%f",ftsec);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 4:
                    ftmin = [self.text1.text doubleValue]*1;
                    msec = ftmin*0.005080;
                    mhr = ftmin*18.287;
                    kmhr = ftmin*0.01829;
                    ftsec = ftmin*0.01667;
                    milehr = ftmin*0.01136;
                    NSLog(@"gr:%f",ftmin);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                    
                default:
                    milehr = [self.text1.text doubleValue]*1;
                    msec = milehr*0.4470;
                    mhr = milehr*1609.3;
                    kmhr = milehr*1.6093;
                    ftsec = milehr*1.4667;
                    ftmin = milehr*88;
                    NSLog(@"gr:%f",milehr);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
            
        }else if (textField == _text2) {
            //速度 欄位二 rowTow 換算
            textBool2 = true;
            textBool1 = false;
            textBool3 = false;
            textBool4 = false;
            textBool5 = false;
            NSLog(@"text2 被選中,值：%@",self.text2.text);
            switch(rowTow) {
                case 0:
                    msec = [self.text2.text doubleValue]*1;
                    mhr = msec*3600;
                    kmhr = msec*3.6;
                    ftsec = msec*3.281;
                    ftmin = msec*196.85;
                    milehr = msec*2.2370;
                    NSLog(@"gr:%f",msec);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    mhr = [self.text2.text doubleValue]*1;
                    msec = mhr*0.0002778;
                    kmhr = mhr*0.001;
                    ftsec = mhr*0.0009114;
                    ftmin = mhr*0.05468;
                    milehr = mhr*0.000621;
                    NSLog(@"gr:%f",mhr);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    kmhr = [self.text2.text doubleValue]*1;
                    msec = kmhr*0.2778;
                    mhr = kmhr*1000;
                    ftsec = kmhr*0.9114;
                    ftmin = kmhr*54.682;
                    milehr = kmhr*0.6214;
                    NSLog(@"gr:%f",kmhr);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    ftsec = [self.text2.text doubleValue]*1;
                    msec = ftsec*0.3048;
                    mhr = ftsec*1097.25;
                    kmhr = ftsec*1.0973;
                    ftmin = ftsec*60;
                    milehr = ftsec*0.68182;
                    NSLog(@"gr:%f",ftsec);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 4:
                    ftmin = [self.text2.text doubleValue]*1;
                    msec = ftmin*0.005080;
                    mhr = ftmin*18.287;
                    kmhr = ftmin*0.01829;
                    ftsec = ftmin*0.01667;
                    milehr = ftmin*0.01136;
                    NSLog(@"gr:%f",ftmin);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                    
                default:
                    milehr = [self.text2.text doubleValue]*1;
                    msec = milehr*0.4470;
                    mhr = milehr*1609.3;
                    kmhr = milehr*1.6093;
                    ftsec = milehr*1.4667;
                    ftmin = milehr*88;
                    NSLog(@"gr:%f",milehr);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
            
        }else if (textField == _text3) {
            //速度 欄位三 rowTow 換算
            textBool3 = true;
            textBool2=false;
            textBool1 = false;
            textBool4 = false;
            textBool5 = false;
            NSLog(@"text3 被選中,值：%@",self.text3.text);
            switch(rowThree) {
                case 0:
                    msec = [self.text3.text doubleValue]*1;
                    mhr = msec*3600;
                    kmhr = msec*3.6;
                    ftsec = msec*3.281;
                    ftmin = msec*196.85;
                    milehr = msec*2.2370;
                    NSLog(@"gr:%f",msec);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    mhr = [self.text3.text doubleValue]*1;
                    msec = mhr*0.0002778;
                    kmhr = mhr*0.001;
                    ftsec = mhr*0.0009114;
                    ftmin = mhr*0.05468;
                    milehr = mhr*0.000621;
                    NSLog(@"gr:%f",mhr);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    kmhr = [self.text3.text doubleValue]*1;
                    msec = kmhr*0.2778;
                    mhr = kmhr*1000;
                    ftsec = kmhr*0.9114;
                    ftmin = kmhr*54.682;
                    milehr = kmhr*0.6214;
                    NSLog(@"gr:%f",kmhr);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    ftsec = [self.text3.text doubleValue]*1;
                    msec = ftsec*0.3048;
                    mhr = ftsec*1097.25;
                    kmhr = ftsec*1.0973;
                    ftmin = ftsec*60;
                    milehr = ftsec*0.68182;
                    NSLog(@"gr:%f",ftsec);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 4:
                    ftmin = [self.text3.text doubleValue]*1;
                    msec = ftmin*0.005080;
                    mhr = ftmin*18.287;
                    kmhr = ftmin*0.01829;
                    ftsec = ftmin*0.01667;
                    milehr = ftmin*0.01136;
                    NSLog(@"gr:%f",ftmin);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                    
                default:
                    milehr = [self.text3.text doubleValue]*1;
                    msec = milehr*0.4470;
                    mhr = milehr*1609.3;
                    kmhr = milehr*1.6093;
                    ftsec = milehr*1.4667;
                    ftmin = milehr*88;
                    NSLog(@"gr:%f",milehr);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
            
            
        }else if (textField == _text4) {
            //速度 欄位四 rowTow 換算
            textBool4 = true;
            textBool3=false;
            textBool2=false;
            textBool1 = false;
            textBool5 = false;
            NSLog(@"text4 被選中,值：%@",self.text4.text);
            switch(rowFour) {
                case 0:
                    msec = [self.text4.text doubleValue]*1;
                    mhr = msec*3600;
                    kmhr = msec*3.6;
                    ftsec = msec*3.281;
                    ftmin = msec*196.85;
                    milehr = msec*2.2370;
                    NSLog(@"gr:%f",msec);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    mhr = [self.text4.text doubleValue]*1;
                    msec = mhr*0.0002778;
                    kmhr = mhr*0.001;
                    ftsec = mhr*0.0009114;
                    ftmin = mhr*0.05468;
                    milehr = mhr*0.000621;
                    NSLog(@"gr:%f",mhr);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    kmhr = [self.text4.text doubleValue]*1;
                    msec = kmhr*0.2778;
                    mhr = kmhr*1000;
                    ftsec = kmhr*0.9114;
                    ftmin = kmhr*54.682;
                    milehr = kmhr*0.6214;
                    NSLog(@"gr:%f",kmhr);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    ftsec = [self.text4.text doubleValue]*1;
                    msec = ftsec*0.3048;
                    mhr = ftsec*1097.25;
                    kmhr = ftsec*1.0973;
                    ftmin = ftsec*60;
                    milehr = ftsec*0.68182;
                    NSLog(@"gr:%f",ftsec);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 4:
                    ftmin = [self.text4.text doubleValue]*1;
                    msec = ftmin*0.005080;
                    mhr = ftmin*18.287;
                    kmhr = ftmin*0.01829;
                    ftsec = ftmin*0.01667;
                    milehr = ftmin*0.01136;
                    NSLog(@"gr:%f",ftmin);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                    
                default:
                    milehr = [self.text4.text doubleValue]*1;
                    msec = milehr*0.4470;
                    mhr = milehr*1609.3;
                    kmhr = milehr*1.6093;
                    ftsec = milehr*1.4667;
                    ftmin = milehr*88;
                    NSLog(@"gr:%f",milehr);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
        }else {
            textBool5 = true;
            textBool4=false;
            textBool3=false;
            textBool2 = false;
            textBool1 = false;
            NSLog(@"text5 被選中,值：%@",self.text5.text);
            switch(rowFive) {
                case 0:
                    msec = [self.text5.text doubleValue]*1;
                    mhr = msec*3600;
                    kmhr = msec*3.6;
                    ftsec = msec*3.281;
                    ftmin = msec*196.85;
                    milehr = msec*2.2370;
                    NSLog(@"gr:%f",msec);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    mhr = [self.text5.text doubleValue]*1;
                    msec = mhr*0.0002778;
                    kmhr = mhr*0.001;
                    ftsec = mhr*0.0009114;
                    ftmin = mhr*0.05468;
                    milehr = mhr*0.000621;
                    NSLog(@"gr:%f",mhr);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    kmhr = [self.text5.text doubleValue]*1;
                    msec = kmhr*0.2778;
                    mhr = kmhr*1000;
                    ftsec = kmhr*0.9114;
                    ftmin = kmhr*54.682;
                    milehr = kmhr*0.6214;
                    NSLog(@"gr:%f",kmhr);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    ftsec = [self.text5.text doubleValue]*1;
                    msec = ftsec*0.3048;
                    mhr = ftsec*1097.25;
                    kmhr = ftsec*1.0973;
                    ftmin = ftsec*60;
                    milehr = ftsec*0.68182;
                    NSLog(@"gr:%f",ftsec);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 4:
                    ftmin = [self.text5.text doubleValue]*1;
                    msec = ftmin*0.005080;
                    mhr = ftmin*18.287;
                    kmhr = ftmin*0.01829;
                    ftsec = ftmin*0.01667;
                    milehr = ftmin*0.01136;
                    NSLog(@"gr:%f",ftmin);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                    
                default:
                    milehr = [self.text5.text doubleValue]*1;
                    msec = milehr*0.4470;
                    mhr = milehr*1609.3;
                    kmhr = milehr*1.6093;
                    ftsec = milehr*1.4667;
                    ftmin = milehr*88;
                    NSLog(@"gr:%f",milehr);
                    unitvs1 = [NSNumber numberWithDouble:msec];
                    unitvs2 = [NSNumber numberWithDouble:mhr];
                    unitvs3 = [NSNumber numberWithDouble:kmhr];
                    unitvs4 = [NSNumber numberWithDouble:ftsec];
                    unitvs5 = [NSNumber numberWithDouble:ftmin];
                    unitvs6 = [NSNumber numberWithDouble:milehr];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
        }

    }else if([unitName containsString:@"時間"] ){
          NSLog(@"now1%@",_pickerData[3]);
            if (textField == _text1) {
                textBool1 = true;
                textBool2 = false;
                textBool3 = false;
                textBool4 = false;
                textBool5 = false;
                switch(rowOne) {
                    case 0:
                        sec = [self.text1.text doubleValue]*1;
                        min = sec*0.016667;
                        hr = sec*0.00027778;
                        d = sec*0.000011574;
                        yr = sec*0.00000003175;
                        NSLog(@"gr:%f",sec);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        min = [self.text1.text doubleValue]*1;
                        sec = min*60;
                        hr = min*0.016667;
                        d = min*0.00069444;
                        yr = min*0.000001903;
                        NSLog(@"gr:%f",min);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        hr = [self.text1.text doubleValue]*1;
                        sec = hr*3600;
                        min = hr*60;
                        d = hr*0.041667;
                        yr = hr*0.0001142;
                        NSLog(@"gr:%f",hr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        d = [self.text1.text doubleValue]*1;
                        sec = d*86400;
                        min = d*1440;
                        hr = d*24;
                        yr = d*0.00274;
                        NSLog(@"gr:%f",d);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        yr = [self.text1.text doubleValue]*1;
                        sec = yr*31536000;
                        min = yr*525600;
                        hr = yr*8760;
                        yr = yr*365;
                        NSLog(@"gr:%f",yr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];

                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
                
            }else if (textField == _text2) {
                //時間 欄位二 rowTow 換算
                textBool2 = true;
                textBool1 = false;
                textBool3 = false;
                textBool4 = false;
                textBool5 = false;
                NSLog(@"text2 被選中,值：%@",self.text2.text);
                switch(rowTow) {
                    case 0:
                        sec = [self.text2.text doubleValue]*1;
                        min = sec*0.016667;
                        hr = sec*0.00027778;
                        d = sec*0.000011574;
                        yr = sec*0.00000003175;
                        NSLog(@"gr:%f",sec);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        min = [self.text2.text doubleValue]*1;
                        sec = min*60;
                        hr = min*0.016667;
                        d = min*0.00069444;
                        yr = min*0.000001903;
                        NSLog(@"gr:%f",min);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        hr = [self.text2.text doubleValue]*1;
                        sec = hr*3600;
                        min = hr*60;
                        d = hr*0.041667;
                        yr = hr*0.0001142;
                        NSLog(@"gr:%f",hr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        d = [self.text2.text doubleValue]*1;
                        sec = d*86400;
                        min = d*1440;
                        hr = d*24;
                        yr = d*0.00274;
                        NSLog(@"gr:%f",d);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        yr = [self.text2.text doubleValue]*1;
                        sec = yr*31536000;
                        min = yr*525600;
                        hr = yr*8760;
                        yr = yr*365;
                        NSLog(@"gr:%f",yr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
                
            }else if (textField == _text3) {
                //時間 欄位二 rowTow 換算
                 textBool3= true;
                 textBool2=false;
                 textBool1 = false;
                 textBool4 = false;
                 textBool5 = false;
                NSLog(@"text3 被選中,值：%@",self.text3.text);
                switch(rowThree) {
                    case 0:
                        sec = [self.text3.text doubleValue]*1;
                        min = sec*0.016667;
                        hr = sec*0.00027778;
                        d = sec*0.000011574;
                        yr = sec*0.00000003175;
                        NSLog(@"gr:%f",sec);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        min = [self.text3.text doubleValue]*1;
                        sec = min*60;
                        hr = min*0.016667;
                        d = min*0.00069444;
                        yr = min*0.000001903;
                        NSLog(@"gr:%f",min);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        hr = [self.text3.text doubleValue]*1;
                        sec = hr*3600;
                        min = hr*60;
                        d = hr*0.041667;
                        yr = hr*0.0001142;
                        NSLog(@"gr:%f",hr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        d = [self.text3.text doubleValue]*1;
                        sec = d*86400;
                        min = d*1440;
                        hr = d*24;
                        yr = d*0.00274;
                        NSLog(@"gr:%f",d);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        yr = [self.text3.text doubleValue]*1;
                        sec = yr*31536000;
                        min = yr*525600;
                        hr = yr*8760;
                        yr = yr*365;
                        NSLog(@"gr:%f",yr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }else if (textField == _text4) {
                //時間 欄位四 rowTow 換算
                 textBool4 = true;
                textBool3=false;
                textBool2=false;
                textBool1 = false;
                textBool5 = false;
                NSLog(@"text4 被選中,值：%@",self.text4.text);
                switch(rowFour) {
                    case 0:
                        sec = [self.text4.text doubleValue]*1;
                        min = sec*0.016667;
                        hr = sec*0.00027778;
                        d = sec*0.000011574;
                        yr = sec*0.00000003175;
                        NSLog(@"gr:%f",sec);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        min = [self.text4.text doubleValue]*1;
                        sec = min*60;
                        hr = min*0.016667;
                        d = min*0.00069444;
                        yr = min*0.000001903;
                        NSLog(@"gr:%f",min);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        hr = [self.text4.text doubleValue]*1;
                        sec = hr*3600;
                        min = hr*60;
                        d = hr*0.041667;
                        yr = hr*0.0001142;
                        NSLog(@"gr:%f",hr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        d = [self.text4.text doubleValue]*1;
                        sec = d*86400;
                        min = d*1440;
                        hr = d*24;
                        yr = d*0.00274;
                        NSLog(@"gr:%f",d);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        yr = [self.text4.text doubleValue]*1;
                        sec = yr*31536000;
                        min = yr*525600;
                        hr = yr*8760;
                        yr = yr*365;
                        NSLog(@"gr:%f",yr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
                
                
            }else {
                textBool5 = true;
                textBool4=false;
                textBool3=false;
                textBool2 = false;
                textBool1 = false;
                NSLog(@"text5 被選中,值：%@",self.text5.text);
                switch(rowFive) {
                    case 0:
                        sec = [self.text5.text doubleValue]*1;
                        min = sec*0.016667;
                        hr = sec*0.00027778;
                        d = sec*0.000011574;
                        yr = sec*0.00000003175;
                        NSLog(@"gr:%f",sec);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        min = [self.text5.text doubleValue]*1;
                        sec = min*60;
                        hr = min*0.016667;
                        d = min*0.00069444;
                        yr = min*0.000001903;
                        NSLog(@"gr:%f",min);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        hr = [self.text5.text doubleValue]*1;
                        sec = hr*3600;
                        min = hr*60;
                        d = hr*0.041667;
                        yr = hr*0.0001142;
                        NSLog(@"gr:%f",hr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        d = [self.text5.text doubleValue]*1;
                        sec = d*86400;
                        min = d*1440;
                        hr = d*24;
                        yr = d*0.00274;
                        NSLog(@"gr:%f",d);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        yr = [self.text5.text doubleValue]*1;
                        sec = yr*31536000;
                        min = yr*525600;
                        hr = yr*8760;
                        yr = yr*365;
                        NSLog(@"gr:%f",yr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
        
    }else if([unitName containsString:@"溫度"] ){
          NSLog(@"now1%@",_pickerData[4]);
            if (textField == _text1) {
                 textBool1 = true;
                textBool2 = false;
                textBool3 = false;
                textBool4 = false;
                textBool5 = false;
                switch(rowOne) {
                    case 0:
                        cv = [self.text1.text doubleValue]*1;
                        fv= (cv*1.8)+32;
                 
                        NSLog(@"gr:%f",cv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                default:
                        fv = [self.text1.text doubleValue]*1;
                        cv= (fv-32)/1.8;
                        
                        NSLog(@"gr:%f",fv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
                
            }else if (textField == _text2) {
                //溫度 欄位二 rowTow 換算
                 textBool2 = true;
                textBool1 = false;
                textBool3 = false;
                textBool4 = false;
                textBool5 = false;
                NSLog(@"text2 被選中,值：%@",self.text2.text);
                switch(rowTow) {
                    case 0:
                        cv = [self.text2.text doubleValue]*1;
                        fv= (cv*1.8)+32;
                        
                        NSLog(@"cv:%f",cv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        fv = [self.text2.text doubleValue]*1;
                        cv= (fv-32)/1.8;
                        
                        NSLog(@"fv:%f",fv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
                
            }else if (textField == _text3) {
                //溫度 欄位三 rowTow 換算
                 textBool3 = true;
                textBool2=false;
                textBool1 = false;
                textBool4 = false;
                textBool5 = false;
                NSLog(@"text3 被選中,值：%@",self.text3.text);
                switch(rowThree) {
                    case 0:
                        cv = [self.text3.text doubleValue]*1;
                        fv= (cv*1.8)+32;
                        
                        NSLog(@"gr:%f",cv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        fv = [self.text3.text doubleValue]*1;
                        cv= (fv-32)/1.8;
                        
                        NSLog(@"gr:%f",fv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
                
                
            }else if (textField == _text4) {
                //溫度 欄位四 rowTow 換算
                 textBool4 = true;
                textBool3=false;
                textBool2=false;
                textBool1 = false;
                textBool5 = false;

                NSLog(@"text4 被選中,值：%@",self.text4.text);
                switch(rowFour) {
                    case 0:
                        cv = [self.text4.text doubleValue]*1;
                        fv= (cv*1.8)+32;
                        
                        NSLog(@"gr:%f",cv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        fv = [self.text4.text doubleValue]*1;
                        cv= (fv-32)/1.8;
                        
                        NSLog(@"gr:%f",fv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
                
                
            }else {
                textBool5 = true;
                textBool4=false;
                textBool3=false;
                textBool2 = false;
                textBool1 = false;
                NSLog(@"text5 被選中,值：%@",self.text5.text);
                switch(rowFive) {
                    case 0:
                        cv = [self.text5.text doubleValue]*1;
                        fv= (cv*1.8)+32;
                        
                        NSLog(@"gr:%f",cv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        fv = [self.text5.text doubleValue]*1;
                        cv= (fv-32)/1.8;
                        
                        NSLog(@"gr:%f",fv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            
    }else{
        NSLog(@"現在為：%@",_pickerData[0]);  //***************長度的換算********************
        if (textField == _text1) {
            textBool1 = true;
            textBool2 = false;
            textBool3 = false;
            textBool4 = false;
            textBool5 = false;
            switch(rowOne) {
                case 0:
                    cm = [self.text1.text doubleValue]*1;
                    m = cm*0.01;
                    km = cm*0.00001;
                    inv = cm*0.3937;
                    ft = cm*0.0328;
                    mm = cm*0.033;
                    NSLog(@"目前輸入值為:%f",cm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    NSLog(@"長度unitValue%@",unitValue);
                  
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"目前unitVale值: %@",unitValue);
                    break;
                case 1:
                    m = [self.text1.text doubleValue]*1;
                    cm = m*100;
                    km = m*0.001;
                    inv = m*39.371;
                    ft = m*3.2809;
                    mm = m*3.3;
                    NSLog(@"gr:%f",m);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    km = [self.text1.text doubleValue]*1;
                    cm = km*100000;
                    m = km*1000;
                    inv = km*39371;
                    ft = km*3280.9;
                    mm = km*3300;
                    NSLog(@"gr:%f",km);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    inv = [self.text1.text doubleValue]*1;
                    cm = inv*2.54;
                    m = inv*0.02540;
                    km = inv*0.0000254;
                    ft = inv*0.08333;
                    mm = inv*0.08382;
                    NSLog(@"gr:%f",inv);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 4:
                    ft = [self.text1.text doubleValue]*1;
                    cm = ft*30.48;
                    m = ft*0.3048;
                    km = ft*0.0003048;
                    inv = ft*12;
                    mm = ft*1.0058;
                    NSLog(@"gr:%f",ft);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;

                default:
                    mm = [self.text1.text doubleValue]*1;
                    cm = mm*30.30;
                    m = mm*0.30303;
                    km = mm*0.0003030;
                    inv = mm*11.9303;
                    ft = mm*0.9942;
                    NSLog(@"gr:%f",mm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
            
        }else if (textField == _text2) { //長度 欄位二 rowTow 換算
            textBool2=true;
            textBool1 = false;
            textBool3 = false;
            textBool4 = false;
            textBool5 = false;
            NSLog(@"text2 被選中,值：%@",self.text2.text);
            switch(rowTow) {
                case 0:
                    cm = [self.text2.text doubleValue]*1;
                    m = cm*0.01;
                    km = cm*0.00001;
                    inv = cm*0.3937;
                    ft = cm*0.0328;
                    mm = cm*0.033;
                    NSLog(@"gr:%f",cm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    m = [self.text2.text doubleValue]*1;
                    cm = m*100;
                    km = m*0.001;
                    inv = m*39.371;
                    ft = m*3.2809;
                    mm = m*3.3;
                    NSLog(@"gr:%f",m);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    km = [self.text2.text doubleValue]*1;
                    cm = km*100000;
                    m = km*1000;
                    inv = km*39371;
                    ft = km*3280.9;
                    mm = km*3300;
                    NSLog(@"gr:%f",km);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    inv = [self.text2.text doubleValue]*1;
                    cm = inv*2.54;
                    m = inv*0.02540;
                    km = inv*0.0000254;
                    ft = inv*0.08333;
                    mm = inv*0.08382;
                    NSLog(@"gr:%f",inv);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 4:
                    ft = [self.text2.text doubleValue]*1;
                    cm = ft*30.48;
                    m = ft*0.3048;
                    km = ft*0.0003048;
                    inv = ft*12;
                    mm = ft*1.0058;
                    NSLog(@"gr:%f",ft);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                    
                default:
                    mm = [self.text2.text doubleValue]*1;
                    cm = mm*30.30;
                    m = mm*0.30303;
                    km = mm*0.0003030;
                    inv = mm*11.9303;
                    ft = mm*0.9942;
                    NSLog(@"gr:%f",mm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
            
        }else if (textField == _text3) {//長度 欄位二 rowTow 換算
            textBool3=true;
            textBool2=false;
            textBool1 = false;
            textBool4 = false;
            textBool5 = false;
            NSLog(@"text3 被選中,值：%@",self.text3.text);
            switch(rowThree) {
                case 0:
                    cm = [self.text3.text doubleValue]*1;
                    m = cm*0.01;
                    km = cm*0.00001;
                    inv = cm*0.3937;
                    ft = cm*0.0328;
                    mm = cm*0.033;
                    NSLog(@"gr:%f",cm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    m = [self.text3.text doubleValue]*1;
                    cm = m*100;
                    km = m*0.001;
                    inv = m*39.371;
                    ft = m*3.2809;
                    mm = m*3.3;
                    NSLog(@"gr:%f",m);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    km = [self.text3.text doubleValue]*1;
                    cm = km*100000;
                    m = km*1000;
                    inv = km*39371;
                    ft = km*3280.9;
                    mm = km*3300;
                    NSLog(@"gr:%f",km);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    inv = [self.text3.text doubleValue]*1;
                    cm = inv*2.54;
                    m = inv*0.02540;
                    km = inv*0.0000254;
                    ft = inv*0.08333;
                    mm = inv*0.08382;
                    NSLog(@"gr:%f",inv);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 4:
                    ft = [self.text3.text doubleValue]*1;
                    cm = ft*30.48;
                    m = ft*0.3048;
                    km = ft*0.0003048;
                    inv = ft*12;
                    mm = ft*1.0058;
                    NSLog(@"gr:%f",ft);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                    
                default:
                    mm = [self.text3.text doubleValue]*1;
                    cm = mm*30.30;
                    m = mm*0.30303;
                    km = mm*0.0003030;
                    inv = mm*11.9303;
                    ft = mm*0.9942;
                    NSLog(@"gr:%f",mm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
            
            
        }else if (textField == _text4) {                        //長度 欄位二 rowTow 換算
            textBool4=true;
            textBool3=false;
            textBool2=false;
            textBool1 = false;
            textBool5 = false;
            NSLog(@"text4 被選中,值：%@",self.text4.text);
            switch(rowFour) {
                case 0:
                    cm = [self.text4.text doubleValue]*1;
                    m = cm*0.01;
                    km = cm*0.00001;
                    inv = cm*0.3937;
                    ft = cm*0.0328;
                    mm = cm*0.033;
                    NSLog(@"gr:%f",cm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    m = [self.text4.text doubleValue]*1;
                    cm = m*100;
                    km = m*0.001;
                    inv = m*39.371;
                    ft = m*3.2809;
                    mm = m*3.3;
                    NSLog(@"gr:%f",m);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    km = [self.text4.text doubleValue]*1;
                    cm = km*100000;
                    m = km*1000;
                    inv = km*39371;
                    ft = km*3280.9;
                    mm = km*3300;
                    NSLog(@"gr:%f",km);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    inv = [self.text4.text doubleValue]*1;
                    cm = inv*2.54;
                    m = inv*0.02540;
                    km = inv*0.0000254;
                    ft = inv*0.08333;
                    mm = inv*0.08382;
                    NSLog(@"gr:%f",inv);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 4:
                    ft = [self.text4.text doubleValue]*1;
                    cm = ft*30.48;
                    m = ft*0.3048;
                    km = ft*0.0003048;
                    inv = ft*12;
                    mm = ft*1.0058;
                    NSLog(@"gr:%f",ft);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                    
                default:
                    mm = [self.text4.text doubleValue]*1;
                    cm = mm*30.30;
                    m = mm*0.30303;
                    km = mm*0.0003030;
                    inv = mm*11.9303;
                    ft = mm*0.9942;
                    NSLog(@"gr:%f",mm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
        }else {
            textBool5=true;
            textBool4=false;
            textBool3=false;
            textBool2=false;
            textBool1 = false;
            NSLog(@"text5 被選中,值：%@",self.text5.text);
            switch(rowFive) {
                case 0:
                    cm = [self.text5.text doubleValue]*1;
                    m = cm*0.01;
                    km = cm*0.00001;
                    inv = cm*0.3937;
                    ft = cm*0.0328;
                    mm = cm*0.033;
                    NSLog(@"gr:%f",cm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    m = [self.text5.text doubleValue]*1;
                    cm = m*100;
                    km = m*0.001;
                    inv = m*39.371;
                    ft = m*3.2809;
                    mm = m*3.3;
                    NSLog(@"gr:%f",m);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    km = [self.text5.text doubleValue]*1;
                    cm = km*100000;
                    m = km*1000;
                    inv = km*39371;
                    ft = km*3280.9;
                    mm = km*3300;
                    NSLog(@"gr:%f",km);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    inv = [self.text5.text doubleValue]*1;
                    cm = inv*2.54;
                    m = inv*0.02540;
                    km = inv*0.0000254;
                    ft = inv*0.08333;
                    mm = inv*0.08382;
                    NSLog(@"gr:%f",inv);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 4:
                    ft = [self.text5.text doubleValue]*1;
                    cm = ft*30.48;
                    m = ft*0.3048;
                    km = ft*0.0003048;
                    inv = ft*12;
                    mm = ft*1.0058;
                    NSLog(@"gr:%f",ft);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                    
                default:
                    mm = [self.text5.text doubleValue]*1;
                    cm = mm*30.30;
                    m = mm*0.30303;
                    km = mm*0.0003030;
                    inv = mm*11.9303;
                    ft = mm*0.9942;
                    NSLog(@"gr:%f",mm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
        }
    }

   // NSLog(@"%@",self.text1.text);
    return YES;
}
// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 6;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return _pickerData.count;
    } else {
        NSInteger rowProvince = [_picker selectedRowInComponent:0];
        NSString *provinceName = _pickerData[rowProvince];
        NSArray *uints = _pickSelect[provinceName];
        return uints.count;
    }
}


// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        //NSLog(@"pickerData[row]: %@",_pickerData[row]);
        return _pickerData[row];
    } else {
        NSInteger rowProvince = [_picker selectedRowInComponent:0];
        NSString *provinceName = _pickerData[rowProvince];
        NSArray *units = _pickSelect[provinceName];
        return  units[row];
    }
}
//設置picker veiw 字型內容
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;

    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumFontSize = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:UITextAlignmentRight];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:20]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_picker reloadComponent:1];
    [_picker reloadComponent:2];
    [_picker reloadComponent:3];
    [_picker reloadComponent:4];
    [_picker reloadComponent:5];
    
    unitRow= [_picker selectedRowInComponent:0];
    rowOne = [_picker selectedRowInComponent:1];
    rowTow = [_picker selectedRowInComponent:2];
    rowThree = [_picker selectedRowInComponent:3];
    rowFour = [_picker selectedRowInComponent:4];
    rowFive = [_picker selectedRowInComponent:5];
    
    NSString *unitName1 = _pickerData[unitRow];
    NSArray *units1 = _pickSelect[unitName1];
    NSLog(@"units1:%@",units1);

    //label欄位值改變
    self.cell1.text = units1[rowOne];
    self.cell2.text =  units1[rowTow];
    self.cell3.text =  units1[rowThree];
    self.cell4.text =  units1[rowFour];
    self.cell5.text =  units1[rowFive];
    
    unitName =  _pickerData[unitRow]; //將欄位名稱陣列位置放到區域變數上好讓欄位值受到改變
    
    unitValue = [[NSMutableArray alloc]init];
    NSLog(@"textFieldDidChange unitValue%@",unitValue);
    
    double gr = 0,dyne = 0,kg = 0,lb = 0,poundal = 0;
    double cm=0,m=0,km=0,inv=0,ft=0,mm=0 ;
    double msec=0,mhr=0,kmhr=0,ftsec=0,ftmin=0,milehr=0;
    double sec=0,min=0,hr=0,d=0,yr=0;
    double cv=0,fv=0;
    NSNumber *unitvs1 = [[NSNumber alloc]init];
    NSNumber *unitvs2 = [[NSNumber alloc]init];
    NSNumber *unitvs3 = [[NSNumber alloc]init];
    NSNumber *unitvs4 = [[NSNumber alloc]init];
    NSNumber *unitvs5 = [[NSNumber alloc]init];
    NSNumber *unitvs6 = [[NSNumber alloc]init];

    
     NSLog(@"目前pick unitVale值: %@",unitValue);
    if ([unitName containsString:@"重力"] ) {
            NSLog(@"now1%@",_pickerData[1]);
            if (textBool1) {
                switch(rowOne) {
                    case 0:
                        gr = [self.text1.text doubleValue]*1;
                        dyne = gr*980.6;
                        kg = gr*0.001;
                        lb = gr*0.002205;
                        poundal = gr*0.07092;
                        NSLog(@"gr:%f",gr);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        dyne = [self.text1.text doubleValue]*1;
                        gr = dyne*0.00102;
                        kg = dyne*0.00000102;
                        lb = dyne*0.000002248;
                        poundal = dyne*0.00007233;
                        NSLog(@"gr:%f",dyne);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        kg = [self.text1.text doubleValue]*1;
                        dyne = kg*980600;
                        gr = kg*1000;
                        lb = kg*2.20462;
                        poundal = kg*70.9119;
                        NSLog(@"gr:%f",kg);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        lb = [self.text1.text doubleValue]*1;
                        dyne = lb*444.792;
                        kg = lb*0.45359;
                        gr = lb*453.59;
                        poundal = lb*32.17;
                        NSLog(@"gr:%f",lb);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        poundal = [self.text1.text doubleValue]*1;
                        dyne = poundal*13.825;
                        kg = poundal*0.014102;
                        lb = poundal*0.03109;
                        gr = poundal*14.102;
                        NSLog(@"gr:%f",poundal);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            if (textBool2) {
                switch(rowTow) {
                    case 0:
                        gr = [self.text2.text doubleValue]*1;
                        dyne = gr*980.6;
                        kg = gr*0.001;
                        lb = gr*0.002205;
                        poundal = gr*0.07092;
                        NSLog(@"gr:%f",gr);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        dyne = [self.text2.text doubleValue]*1;
                        gr = dyne*0.00102;
                        kg = dyne*0.00000102;
                        lb = dyne*0.000002248;
                        poundal = dyne*0.00007233;
                        NSLog(@"gr:%f",dyne);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        NSLog(@"unitVale: %@",unitValue);
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        break;
                    case 2:
                        kg = [self.text2.text doubleValue]*1;
                        dyne = kg*980600;
                        gr = kg*1000;
                        lb = kg*2.20462;
                        poundal = kg*70.9119;
                        NSLog(@"gr:%f",kg);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        lb = [self.text2.text doubleValue]*1;
                        dyne = lb*444.792;
                        kg = lb*0.45359;
                        gr = lb*453.59;
                        poundal = lb*32.17;
                        NSLog(@"gr:%f",lb);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        poundal = [self.text2.text doubleValue]*1;
                        dyne = poundal*13.825;
                        kg = poundal*0.014102;
                        lb = poundal*0.03109;
                        gr = poundal*14.102;
                        NSLog(@"gr:%f",poundal);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            if (textBool3) {
                //重量 欄位二 rowTow 換算
                switch(rowThree) {
                    case 0:
                        gr = [self.text3.text doubleValue]*1;
                        dyne = gr*980.6;
                        kg = gr*0.001;
                        lb = gr*0.002205;
                        poundal = gr*0.07092;
                        NSLog(@"gr:%f",gr);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        dyne = [self.text3.text doubleValue]*1;
                        gr = dyne*0.00102;
                        kg = dyne*0.00000102;
                        lb = dyne*0.000002248;
                        poundal = dyne*0.00007233;
                        NSLog(@"gr:%f",dyne);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        kg = [self.text3.text doubleValue]*1;
                        dyne = kg*980600;
                        gr = kg*1000;
                        lb = kg*2.20462;
                        poundal = kg*70.9119;
                        NSLog(@"gr:%f",kg);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        lb = [self.text3.text doubleValue]*1;
                        dyne = lb*444.792;
                        kg = lb*0.45359;
                        gr = lb*453.59;
                        poundal = lb*32.17;
                        NSLog(@"gr:%f",lb);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        poundal = [self.text3.text doubleValue]*1;
                        dyne = poundal*13.825;
                        kg = poundal*0.014102;
                        lb = poundal*0.03109;
                        gr = poundal*14.102;
                        NSLog(@"gr:%f",poundal);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            if (textBool4) {
                switch(rowFour) {
                    case 0:
                        gr = [self.text4.text doubleValue]*1;
                        dyne = gr*980.6;
                        kg = gr*0.001;
                        lb = gr*0.002205;
                        poundal = gr*0.07092;
                        NSLog(@"gr:%f",gr);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        dyne = [self.text4.text doubleValue]*1;
                        gr = dyne*0.00102;
                        kg = dyne*0.00000102;
                        lb = dyne*0.000002248;
                        poundal = dyne*0.00007233;
                        NSLog(@"gr:%f",dyne);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        kg = [self.text4.text doubleValue]*1;
                        dyne = kg*980600;
                        gr = kg*1000;
                        lb = kg*2.20462;
                        poundal = kg*70.9119;
                        NSLog(@"gr:%f",kg);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        lb = [self.text4.text doubleValue]*1;
                        dyne = lb*444.792;
                        kg = lb*0.45359;
                        gr = lb*453.59;
                        poundal = lb*32.17;
                        NSLog(@"gr:%f",lb);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        poundal = [self.text4.text doubleValue]*1;
                        dyne = poundal*13.825;
                        kg = poundal*0.014102;
                        lb = poundal*0.03109;
                        gr = poundal*14.102;
                        NSLog(@"gr:%f",poundal);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            if (textBool5) {
                switch(rowFive) {
                    case 0:
                        gr = [self.text5.text doubleValue]*1;
                        dyne = gr*980.6;
                        kg = gr*0.001;
                        lb = gr*0.002205;
                        poundal = gr*0.07092;
                        NSLog(@"gr:%f",gr);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        dyne = [self.text5.text doubleValue]*1;
                        gr = dyne*0.00102;
                        kg = dyne*0.00000102;
                        lb = dyne*0.000002248;
                        poundal = dyne*0.00007233;
                        NSLog(@"gr:%f",dyne);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",poundal];
                        }
                        
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        kg = [self.text5.text doubleValue]*1;
                        dyne = kg*980600;
                        gr = kg*1000;
                        lb = kg*2.20462;
                        poundal = kg*70.9119;
                        NSLog(@"gr:%f",kg);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        lb = [self.text5.text doubleValue]*1;
                        dyne = lb*444.792;
                        kg = lb*0.45359;
                        gr = lb*453.59;
                        poundal = lb*32.17;
                        NSLog(@"gr:%f",lb);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        poundal = [self.text5.text doubleValue]*1;
                        dyne = poundal*13.825;
                        kg = poundal*0.014102;
                        lb = poundal*0.03109;
                        gr = poundal*14.102;
                        NSLog(@"gr:%f",poundal);
                        unitvs1 = [NSNumber numberWithDouble:gr];
                        unitvs2 = [NSNumber numberWithDouble:dyne];
                        unitvs3 = [NSNumber numberWithDouble:kg];
                        unitvs4 = [NSNumber numberWithDouble:lb];
                        unitvs5 = [NSNumber numberWithDouble:poundal];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後自動給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            
        }else if([unitName containsString:@"速度"] ){
            NSLog(@"now1%@",_pickerData[2]);
            if (textBool1) {
                switch(rowOne) {
                    case 0:
                        msec = [self.text1.text doubleValue]*1;
                        mhr = msec*3600;
                        kmhr = msec*3.6;
                        ftsec = msec*3.281;
                        ftmin = msec*196.85;
                        milehr = msec*2.2370;
                        NSLog(@"gr:%f",msec);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        mhr = [self.text1.text doubleValue]*1;
                        msec = mhr*0.0002778;
                        kmhr = mhr*0.001;
                        ftsec = mhr*0.0009114;
                        ftmin = mhr*0.05468;
                        milehr = mhr*0.000621;
                        NSLog(@"gr:%f",mhr);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        kmhr = [self.text1.text doubleValue]*1;
                        msec = kmhr*0.2778;
                        mhr = kmhr*1000;
                        ftsec = kmhr*0.9114;
                        ftmin = kmhr*54.682;
                        milehr = kmhr*0.6214;
                        NSLog(@"gr:%f",kmhr);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        ftsec = [self.text1.text doubleValue]*1;
                        msec = ftsec*0.3048;
                        mhr = ftsec*1097.25;
                        kmhr = ftsec*1.0973;
                        ftmin = ftsec*60;
                        milehr = ftsec*0.68182;
                        NSLog(@"gr:%f",ftsec);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 4:
                        ftmin = [self.text1.text doubleValue]*1;
                        msec = ftmin*0.005080;
                        mhr = ftmin*18.287;
                        kmhr = ftmin*0.01829;
                        ftsec = ftmin*0.01667;
                        milehr = ftmin*0.01136;
                        NSLog(@"gr:%f",ftmin);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                        
                    default:
                        milehr = [self.text1.text doubleValue]*1;
                        msec = milehr*0.4470;
                        mhr = milehr*1609.3;
                        kmhr = milehr*1.6093;
                        ftsec = milehr*1.4667;
                        ftmin = milehr*88;
                        NSLog(@"gr:%f",milehr);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            if (textBool2) {
                NSLog(@"text2 被選中,值：%@",self.text2.text);
                switch(rowTow) {
                    case 0:
                        msec = [self.text2.text doubleValue]*1;
                        mhr = msec*3600;
                        kmhr = msec*3.6;
                        ftsec = msec*3.281;
                        ftmin = msec*196.85;
                        milehr = msec*2.2370;
                        NSLog(@"gr:%f",msec);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        mhr = [self.text2.text doubleValue]*1;
                        msec = mhr*0.0002778;
                        kmhr = mhr*0.001;
                        ftsec = mhr*0.0009114;
                        ftmin = mhr*0.05468;
                        milehr = mhr*0.000621;
                        NSLog(@"gr:%f",mhr);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        kmhr = [self.text2.text doubleValue]*1;
                        msec = kmhr*0.2778;
                        mhr = kmhr*1000;
                        ftsec = kmhr*0.9114;
                        ftmin = kmhr*54.682;
                        milehr = kmhr*0.6214;
                        NSLog(@"gr:%f",kmhr);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        ftsec = [self.text2.text doubleValue]*1;
                        msec = ftsec*0.3048;
                        mhr = ftsec*1097.25;
                        kmhr = ftsec*1.0973;
                        ftmin = ftsec*60;
                        milehr = ftsec*0.68182;
                        NSLog(@"gr:%f",ftsec);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 4:
                        ftmin = [self.text2.text doubleValue]*1;
                        msec = ftmin*0.005080;
                        mhr = ftmin*18.287;
                        kmhr = ftmin*0.01829;
                        ftsec = ftmin*0.01667;
                        milehr = ftmin*0.01136;
                        NSLog(@"gr:%f",ftmin);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                        
                    default:
                        milehr = [self.text2.text doubleValue]*1;
                        msec = milehr*0.4470;
                        mhr = milehr*1609.3;
                        kmhr = milehr*1.6093;
                        ftsec = milehr*1.4667;
                        ftmin = milehr*88;
                        NSLog(@"gr:%f",milehr);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            
            if (textBool3) {
                NSLog(@"text3 被選中,值：%@",self.text3.text);
                switch(rowThree) {
                    case 0:
                        msec = [self.text3.text doubleValue]*1;
                        mhr = msec*3600;
                        kmhr = msec*3.6;
                        ftsec = msec*3.281;
                        ftmin = msec*196.85;
                        milehr = msec*2.2370;
                        NSLog(@"gr:%f",msec);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        mhr = [self.text3.text doubleValue]*1;
                        msec = mhr*0.0002778;
                        kmhr = mhr*0.001;
                        ftsec = mhr*0.0009114;
                        ftmin = mhr*0.05468;
                        milehr = mhr*0.000621;
                        NSLog(@"gr:%f",mhr);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        kmhr = [self.text3.text doubleValue]*1;
                        msec = kmhr*0.2778;
                        mhr = kmhr*1000;
                        ftsec = kmhr*0.9114;
                        ftmin = kmhr*54.682;
                        milehr = kmhr*0.6214;
                        NSLog(@"gr:%f",kmhr);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        ftsec = [self.text3.text doubleValue]*1;
                        msec = ftsec*0.3048;
                        mhr = ftsec*1097.25;
                        kmhr = ftsec*1.0973;
                        ftmin = ftsec*60;
                        milehr = ftsec*0.68182;
                        NSLog(@"gr:%f",ftsec);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 4:
                        ftmin = [self.text3.text doubleValue]*1;
                        msec = ftmin*0.005080;
                        mhr = ftmin*18.287;
                        kmhr = ftmin*0.01829;
                        ftsec = ftmin*0.01667;
                        milehr = ftmin*0.01136;
                        NSLog(@"gr:%f",ftmin);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                        
                    default:
                        milehr = [self.text3.text doubleValue]*1;
                        msec = milehr*0.4470;
                        mhr = milehr*1609.3;
                        kmhr = milehr*1.6093;
                        ftsec = milehr*1.4667;
                        ftmin = milehr*88;
                        NSLog(@"gr:%f",milehr);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            
            if (textBool4) {
                NSLog(@"text4 被選中,值：%@",self.text4.text);
                switch(rowFour) {
                    case 0:
                        msec = [self.text4.text doubleValue]*1;
                        mhr = msec*3600;
                        kmhr = msec*3.6;
                        ftsec = msec*3.281;
                        ftmin = msec*196.85;
                        milehr = msec*2.2370;
                        NSLog(@"gr:%f",msec);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        mhr = [self.text4.text doubleValue]*1;
                        msec = mhr*0.0002778;
                        kmhr = mhr*0.001;
                        ftsec = mhr*0.0009114;
                        ftmin = mhr*0.05468;
                        milehr = mhr*0.000621;
                        NSLog(@"gr:%f",mhr);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        kmhr = [self.text4.text doubleValue]*1;
                        msec = kmhr*0.2778;
                        mhr = kmhr*1000;
                        ftsec = kmhr*0.9114;
                        ftmin = kmhr*54.682;
                        milehr = kmhr*0.6214;
                        NSLog(@"gr:%f",kmhr);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        ftsec = [self.text4.text doubleValue]*1;
                        msec = ftsec*0.3048;
                        mhr = ftsec*1097.25;
                        kmhr = ftsec*1.0973;
                        ftmin = ftsec*60;
                        milehr = ftsec*0.68182;
                        NSLog(@"gr:%f",ftsec);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 4:
                        ftmin = [self.text4.text doubleValue]*1;
                        msec = ftmin*0.005080;
                        mhr = ftmin*18.287;
                        kmhr = ftmin*0.01829;
                        ftsec = ftmin*0.01667;
                        milehr = ftmin*0.01136;
                        NSLog(@"gr:%f",ftmin);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                        
                    default:
                        milehr = [self.text4.text doubleValue]*1;
                        msec = milehr*0.4470;
                        mhr = milehr*1609.3;
                        kmhr = milehr*1.6093;
                        ftsec = milehr*1.4667;
                        ftmin = milehr*88;
                        NSLog(@"gr:%f",milehr);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFive ==4){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            if (textBool5) {
                NSLog(@"text5 被選中,值：%@",self.text5.text);
                switch(rowFive) {
                    case 0:
                        msec = [self.text5.text doubleValue]*1;
                        mhr = msec*3600;
                        kmhr = msec*3.6;
                        ftsec = msec*3.281;
                        ftmin = msec*196.85;
                        milehr = msec*2.2370;
                        NSLog(@"gr:%f",msec);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        mhr = [self.text5.text doubleValue]*1;
                        msec = mhr*0.0002778;
                        kmhr = mhr*0.001;
                        ftsec = mhr*0.0009114;
                        ftmin = mhr*0.05468;
                        milehr = mhr*0.000621;
                        NSLog(@"gr:%f",mhr);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        kmhr = [self.text5.text doubleValue]*1;
                        msec = kmhr*0.2778;
                        mhr = kmhr*1000;
                        ftsec = kmhr*0.9114;
                        ftmin = kmhr*54.682;
                        milehr = kmhr*0.6214;
                        NSLog(@"gr:%f",kmhr);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        ftsec = [self.text5.text doubleValue]*1;
                        msec = ftsec*0.3048;
                        mhr = ftsec*1097.25;
                        kmhr = ftsec*1.0973;
                        ftmin = ftsec*60;
                        milehr = ftsec*0.68182;
                        NSLog(@"gr:%f",ftsec);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 4:
                        ftmin = [self.text5.text doubleValue]*1;
                        msec = ftmin*0.005080;
                        mhr = ftmin*18.287;
                        kmhr = ftmin*0.01829;
                        ftsec = ftmin*0.01667;
                        milehr = ftmin*0.01136;
                        NSLog(@"gr:%f",ftmin);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                        
                    default:
                        milehr = [self.text5.text doubleValue]*1;
                        msec = milehr*0.4470;
                        mhr = milehr*1609.3;
                        kmhr = milehr*1.6093;
                        ftsec = milehr*1.4667;
                        ftmin = milehr*88;
                        NSLog(@"gr:%f",milehr);
                        unitvs1 = [NSNumber numberWithDouble:msec];
                        unitvs2 = [NSNumber numberWithDouble:mhr];
                        unitvs3 = [NSNumber numberWithDouble:kmhr];
                        unitvs4 = [NSNumber numberWithDouble:ftsec];
                        unitvs5 = [NSNumber numberWithDouble:ftmin];
                        unitvs6 = [NSNumber numberWithDouble:milehr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        [unitValue addObject:unitvs6];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowOne ==4){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowTow ==4){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowThree ==4){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",msec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mhr];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kmhr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftsec];
                        }else if (rowFour ==4){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ftmin];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",milehr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
                
            }
        }else if([unitName containsString:@"時間"] ){
            NSLog(@"目前值為%@",_pickerData[3]);
            if (textBool1) {
                
                switch(rowOne) {
                    case 0:
                        sec = [self.text1.text doubleValue]*1;
                        min = sec*0.016667;
                        hr = sec*0.00027778;
                        d = sec*0.000011574;
                        yr = sec*0.00000003175;
                        NSLog(@"gr:%f",sec);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        min = [self.text1.text doubleValue]*1;
                        sec = min*60;
                        hr = min*0.016667;
                        d = min*0.00069444;
                        yr = min*0.000001903;
                        NSLog(@"gr:%f",min);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        hr = [self.text1.text doubleValue]*1;
                        sec = hr*3600;
                        min = hr*60;
                        d = hr*0.041667;
                        yr = hr*0.0001142;
                        NSLog(@"gr:%f",hr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        d = [self.text1.text doubleValue]*1;
                        sec = d*86400;
                        min = d*1440;
                        hr = d*24;
                        yr = d*0.00274;
                        NSLog(@"gr:%f",d);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        yr = [self.text1.text doubleValue]*1;
                        sec = yr*31536000;
                        min = yr*525600;
                        hr = yr*8760;
                        yr = yr*365;
                        NSLog(@"gr:%f",yr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            
            if (textBool2) {
                NSLog(@"text2 被選中,值：%@",self.text2.text);
                switch(rowTow) {
                    case 0:
                        sec = [self.text2.text doubleValue]*1;
                        min = sec*0.016667;
                        hr = sec*0.00027778;
                        d = sec*0.000011574;
                        yr = sec*0.00000003175;
                        NSLog(@"gr:%f",sec);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        min = [self.text2.text doubleValue]*1;
                        sec = min*60;
                        hr = min*0.016667;
                        d = min*0.00069444;
                        yr = min*0.000001903;
                        NSLog(@"gr:%f",min);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        hr = [self.text2.text doubleValue]*1;
                        sec = hr*3600;
                        min = hr*60;
                        d = hr*0.041667;
                        yr = hr*0.0001142;
                        NSLog(@"gr:%f",hr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        d = [self.text2.text doubleValue]*1;
                        sec = d*86400;
                        min = d*1440;
                        hr = d*24;
                        yr = d*0.00274;
                        NSLog(@"gr:%f",d);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        yr = [self.text2.text doubleValue]*1;
                        sec = yr*31536000;
                        min = yr*525600;
                        hr = yr*8760;
                        yr = yr*365;
                        NSLog(@"gr:%f",yr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            
            if (textBool3) {
                NSLog(@"text3 被選中,值：%@",self.text3.text);
                switch(rowThree) {
                    case 0:
                        sec = [self.text3.text doubleValue]*1;
                        min = sec*0.016667;
                        hr = sec*0.00027778;
                        d = sec*0.000011574;
                        yr = sec*0.00000003175;
                        NSLog(@"gr:%f",sec);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        min = [self.text3.text doubleValue]*1;
                        sec = min*60;
                        hr = min*0.016667;
                        d = min*0.00069444;
                        yr = min*0.000001903;
                        NSLog(@"gr:%f",min);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        hr = [self.text3.text doubleValue]*1;
                        sec = hr*3600;
                        min = hr*60;
                        d = hr*0.041667;
                        yr = hr*0.0001142;
                        NSLog(@"gr:%f",hr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        d = [self.text3.text doubleValue]*1;
                        sec = d*86400;
                        min = d*1440;
                        hr = d*24;
                        yr = d*0.00274;
                        NSLog(@"gr:%f",d);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        yr = [self.text3.text doubleValue]*1;
                        sec = yr*31536000;
                        min = yr*525600;
                        hr = yr*8760;
                        yr = yr*365;
                        NSLog(@"gr:%f",yr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            
            
            if (textBool4) {
                NSLog(@"text4 被選中,值：%@",self.text4.text);
                switch(rowFour) {
                    case 0:
                        sec = [self.text4.text doubleValue]*1;
                        min = sec*0.016667;
                        hr = sec*0.00027778;
                        d = sec*0.000011574;
                        yr = sec*0.00000003175;
                        NSLog(@"gr:%f",sec);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        min = [self.text4.text doubleValue]*1;
                        sec = min*60;
                        hr = min*0.016667;
                        d = min*0.00069444;
                        yr = min*0.000001903;
                        NSLog(@"gr:%f",min);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        hr = [self.text4.text doubleValue]*1;
                        sec = hr*3600;
                        min = hr*60;
                        d = hr*0.041667;
                        yr = hr*0.0001142;
                        NSLog(@"gr:%f",hr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        d = [self.text4.text doubleValue]*1;
                        sec = d*86400;
                        min = d*1440;
                        hr = d*24;
                        yr = d*0.00274;
                        NSLog(@"gr:%f",d);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        yr = [self.text4.text doubleValue]*1;
                        sec = yr*31536000;
                        min = yr*525600;
                        hr = yr*8760;
                        yr = yr*365;
                        NSLog(@"gr:%f",yr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",gr];
                        }else if (rowFive ==1){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",dyne];
                        }else if (rowFive ==2){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",kg];
                        }else if (rowFive ==3){
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",lb];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",poundal];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            if (textBool5) {
                NSLog(@"text5 被選中,值：%@",self.text5.text);
                switch(rowFive) {
                    case 0:
                        sec = [self.text5.text doubleValue]*1;
                        min = sec*0.016667;
                        hr = sec*0.00027778;
                        d = sec*0.000011574;
                        yr = sec*0.00000003175;
                        NSLog(@"gr:%f",sec);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 1:
                        min = [self.text5.text doubleValue]*1;
                        sec = min*60;
                        hr = min*0.016667;
                        d = min*0.00069444;
                        yr = min*0.000001903;
                        NSLog(@"gr:%f",min);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 2:
                        hr = [self.text5.text doubleValue]*1;
                        sec = hr*3600;
                        min = hr*60;
                        d = hr*0.041667;
                        yr = hr*0.0001142;
                        NSLog(@"gr:%f",hr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    case 3:
                        d = [self.text5.text doubleValue]*1;
                        sec = d*86400;
                        min = d*1440;
                        hr = d*24;
                        yr = d*0.00274;
                        NSLog(@"gr:%f",d);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        yr = [self.text5.text doubleValue]*1;
                        sec = yr*31536000;
                        min = yr*525600;
                        hr = yr*8760;
                        yr = yr*365;
                        NSLog(@"gr:%f",yr);
                        unitvs1 = [NSNumber numberWithDouble:sec];
                        unitvs2 = [NSNumber numberWithDouble:min];
                        unitvs3 = [NSNumber numberWithDouble:hr];
                        unitvs4 = [NSNumber numberWithDouble:d];
                        unitvs5 = [NSNumber numberWithDouble:yr];
                        
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        [unitValue addObject:unitvs3];
                        [unitValue addObject:unitvs4];
                        [unitValue addObject:unitvs5];
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowOne ==1){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowOne ==2){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowOne ==3){
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowTow ==1){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowTow ==2){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowTow ==3){
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowThree ==1){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowThree ==2){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowThree ==3){
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",sec];
                        }else if (rowFour ==1){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",min];
                        }else if (rowFour ==2){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",hr];
                        }else if (rowFour ==3){
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",d];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",yr];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            
        }else if([unitName containsString:@"溫度"] ){
            NSLog(@"now1%@",_pickerData[4]);
            if(textBool1){
                switch(rowOne) {
                    case 0:
                        cv = [self.text1.text doubleValue]*1;
                        fv= (cv*1.8)+32;
                        
                        NSLog(@"gr:%f",cv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        fv = [self.text1.text doubleValue]*1;
                        cv= (fv-32)/1.8;
                        
                        NSLog(@"gr:%f",fv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            //長度 欄位二 rowTow 換算
            if(textBool2){
                NSLog(@"text2 被選中,值：%@",self.text2.text);
                switch(rowTow) {
                    case 0:
                        cv = [self.text2.text doubleValue]*1;
                        fv= (cv*1.8)+32;
                        
                        NSLog(@"cv:%f",cv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        fv = [self.text2.text doubleValue]*1;
                        cv= (fv-32)/1.8;
                        
                        NSLog(@"fv:%f",fv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            //長度 欄位二 rowTow 換算
            if(textBool3){
                NSLog(@"text3 被選中,值：%@",self.text3.text);
                switch(rowThree) {
                    case 0:
                        cv = [self.text3.text doubleValue]*1;
                        fv= (cv*1.8)+32;
                        
                        NSLog(@"gr:%f",cv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        fv = [self.text3.text doubleValue]*1;
                        cv= (fv-32)/1.8;
                        
                        NSLog(@"gr:%f",fv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            //長度 欄位二 rowTow 換算
            if(textBool4){
                NSLog(@"text4 被選中,值：%@",self.text4.text);
                switch(rowFour) {
                    case 0:
                        cv = [self.text4.text doubleValue]*1;
                        fv= (cv*1.8)+32;
                        
                        NSLog(@"gr:%f",cv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        fv = [self.text4.text doubleValue]*1;
                        cv= (fv-32)/1.8;
                        
                        NSLog(@"gr:%f",fv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowFive == 0) {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            if(textBool5){
                NSLog(@"text5 被選中,值：%@",self.text5.text);
                switch(rowFive) {
                    case 0:
                        cv = [self.text5.text doubleValue]*1;
                        fv= (cv*1.8)+32;
                        
                        NSLog(@"gr:%f",cv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                    default:
                        fv = [self.text5.text doubleValue]*1;
                        cv= (fv-32)/1.8;
                        
                        NSLog(@"gr:%f",fv);
                        unitvs1 = [NSNumber numberWithDouble:fv];
                        unitvs2 = [NSNumber numberWithDouble:cv];
                        [unitValue addObject:unitvs1];
                        [unitValue addObject:unitvs2];
                        
                        //判斷rowTow～rowFive為哪個單位後給予欄位值
                        if (rowOne == 0) {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowTow == 0) {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowThree == 0) {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        
                        if (rowFour == 0) {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cv];
                        }else {
                            self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",fv];
                        }
                        NSLog(@"unitVale: %@",unitValue);
                        break;
                }
            }
            
        }else{
        NSLog(@"now1%@",_pickerData[0]);  //***************長度的換算********************
        if(textBool1){
            switch(rowOne) {
                case 0:
                    cm = [self.text1.text doubleValue]*1;
                    m = cm*0.01;
                    km = cm*0.00001;
                    inv = cm*0.3937;
                    ft = cm*0.0328;
                    mm = cm*0.033;
                    NSLog(@"gr:%f",cm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
        
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                        
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }                    NSLog(@"unitVale: %@",unitValue);
                    break;
                    
                case 1:
                    m = [self.text1.text doubleValue]*1;
                    cm = m*100;
                    km = m*0.001;
                    inv = m*39.371;
                    ft = m*3.2809;
                    mm = m*3.3;
                    NSLog(@"gr:%f",m);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                        
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }                    NSLog(@"unitVale: %@",unitValue);
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    km = [self.text1.text doubleValue]*1;
                    cm = km*100000;
                    m = km*1000;
                    inv = km*39371;
                    ft = km*3280.9;
                    mm = km*3300;
                    NSLog(@"gr:%f",km);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                        
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }                    NSLog(@"unitVale: %@",unitValue);
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    inv = [self.text1.text doubleValue]*1;
                    cm = inv*2.54;
                    m = inv*0.02540;
                    km = inv*0.0000254;
                    ft = inv*0.08333;
                    mm = inv*0.08382;
                    NSLog(@"gr:%f",inv);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                        
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }                    NSLog(@"unitVale: %@",unitValue);
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 4:
                    ft = [self.text1.text doubleValue]*1;
                    cm = ft*30.48;
                    m = ft*0.3048;
                    km = ft*0.0003048;
                    inv = ft*12;
                    mm = ft*1.0058;
                    NSLog(@"gr:%f",ft);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                        
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }                    NSLog(@"unitVale: %@",unitValue);
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                    
                default:
                    mm = [self.text1.text doubleValue]*1;
                    cm = mm*30.30;
                    m = mm*0.30303;
                    km = mm*0.0003030;
                    inv = mm*11.9303;
                    ft = mm*0.9942;
                    NSLog(@"gr:%f",mm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                        
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                        NSLog(@"**text2:%@",self.text2.text);
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                        
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                        
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                        
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                        
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }                    NSLog(@"unitVale: %@",unitValue);
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
      }
                                     //長度 欄位二 rowTow 換算
   if(textBool2){
       NSLog(@"textbool2:true");
            switch(rowTow) {
                case 0:
                    cm = [self.text2.text doubleValue]*1;
                    m = cm*0.01;
                    km = cm*0.00001;
                    inv = cm*0.3937;
                    ft = cm*0.0328;
                    mm = cm*0.033;
                    NSLog(@"gr:%f",cm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    m = [self.text2.text doubleValue]*1;
                    cm = m*100;
                    km = m*0.001;
                    inv = m*39.371;
                    ft = m*3.2809;
                    mm = m*3.3;
                    NSLog(@"gr:%f",m);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    km = [self.text2.text doubleValue]*1;
                    cm = km*100000;
                    m = km*1000;
                    inv = km*39371;
                    ft = km*3280.9;
                    mm = km*3300;
                    NSLog(@"gr:%f",km);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    inv = [self.text2.text doubleValue]*1;
                    cm = inv*2.54;
                    m = inv*0.02540;
                    km = inv*0.0000254;
                    ft = inv*0.08333;
                    mm = inv*0.08382;
                    NSLog(@"gr:%f",inv);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 4:
                    ft = [self.text2.text doubleValue]*1;
                    cm = ft*30.48;
                    m = ft*0.3048;
                    km = ft*0.0003048;
                    inv = ft*12;
                    mm = ft*1.0058;
                    NSLog(@"gr:%f",ft);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                    
                default:
                    mm = [self.text2.text doubleValue]*1;
                    cm = mm*30.30;
                    m = mm*0.30303;
                    km = mm*0.0003030;
                    inv = mm*11.9303;
                    ft = mm*0.9942;
                    NSLog(@"gr:%f",mm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
       
       
   }
                                     //長度 欄位二 rowTow 換算
    if(textBool3){
            switch(rowThree) {
                case 0:
                    cm = [self.text3.text doubleValue]*1;
                    m = cm*0.01;
                    km = cm*0.00001;
                    inv = cm*0.3937;
                    ft = cm*0.0328;
                    mm = cm*0.033;
                    NSLog(@"gr:%f",cm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    m = [self.text3.text doubleValue]*1;
                    cm = m*100;
                    km = m*0.001;
                    inv = m*39.371;
                    ft = m*3.2809;
                    mm = m*3.3;
                    NSLog(@"gr:%f",m);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    km = [self.text3.text doubleValue]*1;
                    cm = km*100000;
                    m = km*1000;
                    inv = km*39371;
                    ft = km*3280.9;
                    mm = km*3300;
                    NSLog(@"gr:%f",km);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    inv = [self.text3.text doubleValue]*1;
                    cm = inv*2.54;
                    m = inv*0.02540;
                    km = inv*0.0000254;
                    ft = inv*0.08333;
                    mm = inv*0.08382;
                    NSLog(@"gr:%f",inv);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 4:
                    ft = [self.text3.text doubleValue]*1;
                    cm = ft*30.48;
                    m = ft*0.3048;
                    km = ft*0.0003048;
                    inv = ft*12;
                    mm = ft*1.0058;
                    NSLog(@"gr:%f",ft);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                    
                default:
                    mm = [self.text3.text doubleValue]*1;
                    cm = mm*30.30;
                    m = mm*0.30303;
                    km = mm*0.0003030;
                    inv = mm*11.9303;
                    ft = mm*0.9942;
                    NSLog(@"gr:%f",mm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
    }
            
                                //長度 欄位二 rowTow 換算
  if(textBool4){
            switch(rowFour) {
                case 0:
                    cm = [self.text4.text doubleValue]*1;
                    m = cm*0.01;
                    km = cm*0.00001;
                    inv = cm*0.3937;
                    ft = cm*0.0328;
                    mm = cm*0.033;
                    NSLog(@"gr:%f",cm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    m = [self.text4.text doubleValue]*1;
                    cm = m*100;
                    km = m*0.001;
                    inv = m*39.371;
                    ft = m*3.2809;
                    mm = m*3.3;
                    NSLog(@"gr:%f",m);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    km = [self.text4.text doubleValue]*1;
                    cm = km*100000;
                    m = km*1000;
                    inv = km*39371;
                    ft = km*3280.9;
                    mm = km*3300;
                    NSLog(@"gr:%f",km);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    inv = [self.text4.text doubleValue]*1;
                    cm = inv*2.54;
                    m = inv*0.02540;
                    km = inv*0.0000254;
                    ft = inv*0.08333;
                    mm = inv*0.08382;
                    NSLog(@"gr:%f",inv);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 4:
                    ft = [self.text4.text doubleValue]*1;
                    cm = ft*30.48;
                    m = ft*0.3048;
                    km = ft*0.0003048;
                    inv = ft*12;
                    mm = ft*1.0058;
                    NSLog(@"gr:%f",ft);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                    
                default:
                    mm = [self.text4.text doubleValue]*1;
                    cm = mm*30.30;
                    m = mm*0.30303;
                    km = mm*0.0003030;
                    inv = mm*11.9303;
                    ft = mm*0.9942;
                    NSLog(@"gr:%f",mm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFive == 0) {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFive ==1){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFive ==2){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFive ==3){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFive ==4){
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text5.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
          }
        if(textBool5){
            switch(rowFive) {
                case 0:
                    cm = [self.text5.text doubleValue]*1;
                    m = cm*0.01;
                    km = cm*0.00001;
                    inv = cm*0.3937;
                    ft = cm*0.0328;
                    mm = cm*0.033;
                    NSLog(@"gr:%f",cm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 1:
                    m = [self.text5.text doubleValue]*1;
                    cm = m*100;
                    km = m*0.001;
                    inv = m*39.371;
                    ft = m*3.2809;
                    mm = m*3.3;
                    NSLog(@"gr:%f",m);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 2:
                    km = [self.text5.text doubleValue]*1;
                    cm = km*100000;
                    m = km*1000;
                    inv = km*39371;
                    ft = km*3280.9;
                    mm = km*3300;
                    NSLog(@"gr:%f",km);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 3:
                    inv = [self.text5.text doubleValue]*1;
                    cm = inv*2.54;
                    m = inv*0.02540;
                    km = inv*0.0000254;
                    ft = inv*0.08333;
                    mm = inv*0.08382;
                    NSLog(@"gr:%f",inv);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                case 4:
                    ft = [self.text5.text doubleValue]*1;
                    cm = ft*30.48;
                    m = ft*0.3048;
                    km = ft*0.0003048;
                    inv = ft*12;
                    mm = ft*1.0058;
                    NSLog(@"gr:%f",ft);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
                    
                default:
                    mm = [self.text5.text doubleValue]*1;
                    cm = mm*30.30;
                    m = mm*0.30303;
                    km = mm*0.0003030;
                    inv = mm*11.9303;
                    ft = mm*0.9942;
                    NSLog(@"gr:%f",mm);
                    unitvs1 = [NSNumber numberWithDouble:cm];
                    unitvs2 = [NSNumber numberWithDouble:m];
                    unitvs3 = [NSNumber numberWithDouble:km];
                    unitvs4 = [NSNumber numberWithDouble:inv];
                    unitvs5 = [NSNumber numberWithDouble:ft];
                    unitvs6 = [NSNumber numberWithDouble:mm];
                    [unitValue addObject:unitvs1];
                    [unitValue addObject:unitvs2];
                    [unitValue addObject:unitvs3];
                    [unitValue addObject:unitvs4];
                    [unitValue addObject:unitvs5];
                    [unitValue addObject:unitvs6];
                    //判斷rowTow～rowFive為哪個單位後給予欄位值
                    if (rowOne == 0) {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowOne ==1){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowOne ==2){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowOne ==3){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowOne ==4){
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text1.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowTow == 0) {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowTow ==1){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowTow ==2){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowTow ==3){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowTow ==4){
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text2.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowThree == 0) {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowThree ==1){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowThree ==2){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowThree ==3){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowThree ==4){
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text3.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    
                    if (rowFour == 0) {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",cm];
                    }else if (rowFour ==1){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",m];
                    }else if (rowFour ==2){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.8f",km];
                    }else if (rowFour ==3){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",inv];
                    }else if (rowFour ==4){
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",ft];
                    }else {
                        self.text4.text = [[NSString alloc]initWithFormat:@"%.4f",mm];
                    }
                    NSLog(@"unitVale: %@",unitValue);
                    break;
            }
          }
        
    }
    
    // NSLog(@"%@",self.text1.text);
  
    
    NSLog(@"目前:%@ - 選中：%@及%@及%@及%@及%@", _pickerData[unitRow], units1[rowOne], units1[rowTow], units1[rowThree], units1[rowFour], units1[rowFive]);
//     NSLog(@"目前:%@ - 選中：%@及%@及%@及%@及%@", _pickerData[unitRow], unitValues[rowOne], unitValues[rowTow], unitValues[rowThree], unitValues[rowFour], unitValues[rowFive]);
    

    }


@end

