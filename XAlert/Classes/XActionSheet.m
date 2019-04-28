//
//  XActionSheet.m
//  Demo2
//
//  Created by xlx on 15/7/29.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import "XActionSheet.h"

@interface XActionSheetButton : UIButton

@property (nonatomic, strong) void(^handler)(void);

@end

@implementation XActionSheetButton



@end


@interface XActionSheet ()
{
    CGFloat width;
    CGFloat height;
    CGFloat bottomHeight;
    BOOL InAnimate;
}

@property (nonatomic, strong) UIView *bottom;
@property (nonatomic, strong) UIView *allBottom;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIView *layView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) NSMutableArray<UIButton *> *btnArray;



@end

@implementation XActionSheet

- (id)initWithTitleAndDesc:(NSString *)Title Desc:(NSString *)Desc{
    self = [self init];
    
    self.titleLabel.text = Title;
    self.descLabel.text = Desc;

   
    
    //无title 有desc
    if ( (Title == nil || [Title isEqualToString:@""]) && (Desc != nil && ![Desc isEqualToString:@""]) ) {
        self.descLabel.frame = CGRectMake(0, 17, width*0.9, 15);
        [self.titleView addSubview:self.descLabel];
    }
    //无desc 有title
    else if( (Title != nil && ![Title isEqualToString:@""]) && (Desc == nil || [Desc isEqualToString:@""]) ) {
        self.titleLabel.frame = CGRectMake(0, 17, width*0.9, 15);
        [self.titleView addSubview:self.titleLabel];
    }
    //有desc 有title
    else if ( (Title != nil && ![Title isEqualToString:@""]) && (Desc != nil && ![Desc isEqualToString:@""]) ) {
        
        [self.titleView addSubview:self.titleLabel];
        [self.titleView addSubview:self.descLabel];
    }
    //无desc 无title
    else {
        self.titleView.frame = CGRectMake(0, 0, width * 0.9, 10);
    }
    
    return self;
}
- (id)init{
    self = [super init];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    _btnArray                   = [[NSMutableArray alloc]init];
    width                       = [UIScreen mainScreen].bounds.size.width;
    height                      = [UIScreen mainScreen].bounds.size.height;
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
        self.cancelButton.backgroundColor = color;
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
        self.titleView.backgroundColor = color;
    }
}



/**
 *  添加取消按钮
 */
-(void)addCancelButtonWithTitle:(NSString *)Title{
    [self.cancelButton setTitle:Title forState:normal];

}
/**
 *  添加按钮
 */
-(void)addButtonwithTitle:(NSString *)Title handler:(void(^)(void))handler{
    
    XActionSheetButton *btn = [[XActionSheetButton alloc]init];
    btn.tag = _btnArray.count;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = greenColor;
    [btn setTitle:Title forState:normal];
    [btn setTitleColor:buttonTextColor forState:0];
    [_btnArray addObject:btn];
    btn.handler = handler;
}
/**
 *  按钮点击动作
 */
- (void)buttonClick:(id)sender{

    XActionSheetButton *btn = (XActionSheetButton *)sender;
    if (btn.handler) {
        btn.handler();
    }
    [self close];
}


/**
 *  展示动画
 */
- (void)show{
    if (self.titleView) {
        bottomHeight += 50;
    }
    
    bottomHeight += 40*(_btnArray.count-1) + self.titleView.frame.size.height;
   
    
    if (self.cancelButton) {
        bottomHeight += 56;
    }
    
    
    
    
    CGFloat btnY = 0;
    if (self.titleView) {
        [self.bottom addSubview:self.titleView];
        btnY += self.titleView.frame.size.height;
        
        //如果titleView中有内容
        if (self.titleView.subviews.count > 0) {
            btnY += 1;
        }
    }
    for (UIButton *btn in _btnArray) {
        CGRect rect = CGRectMake(0, btnY, width * 0.9, 39.5);
        btn.frame = rect;
        [self.bottom addSubview:btn];
        btnY += 40;
    }
    
    [self.allBottom addSubview:self.bottom];
    
    if (self.cancelButton) {
        btnY += 8;
        CGRect rect = CGRectMake(0, btnY, width * 0.9, 39.5);
        self.cancelButton.frame = rect;
        [self.allBottom addSubview:self.cancelButton];
    }
    
   
    [self addTheLayer];
    [self addSubview:self.allBottom];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.allBottom.frame = CGRectMake(self->width*0.05, self->height - self->bottomHeight, self->width*0.9, self->bottomHeight);
    }];
}
- (void)showInAnimate{
    
    [self addTheLayer];
    InAnimate = YES;
    
    NSMutableArray *viewArray = [[NSMutableArray alloc]init];
    if (self.titleView) {
        [viewArray addObject:self.titleView];
    }
    [viewArray addObjectsFromArray:_btnArray];
    [self cornerRadiu:viewArray.firstObject];
    
    
    CGFloat btnY = height - 8 - 40;
    /**
     *  i是一个标记位  1 表示从左边进入 0 表示从右边进入
     */
    CGFloat i = 1;
    if (self.cancelButton) {
        CGFloat x;
        if (i) {
            x = -width*0.9;
            i = 0;
        }else{
            x = width;
            i = 1;
        }
        CGRect rect = CGRectMake(x, btnY, width*0.9, 40);
        self.cancelButton.frame = rect;
        [self addSubview:self.cancelButton];
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
        if (j==0 && self.titleView) {
            btnY -= self.titleView.frame.size.height;
            CGRect rect = CGRectMake(x, btnY, width*0.9, self.titleView.frame.size.height);
            btn.frame = rect;
        }else{
            btnY -= 40;
            CGRect rect = CGRectMake(x, btnY, width*0.9, 39.5);
            btn.frame = rect;
        }
        if (j == 1) {
            
            //如果titleView中有内容
            if (self.titleView.subviews.count > 0) {
                btnY -= 3; //当为倒数第二个时  也就是接下来是第一个title Y往上多移10
            }
        }
        [self addSubview:btn];
    }
    
    
    __block double delay = 0;
    double duration = 0.1 * viewArray.count + 0.1;
    if (self.cancelButton) {
        duration += 0.2;
    }
    
   [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionOverrideInheritedOptions animations:^{
       for (UIView *view in viewArray) {
           [UIView addKeyframeWithRelativeStartTime:delay relativeDuration:0.3 animations:^{
               CGRect rect = view.frame;
               rect.origin.x = self->width * 0.05;
               view.frame = rect;
           }];
           delay = delay + 0.2;
       }
       if (self.cancelButton) {
           [UIView addKeyframeWithRelativeStartTime:delay relativeDuration:0.2 animations:^{
               CGRect rect = self.cancelButton.frame;
               rect.origin.x = self->width * 0.05;
               self.cancelButton.frame = rect;
           }];
           delay = delay + 0.2;
       }
       
   } completion:^(BOOL finished) {
       
   }];
    
    
    
}
-(void)addTheLayer{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [self addSubview:self.layView];
    [UIView animateWithDuration:0.2 animations:^{
        self.layView.alpha = 0.2;
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    [self.layView addGestureRecognizer:tap];
    
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
        CGRect rect = self.allBottom.frame;
        rect.origin.y = self->height;
        self.allBottom.frame = rect;
        self.layView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
-(void)closeInAnimate{

   
    
    NSMutableArray *viewArray = [[NSMutableArray alloc]init];
    if (self.titleView) {
        [viewArray addObject:self.titleView];
    }
    [viewArray addObjectsFromArray:_btnArray];
    if (self.cancelButton) {
        [viewArray addObject:self.cancelButton];
    }
    
    /**
     *  i是一个标记位  1 表示从左边出去 0 表示从右边出去
     */
    __block CGFloat i = 1;
    
    __block double delay = 0;
    double duration = 0.1 * viewArray.count + 0.1;
    if (self.cancelButton) {
        duration += 0.1;
    }
    
    [UIView animateKeyframesWithDuration:duration delay:0 options:UIViewKeyframeAnimationOptionOverrideInheritedOptions animations:^{
        for (UIView *view in viewArray) {
            __block CGRect rect = view.frame;
            if (i) {
                rect.origin.x = -self->width*0.9;
                i = 0;
            }else{
                rect.origin.x = self->width;
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
        self.layView.alpha = 0;
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


#pragma mark - implementation from XAlert

-(void)addAction:(XAlertAction *)action{
    if (action.style == XAlertActionStyleDefault) {
        [self addButtonwithTitle:action.title handler:action.handler];
    }else if (action.style == XAlertActionStyleCancel){
        [self addCancelButtonWithTitle:action.title];
    }
}
-(void)showWithAnimateStyle:(XAlertAnimateStyle)style{
    if (style == XAlertAnimateStyleNormal) {
        [self show];
    }else if (style == XAlertAnimateStyleTranslation){
        [self showInAnimate];
    }
}

#pragma mark - getter & setter

-(UIView *)bottom{
    if (!_bottom) {
        _bottom = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width*0.9, bottomHeight)];
        _bottom.layer.cornerRadius = 5;
        _bottom.layer.masksToBounds = true;
    }
    return _bottom;
}
-(UIView *)allBottom{
    if (!_allBottom) {
        _allBottom = [[UIView alloc]initWithFrame:CGRectMake(width*0.05, height, width*0.9, bottomHeight)];

    }
    return _allBottom;
}
-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width * 0.9, 49.5)];
        _titleView.backgroundColor = greenColor;

    }
    return _titleView;
}
-(UIView *)layView{
    if (!_layView) {
        _layView = [[UIView alloc]initWithFrame:self.frame];
        _layView.backgroundColor = layerColor;
        _layView.alpha = 0;
    }
    return _layView;
}
-(UILabel *)TitleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, width*0.9, 15)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [_titleLabel setAdjustsFontSizeToFitWidth:true];
        _titleLabel.textColor = titleTextColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UILabel *)descLabel{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, width*0.9, 15)];
        [_descLabel setAdjustsFontSizeToFitWidth:true];
        _descLabel.font = [UIFont systemFontOfSize:12];
        _descLabel.textColor = titleTextColor;
        _descLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _descLabel;
}
-(UIButton *)cancelButton{
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc]init];
        _cancelButton.layer.cornerRadius = 5;
        _cancelButton.layer.masksToBounds = true;
        _cancelButton.backgroundColor = brownColor;
        [_cancelButton setTitleColor:buttonTextColor forState:0];
        [_cancelButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
@end










