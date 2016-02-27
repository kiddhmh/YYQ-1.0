//
//  BigModel.m
//  有妖气漫画
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import "BigModel.h"
#import "MJExtension.h"
#import "SmallModel.h"
@implementation BigModel

///声明smallMLArray数组对应的模型是SmallModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"comicListItems":[SmallModel class]
             
             };
}

@end
