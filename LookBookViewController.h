//
//  LookBookViewController.h
//  有妖气漫画---阅读
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeadView;
@class LookBookDatamodel;
@interface LookBookViewController : UIViewController

///传入漫画的网址
@property (strong, nonatomic) NSString *urlStr;

@property (strong, nonatomic) NSString *titleStr;



@end
