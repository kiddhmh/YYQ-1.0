//
//  LoginModel.h
//  登陆界面
//
//  Created by ma c on 16/1/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject<NSCoding>
///用户昵称
@property (nonatomic,copy) NSString *Username;

///用户密码
@property (nonatomic,copy) NSString *PassWord;

///头像图片
@property (nonatomic,strong) NSData *iconData;

@end
