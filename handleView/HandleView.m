//
//  HandleView.m
//  云台手柄
//
//  Created by pqtel02 on 16/11/2.
//  Copyright © 2016年 pqtel02. All rights reserved.
//

#import "HandleView.h"
//#import "gbt28181.h"

@interface HandleView()
{
    UIView *_hand;
    CGPoint _currentCenter;
    CGFloat _radius;
    int _handleNum;
}
@end

@implementation HandleView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    _radius = rect.size.width/2;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(2, 2, rect.size.width-4, rect.size.width-4)];
    view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    view.alpha = 0.5;
    view.layer.cornerRadius = view.frame.size.width/2;
    [self addSubview:view];
    _hand = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width/2, view.frame.size.width/2)];
    _hand.center = view.center;
    _hand.backgroundColor = [UIColor colorWithRed:240/255.0 green:235.0/255.0 blue:211/255.0 alpha:0.7];
    _hand.layer.cornerRadius = _hand.frame.size.width/2;
    
    _hand.layer.shadowColor=[[UIColor grayColor] colorWithAlphaComponent:0.8].CGColor;
    _hand.layer.shadowOffset=CGSizeMake(0,5);
    _hand.layer.shadowOpacity=0.5;
    
    [self addSubview:_hand];
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGr:)];
    [_hand addGestureRecognizer:panGes];
    
    
}



- (void)panGr:(UIPanGestureRecognizer *)pan
{
    CGPoint point2 = [pan translationInView:self];
    
    CGPoint point;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            _currentCenter = _hand.center;
            break;
        case UIGestureRecognizerStateChanged:
            
            
            if (fabs(point2.x)> _radius || fabs(point2.y) > _radius)
            {
                CGFloat x = _radius * sqrt(point2.x*point2.x/(point2.x*point2.x+point2.y*point2.y));
                CGFloat y = sqrt(_radius*_radius - x*x);
                
                if (point2.x < 0) {
                    x = -x;
                }
                if (point2.y < 0) {
                    y = -y;
                }
                point = CGPointMake(x, y);
                
            }
            else
            {
                point = point2;
            }

            _hand.center = CGPointMake(_currentCenter.x+point.x, _currentCenter.y+point.y);
            
            //代理返回是哪个方向
            if ([_delegate respondsToSelector:@selector(returnPosition:)]) {
                if (-point.y < point.x/2 && -point.y > -point.x/2) {
                    //向右
                    if (_handleNum != 1/*PTZRIGHT*/) {
                        _handleNum = 1;//PTZRIGHT;
                        [_delegate returnPosition:_handleNum];
                    }
                }
                else if(-point.y < -point.x/2 && -point.y > -2*point.x)
                {
                    //向右下
                    if (_handleNum != 2/*PTZDOWN_RIGHT*/) {
                        _handleNum = 2;//PTZDOWN_RIGHT;
                        [_delegate returnPosition:_handleNum];
                    }
                }
                else if(-point.y < -2*point.x && -point.y < 2 * point.x)
                {
                    //向下
//                    NSLog(@"~~~~~~向下%@",NSStringFromCGPoint(point));
//                    [_delegate returnPosition:-1];
                    if (_handleNum != 3/*PTZDOWN*/) {
                        _handleNum = 3;//PTZDOWN;
                        [_delegate returnPosition:_handleNum];
                    }
                }
                else if (-point.y > 2*point.x && -point.y < point.x / 2)
                {
                    //向左下
//                    [_delegate returnPosition:-3];
                    if (_handleNum != 4/*PTZDOWN_LEFT*/) {
                        _handleNum = 4;//PTZDOWN_LEFT;
                        [_delegate returnPosition:_handleNum];
                    }
                }
                else if(-point.y > point.x /2 && -point.y < -point.x/2)
                {
                    //向左
//                   [_delegate returnPosition:-2];
                    if (_handleNum != 5/*PTZLEFT*/) {
                        _handleNum = 5;//PTZLEFT;
                        [_delegate returnPosition:_handleNum];
                    }
                }
                else if (-point.y > -point.x/2 && -point.y < -2*point.x)
                {
                    //向左上
//                    [_delegate returnPosition:-4];
                    if (_handleNum != 6/*PTZUP_LEFT*/) {
                        _handleNum = 6;//PTZUP_LEFT;
                        [_delegate returnPosition:_handleNum];
                    }
                }
                else if (-point.y > -2*point.x && -point.y > 2*point.x)
                {
                    //向上
//                    NSLog(@"向上");
//                    [_delegate returnPosition:1];
                    if (_handleNum != 7/*PTZUP*/) {
                        _handleNum = 7;//PTZUP;
                        [_delegate returnPosition:_handleNum];
                    }
                }
                else if (-point.y < 2 * point.x && -point.y > point.x/2)
                {
                    //向右上
//                    NSLog(@"向右上");
//                    [_delegate returnPosition:3];
                    if (_handleNum != 8/*PTZUP_RIGHT*/) {
                        _handleNum = 8;//PTZUP_RIGHT;
                        
                    }
                }
            
            }
            break;
        case UIGestureRecognizerStateEnded:
            {
                _handleNum = 0;
                [UIView animateWithDuration:0.2 animations:^{
               _hand.center = _currentCenter;
                }];
                [_delegate returnPosition:0/*PTZSTOP*/];
            break;
            }
        default:
            break;
    }
    
}


@end
