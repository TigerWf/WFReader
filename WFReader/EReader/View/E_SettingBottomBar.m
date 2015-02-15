//
//  E_SettingBottomBar.m
//  WFReader
//
//  Created by 吴福虎 on 15/2/13.
//  Copyright (c) 2015年 tigerwf. All rights reserved.
//

#import "E_SettingBottomBar.h"
#import "E_ContantFile.h"
#import "E_CommonManager.h"
#import "ILSlider.h"


#define MAX_FONT_SIZE 27
#define MIN_FONT_SIZE 17

@implementation E_SettingBottomBar
{
    ILSlider *ilSlider;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:59/255.0 green:59/255.0 blue:59/255.0 alpha:1.0];
        [self configUI];
    }
    return self;
    
}


- (void)configUI{

    UIButton *menuBtn = [UIButton buttonWithType:0];
    [menuBtn setImage:[UIImage imageNamed:@"reader_cover.png"] forState:0];
    [menuBtn addTarget:self action:@selector(showDrawerView) forControlEvents:UIControlEventTouchUpInside];
    menuBtn.frame = CGRectMake(10, self.frame.size.height - 54, 60, 44);
    [self addSubview:menuBtn];
    
    UIButton *commentBtn = [UIButton buttonWithType:0];
    [commentBtn setImage:[UIImage imageNamed:@"reader_comments.png"] forState:0];
    commentBtn.frame = CGRectMake(self.frame.size.width - 70, self.frame.size.height - 54, 60, 44);
    [self addSubview:commentBtn];
    
    _bigFont = [UIButton buttonWithType:0];
    _bigFont.frame = CGRectMake(110 + (self.frame.size.width - 200)/2, self.frame.size.height - 54, (self.frame.size.width - 200)/2, 44);
    [_bigFont setImage:[UIImage imageNamed:@"reader_font_increase.png"] forState:0];
    _bigFont.backgroundColor = [UIColor clearColor];
   
    [_bigFont addTarget:self action:@selector(changeBig) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_bigFont];
    
    _smallFont = [UIButton buttonWithType:0];
   
    [_smallFont setImage:[UIImage imageNamed:@"reader_font_decrease.png"] forState:0];
    [_smallFont addTarget:self action:@selector(changeSmall) forControlEvents:UIControlEventTouchUpInside];
    _smallFont.frame =  CGRectMake(90, self.frame.size.height - 54, (self.frame.size.width - 200)/2, 44);
    [self addSubview:_smallFont];
    

    ilSlider = [[ILSlider alloc] initWithFrame:CGRectMake(50, self.frame.size.height - 54 - 40 , self.frame.size.width - 100, 40) direction:ILSliderDirectionHorizonal];
    ilSlider.maxValue = 3;
    ilSlider.minValue = 1;
    
    [ilSlider sliderChangeBlock:^(CGFloat value) {
        NSLog(@"value == %f",value);
    }];
    [ilSlider sliderTouchEndBlock:^(CGFloat value) {
         NSLog(@"value == %f",value);
    }];

    [self addSubview:ilSlider];
    
    UIButton *preChapterBtn = [UIButton buttonWithType:0];
    preChapterBtn.frame = CGRectMake(5, self.frame.size.height - 54 - 40, 40, 40);
    preChapterBtn.backgroundColor = [UIColor clearColor];
    [preChapterBtn setTitle:@"上一章" forState:0];
    [preChapterBtn addTarget:self action:@selector(goToPreChapter) forControlEvents:UIControlEventTouchUpInside];
    preChapterBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [preChapterBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self addSubview:preChapterBtn];
    
    UIButton *nextChapterBtn = [UIButton buttonWithType:0];
    nextChapterBtn.frame = CGRectMake(self.frame.size.width - 45, self.frame.size.height - 54 - 40, 40, 40);
    nextChapterBtn.backgroundColor = [UIColor clearColor];
    [nextChapterBtn setTitle:@"下一章" forState:0];
    [nextChapterBtn addTarget:self action:@selector(goToNextChapter) forControlEvents:UIControlEventTouchUpInside];
    nextChapterBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [nextChapterBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self addSubview:nextChapterBtn];
}


- (void)goToNextChapter{
    
    [_delegate turnToNextChapter];
    
}

- (void)goToPreChapter{
    
    [_delegate turnToPreChapter];

}

#pragma mark - 小
- (void)changeSmall
{
    NSUInteger fontSize = [E_CommonManager fontSize];
    if (fontSize <= MIN_FONT_SIZE) {
        return;
    }
    fontSize--;
    [E_CommonManager saveFontSize:fontSize];
    [self updateFontButtons];
    [_delegate fontSizeChanged:(int)fontSize];
    [_delegate shutOffPageViewControllerGesture:NO];
}

- (void)changeBig
{
    NSUInteger fontSize = [E_CommonManager fontSize];
    if (fontSize >= MAX_FONT_SIZE) {
        return;
    }
    fontSize++;
    [E_CommonManager saveFontSize:fontSize];
    [self updateFontButtons];
    [_delegate fontSizeChanged:(int)fontSize];
    [_delegate shutOffPageViewControllerGesture:NO];
    
}


- (void)updateFontButtons
{
    NSUInteger fontSize = [E_CommonManager fontSize];
    _bigFont.enabled = fontSize < MAX_FONT_SIZE;
    _smallFont.enabled = fontSize > MIN_FONT_SIZE;
}

- (void)showDrawerView{
   
    [_delegate callDrawerView];

}


- (void)showToolBar{
    
    CGRect newFrame = self.frame;
    newFrame.origin.y -= kBottomBarH;
    [UIView animateWithDuration:0.18 animations:^{
        self.frame = newFrame;
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void)hideToolBar{
    
    CGRect newFrame = self.frame;
    newFrame.origin.y += kBottomBarH;
    [UIView animateWithDuration:0.18 animations:^{
        self.frame = newFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
