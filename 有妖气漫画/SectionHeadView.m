//
//  SectionHeadView.m
//  有妖气漫画
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import "SectionHeadView.h"
#import "UIImageView+WebCache.h"
@interface SectionHeadView ()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleLabel;

@end
@implementation SectionHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //初始化子空间
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.numberOfLines = 0;
        [self addSubview:self.titleLabel];
        
        UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(305, 0,55,35)];
        rightLabel.textAlignment = NSTextAlignmentCenter;
        rightLabel.textColor = [UIColor darkGrayColor];
        rightLabel.text = @"全部 >";
        [self addSubview:rightLabel];
        
    }
    return self;
}


//设置子控件的frame
- (void)layoutSubviews
{
    self.imageView.frame = CGRectMake(0,8, 32,22);
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.frame = CGRectMake(32,0,100, 35);
}


- (void)setImageURL:(NSString *)imageURL
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

@end
