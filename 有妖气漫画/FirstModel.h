//
//  FirstModel.h
//  有妖气漫画
//
//  Created by ma c on 16/1/22.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstModel : NSObject


//漫画封面图片数据
@property (strong, nonatomic) NSString *cover;
//漫画名称数据
@property (strong, nonatomic) NSString *name;
//作者名称数据
@property (strong, nonatomic) NSString *nickname;
//总点击数据
@property (strong, nonatomic) NSString *extraValue;
//最新更新章节数据
@property (strong, nonatomic) NSString *last_update_chapter_name;
//漫画类型Label
@property (strong, nonatomic) NSString *tags;
//是否是独家
@property (assign, nonatomic) NSNumber *is_dujia;


-(instancetype)initWithDic:(NSDictionary*)dic;




@end
