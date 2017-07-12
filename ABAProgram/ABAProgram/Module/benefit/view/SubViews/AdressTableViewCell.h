//
//  AdressTableViewCell.h
//  ABAProgram
//
//  Created by 张宇轩 on 2017/7/10.
//  Copyright © 2017年 宇轩. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetReceiptAdressModel.h"

@protocol AdressDelegate;

@interface AdressTableViewCell : UITableViewCell

@property (nonatomic, assign) id<AdressDelegate>delegate;
@property (nonatomic, strong) GetReceiptAdressModel *adressModel;

@end


@protocol AdressDelegate <NSObject>

- (void)addAdressAction;

@end
