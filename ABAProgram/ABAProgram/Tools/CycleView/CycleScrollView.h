//
//  CycleScrollView.h
//  CycleScrollView
//
//  Created by 张宇轩 on 16/4/18.
//  Copyright © 2016年 Tintin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CyclePageAlignment) {
    CCPageAlignmentRight = 0,
    CCPageAlignmentCenter = 1,
    CCPageAlignmentLeft = 2,
};
typedef void (^SourceAtIndex)(NSInteger currentIndex , UIImageView * imageView);//图片显示什么由外面决定

typedef void (^SourceIndexHandle)(NSInteger indexClick);//点击的block

@interface CycleScrollView : UIView
@property(nonatomic,weak)NSTimer * timer;

/**
 当前显示的block回调
 */
@property(nonatomic, copy)SourceAtIndex sourceIndex;
/**
 点击第几个回调
 */
@property(nonatomic, copy)SourceIndexHandle  sourceHandler;
/**
 是否显示pageControl
 */
@property(nonatomic, assign)BOOL showPageControl;
/**
 pageControl的位置
 */
@property(nonatomic, assign)CyclePageAlignment pageAligment;

/*
  设置默认显示第几个位置的资源
 */
@property(nonatomic,assign)NSInteger currentIndex;


//初始化方法
//-(instancetype)initWithFrame:(CGRect)frame totleCount:(NSInteger)totleCount;
//
//-(instancetype)initWithFrame:(CGRect)frame totleCount:(NSInteger)totleCount sourceHandler:(SourceIndexHandle)sourceHandler;


-(instancetype)initWithFrame:(CGRect)frame totleCount:(NSInteger)totleCount currentIndexShow:(SourceAtIndex)sourceIndex sourceHandler:(SourceIndexHandle)sourceHandler;

- (void)startScrollAnimation;//开始自动滚动

@end
