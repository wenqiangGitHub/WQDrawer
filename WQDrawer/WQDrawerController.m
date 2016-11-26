//
//  WQDrawerController.m
//  WQDrawer
//
//  Created by li on 16/11/26.
//  Copyright © 2016年 李文强. All rights reserved.
//

#import "WQDrawerController.h"

@interface WQDrawerController ()
@property(strong,nonatomic)UIViewController*mainVc;
@property(strong,nonatomic)UIViewController*leftVc;
@property(strong,nonatomic)UIButton*coverbtn;
@end

@implementation WQDrawerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    [self addGesture];
    

}


//设置主控制器和左边控制器
-(void)mainVC:(UIViewController *)mainVC leftVc:(UIViewController *)leftVc{
    self.leftVc=leftVc;
    [self addChildViewController:self.leftVc];
    self.leftVc.view.frame=self.view.frame;
    [self.view addSubview:self.leftVc.view];
    
    
    self.mainVc=mainVC;
    [self addChildViewController:self.mainVc];
    self.mainVc.view.frame=self.view.frame;
    [self.view addSubview:self.mainVc.view];
    
    
   
}

//打开抽屉
-(void)openDrawer{

    [UIView animateWithDuration:0.25 animations:^{
        self.mainVc.view.frame=CGRectMake([UIScreen mainScreen].bounds.size.width*0.75, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
    [self addcover];
    
}


//关闭抽屉
-(void)closeDrawer{
    [UIView animateWithDuration:0.25 animations:^{
        self.mainVc.view.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }];
    
    [self.coverbtn removeFromSuperview];
    self.coverbtn=nil;
}

//添加手势
-(void)addGesture{
    UIPanGestureRecognizer*pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(GestureEvent:)];
    [self.view addGestureRecognizer:pan];

}

//手势的响应事件
-(void)GestureEvent:(UIPanGestureRecognizer*)pan{
    if (pan.state==UIGestureRecognizerStateEnded||pan.state==UIGestureRecognizerStateCancelled) {
        if (self.mainVc.view.frame.origin.x>=[UIScreen mainScreen].bounds.size.width*0.5) {
            [self openDrawer];
        }else{
            [self closeDrawer];
        }
    }else if(pan.state==UIGestureRecognizerStateChanged){
        CGFloat offset=[pan translationInView:pan.view].x;
        if (offset>0) {
            self.mainVc.view.frame=CGRectMake(offset, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        }
    
    }

}

//添加遮盖
-(void)addcover{

    self.coverbtn=[[UIButton alloc]init];
    [self.coverbtn addTarget:self action:@selector(closeDrawer) forControlEvents:UIControlEventTouchDown];
    self.coverbtn.frame=self.mainVc.view.bounds;
    [self.mainVc.view addSubview:self.coverbtn];
}

@end
