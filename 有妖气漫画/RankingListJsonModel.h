//
//  RankingListJsonModel.h
//  有妖气漫画
//
//  Created by mac on 16/1/22.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  解析类
 */
@interface RankingListJsonModel : NSObject

@property (strong, nonatomic) NSDictionary* data;

@property (strong, nonatomic) NSString* message;
@property (strong, nonatomic) NSDictionary* returnData;

@property (strong, nonatomic) NSArray* rankinglist;


@property (strong, nonatomic) NSString* rankingName;
@property (strong, nonatomic) NSString* rankingDescription1;
@property (strong, nonatomic) NSString* rankingDescription2;
@property (strong, nonatomic) NSString* cover; ///图片
@property (strong, nonatomic) NSString* argCon;
@property (strong, nonatomic) NSString* argName;
@property (strong, nonatomic) NSNumber* argValue;

- (void)jsonModelMethod:(NSDictionary *)dic;

@property (strong, nonatomic) NSMutableArray *allJsonDataMutArray;


@end
