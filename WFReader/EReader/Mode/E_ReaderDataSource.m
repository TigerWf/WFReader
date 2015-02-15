//
//  E_ReaderDataSource.m
//  E_Reader
//
//  Created by 阿虎 on 14-8-8.
//  Copyright (c) 2014年 tiger. All rights reserved.
//

#import "E_ReaderDataSource.h"
#import "E_CommonManager.h"

@implementation E_ReaderDataSource

+ (E_ReaderDataSource *)shareInstance
{
    static E_ReaderDataSource *dataSource;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        dataSource = [[E_ReaderDataSource alloc] init];
      
    });
    
    return dataSource;
}


- (E_EveryChapter *)openChapter:(NSInteger)clickChapter{

    _currentChapterIndex = clickChapter;
    
    E_EveryChapter *chapter = [[E_EveryChapter alloc] init];
    
    NSString *chapter_num = [NSString stringWithFormat:@"Chapter%ld",_currentChapterIndex];
    NSString *path1 = [[NSBundle mainBundle] pathForResource:chapter_num ofType:@"txt"];
    chapter.chapterContent = [NSString stringWithContentsOfFile:path1 encoding:4 error:NULL];
    
    return chapter;
}

- (E_EveryChapter *)openChapter
{
    NSUInteger index = [E_CommonManager Manager_getChapterBefore];
    
    _currentChapterIndex = index;
    
    E_EveryChapter *chapter = [[E_EveryChapter alloc] init];
    
    NSString *chapter_num = [NSString stringWithFormat:@"Chapter%ld",_currentChapterIndex];
    NSString *path1 = [[NSBundle mainBundle] pathForResource:chapter_num ofType:@"txt"];
    chapter.chapterContent = [NSString stringWithContentsOfFile:path1 encoding:4 error:NULL];
    
    return chapter;
}

- (NSUInteger)openPage{
    
    NSUInteger index = [E_CommonManager Manager_getPageBefore];
    return index;

}


- (E_EveryChapter *)nextChapter
{

    if (_currentChapterIndex >= _totalChapter) {
        
        return nil;
        
    }else{
        _currentChapterIndex++;
        
        E_EveryChapter *chapter = [E_EveryChapter new];
        chapter.chapterContent = readTextData(_currentChapterIndex);
        
        return chapter;
    
    }

}

- (E_EveryChapter *)preChapter
{
    if (_currentChapterIndex <= 1) {
        
        return nil;
        
    }else{
        _currentChapterIndex --;
        
        E_EveryChapter *chapter = [E_EveryChapter new];
        chapter.chapterContent = readTextData(_currentChapterIndex);
        
        return chapter;
    }
}


static NSString *readTextData(NSUInteger index)
{
    NSString *chapter_num = [NSString stringWithFormat:@"Chapter%ld",index];
    NSString *path1 = [[NSBundle mainBundle] pathForResource:chapter_num ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path1 encoding:4 error:NULL];
    return content;
}

@end
