//
//  ViewController.h
//  fmdbDemo
//
//  Created by fengbang on 2019/9/3.
//  Copyright © 2019 王颖博. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,YBFuncItem) {
    /***/
    YBFuncItemSemaphore = 100,
    /***/
    YBFuncItemFMDBCreateDB,
    /***/
    YBFuncItemFMDBCreateTable,
    /***/
    YBFuncItemFMDBInsert,
    /***/
    YBFuncItemFMDBDelete,
    /***/
    YBFuncItemFMDBSort,
    /***/
    //YBFuncItem,
};

@interface ViewController : UIViewController


@end

