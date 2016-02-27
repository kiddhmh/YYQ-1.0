//
//  RankingListTableViewCell.m
//  有妖气漫画
//
//  Created by mac on 16/1/22.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import "RankingListTableViewCell.h"

@implementation RankingListTableViewCell

@synthesize imageView;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCellUI];
    }
    return self;
}


-(void)createCellUI
{
    self.viewBachground = [[UIView alloc] initWithFrame:CGRectMake(0, 2, self.frame.size.width*3,116)];
    self.viewBachground.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:self.viewBachground];
    
    
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 150, 100)];
    [self.contentView addSubview:self.imageView];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, [UIScreen mainScreen].bounds.size.width - 230, 30)];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    
    
    self.lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 49, [UIScreen mainScreen].bounds.size.width - 230, 1)];
    self.lineLabel.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.lineLabel];
    
    self.rankingDescription1Label = [[UILabel alloc] initWithFrame:CGRectMake(170, 60, [UIScreen mainScreen].bounds.size.width - 220, 15)];
    self.rankingDescription1Label.textAlignment = NSTextAlignmentLeft;
    self.rankingDescription1Label.font = [UIFont systemFontOfSize:15];
    self.rankingDescription1Label.textColor = [UIColor grayColor];
    [self.contentView addSubview:self.rankingDescription1Label];
    
    self.rankingDescription2Label = [[UILabel alloc] initWithFrame:CGRectMake(170, 90, [UIScreen mainScreen].bounds.size.width - 220, 15)];
    self.rankingDescription2Label.textAlignment = NSTextAlignmentLeft;
    self.rankingDescription2Label.textColor = [UIColor grayColor];
    self.rankingDescription2Label.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.rankingDescription2Label];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
