//
//  E_ReaderDataSource.h
//  E_Reader
//
//  Created by 阿虎 on 14-8-8.
//  Copyright (c) 2014年 tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "E_EveryChapter.h"
/**
 *  书籍内容来源部分   退出的时候页码存储未写，根据实际情况去存
 */
@interface E_ReaderDataSource : NSObject

//当前章节数
@property (unsafe_unretained, nonatomic) NSUInteger currentChapterIndex;

//总章节数
@property (unsafe_unretained, nonatomic) NSUInteger totalChapter;

/**
 *  单例
 *
 *  @return 实例
 */
+ (E_ReaderDataSource *)shareInstance;


/**
 *  通过传入id来获取章节信息
 *
 *  @return 章节类
 */
- (E_EveryChapter *)openChapter;



/**
 *  获得下一章内容
 *
 *  @return 章节类
 */
- (E_EveryChapter *)nextChapter;


/**
 *  获得上一章内容
 *
 *  @return 章节类
 */
- (E_EveryChapter *)preChapter;

@end
