//
//  FirstModel.m
//  有妖气漫画
//
//  Created by ma c on 16/1/22.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import "FirstModel.h"

@implementation FirstModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.cover = [dic valueForKey:@"cover"];
        self.name = [dic valueForKey:@"name"];
        self.nickname = [dic valueForKey:@"nickname"];
        self.extraValue = [dic valueForKey:@"extraValue"];
        self.last_update_chapter_name = [dic valueForKey:@"last_update_chapter_name"];
        self.is_dujia = [dic valueForKey:@"is_dujia"];
        
        //将数组转化成字符串
        NSMutableArray *tagsArray = [[NSMutableArray alloc] initWithArray:[dic valueForKey:@"tags"]];
        NSMutableString * tempStr = [[NSMutableString alloc] init];
        for(NSString * str in tagsArray)
        {
            [tempStr appendFormat:@"  %@",str];
        }
        
        
        self.tags = tempStr;
        
    }
    return self;
}

































@end
