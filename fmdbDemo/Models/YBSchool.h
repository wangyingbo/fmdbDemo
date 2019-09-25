//
//  YBSchool.h
//  fmdbDemo
//
//  Created by fengbang on 2019/9/25.
//  Copyright © 2019 王颖博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YBClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface YBSchool : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong) YBClass *aClass;

@end

NS_ASSUME_NONNULL_END
