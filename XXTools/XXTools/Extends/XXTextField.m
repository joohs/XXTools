//
//  XXTextField.m
//  plasticScan
//
//  Created by Jon on 2021/6/28.
//

#import "XXTextField.h"
#import <objc/runtime.h>

@implementation XXTextField

-(void)changePlaceholder {
    Ivar ivar = class_getInstanceVariable([UITextField class], "_placeholderLabel");
    UILabel *placeholderLabel = object_getIvar(self, ivar);
    if (placeholderLabel != nil) {
        placeholderLabel.textColor = _placeholderColor;
        placeholderLabel.font = _placeholderFont;
    }
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self changePlaceholder];
}

-(void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    [self changePlaceholder];
}

-(void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    [self changePlaceholder];
}

@end
