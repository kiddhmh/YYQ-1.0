//
//  LoginViewController.h
//  登陆界面
//
//  Created by ma c on 16/1/26.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^NameBlock)(NSString *name,NSData *iconData);
@interface LoginViewController : UIViewController
@property (nonatomic,copy) NameBlock nameBlock;

- (void)passNameBlock:(NameBlock)block;

@end
