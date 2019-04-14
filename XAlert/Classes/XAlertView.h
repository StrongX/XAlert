//
//  XAlertView.h
//  test
//
//  Created by xlx on 15/8/31.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XAlert.h"

@class XAlert;

#define green_Color [UIColor colorWithRed:102.0/255.0 green:195.0/255.0 blue:165.0/255.0 alpha:1.0f]



@interface XAlertView : XAlert

-(id)initWithTitleAndDesc:(NSString *)Title Desc:(NSString *)Desc;



-(void)showAnimation1;

-(void)showAnimation2;

@property (nonatomic, strong) UILabel *TitleLabel;
@property (nonatomic, strong) UILabel *DescLabel;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic,       ) CGFloat containViewHeight;


@end
