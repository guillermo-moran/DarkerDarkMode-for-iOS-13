#import <UIKit/UIKit.h>

#define OLED_BACKGROUND_COLOR [UIColor colorWithRed:0.00 green:0.00 blue:0.00 alpha:1.0]
#define OLED_CELL_COLOR [UIColor colorWithRed:0.02 green:0.02 blue:0.02 alpha:1.0]
#define OLED_LIGHTER_ACCENT [UIColor colorWithRed:0.11 green:0.11 blue:0.11 alpha:1.0]
#define createDynamicEclipseColor(light, dark) [UIColor createDynamicEclipseColor:light darkColor:dark]

@interface SBMainWorkspace : NSObject
+ (instancetype)_instanceIfExists;
@end

@interface UIColor (DarkerDarkMode)
+ (UIColor *)createDynamicEclipseColor:(UIColor *)defaultColor darkColor:(UIColor *)darkColor;
- (UIColor *)darkerColor;
@end

@implementation UIColor (DarkerDarkMode)
+ (UIColor *)createDynamicEclipseColor:(UIColor *)defaultColor darkColor:(UIColor *)darkColor {
    return [self colorWithDynamicProvider:^UIColor *_Nonnull(UITraitCollection * _Nonnull traits) {
        return traits.userInterfaceStyle == UIUserInterfaceStyleDark ? darkColor : defaultColor;
    }];
}
- (UIColor *)darkerColor {
    CGFloat h, s, b, a;
    return [self getHue:&h saturation:&s brightness:&b alpha:&a] ? [UIColor colorWithHue:h saturation:s brightness:b * 0.75 alpha:a] : nil;
}
@end

%group UIColor
%hook UIColor
+ (UIColor *)systemBackgroundColor {
    return createDynamicEclipseColor(%orig, OLED_BACKGROUND_COLOR);
}
+ (UIColor *)systemGroupedBackgroundColor {
    return createDynamicEclipseColor(%orig, OLED_BACKGROUND_COLOR);
}
+ (UIColor *)groupTableViewBackgroundColor {
    return createDynamicEclipseColor(%orig, OLED_BACKGROUND_COLOR);
}
+ (UIColor *)tableBackgroundColor {
    return createDynamicEclipseColor(%orig, OLED_BACKGROUND_COLOR);
}
+ (UIColor *)tableCellPlainBackgroundColor {
    return createDynamicEclipseColor(%orig, OLED_CELL_COLOR);
}
+ (UIColor *)tableCellGroupedBackgroundColor {
    return createDynamicEclipseColor(%orig, OLED_CELL_COLOR);
}
+ (UIColor *)secondarySystemBackgroundColor {
    return createDynamicEclipseColor(%orig, OLED_BACKGROUND_COLOR);
}
+ (UIColor *)secondarySystemGroupedBackgroundColor {
    return createDynamicEclipseColor(%orig, OLED_BACKGROUND_COLOR);
}
+ (UIColor *)tertiarySystemBackgroundColor {
    return createDynamicEclipseColor(%orig, OLED_BACKGROUND_COLOR);
}
+ (UIColor *)tertiarySystemGroupedBackgroundColor {
    return createDynamicEclipseColor(%orig, OLED_BACKGROUND_COLOR);
}
+ (UIColor *)systemGrayColor {
    UIColor *originalColor = %orig;
    return createDynamicEclipseColor(originalColor, [originalColor darkerColor]);
}
+ (UIColor *)systemGray2Color {
    UIColor *originalColor = %orig;
    return createDynamicEclipseColor(originalColor, [originalColor darkerColor]);
}
+ (UIColor *)systemGray3Color {
    UIColor *originalColor = %orig;
    return createDynamicEclipseColor(originalColor, [originalColor darkerColor]);
}
+ (UIColor *)systemGray4Color {
    UIColor *originalColor = %orig;
    return createDynamicEclipseColor(originalColor, [originalColor darkerColor]);
}
+ (UIColor *)systemGray5Color {
    UIColor *originalColor = %orig;
    return createDynamicEclipseColor(originalColor, [originalColor darkerColor]);
}
+ (UIColor *)separatorColor {
    UIColor *originalColor = %orig;
    return createDynamicEclipseColor(originalColor, [originalColor darkerColor]);
}
+ (UIColor *)opaqueSeparatorColor {
    UIColor *originalColor = %orig;
    return createDynamicEclipseColor(originalColor, [originalColor darkerColor]);
}
+ (UIColor *)tableSeparatorColor {
    UIColor *originalColor = %orig;
    return createDynamicEclipseColor(originalColor, [originalColor darkerColor]);
}
%end
%end

static void initUIColor() {
    %init(UIColor);
}

%group SBMainWorkspace
%hook SBMainWorkspace
- (void)_finishInitialization {
    %orig;
    initUIColor();
}
%end
%end

%ctor {
    if ([%c(SBMainWorkspace) _instanceIfExists] || ![NSBundle.mainBundle.bundleIdentifier isEqualToString:@"com.apple.springboard"]) {
        initUIColor();
    } else {
        %init(SBMainWorkspace);
    }
}
