//
//  HMHNavViewController.m
//  有妖气漫画
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "HMHNavViewController.h"
#import "UIBarButtonItem+Extension.h"

@interface HMHNavViewController ()

@end

@implementation HMHNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 重写push方法，统一返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    //设置左耳目
    UIBarButtonItem *backItem = [UIBarButtonItem itemWithTagert:self action:@selector(back) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
    
    viewController.navigationItem.leftBarButtonItem = backItem;
    
    [super pushViewController:viewController animated:animated];
}


//返回上一级界面
- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
