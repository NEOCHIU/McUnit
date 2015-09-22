//
//  AppDelegate.m
//  McUnit
//
//  Created by kid chiu on 2015/7/22.
//  Copyright (c) 2015年 kidmac. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "CuttingConditonViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate

-(sqlite3 *)getDB{
    return db;
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //將資料庫複製到Document具有複製的權限目錄
    NSFileManager *fm =[[NSFileManager alloc]init];
    NSString *src = [[NSBundle mainBundle]pathForResource:@"cuttingconditions" ofType:@"sqlite"];
    NSString *dst =[NSString stringWithFormat:@"%@/Documents/cuttingconditions.sqlite",NSHomeDirectory()];
    
    //檢查目錄是否存在，不存在則複製資料庫
    if(![fm fileExistsAtPath:dst]){
        [fm copyItemAtPath:src toPath:dst error:nil];
    }
    
    //資料庫連線 將結果存入db變數
    if(sqlite3_open([dst UTF8String], &db) != SQLITE_OK){
        db = nil;
        NSLog(@"資料庫連線失敗");
    
    }
        NSLog(@"資料庫連線成功");
        NSLog(@"%@",[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    
    //改變tab bar 圖示
    // Assign tab bar item with titles
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
//    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    
   
    tabBarItem2.title = @"換算表";
    tabBarItem3.title = @"關於我";
    
   
    
    [tabBarItem2 setImage:[[UIImage imageNamed:@"tab-iconB.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [tabBarItem3 setImage:[[UIImage imageNamed:@"tab-iconC.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"tab-iconB.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab-iconB-1.png"]];
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"tab-iconC.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab-iconC-1.png"]];
   
    
        
    
    
    
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
  //關閉資料庫
    sqlite3_close(db);
}

@end
