//
//  JSSHEditShopInfoViewController.m
//  JSSeller
//
//  Created by 吴頔 on 2017/10/4.
//  Copyright © 2017年 lichunfei. All rights reserved.
//

#import "JSSHEditShopInfoViewController.h"

@interface JSSHEditShopInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *shopinfoTextView;
@property (weak, nonatomic) IBOutlet UINavigationItem *myNaviItem;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@end

@implementation JSSHEditShopInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _myNaviItem.title = _mytitle;
    self.shopinfoTextView.text = self.infoLabel.text;
    self.countLabel.text = [NSString stringWithFormat:@"%ld/100",self.infoLabel.text.length];
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveAction:(id)sender {
    if (self.shopinfoTextView.text.length > 100) {
        [AppManager showToastWithMsg:@"超过规定字数了"];
        return;
    }
    self.infoLabel.text = self.shopinfoTextView.text;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    self.countLabel.text = [NSString stringWithFormat:@"%ld/100",textView.text.length];
    if (textView.text.length > 100) {
        self.countLabel.textColor = [UIColor redColor];
    } else {
        self.countLabel.textColor = UIColorFromRGB(0x6e6d6d);
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
