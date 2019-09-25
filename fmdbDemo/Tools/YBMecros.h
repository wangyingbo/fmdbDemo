//
//  YBMecros.h
//  fmdbDemo
//
//  Created by fengbang on 2019/9/25.
//  Copyright © 2019 王颖博. All rights reserved.
//

#ifndef YBMecros_h
#define YBMecros_h

#define IS_IPHONEX      public_isIPhoneXSeries()
#define TAB_BAR_H  (IS_IPHONEX ? 49.0+34.0 : 49.0)
#define STATUS_BAR_H  (IS_IPHONEX ? 44.0 : 20.0)
#define NAVIGATION_H (STATUS_BAR_H+44)


/**屏幕的宽和高*/
#define FULL_SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define FULL_SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
#define VIEWLAYOUT_W  KV_SCREEN_WIDTH/375
#define VIEWLAYOUT_H  (IS_IPHONEX?VIEWLAYOUT_W:KV_SCREEN_HEIGHT/667)
#define YBLAYOUT_W(w) w*VIEWLAYOUT_W//
#define YBLAYOUT_H(h) h*VIEWLAYOUT_H//


/**用printf定义log*/
#ifdef DEBUG
#define YBLog(...) printf("打印：%s第%d行\n%s\n",__func__,__LINE__,[[NSString stringWithFormat:__VA_ARGS__]UTF8String]);
#else
#define YBLog(...)
#endif


/**GCD - 在Main线程上运行*/
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
/**GCD - 开启异步线程*/
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlock);


/**重写dealloc*/
#define FB_REWRITE_DEALLOC \
- (void)dealloc { \
FBLog(@"%@——销毁了",[self class]);\
}


/**设置 view 圆角和边框*/
#define YBViewBorderRadius(View, radius, borderWidth, borderColor)\
\
[View.layer setCornerRadius:(radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(borderWidth)];\
[View.layer setBorderColor:[borderColor CGColor]];

#define YBViewShadow(View,shadowColor,offset,opacity,radius)\
View.layer.shadowOffset = offset;\
View.layer.shadowOpacity = opacity;\
View.layer.shadowRadius = radius;\
[View.layer setShadowColor:[shadowColor CGColor]];


/**实现归档解档的宏*/
#define YB_IMPLEMENTATION_CODE_WITH_CODER \
- (void)encodeWithCoder:(NSCoder *)aCoder { \
NSArray * properNames = [self properNames]; \
for (NSString * properName in properNames) { \
id value = [self valueForKey:properName]; \
if (value && properName) { \
[aCoder encodeObject:value forKey:properName]; \
} \
} \
} \
\
- (instancetype)initWithCoder:(NSCoder *)aDecoder { \
if (self = [super init]) { \
NSArray * properNames = [self properNames]; \
for (NSString * properName in properNames) { \
id value = [aDecoder decodeObjectForKey:properName]; \
if (value && properName) { \
[self setValue:value forKey:properName]; \
} \
} \
} \
return self; \
} \
\
- (NSArray<NSString*>*)properNames { \
Class class = [self class];\
NSMutableArray * propers = [NSMutableArray array]; \
while (class != [NSObject class]) {\
unsigned int count; \
Ivar * ivarList = class_copyIvarList(class, &count); \
for (int i = 0; i<count; i++) { \
Ivar ivar = ivarList[i]; \
NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];\
NSString * key = [name substringFromIndex:1]; \
[propers addObject:key]; \
} \
free(ivarList);\
class = class_getSuperclass(class);\
}\
return propers; \
}

/**单例的宏*/
#define SingletonH(name) + (instancetype)shared##name;

#define SingletonM(name) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}\
\
- (id)mutableCopyWithZone:(NSZone *)zone { \
return _instance; \
}



#endif /* YBMecros_h */
