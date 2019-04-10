
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


@interface XAlert()<XAlertViewDelegate,XActionSheetDelegate>

@property (nonatomic, assign, readwrite) XAlertStyle style;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSMutableArray *actionArrray;

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
    [self.actionArrray addObject:action];
    if (self.style == XAlertStyleAlertView) {
        
    }else{
        if (action.style == XAlertActionStyleDefault) {
            [self.actionSheet addButtonwithTitle:action.title];
        }else if (action.style == XAlertActionStyleCancel){
            [self.actionSheet addCancelButtonWithTitle:action.title];
        }
    }
}
-(void)show{
    [self showWithAnimateStyle:XAlertAnimateStyleNormal];
}
-(void)showWithAnimateStyle:(XAlertAnimateStyle)style{
    if (style == XAlertAnimateStyleNormal) {
        if (_style == XAlertStyleActionSheet) {
            [self.actionSheet show];
        }
    }
}

#pragma mark - XAlertViewDelegate,XActionSheetDelegate

-(void)actionSheet:(XActionSheet *)actionSheet buttonClick:(NSInteger)index {
    XAlertAction *action = self.actionArrray[index];
    action.handler();
}
-(void)alertView:(XAlertView *)alertView buttonClick:(NSInteger)index {
    XAlertAction *action = self.actionArrray[index];
    action.handler();
}

#pragma mark - getter & setter

-(XActionSheet *)actionSheet{
    if (!_actionSheet) {
        _actionSheet = [[XActionSheet alloc]initWithTitleAndDesc:_title Desc:_message];
        _actionSheet.delegate = self;
    }
    return _actionSheet;
}

-(NSMutableArray *)actionArrray{
    if (!_actionArrray) {
        _actionArrray = [@[] mutableCopy];
    }
    return _actionArrray;
}


@end
