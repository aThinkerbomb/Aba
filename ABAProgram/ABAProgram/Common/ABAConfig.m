//
//  ABAConfig.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/23.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "ABAConfig.h"
#import "BaseNavigationController.h"
#import "LoginViewController.h"
#import "ABATabBarController.h"

#define WeiXinAppKey @"Yccit412Yccit412Yccit412Yccit412"

@implementation ABAConfig

+(instancetype)shareConfig
{
    static ABAConfig *config = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        config = [[ABAConfig alloc] init];
    });
    return config;
    
}


+ (UINavigationController *)creatLoginViewController
{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    BaseNavigationController *baseNV = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
    return baseNV;
}

+ (UITabBarController *)initTabBarViewController{
    return [[ABATabBarController alloc] init];
}

+ (void)creatRootViewController:(UIViewController *)viewController
{
    [kAppDelegate.window setRootViewController:viewController];
    [kAppDelegate.window reloadInputViews];
}

+ (NSString *)getCurrentVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (BOOL)isEmptyOfObj:(id)obj
{
    if (obj == nil || [obj isEqual:[NSNull null]]) {
        return YES;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        if ([obj isEqualToString:@""] || [obj isEqualToString:@"null"] || [obj isEqualToString:@"(null)"]||[obj isEqualToString:@" "]) {
            return YES;
        }
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        if ([obj count] == 0) {
            return YES;
        }
    }
    if ([obj isKindOfClass:[NSDictionary class]]) {
        if ([obj count] == 0) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)checkResponseObject:(id)responseObject
{
    NSInteger status = [[responseObject objectForKey:@"status"] integerValue];
    NSString *msg = [responseObject objectForKey:@"msg"];
    id body = [responseObject objectForKey:@"body"];
    if (status == 200 && [msg isEqualToString:@"SUCCESS"] && ![ABAConfig isEmptyOfObj:body]) {
        return YES;
    }
    return NO;
    
}

+ (BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
        
    }
    return NO;
    
}


+ (NSString *)getSignFieldFromRequestDictionary:(NSDictionary *)dictionary
{
    if ([self isEmptyOfObj:dictionary]) {
        return @"";
    }
    
    NSArray * keys = [dictionary allKeys];
    NSArray * array = [keys sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray * strArray = [NSMutableArray array];
    for (int i = 0; i < [array count]; i++) {
        NSString * str = [[array[i] stringByAppendingString:@"="] stringByAppendingString:[NSString stringWithFormat:@"%@", [dictionary valueForKey:array[i]]]];
        [strArray addObject:str];
    }
    [strArray addObject:[NSString stringWithFormat:@"key=%@", WeiXinAppKey]];
    NSString * newString = [strArray componentsJoinedByString:@"&"];
    NSLog(@"newString = %@", newString);
    NSString * sign = [self creatMD5StringWithString:newString];
    NSLog(@"sign = %@", sign);
    return sign;
}

+ (NSString *)creatMD5StringWithString:(NSString *)string
{
    const char *original_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash uppercaseString];
}

+ (NSString *)acrRandow
{
    NSString * randow = [[NSString alloc]init];
    int xx = 0;
    for (int x =0 ; x <16; x++) {
        xx = arc4random() %10;
        NSString * aa = [NSString stringWithFormat:@"%d",xx];
        randow = [NSString stringWithFormat:@"%@%@",randow,aa];
    }
    return randow;
}


+ (int)getAgeWithDateTimeInterval:(NSTimeInterval)time {
    int age  =  fabs(time/(60*60*24))/365;
    return age;
}


+ (NSString *)calculateConstellationWithMonth:(NSInteger)month day:(NSInteger)day {
    
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    
    NSString *astroFormat = @"102123444543";
    
    NSString *result;
    
    if (month<1 || month>12 || day<1 || day>31){
        
        return @"错误日期格式!";
        
    }
    
    if(month==2 && day>29)
        
    {
        
        return @"错误日期格式!!";
        
    }else if(month==4 || month==6 || month==9 || month==11) {
        
        if (day>30) {
            
            return @"错误日期格式!!!";
            
        }
    }
    
    result=[NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(month*2-(day < [[astroFormat substringWithRange:NSMakeRange((month-1), 1)] intValue] - (-19))*2,2)]];
    
    return [NSString stringWithFormat:@"%@座",result];
    
}



@end
