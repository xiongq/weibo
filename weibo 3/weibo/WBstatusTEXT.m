//
//  WBstatusTEXT.m
//  weibo
//
//  Created by xiong on 15/10/14.
//  Copyright © 2015年 x. All rights reserved.
//

#import "WBstatusTEXT.h"
#import "WBspecol.h"


#define coverTag 1000

@implementation WBstatusTEXT
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        self.editable = NO;
        self.scrollEnabled = NO;
    }
    return self;
}
//代码创建是这个
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {

        self.editable = NO;
        self.scrollEnabled = NO;
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
    }
    return self;

}
//找出特殊文字
-(void)specialsRects{
     NSArray *specal = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    for (WBspecol *model in specal) {
        //设置self.selectedRange 会影响self.selectedTextRange 变相设置
        self.selectedRange = model.range;
        //selectionRectsForRange 给选中文字range，返回文字矩形框rect 数组
        NSArray *selectRects = [self selectionRectsForRange:self.selectedTextRange];
        //设为0是为了取消手指离开后还是选中状态
        self.selectedRange = NSMakeRange(0, 0);
        //文字矩形框rect
        NSMutableArray *array = [NSMutableArray new];
        for (UITextSelectionRect *selectedRectt in selectRects) {
            CGRect rect = selectedRectt.rect;
            //跳过那些width = height = 0的rect无用
            if (rect.size.width == 0||rect.size.height == 0) continue;
            [array addObject:[NSValue valueWithCGRect:rect]];
        }
        model.rects = array;
    }
}
/**
 *  传入一个触摸位置
 *
 *  @param point 触摸位置
 *
 *  @return 判断是否点在属性文字，是就返回包装了一种nsvalue-rect的数组
 */
-(WBspecol *)touchSpecialWithPoint:(CGPoint)point{
    NSArray *specal = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
    for (WBspecol *model in specal) {
        for (NSValue *recrValue in model.rects) {
            if (CGRectContainsPoint(recrValue.CGRectValue, point)) {
                return model;
            }
        }
    
    }
    return nil;
}
/**
 *  点击事件
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    //手指触摸位置
    CGPoint point = [touch locationInView:self];

    [self specialsRects];
    
    WBspecol *special = [self touchSpecialWithPoint:point];
    for (NSValue *rectValue in special.rects) {
                UIView *cover = [UIView new];
                cover.frame = rectValue.CGRectValue;
                cover.backgroundColor = [UIColor grayColor];
                cover.tag = coverTag;
                cover.layer.cornerRadius = 5;
                //插入
                [self insertSubview:cover atIndex:0];
    }
    
    
}
/**
 *  强制中断，比喻电话
 */
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UIView *child in self.subviews) {
        if (child.tag == coverTag) {
            [child removeFromSuperview];
        }
    }
}
/**
 *  手指离开，就移除
 */
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}
/**
 告诉系统:触摸点point是否在这个UI控件身上
 */
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    [self specialsRects];
    
    WBspecol *model = [self touchSpecialWithPoint:point];
    if  (model) {
        return YES;
    }else{
        return NO;
    }
}
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    return [super hitTest:point withEvent:event];
//}

// 触摸事件的处理
// 1.判断触摸点在谁身上: 调用所有UI控件的- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
// 2.pointInside返回YES的控件就是触摸点所在的UI控件
// 3.由触摸点所在的UI控件选出处理事件的UI控件: 调用- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event




//bool值 遍历时一行显示不了，换行的特殊文子可能有多个view
//    BOOL contains = NO;
//    //取出特殊文字及range数组
//    NSArray *specal = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:NULL];
//
//    for (WBspecol *model in specal) {
//        //设置self.selectedRange 会影响self.selectedTextRange 变相设置
//        self.selectedRange = model.range;
//        //selectionRectsForRange 给选中文字range，返回文字矩形框rect 数组
//        NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
//        //设为0是为了取消手指离开后还是选中状态
//        self.selectedRange = NSMakeRange(0, 0);
//        //文字矩形框rect
//        for (UITextSelectionRect *selectedRectt in rects) {
//            CGRect rect = selectedRectt.rect;
//            //跳过那些width = height = 0的rect无用
//            if (rect.size.width == 0||rect.size.height == 0) continue;
//            //手指触摸点在文字矩形框范围内
//            if (CGRectContainsPoint(rect, point)) {
//                contains = YES; //标记
//                break;
//            }
//        }
//        //再次遍历标记
//        if (contains) {
@end
