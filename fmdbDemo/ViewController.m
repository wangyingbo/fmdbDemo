//
//  ViewController.m
//  fmdbDemo
//
//  Created by fengbang on 2019/9/3.
//  Copyright © 2019 王颖博. All rights reserved.
//

#import "ViewController.h"
#import "YBSchool.h"

@interface ViewController ()
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, strong) FMDatabase *database;
@end

@implementation ViewController

#pragma mark - override
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavigationUI];
    
    [self configData];
    
    [self configButtons];
}

#pragma mark - configData
- (void)configData {
    NSArray *arr = @[
                     YB_CREATE_ITEM(YBFuncItemSemaphore, @"semaphore"),
                     YB_CREATE_ITEM(YBFuncItemFMDBCreateDB, @"FMDB_db"),
                     YB_CREATE_ITEM(YBFuncItemFMDBCreateTable, @"FMDB_table"),
                     YB_CREATE_ITEM(YBFuncItemFMDBInsert, @"FMDB_insert"),
                     YB_CREATE_ITEM(YBFuncItemFMDBDelete, @"FMDB_delete"),
                     YB_CREATE_ITEM(YBFuncItemFMDBSort, @"FMDB_sort"),
                     ];
    self.titleArray = arr;
}

#pragma mark - configUI
- (void)configNavigationUI {
    NSString *title = @"fmdbDemo";
    self.title = title;
    self.navigationController.navigationItem.title = title;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)configButtons {
    UIButton *lastButton;
    CGFloat leftMargin = 25.f;
    CGFloat rightMargin = 25.f;
    CGFloat topMargin = NAVIGATION_H + 50.f;
    CGFloat space_horizontal = 20.f;
    CGFloat space_vertical = 20.f;
    
    for (int i=0;i<self.titleArray.count;i++) {
        YBItem *item = self.titleArray[i];
        UIButton *button = [[UIButton alloc] init];
        [self.view addSubview:button];
        YBViewBorderRadius(button, 10, .8, [UIColor colorWithRed:(0/255.0) green:(116/255.0) blue:(243/255.0) alpha:1])
        button.tag = item.tag.integerValue;
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        [button setTitle:item.name?:@"" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:(0/255.0) green:(116/255.0) blue:(243/255.0) alpha:1] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGSize buttonSize = [button sizeThatFits:CGSizeMake(FULL_SCREEN_WIDTH-leftMargin-rightMargin, MAXFLOAT)];
        buttonSize = CGSizeMake(buttonSize.width+15, buttonSize.height+2);
        CGFloat button_x = leftMargin;
        CGFloat button_y = topMargin;
        if (lastButton) {
            CGFloat button_max_x = CGRectGetMaxX(lastButton.frame)+space_horizontal+buttonSize.width+rightMargin;
            button_x = (button_max_x<=FULL_SCREEN_WIDTH)?(CGRectGetMaxX(lastButton.frame)+space_horizontal):leftMargin;
            button_y = (button_max_x<=FULL_SCREEN_WIDTH)?(CGRectGetMinY(lastButton.frame)):CGRectGetMaxY(lastButton.frame)+space_vertical;
        }
        button.frame = CGRectMake(button_x, button_y, buttonSize.width, buttonSize.height);
        
        lastButton = button;
    }
}

#pragma mark - actions
- (void)buttonClick:(UIButton *)sender {
    NSUInteger tag = sender.tag;
    NSString *title = sender.titleLabel.text;
    [self.view makeToast:title];
    
    switch (tag) {
        case YBFuncItemSemaphore:
        {
            [self semaphore];
        }
            break;
        case YBFuncItemFMDBCreateDB:
        {
            [self fmdb_createDB];
        }
            break;
        case YBFuncItemFMDBCreateTable:
        {
            [self fmdb_createTable];
        }
            break;
        case YBFuncItemFMDBInsert:
        {
            [self fmdb_insert];
        }
            break;
        case YBFuncItemFMDBDelete:
        {
            [self fmdb_delete];
        }
            break;
        case YBFuncItemFMDBSort:
        {
            [self fmdb_sort];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - operation DB

- (void)semaphore {
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

- (void)fmdb_createDB {
    NSString *lidDirPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *databasePath = [lidDirPath stringByAppendingPathComponent:@"DatabaseDemo.sqlite"];
    self.database = [FMDatabase databaseWithPath:databasePath];
    if (self.database) {
        YBLog(@"创建数据库成功");
    }else {
        YBLog(@"创建数据库失败");
    }
}

- (void)fmdb_createTable {
    if ([self.database open]) {
        NSString *createTableSql = @"create table if not exists School(id integer primary key autoincrement, username text not null, phone text not null, age integer)";
        BOOL result = [self.database executeUpdate:createTableSql];
        if (result) {
            YBLog(@"创建表成功");
        }else {
            YBLog(@"创建表失败");
        }
    }
}

- (void)fmdb_insert {
    
}

- (void)fmdb_delete {
    
}

- (void)fmdb_sort {
    
}


@end
