//
//  ViewController.m
//  stanford_iOS_8_DropIt
//
//  Created by Shijie Sun on 16/7/6.
//  Copyright © 2016年 Shijie. All rights reserved.
//

#import "ViewController.h"
#import "DropItBehavior.h"

static const CGSize DROP_SIZE = {40, 40};

@interface ViewController ()<UIDynamicAnimatorDelegate>

@property (nonatomic, weak) IBOutlet UIView *gameView;
@property (nonatomic, retain) UIDynamicAnimator *animator;
@property (nonatomic, retain) DropItBehavior *dropitBehavior;

@end

@implementation ViewController

- (IBAction)tapGesture:(UITapGestureRecognizer *)sender {
    
    [self drop];
    
}

/**
 *  if there are full rows, then blow them up
 *
 *  @param animator animator
 */
- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    [self removeCompleteRows];
}

/**
 *  blow the full rows:check the rows then blow them
 */
- (void)removeCompleteRows
{
    NSMutableArray *dropsToRemove = [[NSMutableArray alloc] init];
    
    //check every rows
    for (CGFloat y = self.gameView.bounds.size.height - DROP_SIZE.height/2;y > 0;y-= DROP_SIZE.height) {
        
        BOOL rowIsComplete = YES;
        
        NSMutableArray *dropsFound = [[NSMutableArray alloc] init];
        
        for (CGFloat x = DROP_SIZE.width/2; x < self.gameView.bounds.size.width - DROP_SIZE.width/2; x+=DROP_SIZE.width) {
            
            //move(x,y),get the view which has this point
            UIView *hitView = [self.gameView hitTest:CGPointMake(x, y) withEvent:NULL];
            
            
            if ([hitView superview] == self.gameView) {
               
                //if the view's super view is gameView means its is a rock
                [dropsFound addObject:hitView];
                
            }else{
               
                //not a full row
                rowIsComplete = NO;
                break;
            }
        }
       
        if (![dropsFound count]) break;
        if (rowIsComplete)[dropsToRemove addObjectsFromArray:dropsFound];
    
    }
    
    //if there are full rows, blow them up
    if ([dropsToRemove count]){
        for (UIView *drop in dropsToRemove){
            [self.dropitBehavior removeItem:drop];
        }
        [self animatedRemovingDrops:dropsToRemove];
    }
    
    
}


- (void)animatedRemovingDrops:(NSArray *)dropsToRemove
{
    [UIView animateWithDuration:0.5 animations:^{
        
        for (UIView *drop in dropsToRemove) {
            
            //the position after being blow up
            int x = (arc4random()%(int)(self.gameView.bounds.size.width*5)) - (int)self.gameView.bounds.size.width*2;
            int y = self.gameView.bounds.size.height;
            drop.center = CGPointMake(x,-y);
        }
        
    } completion:^(BOOL finished) {
        [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }];
}



- (void)drop
{
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    int x = (arc4random()%(int)self.gameView.bounds.size.width)/DROP_SIZE.width;
    frame.origin.x = x * DROP_SIZE.width;
    
    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    dropView.backgroundColor = [self randomColor];
    [self.gameView addSubview:dropView];
    
    [self.dropitBehavior addItem:dropView];

}

- (UIColor *)randomColor
{
    switch (arc4random()%5) {
            
        case 0: return [UIColor redColor];
        case 1: return [UIColor blueColor];
        case 2: return [UIColor yellowColor];
        case 3: return [UIColor greenColor];
        case 4: return [UIColor purpleColor];
          
    }
    return [UIColor blackColor];
}



- (UIDynamicAnimator *)animator
{
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
        _animator.delegate = self;
    }
    return _animator;
}

- (DropItBehavior *)dropitBehavior
{
    if (!_dropitBehavior) {
        _dropitBehavior = [[DropItBehavior alloc] init];
        [self.animator addBehavior:_dropitBehavior];
    }
    return _dropitBehavior;
}


@end
