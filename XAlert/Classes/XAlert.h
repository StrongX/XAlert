
#import <UIKit/UIKit.h>


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



@property (nonatomic, readonly) XAlertActionStyle style;

@property (nullable, nonatomic, readonly) NSString *title;

@property (nonatomic, strong, readonly) void(^handler)(void);


@end



@interface XAlert : UIView

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(XAlertStyle)preferredStyle;

- (void)addAction:(XAlertAction *)action;

- (void)setContainView:(UIView *)containView; //  只有style == XAlertStyleAlertView 才实现了此方法

- (void)show;

- (void)showWithAnimateStyle:(XAlertAnimateStyle)style;

@property (nonatomic, assign, readonly) XAlertStyle style;


@end


