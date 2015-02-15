//
//  SViewController.h
//  WFReader
//
//  Created by 吴福虎 on 15/2/13.
//  Copyright (c) 2015年 tigerwf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"

@interface S_ScrollViewController : UIViewController <SwipeViewDelegate, SwipeViewDataSource>

@property (nonatomic, strong)  SwipeView *swipeView;
@end
