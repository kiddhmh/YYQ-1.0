//
//  chapter_listModel.h
//  有妖气漫画
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface chapter_listModel : NSObject

///章节名称
@property(nonatomic,copy) NSString *name;
///每一章对应的图片个数
@property (nonatomic,assign) NSInteger image_total;

@end
