//
//  E_ListView.h
//  WFReader
//
//  Created by 吴福虎 on 15/2/15.
//  Copyright (c) 2015年 tigerwf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol E_ListViewDelegate <NSObject>

- (void)clickChapter:(NSInteger)chaperIndex;
- (void)removeE_ListView;

@end

@interface E_ListView : UIView<UITableViewDataSource,UITableViewDelegate>
{
   
    UISegmentedControl *_segmentControl;
    NSInteger dataCount;
    CGFloat   _panStartX;

}
@property (nonatomic,assign)id<E_ListViewDelegate>delegate;

@property (nonatomic,strong)UITableView *listView;

@end
