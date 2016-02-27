//
//  CateAnimationLogin.h
//  cutelogin
//
//  Created by nb616 on 16/1/9.
//  Copyright © 2016年 国服第一. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ShowTextField)(NSString *name,NSString *pass);
typedef NS_ENUM(NSInteger,ClickType){
    clicktypeNone,
    clicktypeUser,
    clicktypePass
};
@interface CateAnimationLogin : UIView
@property (strong, nonatomic)UITextField *userNameTextField;
@property (strong, nonatomic)UITextField *PassWordTextField;

- (void)showTextFieldText:(ShowTextField)block;

@end
