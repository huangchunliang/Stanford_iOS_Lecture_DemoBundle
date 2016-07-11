//
//  DropItBehavior.h
//  stanford_iOS_8_DropIt
//
//  Created by Shijie Sun on 16/7/6.
//  Copyright © 2016年 Shijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropItBehavior : UIDynamicBehavior

- (void)addItem:(id<UIDynamicItem>)item;
- (void)removeItem:(id<UIDynamicItem>)item;


@end
