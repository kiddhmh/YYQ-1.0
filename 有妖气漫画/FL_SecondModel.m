//
//  FL_SecondModel.m
//  有妖气_分类
//
//  Created by ma c on 16/1/25.
//  Copyright © 2016年 bjsxt. All rights reserved.
//

#import "FL_SecondModel.h"

@implementation FL_SecondModel

- (instancetype)initWith:(NSDictionary *)dic
{
    if (self = [super init]) {
        self.fl_name = dic[@"name"];
        self.fl_cover = dic[@"cover"];
        self.fl_nickname = dic[@"nickname"];
        self.fl_tags = dic[@"tags"];
        self.fl_click_total = dic[@"click_total"];
        self.fl_description = dic[@"description"];
    }
    return self;
}

@end
