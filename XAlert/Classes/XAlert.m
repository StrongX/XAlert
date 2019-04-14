
#import "XAlert.h"
#import "XAlertView.h"
#import "XActionSheet.h"

@interface XAlertAction()




@property (nonatomic, readwrite) XAlertActionStyle style;

@property (nullable, nonatomic, readwrite) NSString *title;

@property (nonatomic, strong, readwrite) void(^handler)(void);

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


@end

@implementation XAlert

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(XAlertStyle)preferredStyle{
   
    if (preferredStyle == XAlertStyleAlertView) {
        return [[XAlertView alloc]initWithTitleAndDesc:title Desc:message];
    }else if (preferredStyle == XAlertStyleActionSheet){
        return [[XActionSheet alloc]initWithTitleAndDesc:title Desc:message];
    }
    return nil;
}
- (void)addAction:(XAlertAction *)action{
}
-(void)setContainView:(UIView *)containView{
}
-(void)show{
}
-(void)showWithAnimateStyle:(XAlertAnimateStyle)style{
}
@end
