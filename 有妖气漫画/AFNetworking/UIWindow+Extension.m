//
//  UIWindow+Extension.m
//  有妖气漫画
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "HMHNavViewController.h"
#import "NewBootViewController.h"
#import "CartoonViewController.h"
@implementation UIWindow (Extension)

- (void)switchRootViewController
{
    //从沙盒中取出版本号
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    
    //获得当前软件的版本号
    NSDictionary *dic = [NSBundle mainBundle].infoDictionary;
    NSString *nowVersion = dic[key];
    
    //判断两次版本号是否一样
    if ([lastVersion isEqualToString:nowVersion]) {
        
        //版本号相同加载主页面
        CartoonViewController *carVC = [[CartoonViewController alloc] init];
        HMHNavViewController *nav = [[HMHNavViewController alloc] initWithRootViewController:carVC];
        carVC.title = @"有妖气";
        
        [carVC.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"headerViewDetail"] forBarMetrics:UIBarMetricsDefault];
        self.rootViewController = nav;
    }else
    { //版本号不同
        self.rootViewController = [[NewBootViewController alloc] init];
        //将版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:nowVersion forKey:key];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
}

@end
