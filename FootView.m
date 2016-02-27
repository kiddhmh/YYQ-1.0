//
//  FootView.m
//  有妖气漫画---阅读
//
//  Created by ma c on 16/1/25.
//  Copyright © 2016年 zt. All rights reserved.
//

#import "FootView.h"
#import "SVProgressHUD.h"

@interface FootView ()

@property (strong, nonatomic) UIButton *button;
@end

@implementation FootView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self createFootUI];
    }
    return self;
}

- (void)createFootUI
{
    [self createButtonWithRect:CGRectMake(21, -8, 90, 60) andNormalIamge:@"horizontal" andHighImage:@"horizontal_pressed"];
    [self createButtonWithRect:CGRectMake(142, -8, 90, 60) andNormalIamge:@"horizontaladjustluminance" andHighImage:@"horizontaladjustluminance_pressed"];
    [self createButtonWithRect:CGRectMake(256, -8, 90, 60) andNormalIamge:@"horizontaladdbookmark" andHighImage:@"horizontaladdbookmark_pressed"];
    [self createButtonWithRect:CGRectMake(21, 40, 90, 60) andNormalIamge:@"horizontalmybookmark" andHighImage:@"horizontalmybookmark_pressed"];
    [self createButtonWithRect:CGRectMake(142, 40, 90, 60) andNormalIamge:@"horizontalhelp" andHighImage:@"horizontalhelp_pressed"];
    [self createButtonWithRect:CGRectMake(256, 40, 90, 60) andNormalIamge:@"turnpage" andHighImage:@"turnpage_pressed"];
    
    
}
#pragma mark -----创建Button -----------
- (void)createButtonWithRect:(CGRect)rect andNormalIamge:(NSString*)normalImage andHighImage:(NSString*)highImage
{
    static int i =0;
    i++;
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
   self.button.frame = rect;
    self.button.tag = i;
    [self.button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [self.button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [self.button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
}

/// button关联的方法
- (void)click:(UIButton*)optionBtn
{
    NSInteger n = optionBtn.tag;
    switch (n) {
        case 1:
            
            break;
        case 2:
            [self horizontaladjustluminanceMethod];
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            break;
        case 6:
            break;
        default:
            break;
    }
}

/// 横屏按钮关联的方法

- (void)horizontalBtnMethod
{
    
}

/// 亮度调节按钮

- (void)horizontaladjustluminanceMethod
{
    self.alpSlider = [[UISlider alloc] initWithFrame:CGRectMake(50, 540, 300,31)];
    self.alpSlider.minimumValue = 0.3;
    self.alpSlider.maximumValue = 1;
    self.alpSlider.value = 0.6;
    [self.alpSlider addTarget:self action:@selector(sliderMethod) forControlEvents:UIControlEventValueChanged];
    [self.superview addSubview:self.alpSlider];
    
}
- (void)sliderMethod
{
    self.superview.alpha = self.alpSlider.value;
}

/// 书签按钮

- (void)horizontaladdbookmarkMethod
{
    [SVProgressHUD showErrorWithStatus:@"添加失败"];
}

/// 我的书签按钮

- (void)horizontalmybookmarkMethod
{
    [SVProgressHUD showErrorWithStatus:@"该功能尚未开发"];
}

/// 帮助按钮

- (void)horizontalhelpMethod
{
    [SVProgressHUD showErrorWithStatus:@"并没有帮助"];
}

/// 卷纸模式按钮

- (void)turnpage
{
    [SVProgressHUD showErrorWithStatus:@"要几包?"];
}


@end
