//
//  FL_SecondModel.h
//  有妖气_分类
//
//  Created by ma c on 16/1/25.
//  Copyright © 2016年 bjsxt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FL_SecondModel : NSObject
///作品名
@property (strong, nonatomic) NSString *fl_name;
///漫画图片
@property (strong, nonatomic) NSString *fl_cover;
///描述
@property (strong, nonatomic) NSString *fl_description;
///作者
@property (strong, nonatomic) NSString *fl_nickname;
///类别
@property (strong, nonatomic) NSArray *fl_tags;
///点击量
@property (strong, nonatomic) NSString *fl_click_total;

- (instancetype)initWith:(NSDictionary *)dic;

@end
