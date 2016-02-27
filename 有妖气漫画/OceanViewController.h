//
//  OceanViewController.h
//  Ocean1
//
//  Created by ma c on 16/1/26.
//  Copyright (c) 2016年 bjsxt. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BackBlock)();
@interface OceanViewController : UIViewController
///监听蒙版的点击
@property (nonatomic,copy) BackBlock backblock;

- (void)PassBlock:(BackBlock)block;



@end
