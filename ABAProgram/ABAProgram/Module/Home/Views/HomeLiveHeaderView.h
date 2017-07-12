//
//  HomeLiveHeaderView.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/1.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeLiveHeaderViewDelegate;

@interface HomeLiveHeaderView : UIView

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign)id<HomeLiveHeaderViewDelegate>delegate;

@end

@protocol HomeLiveHeaderViewDelegate <NSObject>

- (void)startPlayAction;

@end
