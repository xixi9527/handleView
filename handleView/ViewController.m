//
//  ViewController.m
//  handleView
//
//  Created by Hellen Yang on 2017/8/29.
//  Copyright © 2017年 yjl. All rights reserved.
//

#import "ViewController.h"
#import "HandleView.h"

@interface ViewController ()<HandleDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    HandleView *view = [[HandleView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor clearColor];
    view.center = self.view.center;
    [self.view addSubview:view];
    view.delegate = self;
}

- (void)returnPosition:(int)num
{
    NSLog(@"%d",num);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
