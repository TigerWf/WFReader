//
//  E_ReaderViewController.h
//  E_Reader
//
//  Created by 阿虎 on 14-8-8.
//  Copyright (c) 2014年 tiger. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  显示阅读内容
 */

@protocol E_ReaderViewControllerDelegate <NSObject>

- (void)fontSizeChanged:(int)fontSize;//改变字号
- (void)goBack;//退出

@end


@interface E_ReaderViewController : UIViewController

@property (nonatomic,assign) id<E_ReaderViewControllerDelegate>delegate;
@property (nonatomic,unsafe_unretained) NSUInteger currentPage;
@property (nonatomic,unsafe_unretained) NSUInteger totalPage;
@property (nonatomic,strong)            NSString   *text;
@property (nonatomic,unsafe_unretained) NSUInteger  font;
@property (nonatomic, copy)             NSString   *chapterTitle;
@property (nonatomic, unsafe_unretained,readonly) CGSize readerTextSize;

- (CGSize)readerTextSize;

@end

