//
//  HomeHeaderView.h
//  CheckBox
//
//  Created by lsm on 16/12/19.
//  Copyright © 2016年 lsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CYCLE_HEIGHT 190
#define PROMISE_HEIGHT 100
#define MAIN_SELL_HEIGHT 100
#define SELECTION_LABEL_HEIGHT 20
#define SELECTION_VIEW_HEIGHT 165
#define COLLECTION_LABEL_HEIGHT 20
@class SDCycleScrollView;

@protocol HomeHeaderViewDelegate <NSObject>

/**
 *  顶部轮播图点击
 *
 *  @param cycleScrollView
 *  @param index
 */
- (void)headerViewCycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

/**
 *  自定义按钮区域点击
 *
 *  @param button
 */
- (void)headerViewCustomedButtonPressed:(UIButton *)button;

/**
 *  医疗保险按钮点击
 *
 *  @param button
 */
- (void)headerViewInsureButtonPressed:(UIButton *)button;

/**
 *  金融服务按钮点击
 *
 *  @param button
 */
- (void)headerViewFinancialButtonPressed:(UIButton *)button;

/**
 *  贝贝壳精选按钮点击
 *
 *  @param button
 */
- (void)headerViewSelectionButtonPressed:(UIButton *)button;

/**
 *  热销单品按钮点击
 *
 *  @param button
 */
- (void)headerViewSingleButtonPressed:(UIButton *)button;

@end
@interface HomeHeaderView :  UICollectionReusableView
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, assign) id<HomeHeaderViewDelegate> delegate;
@end
