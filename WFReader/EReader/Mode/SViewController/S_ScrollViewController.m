//
//  SViewController.m
//  WFReader
//
//  Created by 吴福虎 on 15/2/13.
//  Copyright (c) 2015年 tigerwf. All rights reserved.
//

#import "S_ScrollViewController.h"

@interface S_ScrollViewController ()
@property (nonatomic, strong) NSMutableArray *colors;
@end

@implementation S_ScrollViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.colors = [NSMutableArray array];
    
    
    _swipeView = [[SwipeView alloc] initWithFrame:self.view.bounds];
    _swipeView.alignment = SwipeViewAlignmentCenter;
    _swipeView.pagingEnabled = YES;
    _swipeView.wrapEnabled = NO;
    _swipeView.truncateFinalPage = YES;
    _swipeView.delegate = self;
    _swipeView.dataSource = self;
    
    [self.view addSubview:_swipeView];
    
     [self reload];
    [_swipeView scrollToItemAtIndex:0 duration:0.0];
    
   
    // Do any additional setup after loading the view.
}

- (void)reload
{
   
    
    for (int i = 0; i < 3; i++)
    {
        [self.colors addObject:[UIColor colorWithRed:drand48()
                                               green:drand48()
                                                blue:drand48()
                                               alpha:1.0f]];
    }
    
    
    [_swipeView reloadData];
}


- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return [self.colors count];
}

- (void)swipeViewWillBeginDragging:(SwipeView *)swipeView{
    
   
    if (swipeView.currentPage == self.colors.count - 1) {
        [self reload];
    }
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = (UILabel *)view;
    
    //create or reuse view
    if (view == nil)
    {
        label = [[UILabel alloc] initWithFrame:self.view.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        view = label;
    }
    
    //configure view
    label.backgroundColor = (self.colors)[index];
    label.text = [NSString stringWithFormat:@"%i", index];
    
    //return view
    return view;
}



@end
