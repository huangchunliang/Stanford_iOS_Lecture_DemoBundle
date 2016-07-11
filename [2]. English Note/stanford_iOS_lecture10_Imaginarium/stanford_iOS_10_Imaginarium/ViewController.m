//
//  ViewController.m
//  stanford_iOS_10_Imaginarium
//
//  Created by Shijie Sun on 16/7/8.
//  Copyright © 2016年 Shijie. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[ImageViewController class]]) {
       
        ImageViewController *imageVC = (ImageViewController *)segue.destinationViewController;
        
        NSString *string = nil;
        if ([segue.identifier isEqualToString:@"paint"]) {
            
            string = @"https://lh6.ggpht.com/ZoD88QrTxZbZnhpJgQbo9SPuosryX9ujjdRaHvjjvbUGeZcI-9C4AFQsWQm7-pVDv1E=h900";
       
        }else if ([segue.identifier isEqualToString:@"earth"])
        {
            string = @"http://news.nationalgeographic.com/content/dam/news/2016/02/12/01asteroidearth.jpg";
            
        }else if ([segue.identifier isEqualToString:@"night"])
        {
            string = @"https://lh5.ggpht.com/j4C_pXnbRc5FnxNO90wIqodn4QA3f_6rB0cyu2sVnCeSwLDmyZf-xSrC9L8c3oxr6NE=h900";
        }
        
        imageVC.imageURL = [NSURL URLWithString:string];
        imageVC.title = segue.identifier;
    }
}
@end
