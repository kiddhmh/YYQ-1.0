//
//  MyImageView.m
//  有妖气漫画
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import "MyImageView.h"

@implementation MyImageView

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect
{
    [self.image drawInRect:rect];
}

@end
