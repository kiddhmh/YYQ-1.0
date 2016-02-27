//
//  LookBookDatamodel.m
//  有妖气漫画---阅读
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 zt. All rights reserved.
//

#import "LookBookDatamodel.h"

#import "OrangeBaseNetWorking.h"

@implementation LookBookDatamodel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.data = [[NSDictionary alloc] init];
        self.returnData = [[NSArray alloc] init];
        self.imageArr = [[NSMutableArray alloc] initWithCapacity:10];
        
    }
    return self;
}

- (void)JSONLookBookDataModel:(NSDictionary*)dic
{
    self.data = dic[@"data"];
    self.returnData = self.data[@"returnData"];
    
    for (NSDictionary *tempDic in self.returnData) {
        
        NSString *imageUrl = tempDic[@"svol"];

        [self.imageArr addObject:imageUrl];
        
    }
    
}


@end
