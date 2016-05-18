//
//  XAlertView.m
//  test
//
//  Created by xlx on 15/8/31.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import "XAlertView.h"
#import "POP.h"

#define green_Color [UIColor colorWithRed:102.0/255.0 green:195.0/255.0 blue:165.0/255.0 alpha:1.0f]
@implementation XAlertView
{
    CGRect containRect;
    UIView *bottom;
    UIView *layView;
    CGFloat width;
    CGFloat height;
    CGFloat btnWidth;
}

-(id)initWithTitleAndDesc:(NSString *)Title Desc:(NSString *)Desc{
    self = [self init];
    _TitleLabel = [[UILabel alloc]init];
    _DescLabel = [[UILabel alloc]init];
    _TitleLabel.text = Title;
    _DescLabel.text = Desc;
    _TitleLabel.textColor = green_Color;
    _DescLabel.textColor = green_Color;
    _TitleLabel.font = [UIFont systemFontOfSize:14];
    [_TitleLabel setAdjustsFontSizeToFitWidth:true];
    _DescLabel.font = [UIFont systemFontOfSize:12];
    [_DescLabel setAdjustsFontSizeToFitWidth:true];
    _TitleLabel.textAlignment = NSTextAlignmentCenter;
    _DescLabel.textAlignment = NSTextAlignmentCenter;
    
    
    //当desc为空时，不绘制descLabel的label
    if (Desc == nil || [Desc isEqualToString:@""]) {
        _TitleLabel.frame = CGRectMake(0, 10, bottom.frame.size.width, 30);
        [_containView addSubview:_TitleLabel];
    }
    else {
        _TitleLabel.frame = CGRectMake(0, 0, bottom.frame.size.width, 30);
        _DescLabel.frame = CGRectMake(0, 30, bottom.frame.size.width, 20);
        [_containView addSubview:_TitleLabel];
        [_containView addSubview:_DescLabel];
    }
    
    return self;
}

-(id)init{
    self = [super init];
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    self.frame = CGRectMake(0, 0, width,height);
    _containViewHeight = 50;
    
    layView = [[UIView alloc]initWithFrame:self.frame];
    layView.backgroundColor = [UIColor grayColor];
    layView.alpha = 0;
    [self addSubview:layView];
    
    bottom = [[UIView alloc]initWithFrame:CGRectMake(width*0.1, -100, width * 0.8, 50 + _containViewHeight)];
    bottom.backgroundColor = [UIColor whiteColor];
    bottom.layer.cornerRadius = 5;
    bottom.layer.masksToBounds = true;
    [self addSubview:bottom];
    
    _containView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width * 0.8, _containViewHeight)];
    [bottom addSubview:_containView];
   
    _btnArray = [[NSMutableArray alloc]init];
    
    _delegate = nil;
    return self;
}
-(void)setContainRect:(CGRect)rect{
    containRect = rect;
}
-(void)initUI{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    btnWidth = width*0.8/_btnTitleArray.count;
   
    _containView.frame = CGRectMake(0, 0, width * 0.8, _containViewHeight);
    bottom.frame = CGRectMake(width*0.1, -100, width * 0.8, 50 + _containViewHeight);
    
    for (int i = 0; i<_btnTitleArray.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i*btnWidth, _containViewHeight + 10, btnWidth, 40)];
        [btn setTitle:_btnTitleArray[i] forState:normal];
        [btn setTitleColor:green_Color forState:normal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [bottom addSubview:btn];
        [btn addTarget:self action:@selector(closeAction1:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = _btnArray.count;
        [_btnArray addObject:btn];
        if (i != 0) {
            UIView *sp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 40)];
            sp.backgroundColor = green_Color;
            sp.alpha = 0.2;
            [btn addSubview:sp];
        }
    }
    UIView *sp = [[UIView alloc]initWithFrame:CGRectMake(0, bottom.frame.size.height - 40, bottom.frame.size.width, 1)];
    sp.backgroundColor =green_Color;
    [bottom addSubview:sp];
    
    [UIView animateWithDuration:0.2 animations:^{
        layView.alpha = 0.4;
    }];
}
-(void)showAnimation1{
   
    [self initUI];
    [self showAction1];
    
}
-(void)showAnimation2{
    [self initUI];
    bottom.frame = CGRectMake((width - width/3)/2, (height - width/3)/2, width/3, width/3);
    [self showAction2];
}
-(void)showAction1{
    
    POPBasicAnimation *transform = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transform.fromValue = @(-M_PI/2);
    transform.toValue = @(0);
    transform.duration = 0.3;
    [bottom.layer pop_addAnimation:transform forKey:@""];
    
   
    
    POPSpringAnimation *move = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    move.fromValue = @(0);
    move.toValue = @(self.bounds.size.height/2);
    move.beginTime = CACurrentMediaTime();
    move.springSpeed = 5;
    move.springBounciness = 10;
    [bottom pop_addAnimation:move forKey:@""];
}
-(void)showAction2{
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        bottom.frame = CGRectMake(width * 0.1, (height - _containViewHeight - 50)/2, width * 0.8, _containViewHeight + 50);
    } completion:^(BOOL finished) {
        
    }];
}
-(void)closeAction1:(UIButton *)btn{
    POPBasicAnimation *transform = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transform.fromValue = @(0);
    transform.toValue = @(M_PI/2);
    transform.duration = 0.3;
    [bottom.layer pop_addAnimation:transform forKey:@""];
    
    POPBasicAnimation *Opacity = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    Opacity.fromValue = @(0.2);
    Opacity.toValue = @(0);
    Opacity.duration = 0.5;
    [layView.layer pop_addAnimation:Opacity forKey:@""];
    
    
    
    POPSpringAnimation *move = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    move.fromValue = @(self.bounds.size.height/2);
    move.toValue = @(self.bounds.size.height+width);
    move.beginTime = CACurrentMediaTime();
    move.springSpeed = 5;
    move.springBounciness = 2;
    [bottom pop_addAnimation:move forKey:@""];
    
    
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self removeFromSuperview];
    });
    
    if (_delegate && [_delegate respondsToSelector:@selector(alertView:buttonClick:)]) {
        [_delegate alertView:self buttonClick:btn.tag];
    }
    
}
@end
