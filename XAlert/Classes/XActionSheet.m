//
//  XActionSheet.m
//  Demo2
//
//  Created by xlx on 15/7/29.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import "XActionSheet.h"

@interface XActionSheet ()
{
    CGFloat width;
    CGFloat height;
    UIView *titleView;
    UIView *bottom;
    UIView *allBottom;
    UIView *layView;
    BOOL InAnimate;
}
@end

@implementation XActionSheet

- (id)initWithTitleAndDesc:(NSString *)Title Desc:(NSString *)Desc{
    self = [self init];
    _Title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width*0.9, 15)];
    _Title.font = [UIFont systemFontOfSize:14];
    [_Title setAdjustsFontSizeToFitWidth:true];
    _Title.textColor = titleTextColor;
    _Title.textAlignment = NSTextAlignmentCenter;
    _Title.text = Title;
    
    _Desc = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, width*0.9, 15)];
    [_Desc setAdjustsFontSizeToFitWidth:true];
    _Desc.font = [UIFont systemFontOfSize:12];
    _Desc.textColor = titleTextColor;
    _Desc.textAlignment = NSTextAlignmentCenter;
    _Desc.text = Desc;
    
    titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width * 0.9, 49.5)];
    titleView.backgroundColor = greenColor;
    
    //无title 有desc
    if ( (Title == nil || [Title isEqualToString:@""]) && (Desc != nil && ![Desc isEqualToString:@""]) ) {
        _Desc.frame = CGRectMake(0, 17, width*0.9, 15);
        [titleView addSubview:_Desc];
    }
    //无desc 有title
    else if( (Title != nil && ![Title isEqualToString:@""]) && (Desc == nil || [Desc isEqualToString:@""]) ) {
        _Title.frame = CGRectMake(0, 17, width*0.9, 15);
        [titleView addSubview:_Title];
    }
    //有desc 有title
    else if ( (Title != nil && ![Title isEqualToString:@""]) && (Desc != nil && ![Desc isEqualToString:@""]) ) {
        
        [titleView addSubview:_Title];
        [titleView addSubview:_Desc];
    }
    //无desc 无title
    else {
        titleView.frame = CGRectMake(0, 0, width * 0.9, 10);
    }
    
    return self;
}
- (id)init{
    self = [super init];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _btnArray                   = [[NSMutableArray alloc]init];
    width                       = [UIScreen mainScreen].bounds.size.width;
    height                      = [UIScreen mainScreen].bounds.size.height;
    _delegate = nil;
    InAnimate = NO;
    return self;
}

/**
 *  设置取消按钮的背景颜色
 *
 *  @param color 颜色值
 */
- (void)setCancelButtonBackgroundColor:(UIColor *)color
{
    if (color) {
        _CancelButton.backgroundColor = color;
    }
}

/**
 *  设置某个按钮的背景颜色
 *
 *  @param index 按钮的index
 *  @param color 颜色
 */
- (void)setButton:(NSUInteger) index backgroundColor:(UIColor *)color
{
    if (index > _btnArray.count) {
        return ;
    }
    
    if (color) {
        _btnArray[index].backgroundColor = color;
    }
}

/**
 *  设置所有按钮的背景颜色
 *
 *  @param color 颜色
 */
- (void)setAllButtonsBackgroundColor:(UIColor *)color
{
    if (color == nil) {
        return ;
    }
    
    for (UIButton *bt in _btnArray) {
        bt.backgroundColor = color;
    }
}

/**
 *  设置标题背景颜色
 *
 *  @param color 颜色
 */
- (void)setTitleBackgroundColor:(UIColor *)color
{
    if (color) {
        titleView.backgroundColor = color;
    }
}



/**
 *  添加取消按钮
 */
-(void)addCancelButtonWithTitle:(NSString *)Title{
    _CancelButton = [[UIButton alloc]init];
    [_CancelButton setTitle:Title forState:normal];
    _CancelButton.layer.cornerRadius = 5;
    _CancelButton.layer.masksToBounds = true;
    _CancelButton.backgroundColor = brownColor;
    [_CancelButton setTitleColor:buttonTextColor forState:0];
    [_CancelButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
}
/**
 *  添加按钮
 */
-(void)addButtonwithTitle:(NSString *)Title{
    
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = _btnArray.count;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = greenColor;
    [btn setTitle:Title forState:normal];
    [btn setTitleColor:buttonTextColor forState:0];
    [_btnArray addObject:btn];
}
/**
 *  按钮点击动作
 */
- (void)buttonClick:(id)sender{

    UIButton *btn = (UIButton *)sender;
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:buttonClick:)]) {
        [_delegate actionSheet:self buttonClick:btn.tag];
    }
    
    [self close];
}


/**
 *  展示动画
 */
- (void)show{
    CGFloat bottomHeight = 0;
    if (titleView) {
        bottomHeight += 50;
    }
    
    bottomHeight += 40*(_btnArray.count-1) + titleView.frame.size.height;
    
    bottom = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width*0.9, bottomHeight)];
    bottom.layer.cornerRadius = 5;
    bottom.layer.masksToBounds = true;
    
    if (_CancelButton) {
        bottomHeight += 56;
    }
    
    allBottom = [[UIView alloc]initWithFrame:CGRectMake(width*0.05, height, width*0.9, bottomHeight)];
    
    
    
    CGFloat btnY = 0;
    if (titleView) {
        [bottom addSubview:titleView];
        btnY += titleView.frame.size.height;
        
        //如果titleView中有内容
        if (titleView.subviews.count > 0) {
            btnY += 1;
        }
    }
    for (UIButton *btn in _btnArray) {
        CGRect rect = CGRectMake(0, btnY, width * 0.9, 39.5);
        btn.frame = rect;
        [bottom addSubview:btn];
        btnY += 40;
    }
    
    [allBottom addSubview:bottom];
    
    if (_CancelButton) {
        btnY += 8;
        CGRect rect = CGRectMake(0, btnY, width * 0.9, 39.5);
        _CancelButton.frame = rect;
        [allBottom addSubview:_CancelButton];
    }
    
   
    [self addTheLayer];
    [self addSubview:allBottom];
    
    [UIView animateWithDuration:0.2 animations:^{
        allBottom.frame = CGRectMake(width*0.05, height - bottomHeight, width*0.9, bottomHeight);
    }];
}
- (void)showInAnimate{
    
    [self addTheLayer];
    InAnimate = YES;
    
    NSMutableArray *viewArray = [[NSMutableArray alloc]init];
    if (titleView) {
        [viewArray addObject:titleView];
    }
    [viewArray addObjectsFromArray:_btnArray];
    [self cornerRadiu:viewArray.firstObject];
    
    
    CGFloat btnY = height - 8 - 40;
    /**
     *  i是一个标记位  1 表示从左边进入 0 表示从右边进入
     */
    CGFloat i = 1;
    if (_CancelButton) {
        CGFloat x;
        if (i) {
            x = -width*0.9;
            i = 0;
        }else{
            x = width;
            i = 1;
        }
        CGRect rect = CGRectMake(x, btnY, width*0.9, 40);
        _CancelButton.frame = rect;
        [self addSubview:_CancelButton];
        btnY -= 48;
    }
    btnY += 40;
    for (int j = (int)viewArray.count - 1; j >= 0; j--) {
        UIView *btn = (UIView *)viewArray[j];
        CGFloat x;
        if (i) {
            x = -width*0.9;
            i = 0;
        }else{
            x = width;
            i = 1;
        }
        if (j==0 && titleView) {
            btnY -= titleView.frame.size.height;
            CGRect rect = CGRectMake(x, btnY, width*0.9, titleView.frame.size.height);
            btn.frame = rect;
        }else{
            btnY -= 40;
            CGRect rect = CGRectMake(x, btnY, width*0.9, 39.5);
            btn.frame = rect;
        }
        if (j == 1) {
            
            //如果titleView中有内容
            if (titleView.subviews.count > 0) {
                btnY -= 3; //当为倒数第二个时  也就是接下来是第一个title Y往上多移10
            }
        }
        [self addSubview:btn];
    }
    
    
    __block double delay = 0;
    double duration = 0.1 * viewArray.count + 0.1;
    if (_CancelButton) {
        duration += 0.2;
    }
    
   [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionOverrideInheritedOptions animations:^{
       for (UIView *view in viewArray) {
           [UIView addKeyframeWithRelativeStartTime:delay relativeDuration:0.3 animations:^{
               CGRect rect = view.frame;
               rect.origin.x = width * 0.05;
               view.frame = rect;
           }];
           delay = delay + 0.2;
       }
       if (_CancelButton) {
           [UIView addKeyframeWithRelativeStartTime:delay relativeDuration:0.2 animations:^{
               CGRect rect = _CancelButton.frame;
               rect.origin.x = width * 0.05;
               _CancelButton.frame = rect;
           }];
           delay = delay + 0.2;
       }
       
   } completion:^(BOOL finished) {
       
   }];
    
    
    
}
-(void)addTheLayer{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    layView = [[UIView alloc]initWithFrame:self.frame];
    layView.backgroundColor = layerColor;
    layView.alpha = 0;
    [self addSubview:layView];
    [UIView animateWithDuration:0.2 animations:^{
        layView.alpha = 0.2;
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    [layView addGestureRecognizer:tap];
    
}
/**
 *  退出动画
 */
-(void)close{
    if (InAnimate) {
        [self closeInAnimate];
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = allBottom.frame;
        rect.origin.y = height;
        allBottom.frame = rect;
        layView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)closeInAnimate{

   
    
    NSMutableArray *viewArray = [[NSMutableArray alloc]init];
    if (titleView) {
        [viewArray addObject:titleView];
    }
    [viewArray addObjectsFromArray:_btnArray];
    if (_CancelButton) {
        [viewArray addObject:_CancelButton];
    }
    
    /**
     *  i是一个标记位  1 表示从左边出去 0 表示从右边出去
     */
    __block CGFloat i = 1;
    
    __block double delay = 0;
    double duration = 0.1 * viewArray.count + 0.1;
    if (_CancelButton) {
        duration += 0.1;
    }
    
    [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionOverrideInheritedOptions animations:^{
        for (UIView *view in viewArray) {
            __block CGRect rect = view.frame;
            if (i) {
                rect.origin.x = -width*0.9;
                i = 0;
            }else{
                rect.origin.x = width;
                i = 1;
            }
            [UIView addKeyframeWithRelativeStartTime:delay relativeDuration:0.2 animations:^{
                view.frame = rect;
            }];
            delay = delay + 0.2;
        }
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        layView.alpha = 0;
    }];

}
/**
 *  画上面两个圆角
 */
- (void)cornerRadiu:(UIView *)view{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
@end










