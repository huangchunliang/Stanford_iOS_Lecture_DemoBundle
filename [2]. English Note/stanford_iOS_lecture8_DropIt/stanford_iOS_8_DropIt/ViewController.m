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

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIView *gameView;
@property (nonatomic, retain) UIDynamicAnimator *animator;
@property (nonatomic, retain) DropItBehavior *dropitBehavior;

@end

@implementation ViewController

- (IBAction)tapGesture:(UITapGestureRecognizer *)sender {
    
    [self drop];
    
}


/**
 *  generate random rock then drop it
 */
- (void)drop
{
    //1. random position
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    int x = (arc4random()%(int)self.gameView.bounds.size.width)/DROP_SIZE.width;
    frame.origin.x = x * DROP_SIZE.width;
    
    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    
    //2. random color
    dropView.backgroundColor = [self randomColor];
    [self.gameView addSubview:dropView];
    
    //3. add drop behavior
    [self.dropitBehavior addItem:dropView];
    
}

/**
 *  get a random color
 *
 *  @return random color
 */
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
