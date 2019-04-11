
#import "XAlert.h"


@interface XAlertAction()

@property (nonatomic, assign) XAlertActionStyle style;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) void(^handler)(void);

@end

@implementation XAlertAction

+ (instancetype)actionWithTitle:(nullable NSString *)title style:(XAlertActionStyle)style handler:(void (^)(void))handler{
    XAlertAction *action = [XAlertAction new];
    action.title = title;
    action.style = style;
    action.handler = handler;
    return action;
}


@end


@interface XAlert()

@property (nonatomic, assign, readwrite) XAlertStyle style;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) XAlertView *alertView;
@property (nonatomic, strong) XActionSheet *actionSheet;

@end

@implementation XAlert

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(XAlertStyle)preferredStyle{
    XAlert *alert = [XAlert new];
    alert.style = preferredStyle;
    alert.title = title;
    alert.message = message;
    return alert;
}
- (void)addAction:(XAlertAction *)action{
    if (self.style == XAlertStyleAlertView) {
        [self.alertView addButtonWithTitle:action.title handler:action.handler];
    }else{
        if (action.style == XAlertActionStyleDefault) {
            [self.actionSheet addButtonwithTitle:action.title handler:action.handler];
        }else if (action.style == XAlertActionStyleCancel){
            [self.actionSheet addCancelButtonWithTitle:action.title];
        }
    }
}
-(void)show{
    if(_style == XAlertStyleAlertView){
        [self showWithAnimateStyle:XAlertAnimateStyleCurve];
    }else{
        [self showWithAnimateStyle:XAlertAnimateStyleNormal];
    }
}
-(void)showWithAnimateStyle:(XAlertAnimateStyle)style{
    if (style == XAlertAnimateStyleNormal) {
        [self.actionSheet show];
    }else if (style == XAlertAnimateStyleTranslation){
        [self.actionSheet showInAnimate];
    }else if (style == XAlertAnimateStyleCurve){
        [self.alertView showAnimation1];
    }else if (style == XAlertAnimateStyleFold){
        [self.alertView showAnimation2];
    }
}

#pragma mark - getter & setter

-(XActionSheet *)actionSheet{
    if (!_actionSheet) {
        _actionSheet = [[XActionSheet alloc]initWithTitleAndDesc:_title Desc:_message];
    }
    return _actionSheet;
}

-(XAlertView *)alertView{
    if (!_alertView) {
        _alertView = [[XAlertView alloc]initWithTitleAndDesc:_title Desc:_message];
    }
    return _alertView;
}

@end
