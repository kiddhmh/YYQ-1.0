//
//  comicModel.m
//  有妖气漫画
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "comicModel.h"
#import "MJExtension.h"
@implementation comicModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"des" : @"description"
             };
}

@end
