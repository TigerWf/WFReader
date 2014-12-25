//
//  E_ReaderView.m
//  E_Reader
//
//  Created by 阿虎 on 14-8-8.
//  Copyright (c) 2014年 tiger. All rights reserved.
//

#import "E_ReaderView.h"
#import <CoreText/CoreText.h>


@implementation E_ReaderView
{
    CTFrameRef _ctFrame;
}

- (void)dealloc
{
    if (_ctFrame != NULL) {
        CFRelease(_ctFrame);
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}


#pragma mark - 绘制相关方法

- (void)drawRect:(CGRect)rect
{
    if (!_ctFrame) return;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    CGAffineTransform transform = CGAffineTransformMake(1,0,0,-1,0,self.bounds.size.height);
    CGContextConcatCTM(context, transform);
    CTFrameDraw(_ctFrame, context);
}

- (NSDictionary *)coreTextAttributes
{
    UIFont *font_ = [UIFont systemFontOfSize:self.font];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = font_.pointSize / 2;
    paragraphStyle.alignment = NSTextAlignmentJustified;
    
    NSDictionary *dic = @{NSParagraphStyleAttributeName: paragraphStyle, NSFontAttributeName:font_};
    return dic;
}


- (void)render
{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString  alloc] initWithString:self.text];
    [attrString setAttributes:self.coreTextAttributes range:NSMakeRange(0, attrString.length)];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef) attrString);
    CGPathRef path = CGPathCreateWithRect(self.bounds, NULL);
    if (_ctFrame != NULL) {
        CFRelease(_ctFrame), _ctFrame = NULL;
    }
    _ctFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    CFRelease(frameSetter);
}

- (CTFrameRef)getCTFrame
{
    return _ctFrame;
}




@end
