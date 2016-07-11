//
//  ImageViewController.m
//  stanford_iOS_10_Imaginarium
//
//  Created by Shijie Sun on 16/7/8.
//  Copyright © 2016年 Shijie. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()<UIScrollViewDelegate>

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UIImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;


@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView addSubview:self.imageView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}




- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self startDownloading];
    
    

}

- (void)startDownloading
{
    self.image = nil;
   
    if (self.imageURL) {
        
        [self.spinner startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if(!error){
                
                //check if 'someone'changed the url
                if ([request.URL isEqual:self.imageURL])
                {
                    //finish downloading, get the local url
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                    
                    //get the main queue
                    dispatch_async(dispatch_get_main_queue(), ^{

                        //up date the UI
                        self.image = image;
                    });
                }
            }
        }];
        
        [task resume];
    }
}


- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollView.minimumZoomScale = 0.2;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.delegate = self;
    self.scrollView.contentSize = self.image? self.image.size : CGSizeZero;
}

- (UIImage*)image
{
    return self.imageView.image;
}

/**
 *  after setting the image, reset the imageView and contentSize
 *
 *  @param image new image
 */
- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.scrollView.contentSize = self.image? self.image.size : CGSizeZero;
    [self.spinner stopAnimating];
}

@end
