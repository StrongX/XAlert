
#import <UIKit/UIKit.h>
#import "XAlertView.h"
#import "XActionSheet.h"

typedef enum : NSUInteger {
    XAlertStyleAlertView,
    XAlertStyleActionSheet,
} XAlertStyle;


typedef enum : NSUInteger {
    
    XAlertActionStyleDefault,
    XAlertActionStyleCancel,

} XAlertActionStyle;

typedef enum : NSUInteger {
    //ActionSheet Animation
    XAlertAnimateStyleNormal          =          1<<0,
    XAlertAnimateStyleTranslation     =          1<<1,
    XAlertAnimateStyleCurve           =          1<<2,
    XAlertAnimateStyleFold            =          1<<3,

} XAlertAnimateStyle;

@interface XAlertAction : NSObject


+ (instancetype)actionWithTitle:(nullable NSString *)title style:(XAlertActionStyle)style handler:(void (^)(void))handler;

@end



@interface XAlert : NSObject

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(XAlertStyle)preferredStyle;

- (void)addAction:(XAlertAction *)action;

- (void)setContainView:(UIView *)containView;

- (void)show;

- (void)showWithAnimateStyle:(XAlertAnimateStyle)style;

@property (nonatomic, assign, readonly) XAlertStyle style;


@end


