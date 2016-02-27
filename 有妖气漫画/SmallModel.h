//
//  SmallModel.h
//  有妖气漫画
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SmallModel : NSObject

///漫画名称
@property (nonatomic,copy) NSString *name;;
///漫画缩略图
@property (nonatomic,copy) NSString *cover;
///漫画作者
@property (nonatomic,copy) NSString *nickname;
///漫画更新
@property (nonatomic,copy) NSString *last_update_chapter_name;
///漫画描述
@property (nonatomic,copy) NSString *des;

@end
