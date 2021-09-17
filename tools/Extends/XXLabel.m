//
//  XXLabel.m
//  plasticScan
//
//  Created by Jon on 2021/6/23.
//

#import "XXLabel.h"

@interface XXLabel ()

@property (nonatomic, strong) UIColor *defColor;

@end

@implementation XXLabel

-(void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.enableCopy = NO;
    [self attachTapHandler];
}

-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action==@selector(copys:)) {
        return YES;
    }
    return NO;
}

-(void)copys:(id)sender {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

-(void)attachTapHandler {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *touch=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:touch];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _enableCopy = NO;
        [self attachTapHandler];
    }
    return self;
}

-(void)menuWillHide:(NSNotification *)notification {
    self.backgroundColor=_defColor;
    self.userInteractionEnabled=YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillHideMenuNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerDidHideMenuNotification
                                                  object:nil];
}

-(void)handleTap:(UIGestureRecognizer*) recognizer {
    if (self.enableCopy == NO) {
        return;
    }
    [self becomeFirstResponder];
    if (recognizer.state==UIGestureRecognizerStateBegan) {
        _defColor=self.backgroundColor;
        self.backgroundColor = [UIColor lightGrayColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillHide:) name:UIMenuControllerWillHideMenuNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuWillHide:) name:UIMenuControllerDidHideMenuNotification object:nil];
        UIMenuItem *copy=[[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copys:)];
        NSArray *arr = @[copy];
        if (self.userInteractionEnabled) {
            [[UIMenuController sharedMenuController] setMenuItems:arr];
            [[UIMenuController sharedMenuController] setTargetRect:self.frame inView :self.superview];
            [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
            self.userInteractionEnabled=NO;
        }
    }
}

@end
