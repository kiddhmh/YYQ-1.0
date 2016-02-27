//
//  comicModel.h
//  有妖气漫画
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface comicModel : NSObject
///漫画名称
@property (nonatomic,copy) NSString *name;
///漫画作者
@property (nonatomic,copy) NSString *author_name;
///漫画图片
@property (nonatomic,copy) NSString *cover;
///漫画类型
@property (nonatomic,copy) NSString *theme_ids;
///漫画点击量
@property (nonatomic,copy) NSString *click_total;
///漫画简介
@property (nonatomic,copy) NSString *des;


@end
