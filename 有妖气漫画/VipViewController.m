//
//  VipViewController.m
//  Ocean1
//
//  Created by ma c on 16/1/26.
//  Copyright (c) 2016年 bjsxt. All rights reserved.
//

#import "VipViewController.h"

@interface VipViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *fengeLabel1;
@property (weak, nonatomic) IBOutlet UILabel *fengeLabel2;
@property (weak, nonatomic) IBOutlet UILabel *bangdingLabel;
@property (weak, nonatomic) IBOutlet UIButton *bangdingBtn;
@property (weak, nonatomic) IBOutlet UILabel *tancanLabel;
@property (weak, nonatomic) IBOutlet UILabel *xieyiLabel;
@property (weak, nonatomic) IBOutlet UILabel *moonLabel1;
@property (weak, nonatomic) IBOutlet UILabel *moonLabel2;
@property (weak, nonatomic) IBOutlet UILabel *vipLabel1;
@property (weak, nonatomic) IBOutlet UILabel *vipLabel2;
@property (weak, nonatomic) IBOutlet UIButton *vipBtn1;
@property (weak, nonatomic) IBOutlet UIButton *vipBtn2;
@property (weak, nonatomic) IBOutlet UILabel *zhuLabel;


@end

@implementation VipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.topImageView];
    [self.view addSubview:self.fengeLabel1];
    [self.view addSubview:self.fengeLabel2];
    [self.view addSubview:self.bangdingLabel];
    [self.view addSubview:self.bangdingBtn];
    [self.view addSubview:self.tancanLabel];
    [self.view addSubview:self.xieyiLabel];
    [self.view addSubview:self.moonLabel1];
    [self.view addSubview:self.moonLabel2];
    [self.view addSubview:self.vipLabel1];
    [self.view addSubview:self.vipLabel2];
    [self.view addSubview:self.vipBtn1];
    [self.view addSubview:self.vipLabel2];
    [self.view addSubview:self.zhuLabel];
    
}
/**绑定按钮方法*/
- (void)bangdingBtnMethod
{
    
}
/**购买3个月会员按钮方法*/
- (void)vipBtn1Method
{
    
}
/**购买6个月会员按钮方法*/
- (void)vipBtn2Method
{
    
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

- (IBAction)bangdingBtn:(UIButton *)sender {
}
- (IBAction)vipBtn1:(UIButton *)sender {
}

- (IBAction)vipBtn2:(UIButton *)sender {
}
@end
