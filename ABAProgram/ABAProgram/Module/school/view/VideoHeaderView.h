//
//  VideoHeaderView.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpertVideoModel.h"

typedef void(^VideoShare)(void);

@interface VideoHeaderView : UIView

@property (nonatomic, strong) ExpertVideoModel *videoModel;

- (void)pause;

- (void)ShareHandle:(VideoShare)share;
@end
