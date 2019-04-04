# XAlert

[![CI Status](https://img.shields.io/travis/StrongX/XAlert.svg?style=flat)](https://travis-ci.org/StrongX/XAlert)
[![Version](https://img.shields.io/cocoapods/v/XAlert.svg?style=flat)](https://cocoapods.org/pods/XAlert)
[![License](https://img.shields.io/cocoapods/l/XAlert.svg?style=flat)](https://cocoapods.org/pods/XAlert)
[![Platform](https://img.shields.io/cocoapods/p/XAlert.svg?style=flat)](https://cocoapods.org/pods/XAlert)


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![image](https://github.com/StrongX/XAlert/blob/master/10.gif)

```objc

- (IBAction)actionsheet1:(id)sender {
XActionSheet *sheet = [[XActionSheet alloc]initWithTitleAndDesc:@"这是一个上啦菜单" Desc:@"你可以在这里填写一些详细内容"];
[sheet addCancelButtonWithTitle:@"取消"];
[sheet addButtonwithTitle:@"按钮一"];
[sheet addButtonwithTitle:@"按钮二"];
[sheet addButtonwithTitle:@"按钮三"];
sheet.delegate = self;
[sheet show];
}
- (IBAction)actionsheet2:(id)sender {
XActionSheet *sheet = [[XActionSheet alloc]initWithTitleAndDesc:@"这是一个上啦菜单" Desc:@"你可以在这里填写一些详细内容"];
[sheet addCancelButtonWithTitle:@"取消"];
[sheet addButtonwithTitle:@"按钮一"];
[sheet addButtonwithTitle:@"按钮二"];
[sheet addButtonwithTitle:@"按钮三"];
sheet.delegate = self;
[sheet showInAnimate];
}
- (IBAction)AlertView1:(id)sender {
XAlertView *alert = [[XAlertView alloc]initWithTitleAndDesc:@"这是一个警告框" Desc:@"这里可以填一些详细内容"];
alert.btnTitleArray = @[@"按钮一",@"按钮二",@"按钮三"];
alert.delegate = self;
[alert showAnimation1];
}
- (IBAction)AlertView2:(id)sender {
XAlertView *alert = [[XAlertView alloc]init];
alert.containViewHeight = 100;
CGFloat width = alert.containView.frame.size.width;
UIImageView *avatar = [[UIImageView alloc]initWithFrame:CGRectMake((width - 60)/2, 10, 60, 60)];
avatar.layer.cornerRadius = 30;
avatar.layer.masksToBounds = true;
avatar.image = [UIImage imageNamed:@"cute_girl"];
[alert.containView addSubview:avatar];

UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, 10 + 60 + 10,width, 20)];
name.text = @"StrongX";
name.textColor = [UIColor darkGrayColor];
name.textAlignment = NSTextAlignmentCenter;
[alert.containView addSubview:name];

alert.btnTitleArray = @[@"确定",@"关闭"];
alert.delegate = self;
[alert showAnimation2];

}


```

## Installation

XAlert is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XAlert'
```

## Author

StrongX, strongxlx@gmail.com

## License

XAlert is available under the MIT license. See the LICENSE file for more info.
