//
//  FTBWebViewController.m
//  FuzzTestBasic
//
//  Created by Dave on 3/11/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import "FTBWebViewController.h"

@interface FTBWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation FTBWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

self.webView.delegate = self;

//  NSURL *url =[NSURL URLWithString:self.urlString];
//  NSURL *url = [NSURL URLWithString:@"www.microsoft.com"];

//NSString *formattedURLString = [self formattedURLString:kFuzzWebSiteURLString];


self.url = [NSURL URLWithString:kFuzzWebSiteURLString];

self.urlRequest =[NSURLRequest requestWithURL:self.url];
// NSLog(@" URL: %@", self.url);
// NSLog(@" FORMATTED URL STRING:  %@",formattedURLString);

// NSLog(@"URL Request:  %@", self.urlRequest);
// NSLog(@"URL String:  %@", self.urlString);

//  NSError *error;

//  NSURLResponse *response;
[NSURLConnection sendAsynchronousRequest:self.urlRequest queue:Nil completionHandler:nil];

[self.webView loadRequest:self.urlRequest];

//  AXPWebViewController *destinationViewController = (AXPWebViewController *)self.splitViewController.detailViewController;
// NSURLRequest *request = [NSURLRequest requestWithURL:self.url];

//  [destinationViewController.webView loadRequest:request];
// destinationViewController.title = @"Test Title";

// Do any additional setup after loading the view.
}


-(NSString *)formattedURLString:(NSString *)rawURLString
{
    NSString *urlstring = [@"http://" stringByAppendingString:rawURLString];
    
    return urlstring;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
