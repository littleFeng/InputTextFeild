# InputTextFeild
带动画的输入框
 带标题 标题支持动画的输入框  floatingLabelText 即为带动画的输入框  不设置这个属性为普通系统输入框
floatingLabelFont ;  //!<做动画的label floatingLabelActiveTextColor;  //!滑动label text颜色 floatingLabelText;  //!<滑动label 文本 设置textfeild的placeholder 时 会将这个属性默认设置为placeholder文本。
 disableCopyActions;  //!<是否禁用复制粘贴等action, 默认为NO  isFloatLabelActive;//!<label是否默认高亮
 
    _nameTextField = [[JRInputTextField alloc] initWithFrame:CGRectMake(offset_x, 100.0f, (screenWidth - 2* offset_x), inputHight)];
    _nameTextField.floatingLabelText = @"用户名"; //设置这句 即可同时设置placeholder 及做动画的文本  若该属性不设置 或为空 则为普通的系统textfeild。
    
   
