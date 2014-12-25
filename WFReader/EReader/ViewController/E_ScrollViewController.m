//
//  E_ScrollViewController.m
//  E_Reader
//
//  Created by 阿虎 on 14-8-8.
//  Copyright (c) 2014年 tiger. All rights reserved.
//

#import "E_ScrollViewController.h"
#import "E_ReaderViewController.h"
#import "E_ReaderDataSource.h"
#import "E_EveryChapter.h"
#import "E_Paging.h"
#import "E_CommonManager.h"

@interface E_ScrollViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,E_ReaderViewControllerDelegate>
{
    UIPageViewController * _pageViewController;
    E_Paging             * _paginater;
    BOOL _isTurnOver;     //是否跨章；
    BOOL _isRight;       //翻页方向  yes为右 no为左
    BOOL _pageIsAnimating;          //某些特别操作会导致只调用datasource的代理方法 delegate的不调用
    
}
@property (copy, nonatomic) NSString* chapterTitle_;
@property (copy, nonatomic) NSString* chapterContent_;
@property (unsafe_unretained, nonatomic) int fontSize;
@property (unsafe_unretained, nonatomic) NSUInteger readOffset;
@end


@implementation E_ScrollViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置总章节数
    [E_ReaderDataSource shareInstance].totalChapter = 7;
    self.fontSize = [E_CommonManager fontSize];
    _pageIsAnimating = NO;
    
    // // // /// // /////////////////////////////////////
    
    
    E_EveryChapter *chapter = [[E_ReaderDataSource shareInstance] openChapter];
    [self parseChapter:chapter];
    [self initPageView];
}

- (void)initPageView
{
    _pageViewController = [[UIPageViewController alloc] init];
    
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    
    [self showPage:0];
}


- (void)parseChapter:(E_EveryChapter *)chapter
{
    self.chapterContent_ = chapter.chapterContent;
    self.chapterTitle_ = chapter.chapterTitle;
    [self configPaginater];
}


- (void)configPaginater
{
    _paginater = [[E_Paging alloc] init];
    E_ReaderViewController *temp = [[E_ReaderViewController alloc] init];
    temp.delegate = self;
    [temp view];
    _paginater.contentFont = self.fontSize;
    _paginater.textRenderSize = [temp readerTextSize];
    _paginater.contentText = self.chapterContent_;
    [_paginater paginate];
}

- (void)readPositionRecord
{
    int currentPage = [_pageViewController.viewControllers.lastObject currentPage];
    NSRange range = [_paginater rangeOfPage:currentPage];
    self.readOffset = range.location;
}

- (void)fontSizeChanged:(int)fontSize
{
    [self readPositionRecord];
    self.fontSize = fontSize;
    _paginater.contentFont = self.fontSize;
    [_paginater paginate];
    int showPage = [self findOffsetInNewPage:self.readOffset];
    [self showPage:showPage];
    
}

- (void)goBack
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (NSUInteger)findOffsetInNewPage:(NSUInteger)offset
{
    int pageCount = _paginater.pageCount;
    for (int i = 0; i < pageCount; i++) {
        NSRange range = [_paginater rangeOfPage:i];
        if (range.location <= offset && range.location + range.length > offset) {
            return i;
        }
    }
    return 0;
}

//显示第几页
- (void)showPage:(NSUInteger)page
{
    E_ReaderViewController *readerController = [self readerControllerWithPage:page];
    [_pageViewController setViewControllers:@[readerController]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:^(BOOL f){
                                     
                                 }];
}


- (E_ReaderViewController *)readerControllerWithPage:(NSUInteger)page
{
    E_ReaderViewController *textController = [[E_ReaderViewController alloc] init];
    textController.delegate = self;
    textController.view.backgroundColor = [UIColor whiteColor];
    [textController view];
    textController.currentPage = page;
    textController.totalPage = _paginater.pageCount;
    textController.chapterTitle = self.chapterTitle_;
    textController.font = self.fontSize;
    textController.text = [_paginater stringOfPage:page];
    return textController;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIPageViewDataSource And UIPageViewDelegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    _isTurnOver = NO;
    _isRight = NO;
    
    
    E_ReaderViewController *reader = (E_ReaderViewController *)viewController;
    NSUInteger currentPage = reader.currentPage;
    
    if (_pageIsAnimating && currentPage <= 0) {
        
        E_EveryChapter *chapter = [[E_ReaderDataSource shareInstance] nextChapter];
        [self parseChapter:chapter];
        
    }
    
    if (currentPage <= 0) {
        
        _isTurnOver = YES;
        E_EveryChapter *chapter = [[E_ReaderDataSource shareInstance] preChapter];
        if (chapter == nil || chapter.chapterContent == nil || [chapter.chapterContent isEqualToString:@""]) {
            _pageIsAnimating = NO;
            return  nil;
        }
        [self parseChapter:chapter];
        currentPage = self.lastPage + 1;
    }
    
    
    _pageIsAnimating = YES;
    
    E_ReaderViewController *textController = [self readerControllerWithPage:currentPage - 1];
    return textController;
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    
    _isTurnOver = NO;
    _isRight = YES;
    
    E_ReaderViewController *reader = (E_ReaderViewController *)viewController;
    NSUInteger currentPage = reader.currentPage;
    
    
    if (_pageIsAnimating && currentPage <= 0) {
        E_EveryChapter *chapter = [[E_ReaderDataSource shareInstance] nextChapter];
        [self parseChapter:chapter];
        
    }
    
    
    if (currentPage >= self.lastPage) {
        
        _isTurnOver = YES;
        E_EveryChapter *chapter = [[E_ReaderDataSource shareInstance] nextChapter];
        if (chapter == nil || chapter.chapterContent == nil || [chapter.chapterContent isEqualToString:@""]) {
            _pageIsAnimating = NO;
            return nil;
        }
        [self parseChapter:chapter];
        currentPage = -1;
    }
    
    _pageIsAnimating = YES;
    
    E_ReaderViewController *textController = [self readerControllerWithPage:currentPage + 1];
    return textController;
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    _pageIsAnimating = NO;
    
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
    if (completed) {
        //翻页完成
        
        
    }else{ //翻页未完成 又回来了。
        if (_isTurnOver && !_isRight) {//往右翻 且正好跨章节
            
            E_EveryChapter *chapter = [[E_ReaderDataSource shareInstance] nextChapter];
            [self parseChapter:chapter];
            
        }else if(_isTurnOver && _isRight){//往左翻 且正好跨章节
            
            E_EveryChapter *chapter = [[E_ReaderDataSource shareInstance] preChapter];
            [self parseChapter:chapter];
            
        }
        
        
    }
}

- (NSUInteger)lastPage
{
    return _paginater.pageCount - 1;
}



@end
