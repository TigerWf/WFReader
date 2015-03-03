//
//  E_CommentViewController.m
//  WFReader
//
//  Created by 吴福虎 on 15/2/27.
//  Copyright (c) 2015年 tigerwf. All rights reserved.
//

#import "E_CommentViewController.h"

@interface E_CommentViewController ()

@end

@implementation E_CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    [titleLbl setText:@"评论页"];
    titleLbl.font = [UIFont systemFontOfSize:20];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLbl];

    
    UIButton *backBtn = [UIButton buttonWithType:0];
    backBtn.frame = CGRectMake(10, 20, 60, 44);
    [backBtn setTitle:@" 返回" forState:0];
    backBtn.backgroundColor = [UIColor clearColor];
    [backBtn setTitleColor:[UIColor blackColor] forState:0];
    [backBtn addTarget:self action:@selector(backToFront) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UIButton *clickBtn = [UIButton buttonWithType:0];
    clickBtn.frame = CGRectMake(0, 80, self.view.frame.size.width, 88);
    [clickBtn setTitle:@"涉及到富文本排版，参见https://github.com/TigerWf/WFCoretext" forState:0];
    clickBtn.titleLabel.numberOfLines = 2;
    clickBtn.backgroundColor = [UIColor clearColor];
    [clickBtn setTitleColor:[UIColor blackColor] forState:0];
    clickBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [clickBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn];

    
    
    
    
    // Do any additional setup after loading the view.
}


- (void)clickBtn{

    NSString  *urlText = [NSString stringWithFormat:@"https://github.com/TigerWf/WFCoretext"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlText]];
}



- (void)backToFront{
   
    [self dismissViewControllerAnimated:YES completion:NULL];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
