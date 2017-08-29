//
//  HandleView.h
//  云台手柄
//
//  Created by pqtel02 on 16/11/2.
//  Copyright © 2016年 pqtel02. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HandleDelegate <NSObject>

-(void)returnPosition:(int)num;
// 如果0<num<1 向右
// num>1 向上
//num < -1 向

@end

@interface HandleView : UIView

@property (nonatomic, weak)id<HandleDelegate>delegate;

@end
