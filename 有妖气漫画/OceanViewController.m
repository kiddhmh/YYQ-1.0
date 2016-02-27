//
//  OceanViewController.m
//  Ocean1
//
//  Created by ma c on 16/1/26.
//  Copyright (c) 2016年 bjsxt. All rights reserved.
//

#import "OceanViewController.h"
#import "VipViewController.h"
#import "SheZhiViewController.h"
#import "LoginViewController.h"
#import "SVProgressHUD.h"
@interface OceanViewController ()

/**头像按钮*/
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
/**用户名*/
@property (weak, nonatomic) IBOutlet UILabel *photoLabel;
/**主页按钮*/
@property (weak, nonatomic) IBOutlet UIButton *zhuyeBtn;
/**vip按钮*/
@property (weak, nonatomic) IBOutlet UIButton *vipBtn;
/**设置按钮*/
@property (weak, nonatomic) IBOutlet UIButton *shezhiBtn;
/**昵称Label*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**注销按钮*/
@property (weak, nonatomic) IBOutlet UIButton *zhuxiaoButton;

- (IBAction)zhuxiaoBtn:(UIButton *)sender;

@end

@implementation OceanViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg"]]];
    
    /**为按钮设置方法*/
    [self.photoBtn addTarget:self action:@selector(photoBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.zhuyeBtn addTarget:self action:@selector(zhuyeBtnMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.vipBtn addTarget:self action:@selector(vipBtnMethod) forControlEvents:UIControlEventTouchUpInside];
    [self.shezhiBtn addTarget:self action:@selector(shezhiBtnMethod) forControlEvents:UIControlEventTouchUpInside];    
    
    self.photoBtn.layer.masksToBounds = YES;
    [self.photoBtn.layer setCornerRadius:40];
    [self.view addSubview:self.photoBtn];
    [self.view addSubview:self.photoLabel];
    [self.view addSubview:self.zhuyeBtn];
    [self.view addSubview:self.vipBtn];
    [self.view addSubview:self.shezhiBtn];
}

- (void)PassBlock:(BackBlock)block
{
    self.backblock = block;
}

/**头像按钮方法*/
- (void)photoBtnMethod
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    loginVC.title = @"登陆";
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    [loginVC passNameBlock:^(NSString *name, NSData *iconData) {
        self.nameLabel.text = name;
        
        [self.photoBtn setBackgroundImage:[UIImage imageWithData:iconData] forState:UIControlStateNormal];
        
        self.photoBtn.userInteractionEnabled = NO;
        self.zhuxiaoButton.hidden = NO;
    }];
    
    [nav pushViewController:loginVC animated:YES];
}



/**设置主页按钮方法*/
- (void)zhuyeBtnMethod:(BackBlock)block
{
    self.backblock();
}



/**VIP按钮方法*/
- (void)vipBtnMethod
{
    VipViewController *vipControllerVC = [[VipViewController alloc] init];
    vipControllerVC.title = @"VIP";
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav pushViewController:vipControllerVC animated:YES];
}



/**设置按钮的方法*/
- (void)shezhiBtnMethod
{
    SheZhiViewController *sheZhiVC = [[SheZhiViewController alloc] init];
    sheZhiVC.title = @"设置";
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav pushViewController:sheZhiVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  注销登录
 *
 */
-(IBAction)zhuxiaoBtn:(UIButton *)sender {
    
    [SVProgressHUD showSuccessWithStatus:@"注销成功"];
    
    self.photoBtn.userInteractionEnabled = YES;
    [self.photoBtn setBackgroundImage:[UIImage imageNamed:@"login_default_icon@2x副本"] forState:UIControlStateNormal];
    self.photoLabel.text = @"";
    
    sender.hidden = YES;
}
@end
