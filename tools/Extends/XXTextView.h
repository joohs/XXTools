//
//  XXTextView.h
//  plasticScan
//
//  Created by Jon on 2021/6/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXTextView : UITextView

//复制、粘贴面板不出现
@property (nonatomic, assign) BOOL menuDisable;

//面板只展示粘贴按钮
@property (nonatomic, assign) BOOL onlyPaste;

@end

NS_ASSUME_NONNULL_END
