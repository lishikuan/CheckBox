//
//  HomeHeaderView.m
//  CheckBox
//
//  Created by lsm on 16/12/19.
//  Copyright © 2016年 lsm. All rights reserved.
//

#import "HomeHeaderView.h"
#import "SDCycleScrollView.h"
#import "MJRefresh.h"

@interface HomeHeaderView () <SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIView *baseContentView;  /* 内容视图123*/

@end
@implementation HomeHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addContentView];
        
    }
    
    return self;
}
#pragma - custom method
- (void)addContentView
{
    [self addSubview:self.baseContentView];
    
}

- (void)customedButtonPressed:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerViewCustomedButtonPressed:)])
    {
        [self.delegate headerViewCustomedButtonPressed:button];
    }
}

#pragma mark - SDCycleScrollView Delegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerViewCycleScrollView:didSelectItemAtIndex:)])
    {
        [self.delegate headerViewCycleScrollView:cycleScrollView didSelectItemAtIndex:index];
    }
}

#pragma mark - Setters && Getters

- (UIView *)baseContentView
{
    if (!_baseContentView)
    {
        CGFloat height = (CYCLE_HEIGHT) / 375.0 * WIDTH;
        
        _baseContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, height)];
        _baseContentView.backgroundColor = [UIColor hexStringToColor:@"f4f4f4"];
        
        [_baseContentView addSubview:self.cycleScrollView];
        
    }
    
    return _baseContentView;
}

- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView)
    {
        CGFloat cycleScrollViewHeight = CYCLE_HEIGHT / 375.0 * WIDTH;
        
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, cycleScrollViewHeight) delegate:self placeholderImage:[JFUtils imageWithColor:[UIColor hexStringToColor:@"f4f4f4"] size:CGSizeMake(WIDTH, cycleScrollViewHeight)]];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"trreatment_dot"];
        _cycleScrollView.pageDotImage = [UIImage imageNamed:@"trreatment_emptydot"];
        _cycleScrollView.autoScrollTimeInterval = 3.0;
    }
    
    return _cycleScrollView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
