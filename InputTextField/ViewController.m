//
//  ViewController.m
//  InputTextField
//
//  Created by fenglishuai on 15/12/20.
//  Copyright © 2015年 feng. All rights reserved.
//

#import "ViewController.h"
#import "JRInputTextField.h"


#define  screenWidth  [UIScreen mainScreen].bounds.size.width

#define screenHeight [UIScreen mainScreen].bounds.size.height

static const CGFloat offset_x = 50.0f;

static const CGFloat inputHight =  50.0f;

@interface ViewController ()

@property(nonatomic,strong) UIScrollView * mainScrollView;

@property(nonatomic,strong) JRInputTextField * nameTextField;

@property(nonatomic,strong) JRInputTextField * passwordTextFeild;

@property(nonatomic,strong) UIButton * loginButton;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboradDidApper:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)loadUI
{
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    UIColor* beginColor =[UIColor colorWithRed:0 green:1 blue:0 alpha:0.0f];
    UIColor* endColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.5f];
    gradient.frame = CGRectMake(0, 0, screenWidth  ,screenHeight);
    gradient.colors = [NSArray arrayWithObjects:(id)beginColor.CGColor,(id)endColor.CGColor,nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.contentSize = CGSizeMake(screenWidth, screenHeight + 5.0f);
    _mainScrollView.showsHorizontalScrollIndicator= NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHide)];
    [_mainScrollView addGestureRecognizer:tap];
    
    
    _nameTextField = [[JRInputTextField alloc] initWithFrame:CGRectMake(offset_x, 100.0f, (screenWidth - 2* offset_x), inputHight)];
    _nameTextField.floatingLabelText = @"用户名";
    _nameTextField.floatingLabelActiveTextColor = [UIColor blueColor];
    _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _nameTextField.layer.borderWidth = 0.5f;
    _nameTextField.layer.borderColor = [UIColor blackColor].CGColor;
    _nameTextField.backgroundColor = [UIColor clearColor];
    [_mainScrollView addSubview:_nameTextField];
    
    _passwordTextFeild = [[JRInputTextField alloc] initWithFrame:CGRectMake(offset_x, CGRectGetMaxY(_nameTextField.frame)+50.0f, (screenWidth - 2 * offset_x), inputHight)];
    _passwordTextFeild.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordTextFeild.floatingLabelText =@"密码";
    _passwordTextFeild.floatingLabelActiveTextColor= [UIColor blueColor];
    _passwordTextFeild.layer.borderWidth = 0.5f;
    _passwordTextFeild.layer.borderColor = [UIColor blackColor].CGColor;
    _passwordTextFeild.backgroundColor = [UIColor clearColor];
    [_mainScrollView addSubview:_passwordTextFeild];
    
    
    
    _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginButton.frame = CGRectMake(offset_x, CGRectGetMaxY(_passwordTextFeild.frame) + 100.0f , (screenWidth - 2* offset_x), inputHight);
    [_loginButton setTitle:@"  登     陆  " forState:UIControlStateNormal];
    [_loginButton setTitle:@"  登     陆  " forState:UIControlStateHighlighted];
    [_loginButton setBackgroundColor:[UIColor colorWithRed:0 green:1 blue:0 alpha:0.8f]];
    [_mainScrollView addSubview:_loginButton];
    

}

-(void)keyboradDidApper:(NSNotification * ) notice
{
    CGFloat expectHight = (2 * inputHight + 25.0f +30.0f) ;
    
    CGRect rect ;
    [[notice.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&rect];
    rect = [_mainScrollView convertRect:rect toView:nil];
    
    NSNumber * options = [notice.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    CGFloat orign_y =rect.origin.y - expectHight - inputHight > 30.0f ? rect.origin.y - expectHight - inputHight:30.0f;
    
    [UIView animateWithDuration:0.25f delay:0.0f options:[options integerValue] animations:^{
       
        if(  (rect.origin.y-CGRectGetMaxY(_nameTextField.frame)) < expectHight)
        {
            _nameTextField.frame= CGRectMake(offset_x, orign_y , screenWidth-2*offset_x, inputHight);
        }
        if(rect.origin.y - CGRectGetMaxY(_nameTextField.frame) < 2 * inputHight + 150.0f)
        {
            _passwordTextFeild.frame = CGRectMake(offset_x, CGRectGetMaxY(_nameTextField.frame) + 15.0f, screenWidth - 2* offset_x, inputHight);
            _loginButton.frame       = CGRectMake(offset_x, CGRectGetMaxY(_passwordTextFeild.frame) + 20.0f , screenWidth - 2 * offset_x , inputHight);
        }
        else
            return ;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)keyboardDidHide:(NSNotification * )notice
{


    CGRect rect ;
    [[notice.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&rect];
    rect = [_mainScrollView convertRect:rect toView:nil];
    
    NSNumber * options = [notice.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    [UIView animateWithDuration:0.25f delay:0.0f options:[options integerValue] animations:^{
        
        
       _nameTextField.frame= CGRectMake(offset_x, 100.0f, screenWidth-2*offset_x, inputHight);
        _passwordTextFeild.frame = CGRectMake(offset_x, CGRectGetMaxY(_nameTextField.frame) + 50.0f, screenWidth - 2* offset_x, inputHight);
        _loginButton.frame       = CGRectMake(offset_x, CGRectGetMaxY(_passwordTextFeild.frame) + 100.0f , screenWidth - 2 * offset_x , inputHight);
    } completion:^(BOOL finished) {
        
    }];

}

-(void)keyBoardHide
{
    [_passwordTextFeild resignFirstResponder];
    [_nameTextField resignFirstResponder];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
