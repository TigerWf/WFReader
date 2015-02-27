//
//  E_CommonManager.h
//  E_Reader
//
//  Created by 阿虎 on 14-8-8.
//  Copyright (c) 2014年 tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "E_ContantFile.h"
/**
 *  公共管理类
 */


@interface E_CommonManager : NSObject


/**
 *  保存页码
 *
 *  @param currentChapter 现页码
 */
+ (void)saveCurrentPage:(NSInteger)currentPage;



/**
 *  获得之前看的页码
 *
 *  @return 页码数
 */
+ (NSUInteger)Manager_getPageBefore;

/**
 *  保存章节
 *
 *  @param currentChapter 现章节
 */
+ (void)saveCurrentChapter:(NSInteger)currentChapter;

/**
 *  获得主题背景
 *
 *  @return 主题背景id
 */
+ (NSInteger)Manager_getReadTheme;


/**
 *  保存主题ID
 *
 *  @param currentThemeID 主题ID
 */
+ (void)saveCurrentThemeID:(NSInteger)currentThemeID;

/**
 *  获得之前看的章节
 *
 *  @return 章节数
 */
+ (NSUInteger)Manager_getChapterBefore;

/**
 *  获得字号
 *
 *  @return 字号大小
 */
+ (NSUInteger)fontSize;


/**
 *  存储字号
 *
 *  @param fontSize 存储的字号大小
 */
+ (void)saveFontSize:(NSUInteger)fontSize;

@end
