//
//  XXTextView.m
//  plasticScan
//
//  Created by Jon on 2021/6/28.
//

#import "XXTextView.h"

@implementation XXTextView

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (self.menuDisable) {
        if ([UIMenuController sharedMenuController]) {
            [UIMenuController sharedMenuController].menuVisible = NO;
        }
        return NO;
    }
    if (self.onlyPaste) {
        if (action == @selector(paste:)) {
            return YES;
        } else {
            return NO;
        }
    }
    return [super canPerformAction:action withSender:sender];
}

@end
