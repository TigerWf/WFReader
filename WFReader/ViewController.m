//
//  ViewController.m
//  WFReader
//
//  Created by 阿虎 on 14/12/25.
//  Copyright (c) 2014年 tigerwf. All rights reserved.
//

#import "ViewController.h"
#import "E_ScrollViewController.h"
//#import "S_ScrollViewController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *pushBtn = [UIButton buttonWithType:0];
    pushBtn.frame = CGRectMake(40, 50, self.view.frame.size.width - 80, 100);
    [pushBtn setTitle:@"go to Reader" forState:0];
    pushBtn.backgroundColor = [UIColor cyanColor];
    [pushBtn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushBtn];
    
       // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)push{
    E_ScrollViewController *loginvctrl = [[E_ScrollViewController alloc] init];
    [self presentViewController:loginvctrl animated:NO completion:nil];

}
@end
