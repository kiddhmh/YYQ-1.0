//
//  AboutViewController.m
//  Ocean1
//
//  Created by ma c on 16/1/27.
//  Copyright (c) 2016年 bjsxt. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about.png"]];
    [self.imageView setFrame:self.view.frame];
    [self.view addSubview:self.imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
