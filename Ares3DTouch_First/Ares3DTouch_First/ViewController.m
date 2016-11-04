//
//  ViewController.m
//  Ares3DTouch_First
//
//  Created by Admin on 16/11/4.
//  Copyright © 2016年 AresBegin. All rights reserved.
//

#import "ViewController.h"

#import <SafariServices/SafariServices.h>

#define URL @"https://www.baidu.com"

@interface ViewController ()<UIViewControllerPreviewingDelegate>

@property(nonatomic, strong) UILabel * label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    //固定这么写
    [self showViewController:viewControllerToCommit sender:self];
}

- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    if (location.x > 100 && location.x < 200 && location.y > 100 && location.y < 200) {
        SFSafariViewController * sv = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:URL]];
        sv.preferredContentSize = CGSizeMake(0,300);
        
        previewingContext.sourceRect = _label.frame;
        return sv;
    }
    return nil;
}

- (void)loadView{
    [super loadView];
    _label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _label.text = @"请点击";
    _label.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:_label];
    //注册代理
    [self registerForPreviewingWithDelegate:self sourceView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
