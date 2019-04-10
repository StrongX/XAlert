
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
    
    XAlertAnimateStyleNormal =          1<<0,
   
} XAlertAnimateStyle;

@interface XAlertAction : NSObject

#warning 这里没有处理handler为空的情况

+ (instancetype)actionWithTitle:(nullable NSString *)title style:(XAlertActionStyle)style handler:(void (^)(void))handler;

@end



@interface XAlert : NSObject

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message preferredStyle:(XAlertStyle)preferredStyle;

- (void)addAction:(XAlertAction *)action;

-(void)show;

-(void)showWithAnimateStyle:(XAlertAnimateStyle)style;

@property (nonatomic, assign, readonly) XAlertStyle style;


@end


