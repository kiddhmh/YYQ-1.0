//
//  RankingListJsonModel.m
//  有妖气漫画
//
//  Created by mac on 16/1/22.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import "RankingListJsonModel.h"

@implementation RankingListJsonModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.allJsonDataMutArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

-(void)setAllJsonDataMutArray:(NSMutableArray *)allJsonDataMutArray
{
    _allJsonDataMutArray = allJsonDataMutArray;
    if (_allJsonDataMutArray == nil) {
        _allJsonDataMutArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    
}

/**
 *  初始化
 */
- (void)jsonModelMethod:(NSDictionary *)dic
{
    self.data = [dic valueForKey:@"data"];
    self.message = [self.data valueForKey:@"message"];
    self.returnData =[self.data valueForKey:@"returnData"];
    self.rankinglist = [self.returnData valueForKey:@"rankinglist"];
    
    for (NSDictionary* dic in self.rankinglist) {
        self.argCon = [dic valueForKey:@"argCon"];
        self.argName = [dic valueForKey:@"argName"];
        self.argValue =[dic valueForKey:@"argValue"];
        self.cover = [dic valueForKey:@"cover"];
        self.rankingDescription1 = [dic valueForKey:@"rankingDescription1"];
        self.rankingDescription2 = [dic valueForKey:@"rankingDescription2"];
        self.rankingName = [dic valueForKey:@"rankingName"];
        
        
        NSMutableDictionary *tempMutableDic = [[NSMutableDictionary alloc]initWithCapacity:10];
        [tempMutableDic setValue:self.argCon forKey:@"argCon"];
        [tempMutableDic setValue:self.argName forKey:@"argName"];
        [tempMutableDic setValue:self.argValue forKey:@"argValue"];
        [tempMutableDic setValue:self.cover forKey:@"cover"];
        [tempMutableDic setValue:self.rankingDescription1 forKey:@"rankingDescription1"];
        [tempMutableDic setValue:self.rankingDescription2 forKey:@"rankingDescription2"];
        [tempMutableDic setValue:self.rankingName forKey:@"rankingName"];
        [self.allJsonDataMutArray addObject:tempMutableDic];
    }
    
}

@end
