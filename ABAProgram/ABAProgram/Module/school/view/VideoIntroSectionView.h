//
//  VideoIntroSectionView.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/12.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^VideoIntroHandle)(void);
@interface VideoIntroSectionView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *jiantouIcon;

- (void)didClickedVideoIntro:(VideoIntroHandle)handle;
@end
