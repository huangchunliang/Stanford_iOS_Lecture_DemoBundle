//
//  DropItBehavior.m
//  stanford_iOS_8_DropIt
//
//  Created by Shijie Sun on 16/7/6.
//  Copyright © 2016年 Shijie. All rights reserved.
//

#import "DropItBehavior.h"

@interface DropItBehavior()

@property (nonatomic, retain) UIGravityBehavior *gravity;
@property (nonatomic, retain) UICollisionBehavior *collider;

@end

@implementation DropItBehavior

- (instancetype)init
{
    self = [super init];
    
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collider];
    
    return self;
}

- (void)addItem:(id<UIDynamicItem>)item
{
    [self.gravity addItem:item];
    [self.collider addItem:item];
}

- (void)removeItem:(id<UIDynamicItem>)item
{
    [self.gravity removeItem:item];
    [self.collider removeItem:item];
}

- (UIGravityBehavior *)gravity
{
    if (!_gravity) {
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 1.9;
    }
    return _gravity;
}

- (UICollisionBehavior *)collider
{
    if (!_collider) {
        _collider = [[UICollisionBehavior alloc] init];
        _collider.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collider;
}



@end
