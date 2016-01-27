//
//  JRInputTextField.h
//  Demo
//
//  Created by fenglishuai on 15/12/14.
//  Copyright © 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  @author
 *
 *  @brief 带动画的输入框  floatingLabelText 即为带动画的输入框  不设置 为普通系统TextFeild
 *
 */
@interface JRInputTextField : UITextField
@property (nonatomic, strong) UIFont * floatingLabelFont ;  //!<做动画的label的字体
@property (nonatomic, strong) UIColor * floatingLabelActiveTextColor;  //!滑动label text颜色
@property (nonatomic, strong) NSString * floatingLabelText;  //!<滑动label 文本 设置textfeild的placeholder 时 会将这个属性默认设置为placeholder文本。
@property (nonatomic, assign) BOOL disableCopyActions;  //!<是否禁用复制粘贴等action, 默认为NO
@property (nonatomic, assign) BOOL isFloatLabelActive;//!<label是否默认高亮
@end
