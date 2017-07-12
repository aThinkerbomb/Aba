//
//  BabyGoodDetalViewController.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/1.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger, GoodChooseStyle) {
    
    GoodChooseStyleTeach = 1,
    GoodChooseStyleClass
    
};




@interface BabyGoodDetalViewController : BaseViewController

@property (nonatomic, copy) NSString * institutionId;
@property (nonatomic, assign) GoodChooseStyle style;


@end
