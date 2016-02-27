//
//  SreachView.h
//  有妖气漫画——搜索
//
//  Created by ma c on 16/1/23.
//  Copyright © 2016年 zt. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Block)();
@interface SreachView : UIView

@property (strong, nonatomic) UICollectionView *VC_collectionView;
@property (nonatomic,copy) Block block;

- (void)passBlock:(Block)tempBlock;

@end
