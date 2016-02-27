//
//  LookBookDatamodel.h
//  有妖气漫画---阅读
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 zt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LookBookDatamodel : NSObject

@property (strong,  nonatomic) NSDictionary *data;

@property (strong, nonatomic)  NSArray *returnData;

/// 存放图片
@property (strong, nonatomic) NSMutableArray *imageArr;

/// 解析数据
- (void)JSONLookBookDataModel:(NSDictionary*)dic;

@end
