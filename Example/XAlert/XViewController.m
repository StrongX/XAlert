//
//  ViewController.m
//  XAlert
//
//  Created by xlx on 15/9/12.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import "XViewController.h"
#import "XAlert.h"



@interface  XViewController()

@end

@implementation XViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)actionsheet1:(id)sender {
    
    XAlert *alert = [XAlert alertControllerWithTitle:@"这是一个上拉菜单" message:@"你可以在这里填写一些详细内容" preferredStyle:XAlertStyleActionSheet];
    [alert addAction:[XAlertAction actionWithTitle:@"按钮一" style:XAlertActionStyleDefault handler:^{
        NSLog(@"按钮一，actionsheet with animateNormal");
    }]];
    [alert addAction:[XAlertAction actionWithTitle:@"按钮二" style:XAlertActionStyleDefault handler:^{
        NSLog(@"按钮二，actionsheet with animateNormal");
    }]];
    [alert addAction:[XAlertAction actionWithTitle:@"按钮三" style:XAlertActionStyleDefault handler:^{
        NSLog(@"按钮三，actionsheet with animateNormal");
    }]];
    [alert addAction:[XAlertAction actionWithTitle:@"取消" style:XAlertActionStyleCancel handler:^{
        NSLog(@"取消，actionsheet cancel");
    }]];
    [alert show];
}
- (IBAction)actionsheet2:(id)sender {
    XAlert *alert = [XAlert alertControllerWithTitle:@"这是一个上拉菜单" message:@"你可以在这里填写一些详细内容" preferredStyle:XAlertStyleActionSheet];
    [alert addAction:[XAlertAction actionWithTitle:@"按钮一" style:XAlertActionStyleDefault handler:^{
        NSLog(@"按钮一，actionsheet with animateNormal");
    }]];
    [alert addAction:[XAlertAction actionWithTitle:@"按钮二" style:XAlertActionStyleDefault handler:^{
        NSLog(@"按钮二，actionsheet with animateNormal");
    }]];
    [alert addAction:[XAlertAction actionWithTitle:@"按钮三" style:XAlertActionStyleDefault handler:^{
        NSLog(@"按钮三，actionsheet with animateNormal");
    }]];
    [alert addAction:[XAlertAction actionWithTitle:@"取消" style:XAlertActionStyleCancel handler:^{
        NSLog(@"取消，actionsheet cancel");
    }]];
    [alert showWithAnimateStyle:XAlertAnimateStyleTranslation];

}
- (IBAction)AlertView1:(id)sender {
    XAlert *alert = [XAlert alertControllerWithTitle:@"这是一个警告框" message:@"这里可以填一些详细内容" preferredStyle:XAlertStyleAlertView];
    [alert addAction:[XAlertAction actionWithTitle:@"按钮一" style:XAlertActionStyleDefault handler:^{
        NSLog(@"按钮一，XAlert with animateNormal");
    }]];
    [alert addAction:[XAlertAction actionWithTitle:@"按钮二" style:XAlertActionStyleDefault handler:^{
        NSLog(@"按钮二，XAlert with animateNormal");
    }]];
    [alert addAction:[XAlertAction actionWithTitle:@"按钮三" style:XAlertActionStyleDefault handler:^{
        NSLog(@"按钮三，XAlert with animateNormal");
    }]];
    [alert showWithAnimateStyle:XAlertAnimateStyleCurve];
}
- (IBAction)AlertView2:(id)sender {
    XAlert *alert = [XAlert alertControllerWithTitle:@"这是一个警告框" message:@"这里可以填一些详细内容" preferredStyle:XAlertStyleAlertView];
    [alert addAction:[XAlertAction actionWithTitle:@"确定" style:XAlertActionStyleDefault handler:^{
        NSLog(@"确定，XAlert with animateNormal");
    }]];
    [alert addAction:[XAlertAction actionWithTitle:@"关闭" style:XAlertActionStyleDefault handler:^{
        NSLog(@"关闭，XAlert with animateNormal");
    }]];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    
    
    UIImageView *avatar = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 60, 60)];
    avatar.layer.cornerRadius = 30;
    avatar.layer.masksToBounds = true;
    avatar.image = [UIImage imageNamed:@"cute_girl"];
    [view addSubview:avatar];
    
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, 10 + 60 + 10,100, 20)];
    name.text = @"StrongX";
    name.textColor = [UIColor darkGrayColor];
    name.textAlignment = NSTextAlignmentCenter;
    [view addSubview:name];
    
    [alert setContainView:view];
    
    [alert showWithAnimateStyle:XAlertAnimateStyleFold];
    
}

@end
