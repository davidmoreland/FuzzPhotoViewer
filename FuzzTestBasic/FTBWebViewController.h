//
//  FTBWebViewController.h
//  FuzzTestBasic
//
//  Created by Dave on 3/11/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTBWebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSURLRequest *urlRequest;

@end
