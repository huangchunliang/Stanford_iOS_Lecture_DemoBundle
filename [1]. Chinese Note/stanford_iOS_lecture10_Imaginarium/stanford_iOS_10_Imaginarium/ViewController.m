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

//sky
//http://ilovehdwallpapers.com/walls/red-planet-snow-fantasy-stars-night-stones-4k-moon-mountains-HD.jpg
//http://api.ning.com/files/0SWrRKB19QLnhWk275JoEDfNxPrSkalOWbPxHI8VXibxzB3U0z4DDcA9HvUKlTUPzQaf3Js0KHFahU3vxZH2BX3CRUeVi-cH/SPACEFULLHDWALLPAPER26.jpg  earth
//https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=&url=http%3A%2F%2Fwww.young.lv%2Fru%2Fwp-content%2Fuploads%2F2016%2F03%2Fnature__039052_.jpg&psig=AFQjCNGWzc5XGvSDA3X6A4eHuNT-cVV8Tw&ust=1468035882946032 night


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
