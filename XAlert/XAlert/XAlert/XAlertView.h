//
//  XAlertView.h
//  test
//
//  Created by xlx on 15/8/31.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XAlertView;
@protocol XAlertDelegate <NSObject>

@optional
-(void)btnClicked:(NSInteger)index;

@end
@interface XAlertView : UIView

-(id)initWithTitleAndDesc:(NSString *)Title Desc:(NSString *)Desc;


-(void)setContainRect:(CGRect)rect;

-(void)showAnimation1;

-(void)showAnimation2;

@property (nonatomic, strong) UILabel *TitleLabel;
@property (nonatomic, strong) UILabel *DescLabel;
@property (nonatomic, strong) UIView *containView;
@property (nonatomic,       ) CGFloat containViewHeight;
@property (nonatomic, strong) NSArray *btnTitleArray;
@property (nonatomic, strong) NSMutableArray *btnArray;
@property (nonatomic,       ) id<XAlertDelegate>delegate;



@end
