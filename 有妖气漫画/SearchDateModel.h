//
//  SearchDateModel.h
//  有妖气漫画——搜索
//
//  Created by ma c on 16/1/24.
//  Copyright © 2016年 zt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchDateModel : NSObject

@property (strong, nonatomic) NSDictionary *dataDic;

@property (strong, nonatomic) NSArray *returnDataArr;

@property (strong,nonatomic) NSString *tag;

@property (strong, nonatomic) NSString *bgColor;

@property (strong, nonatomic) NSMutableArray *dataMuArr;



- (void)JSONModelMethod:(NSDictionary *)dic;

@end
