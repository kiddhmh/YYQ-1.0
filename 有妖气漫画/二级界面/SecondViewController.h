//
//  SecondViewController.h
//  有妖气
//
//  Created by mac on 16/1/23.
//  Copyright © 2016年 Rain-林. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SecondRankingListJsonMadel;
@class SecondRankingListTableViewCell;

@interface SecondViewController : UIViewController
{
    //解析模型
    SecondRankingListJsonMadel *secondJsonModel;
    //自定义Cell
    SecondRankingListTableViewCell *secondRankingListTableViewCell;
    
    // UINib *nib;
    
}

/**
 *  网址
 */
@property (strong, nonatomic) NSString* urlStr;
@end
