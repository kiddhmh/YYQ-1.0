//
//  SecondRankingListJsonMadel.h
//  有妖气
//
//  Created by mac on 16/1/23.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondRankingListJsonMadel : NSObject

@property (strong, nonatomic) NSDictionary* data;

@property (strong, nonatomic) NSArray* returnData;

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSNumber* chapter_num;
@property (strong, nonatomic) NSString* click_total;
@property (strong, nonatomic) NSString* extraValue;///月票
@property (strong, nonatomic) NSString* nickname;
@property (strong, nonatomic) NSArray* tags;
@property (strong, nonatomic) NSString* cover;
@property (strong, nonatomic) NSString* descriptiontext;
@property (strong, nonatomic) NSNumber* is_dujia;

- (void)jsonModelMethod:(NSDictionary *)dic;

@property (strong, nonatomic) NSMutableArray *allJsonDataMutArray;


@end
