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
    // Do any additional setup after loading the view.
    [self.scrollView addSubview:self.imageView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}



//- (void)setImageURL:(NSURL *)imageURL
//{
//    _imageURL = imageURL;
//    //会阻塞线程
//    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
//}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self startDownloading];
    
    

}

- (void)startDownloading
{
    //先清空现有图片
    self.image = nil;
   
    if (self.imageURL) {
        
        [self.spinner startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        NSURLSession *session2 = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
                                  
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if(!error){
                
                //判断URL是否被更改，因为这是一个异步操作，无法保证在下载过程中一定能保持原来的数据
                if ([request.URL isEqual:self.imageURL])
                {
                    //下载完成，拿到本地的路径
                    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
                    
                    //获得主队列
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //在主队列更新UI
                        self.image = image;
                    });
                }
            }
        }];
        
        [task resume];
    }
}

- (void)mainQueueCallBack
{
    NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
         //这里是主队列，可以更新UI
        
    }];
    
    [task resume];
}

- (void)noDelegateQueueRequest
{
    NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
    }];
    
    [task resume];
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
 *  设置图片后，重新imageView的图片和自己的大小，并设置contentSize
 *
 *  @param image <#image description#>
 */
- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.scrollView.contentSize = self.image? self.image.size : CGSizeZero;
    [self.spinner stopAnimating];
}

@end
