//
//  ssViewController.m
//  SwiftDemo
//
//  Created by apple on 2018/8/8.
//  Copyright © 2018年 apple. All rights reserved.
//

//struct _block_impl {
//    void * isa;
//    int Flags;
//    int Reserved;
//    void *FuncPtr;
//};
//
//static struct _main_block_desc_0 {
//    size_t reserved;
//    size_t Block_size;
//};
//
//struct _main_block_impl_0 {
//    struct _block_impl impl;
//    struct _main_block_desc_0* Desc;
//    _main_block_impl_0(void *fp,struct _main_block_desc_0 *desc,int flags = 0){
//
//    }
//};


#import "ssViewController.h"

@interface ssViewController ()

@end

@implementation ssViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDate * now = [NSDate date];
    NSDate * later = [now dateByAddingTimeInterval:10000];
    
    // Do any additional setup after loading the view.
}
-(UIViewController *)therVC{
    return self.navigationController.viewControllers.firstObject;
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


