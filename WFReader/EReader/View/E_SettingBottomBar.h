//
//  E_SettingBottomBar.h
//  WFReader
//
//  Created by 吴福虎 on 15/2/13.
//  Copyright (c) 2015年 tigerwf. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  底部设置条
 */
@protocol E_SettingBottomBarDelegate <NSObject>

- (void)shutOffPageViewControllerGesture:(BOOL)yesOrNo;
- (void)fontSizeChanged:(int)fontSize;//改变字号
- (void)callDrawerView;
- (void)turnToNextChapter;
- (void)turnToPreChapter;


@end


@interface E_SettingBottomBar : UIView

@property (nonatomic,strong) UIButton *smallFont;
@property (nonatomic,strong) UIButton *bigFont;
@property(nonatomic,assign)id<E_SettingBottomBarDelegate>delegate;


- (void)showToolBar;

- (void)hideToolBar;

@end
