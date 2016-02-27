//
//  UIBarButtonItem+Extension.h
//  有妖气漫画
//
//  Created by ma c on 16/1/25.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTagert:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
