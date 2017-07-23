//
//  VersionManager.m
//  ABAProgram
//
//  Created by 张宇轩 on 2017/6/26.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "VersionManager.h"
#import "VersionAPI.h"
#import "VersionModel.h"

@interface VersionManager ()<UIAlertViewDelegate>

@end


@implementation VersionManager

+ (instancetype)shareInstance
{
    static VersionManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[VersionManager alloc] init];
    });
    return manager;
}



- (void)startCheckVersion
{
    VersionAPI *version = [[VersionAPI alloc] initWithGetVersion];
    [version startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        if (request.responseObject != nil) {
            VersionModel *model = [[VersionModel alloc] init];
            model = [VersionModel mj_objectWithKeyValues:request.responseObject];
            
            if ([self checkUpdateWithNewVersion:model.versonname]) {
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:nil message:model.versionDes delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alerView show];
            }
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex == 1) {
        
        NSURL *appstorrUrl = [NSURL URLWithString:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1261288767&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"];
        if ([[UIApplication sharedApplication] canOpenURL:appstorrUrl]) {
            [[UIApplication sharedApplication] openURL:appstorrUrl];
        }
        
    }
}

- (BOOL)checkUpdateWithNewVersion:(NSString *)newVerison{
    
    if ([ABAConfig isEmptyOfObj:newVerison]) {
        return NO;
    }
    
    NSString *oldVersion = [ABAConfig getCurrentVersion];
    
    NSArray *old = [oldVersion componentsSeparatedByString:@"."];
    NSArray *new = [newVerison componentsSeparatedByString:@"."];
    
    for (int i = 0; i < 3; i++) {
        NSInteger newCode = [new[i] intValue];
        NSInteger oldcode = [old[i] intValue];
        if (newCode > oldcode) {
            
            return  YES;
        }
        
    }
    return NO;
}



@end
