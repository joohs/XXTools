//
//  UIViewController+Extension.h
//  plasticScan
//
//  Created by Jon on 2021/6/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIViewController (Extension)

/**
Whether or not to set ModelPresentationStyle automatically for instance, Default is [Class automaticallySetModalPresentationStyle].

@return BOOL
*/
@property (nonatomic, assign) BOOL automaticallySetModalPresentationStyle;

/**
 Whether or not to set ModelPresentationStyle automatically, Default is YES, but UIImagePickerController/UIAlertController is NO.

 @return BOOL
 */
+ (BOOL)automaticallySetModalPresentationStyle;

@end

NS_ASSUME_NONNULL_END
