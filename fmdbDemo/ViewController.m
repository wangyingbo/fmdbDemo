//
//  ViewController.m
//  fmdbDemo
//
//  Created by fengbang on 2019/9/3.
//  Copyright © 2019 王颖博. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - configData


#pragma mark - other
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSString *str = @"http://www.jianshu.com/p/6930f335adba";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    __block NSUInteger count = 0;
    for (int i=0; i<10; i++) {
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSLog(@"%d---%d",i,i);
            count++;
            if (count==10) {
                dispatch_semaphore_signal(sem);
                count = 0;
            }
            
        }];
        
        [task resume];
    }
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"end");
    });
}
@end
