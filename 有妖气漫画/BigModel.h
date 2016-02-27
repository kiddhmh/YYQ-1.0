//
//  BigModel.h
//  有妖气漫画
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BigModel : NSObject

///左上角图片
@property (nonatomic,copy) NSString *titleIconUrl;

///标题
@property (nonatomic,copy) NSString *titleWithIcon;

///内容
@property (nonatomic,strong)NSArray *comicListItems;

@end
