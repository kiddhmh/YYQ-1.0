//
//  ZhuCeViewController.m
//  登陆界面
//
//  Created by ma c on 16/1/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "ZhuCeViewController.h"
#import "DropDownMenu.h"
#import "LoginModel.h"
#import "SVProgressHUD.h"
#define  filePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]
@interface ZhuCeViewController ()<UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
///输入账号文本框
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

///输入密码文本框
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;

///注册按钮
- (IBAction)zhuceBtn:(UIButton *)sender;

///头像图片数据
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

///圆环图片
@property (weak, nonatomic) IBOutlet UIImageView *ringImageView;

/**
 *  选取的图片数据
 */
@property (nonatomic,strong) NSData *IconData;

@end

@implementation ZhuCeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg"]];
    
    self.nameTextField.delegate = self;
    self.passWordTextField.delegate = self;
    
    self.iconView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePicture)];
    [self.iconView addGestureRecognizer:tap];
}


#pragma mark - 从相册中选取照片
- (void)changePicture
{
    UIAlertController *Actionsheet = [UIAlertController alertControllerWithTitle:@"选取头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //选照片
    [Actionsheet addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self chooseImage];
        
    }]];
    
    //取消按钮
    [Actionsheet addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    [self presentViewController:Actionsheet animated:YES completion:nil];
}



#pragma mark - 选取照片方法
- (void)chooseImage
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //照片来源
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    
    //设置选取的图片可编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate 选取照片后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]) {
        
        //先把图片转换成data
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        self.iconView.image = image;
        self.ringImageView.hidden = YES;
        
        NSData *data = [[NSData alloc] init];
        if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 1.0);
        }else
        {
            data = UIImagePNGRepresentation(image);
        }
        
        self.IconData = data;
    }
    
    //关闭相册界面
    [picker dismissViewControllerAnimated:YES completion:nil];
}


//取消选择图片，返回上一级视图
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)zhuceBtn:(UIButton *)sender {
    
    if ([self.nameTextField.text isEqualToString:@""]) {
        [DropDownMenu showWith:@"请输入账号咯~" to:self.navigationController.view belowSubView:self.navigationController.navigationBar];
    }else if ([self.passWordTextField.text isEqualToString:@""]){
        [DropDownMenu showWith:@"请输入密码咯~" to:self.navigationController.view belowSubView:self.navigationController.navigationBar];
    }else{
        //注册用户,写入沙盒
        LoginModel *model = [[LoginModel alloc] init];
        model.Username = self.nameTextField.text;
        model.PassWord = self.passWordTextField.text;
        
        model.iconData = self.IconData;
        
        if ([NSKeyedArchiver archiveRootObject:model toFile:filePath]) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功~~"];
            //返回上一级界面
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            [SVProgressHUD showErrorWithStatus:@"注册失败>.<"];
        }
    }
    
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.nameTextField resignFirstResponder];
    [self.passWordTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.view.transform = CGAffineTransformIdentity;
    }];
    
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
       
        self.view.transform = CGAffineTransformMakeTranslation(0, -200);
    }];
}


@end
