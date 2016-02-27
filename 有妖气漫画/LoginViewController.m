//
//  LoginViewController.m
//  登陆界面
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "LoginViewController.h"
#import "CateAnimationLogin.h"
#import "DropDownMenu.h"
#import "LoginModel.h"
#import "SVProgressHUD.h"
#import "ZhuCeViewController.h"
#import "BWTKViewController.h"

#define  filePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *BackgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

//猫头鹰登陆页面
@property (nonatomic,strong) CateAnimationLogin *loginView;

//登陆
- (IBAction)LoginBtn:(UIButton *)sender;

//注册
- (IBAction)ZhuCe:(UIButton *)sender;

///进入霸王条款页面（慎点）
- (IBAction)BWTK:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"登陆";
    
    self.BackgroundImage.userInteractionEnabled = YES;
    
    CateAnimationLogin *login = [[CateAnimationLogin alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,320)];
    
    self.loginView = login;
    
    [self.BackgroundImage addSubview:login];
    
    //添加属性字符串
    
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:@"大大们，注册前先看看我们的霸王条款"];
    //设置前面字体灰色
    [attrs addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, 13)];
    //设置后面字体橘黄色
    [attrs addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(13, 4)];
    //设置总字体的大小
    [attrs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 17)];
    //设置后面字体下划线
    [attrs addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:1] range:NSMakeRange(13, 4)];
    //设置后面字体链接属性
//    [attrs addAttribute:NSLinkAttributeName value:[NSURL URLWithString:@"www.baidu.com"] range:NSMakeRange(13, 4)];
    
    //添加属性字符串
    self.desLabel.attributedText = attrs;
    
    //开启用户交互模式
    self.desLabel.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  - 点击登陆按钮事件
- (IBAction)LoginBtn:(UIButton *)sender {
    
    [self.loginView showTextFieldText:^(NSString *name, NSString *pass) {
        if ([name isEqualToString:@""]) {
            [DropDownMenu showWith:@"请输入QQ号咯~" to:self.navigationController.view belowSubView:self.navigationController.navigationBar];
        }else if ([pass isEqualToString:@""]){
            [DropDownMenu showWith:@"请输入密码咯~" to:self.navigationController.view belowSubView:self.navigationController.navigationBar];
        }else{
            //判断密码是否正确
            [self loginToCartoonWithUserName:name PassWord:pass];
        }
    }];
    
}


#pragma mark - 点击注册按钮事件
- (IBAction)ZhuCe:(UIButton *)sender {
    
    ZhuCeViewController *zhuceVC = [[ZhuCeViewController alloc] init];
    zhuceVC.title = @"注册";
    
    [self.navigationController pushViewController:zhuceVC animated:YES];
}


#pragma mark - 进入霸王条款页面
- (IBAction)BWTK:(UIButton *)sender {
    
    BWTKViewController *bwtkVC = [[BWTKViewController alloc] init];
    bwtkVC.title = @"霸王条约";
    
    [self.navigationController pushViewController:bwtkVC animated:YES];
}


- (void)passNameBlock:(NameBlock)block
{
    self.nameBlock = block;
}


#pragma  mark - 判断账号密码是否正确
- (void)loginToCartoonWithUserName:(NSString *)userName PassWord:(NSString *)passWord
{
    //从沙盒中取出账号，查看是否正确
    LoginModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    BOOL flagname = [userName isEqualToString:model.Username];
    BOOL flagpass = [passWord isEqualToString:model.PassWord];
    
    if (!flagname) {
        [SVProgressHUD showErrorWithStatus:@"账号错误"];
    }else if (!flagpass)
    {
        [SVProgressHUD showErrorWithStatus:@"密码错误"];
    }else
    {
        [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
        
        //返回首页
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        self.nameBlock(model.Username,model.iconData);
    }
    
}


@end
