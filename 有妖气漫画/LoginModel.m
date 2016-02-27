//
//  LoginModel.m
//  登陆界面
//
//  Created by ma c on 16/1/27.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.Username forKey:@"Username"];
    [aCoder encodeObject:self.PassWord forKey:@"PassWord"];
    [aCoder encodeObject:self.iconData forKey:@"iconData"];
}


//解档
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _Username = [aDecoder decodeObjectForKey:@"Username"];
        _PassWord = [aDecoder decodeObjectForKey:@"PassWord"];
        _iconData = [aDecoder decodeObjectForKey:@"iconData"];
    }
    return self;
}

@end
