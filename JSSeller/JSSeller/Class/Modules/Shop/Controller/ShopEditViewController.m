//
//  ShopEditViewController.m
//  JSSeller
//
//  Created by 吴頔 on 17/6/24.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "ShopEditViewController.h"

@interface ShopEditViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *doneBT;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewToBottom;

@end

@implementation ShopEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registUI];
}

- (void)registUI {
    self.doneBT.layer.cornerRadius = 5;
    self.doneBT.clipsToBounds = YES;
    [self addKeyboardNotification];
}

- (IBAction)uploadImageAction:(id)sender {
    
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneAction:(id)sender {
    
}

- (IBAction)locationAction:(id)sender {
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"请填写相关店铺公告信息"]) {
        textView.text = @"";
        textView.textColor = UIColorFromRGB(0x333333);
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        textView.text = @"请填写相关店铺公告信息";
        textView.textColor = UIColorFromRGB(0xcccccc);
    }
}

#pragma mark - 添加键盘监听
- (void)addKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark - 移除键盘监听
- (void)removeKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark - 键盘显示响应
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    
    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animation;
    [animationDurationValue getValue:&animation];
    
    NSValue *keyBoardFrameEndUser = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyBoardRect ;
    [keyBoardFrameEndUser getValue:&keyBoardRect];
    self.scrollViewToBottom.constant = keyBoardRect.size.height;
    [self.scrollView setContentOffset:CGPointMake(0, 120) animated:YES];
}

#pragma mark - 键盘移除响应
- (void)keyboardWillHide:(NSNotification *)notification
{
    self.scrollViewToBottom.constant = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self removeKeyboardNotification];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
