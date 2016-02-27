//
//  SecondRankingListJsonMadel.m
//  有妖气
//
//  Created by mac on 16/1/23.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import "SecondRankingListJsonMadel.h"

@implementation SecondRankingListJsonMadel
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.allJsonDataMutArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}


- (void)jsonModelMethod:(NSDictionary *)dic
{
    self.data = [dic valueForKey:@"data"];
    self.returnData =[self.data valueForKey:@"returnData"];
    
    for (NSDictionary* dic in self.returnData) {
        self.name = [dic valueForKey:@"name"];
        self.click_total =[dic valueForKey:@"click_total"];
        self.cover = [dic valueForKey:@"cover"];
        self.descriptiontext = [dic valueForKey:[NSString stringWithFormat:@"description"]];
        self.nickname = [dic valueForKey:@"nickname"];
        self.extraValue = [dic valueForKey:@"extraValue"];
        self.is_dujia = [dic valueForKey:@"is_dujia"];
        self.tags = [dic valueForKey:@"tags"];
        
        NSMutableDictionary *tempMutableDic = [[NSMutableDictionary alloc]initWithCapacity:10];
        
        [tempMutableDic setValue:self.name forKey:@"name"];
        [tempMutableDic setValue:self.cover forKey:@"cover"];
        [tempMutableDic setValue:self.click_total forKey:@"click_total"];
        [tempMutableDic setValue:self.descriptiontext forKey:[NSString stringWithFormat:@"description"]];
        [tempMutableDic setValue:self.nickname forKey:@"nickname"];
        [tempMutableDic setValue:self.extraValue forKey:@"extraValue"];
        [tempMutableDic setValue:self.is_dujia forKey:@"is_dujia"];
        [tempMutableDic setValue:self.tags forKey:@"tags"];
        
        [self.allJsonDataMutArray addObject:tempMutableDic];
    }
    // NSLog(@"----------------%@",_allJsonDataMutArray);
    
}


@end
