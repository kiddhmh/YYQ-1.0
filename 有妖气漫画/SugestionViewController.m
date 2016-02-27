//
//  SugestionViewController.m
//  Ocean1
//
//  Created by ma c on 16/1/27.
//  Copyright (c) 2016年 bjsxt. All rights reserved.
//

#import "SugestionViewController.h"

@interface SugestionViewController ()

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation SugestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"suggestion.png"]];
    [self.imageView setFrame:self.view.frame];
    [self.view addSubview:self.imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
