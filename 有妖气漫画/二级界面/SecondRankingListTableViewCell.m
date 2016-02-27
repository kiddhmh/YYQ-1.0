//
//  SecondRankingListTableViewCell.m
//  有妖气
//
//  Created by mac on 16/1/23.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import "SecondRankingListTableViewCell.h"

@implementation SecondRankingListTableViewCell

/**
 *  重写cell
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    UIView* viewBachground =  [[UIView alloc] initWithFrame:CGRectMake(0, 2, 900, 116)];
    viewBachground.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:viewBachground];
    
    
    self.imageViewSecond = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 100)];
    [self.contentView addSubview:self.imageViewSecond];
    
    self.image1 = [[UIImageView alloc] initWithFrame:CGRectMake(96, 50, 20, 20)];
    self.image1.image = [UIImage imageNamed:@"p1.png"];
    [self.contentView addSubview:self.image1];
    
    self.image2 = [[UIImageView alloc] init];
    self.image2.image = [UIImage imageNamed:@"p2.png"];
    [self.contentView addSubview:self.image2];
    
    self.image3 = [[UIImageView alloc] init];
    self.image3.image = [UIImage imageNamed:@"p3.png"];
    [self.contentView addSubview:self.image3];
    
    self.image4 = [[UIImageView alloc] initWithFrame:CGRectMake(96, 85, 20, 20)];
    self.image4.image = [UIImage imageNamed :@"p4.png"];
    [self.contentView addSubview:self.image4];
    
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(96, 13, 233, 30)];
    self.name.font = [UIFont systemFontOfSize:16];
    self.name.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.name];
    
    self.nickNameLable = [[UILabel alloc] initWithFrame:CGRectMake(120, 55, 65, 21)];
    self.nickNameLable.textColor = [UIColor grayColor];
    self.nickNameLable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.nickNameLable];
    
    self.clickTotalLable = [[UILabel alloc] init];
    self.clickTotalLable.textColor = [UIColor grayColor];
    self.clickTotalLable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.clickTotalLable];
    
    self.styleLable = [[UILabel alloc] init];
    self.styleLable.textColor = [UIColor grayColor];
    self.styleLable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.styleLable];
    
    self.chapter_numLable = [[UILabel alloc] initWithFrame:CGRectMake(120, 87, 200, 21)];
    self.chapter_numLable.textColor = [UIColor orangeColor];
    self.chapter_numLable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.chapter_numLable];
    
    self.dujiaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(305, 2, 72, 53)];
    self.dujiaImageView.image = [UIImage imageNamed:@"dujiaRightTop.png"];
    [self.contentView addSubview:self.dujiaImageView];
    self.dujiaImageView.alpha = 0;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

