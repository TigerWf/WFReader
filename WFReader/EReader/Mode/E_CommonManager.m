//
//  E_CommonManager.m
//  E_Reader
//
//  Created by 阿虎 on 14-8-8.
//  Copyright (c) 2014年 tiger. All rights reserved.
//

#import "E_CommonManager.h"

@implementation E_CommonManager



+ (NSUInteger)Manager_getPageBefore{
    
    NSString *pageID = [[NSUserDefaults standardUserDefaults] objectForKey:SAVEPAGE];
    
    if (pageID == nil) {
        
        return 0;
        
    }else{
        
        return [pageID integerValue];
        
    }

}

+ (void)saveCurrentPage:(NSInteger)currentPage{
    
    [[NSUserDefaults standardUserDefaults] setValue:@(currentPage) forKey:SAVEPAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


+ (NSUInteger)Manager_getChapterBefore
{
    NSString *chapterID = [[NSUserDefaults standardUserDefaults] objectForKey:OPEN];
    
    if (chapterID == nil) {
        
        return 1;
        
    }else{
        
        return [chapterID integerValue];
    
    }

}

+ (void)saveCurrentChapter:(NSInteger)currentChapter{
   
    [[NSUserDefaults standardUserDefaults] setValue:@(currentChapter) forKey:OPEN];
    [[NSUserDefaults standardUserDefaults] synchronize];

}



+ (NSUInteger)fontSize
{
    NSUInteger fontSize = [[NSUserDefaults standardUserDefaults] integerForKey:FONT_SIZE];
    if (fontSize == 0) {
        fontSize = 20;
    }
    return fontSize;
}

+ (void)saveFontSize:(NSUInteger)fontSize
{
    [[NSUserDefaults standardUserDefaults] setValue:@(fontSize) forKey:FONT_SIZE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
