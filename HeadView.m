//
//  HeadView.m
//  有妖气漫画---阅读
//
//  Created by ma c on 16/1/25.
//  Copyright © 2016年 zt. All rights reserved.
//

#import "HeadView.h"
#import "LookBookDatamodel.h"

@implementation HeadView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createHeadUI];
    }
    return self;
}


- (void)createHeadUI
{
    // 返回按钮
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBtn.frame = CGRectMake(15, 12, 25, 25);
    [self.backBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [self.backBtn setImage:[UIImage imageNamed:@"return_pressed"] forState:UIControlStateHighlighted];
   
    [self addSubview:self.backBtn];
    
    // 标题标签
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 15, 150, 15)];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    [self   addSubview:self.titleLabel];
    
    //  高 Button
    
    UIButton *highBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    highBtn.frame = CGRectMake(302, 18, 20, 20);
    [highBtn setTitle:@"高" forState:UIControlStateNormal];
    [highBtn setTitle:@"高" forState:UIControlStateHighlighted];
    highBtn.layer.borderWidth = 1.0;
    highBtn.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    [highBtn addTarget:self action:@selector(sheetThings) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:highBtn];
    
   // 索引BUtton
    
    self.indexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.indexBtn.frame = CGRectMake(335, 15, 25, 25);
    [self.indexBtn setImage:[UIImage imageNamed:@"catalogue_pressed"] forState:UIControlStateNormal];
    [self addSubview:self.indexBtn];
    
    // 索引标签
    
    self.indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 42, 35, 15)];
    self.indexLabel.textAlignment  = NSTextAlignmentCenter;
    self.indexLabel.text = @"1/27";
    self.indexLabel.textColor = [UIColor whiteColor];
    self.indexLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.indexLabel];
    
    // 滑动条
    
    self.slider = [[UISlider alloc] initWithFrame:CGRectMake(50, 35, 310, 31)];
    self.slider.minimumValue = 1;
    self.slider.value = 0;
    [self.slider addTarget:self action:@selector(sliderMethod) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.slider];
    
  
    
    
    
}



/// 高按钮关联的事件

- (void)sheetThings
{
      self.sheet = [[UIActionSheet alloc] initWithTitle:@"选择阅读模式^_^" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"高清 (流量消耗中等)",@"标清 (节省流量)",@"遇异常请点这里", nil];
    
    [self.sheet showInView:self.superview];
}

/// sheet中button关联的方法
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
            self.superview.alpha = 1.0;
            break;
        case 2:
            self.superview.alpha = 0.4;
            break;
        case 3:
            NSLog(@"呵呵哒");
            break;
        default:
            break;
    }
}

/// 滑动条关联的方法

- (void)sliderMethod
{
    self.indexLabel.text = [NSString stringWithFormat:@"%d/27",(int)self.slider.value];
    
}

@end
