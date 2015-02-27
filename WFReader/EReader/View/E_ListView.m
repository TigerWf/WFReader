//
//  E_ListView.m
//  WFReader
//
//  Created by 吴福虎 on 15/2/15.
//  Copyright (c) 2015年 tigerwf. All rights reserved.
//

#import "E_ListView.h"
#import "E_ReaderDataSource.h"


@implementation E_ListView

- (id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:234/255.0 alpha:1.0];
        dataCount = [E_ReaderDataSource shareInstance].totalChapter;
        [self configListView];
        
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panEListView:)];
        [self addGestureRecognizer:panGes];
        
    }
    return self;
}

- (void)panEListView:(UIPanGestureRecognizer *)recongnizer{
    CGPoint touchPoint = [recongnizer locationInView:self];
    switch (recongnizer.state) {
        case UIGestureRecognizerStateBegan:{
            _panStartX = touchPoint.x;
           }
            break;
            
        case UIGestureRecognizerStateChanged:{
            CGFloat offSetX = touchPoint.x - _panStartX;
            CGRect newFrame = self.frame;
            //NSLog(@"offSetX == %f",offSetX);
            newFrame.origin.x += offSetX;
            if (newFrame.origin.x >= 0){//试图向上滑动 阻止
               
                newFrame.origin.x = 0;
                self.frame = newFrame;
                return;
            }else{
                self.frame = newFrame;
            }
            
        
        }
            
            break;
            
        case UIGestureRecognizerStateEnded:{
            
            float duringTime = (self.frame.size.width + self.frame.origin.x)/self.frame.size.width * 0.25;
            if (self.frame.origin.x < 0) {
                [UIView animateWithDuration:duringTime animations:^{
                    self.frame = CGRectMake(-self.frame.size.width , 0,  self.frame.size.width, self.frame.size.height);
                } completion:^(BOOL finished) {
                    [_delegate removeE_ListView];
                }];
                
            }
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
            
            break;
            
        default:
            break;
    }


}



- (void)configListView{
    
    [self configListViewHeader];
   
    _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 80, self.frame.size.width, self.frame.size.height - 80 - 60)];
    _listView.delegate = self;
    _listView.dataSource = self;
    _listView.backgroundColor = [UIColor clearColor];
    [self addSubview:_listView];
    
    UIButton *otherBtn = [UIButton buttonWithType:0];
    otherBtn.frame = CGRectMake(70, self.frame.size.height - 40, self.frame.size.width - 140, 20);
    otherBtn.layer.borderWidth = 1.0;
    otherBtn.layer.cornerRadius = 2.0;
    otherBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [otherBtn setTitleColor:[UIColor colorWithRed:233/255.0 green:64/255.0 blue:64/255.0 alpha:1.0] forState:0];
    [otherBtn setTitle:@"备用按钮" forState:0];
    otherBtn.layer.borderColor = [UIColor colorWithRed:233/255.0 green:64/255.0 blue:64/255.0 alpha:1.0].CGColor;
    [self addSubview:otherBtn];
    
}

- (void)configListViewHeader{

    NSArray *segmentedArray = @[@"目录",@"书签",@"笔记"];
    _segmentControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    _segmentControl.frame = CGRectMake(15, 30, self.bounds.size.width - 30 , 40);
    _segmentControl.selectedSegmentIndex = 0;
    _segmentControl.tintColor = [UIColor colorWithRed:233/255.0 green:64/255.0 blue:64/255.0 alpha:1.0];
    [self addSubview:_segmentControl];
    [_segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17] forKey:NSFontAttributeName];
    [_segmentControl setTitleTextAttributes:dict forState:0];



}

- (void)segmentAction:(UISegmentedControl *)sender{
    
    NSInteger index = sender.selectedSegmentIndex;
    switch (index) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            
            break;
            
        default:
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataCount;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_delegate clickChapter:indexPath.row];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStr = @"listCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld章",indexPath.row + 1];
    return cell;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
