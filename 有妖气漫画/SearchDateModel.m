//
//  SearchDateModel.m
//  有妖气漫画——搜索
//
//  Created by ma c on 16/1/24.
//  Copyright © 2016年 zt. All rights reserved.
//

#import "SearchDateModel.h"

@implementation SearchDateModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataDic = [[NSDictionary alloc] init];
        self.returnDataArr = [[NSArray alloc] init];
        self.dataMuArr = [[NSMutableArray alloc] initWithCapacity:10];
            }
    return self;
}

- (void)JSONModelMethod:(NSDictionary *)dic;
{
    self.dataDic = dic[@"data"];
    self.returnDataArr = self.dataDic[@"returnData"];
    
    for (NSDictionary *tempDic in self.returnDataArr) {
        self.tag = tempDic[@"tag"];
        self.bgColor = tempDic [@"bgColor"];
        
        NSMutableDictionary *dataMuDic = [[NSMutableDictionary alloc] initWithCapacity:10];
        [dataMuDic setValue:self.tag forKey:@"tag"];
        [dataMuDic setValue:self.bgColor forKey:@"bgColor"];
        
        [self.dataMuArr addObject:dataMuDic];
    }
    
    
    
    
}


@end
