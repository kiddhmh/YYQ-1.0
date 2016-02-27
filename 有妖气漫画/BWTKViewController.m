//
//  BWTKViewController.m
//  ios_textView
//
//  Created by ma c on 16/1/27.
//  Copyright © 2016年 bjsxt. All rights reserved.
//

#import "BWTKViewController.h"

@interface BWTKViewController ()

@end

@implementation BWTKViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    _BWTKtextView.textAlignment = NSTextAlignmentCenter;
//    _BWTKtextView.text = @"爱看不看！        呵呵！           ！！！ ";
    _BWTKtextView.font = [UIFont systemFontOfSize:48];
    
    
    [self.view addSubview:_BWTKtextView];
    
    
    _BWTKlable.textAlignment = NSTextAlignmentCenter;
    _BWTKlable.font = [UIFont systemFontOfSize:20];
//    _BWTKlable.text = @"有妖气动漫";
    
    
    [self.view addSubview:_BWTKlable];
     








}











@end
