//
//  E_ReaderView.h
//  E_Reader
//
//  Created by 阿虎 on 14-8-8.
//  Copyright (c) 2014年 tiger. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface E_ReaderView : UIView

@property(unsafe_unretained, nonatomic)NSUInteger font;
@property(copy, nonatomic)NSString *text;

- (void)render;

@end
