//  Fuzz Test Basic
//  Web Transfers
//
// IOS 7 using  URL Session Class
//
//
// By David Moreland  03.11.14
//

#import "DCMWebTransfer.h"

#define kResponseTimeOut = 20;

static NSString *FuzzTestDataURLString = @"http://dev.fuzzproductions.com/MobileTest/test.json";


@interface DCMWebTransfer ()
{
  

}
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic)double downloadProgress;

@property (nonatomic) NSURLSession *session1;

@property (nonatomic) NSURLSessionDownloadTask *downloadTask1;

@property (nonatomic, strong) NSDate *startDownloadTime;
@property (nonatomic) int fileSize;
@property (nonatomic) int responseWatchDog;
@property (nonatomic, strong) NSURL *dataURL;
@property (nonatomic, strong) NSURL *imageURL;

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) FTBAppDelegate *appDelegate;
@end


@implementation DCMWebTransfer

-(DCMWebTransfer *)init
{
    _responseWatchDog = 0;
    
  //  self.session1 = [self session1];
    self.isImage = NO;
       [self start];
   
    self.startDownloadTime = [NSDate date];
    //DEBUG
    // NSLog(@"Start Time: %@",self.startDownloadTime);
    
    return self;
}


- (void)start
{
    [self session1];
    
    self.dataURL = [NSURL URLWithString:FuzzTestDataURLString];
    
	NSURLRequest *request1 = [NSURLRequest requestWithURL:self.dataURL];
	
    self.downloadTask1 = [self.session1 downloadTaskWithRequest:request1];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

    [self.downloadTask1 resume];
   
 }
- (NSURLSession *)session1
{
    static NSURLSession *session1 = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
		session1 = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        configuration.timeoutIntervalForRequest = 20;
        
	});
  	return session1;

}
/****
- (NSURLSession *)session2
{
    static NSURLSession *session2 = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
		session2 = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        configuration.timeoutIntervalForRequest = 20;
        
	});
  	return session2;
    
}
***/

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
  //  if (downloadTask == self.downloadTask1)
  //  {
        double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
        self.downloadProgress = progress;
        
        NSLog (@"Number of Bytes: %lld", totalBytesWritten);
        
        NSLog(@"Progress of download: %f", self.downloadProgress);
        
        
        // Not Used in Basic Fuzz Test App
    /*    [[NSNotificationCenter defaultCenter] postNotificationName:kSGDownloadProgressNotification
                                                            object:self
                                                          userInfo:@{@"progress" :@((self.downloadProgress))}];
     */
        
  //  }
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
  
        if (error == nil)
        {
            if(!self.isImage)  // Downloading Json Data  when app first runs
            {
            FTBAppDelegate *appDelegate = (FTBAppDelegate *) [[UIApplication sharedApplication] delegate];
      
            NSURLSessionDataTask *fetchedFuzzDataTask = [self.session1
                                         dataTaskWithURL:self.dataURL
                                        completionHandler:^(NSData *data,
                                                              NSURLResponse *response,NSError *error) {
                                            
                        self.fuzzDataArray =  [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingAllowFragments
                                                 error:&error];
                            
                                            // load application Array with data
                                            appDelegate.mainFuzzDataArray = [self.fuzzDataArray copy];
                                            self.fuzzDataArray = nil;
                                            
                        
                                    }];
                
            [fetchedFuzzDataTask resume];
                
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                self.session1 = nil;
            }
            else
            {  // Download is IMAGE
       
            
            }
      
        }
        else
        {  // Download EROR
        [self cancelDownload];
        }
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}


/****
-(UIImage *)getImage:(NSString *)imageURLString
{
     [self session2];
    
     UIImage __block *image;
   
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:imageURL];
	
  //  self.downloadTask1 = [self.session1 downloadTaskWithRequest:request1];
    NSURLSessionDataTask *imageDataTask = [self.session2 dataTaskWithRequest:request2];
    
   /***
    NSURLSessionDownloadTask *getImageTask =
    [self.session2 downloadTaskWithURL:imageURL
               completionHandler:^(NSURL *location,
                                   NSURLResponse *response,
                                   NSError *error) {
                 
                   UIImage *downloadedImage =
                   [UIImage imageWithData:
                    [NSData dataWithContentsOfURL:location]];
                 
                   dispatch_async(dispatch_get_main_queue(), ^{
                       
                       NSLog(@"Downloaded location: %@",location);
                       
                       image = downloadedImage;
                       NSLog(@"Downloaded Image: %@",image);

                   });
               }];
    
    
    [imageDataTask resume];
    
  //  [getImageTask resume];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
  
    return image;
    
}
****/

/*
 If an application has received an -application:handleEventsForBackgroundURLSession:completionHandler: message, the session delegate will receive this message to indicate that all messages previously enqueued for this session have been delivered. At this time it is safe to invoke the previously stored completion handler, or to begin any internal updates that will result in invoking the completion handler.
 */



/***  Not Implememnted in Test App
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
    FTBAppDelegate *appDelegate = (FTBAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.backgroundSessionCompletionHandler) {
        void (^completionHandler)() = appDelegate.backgroundSessionCompletionHandler;
        appDelegate.backgroundSessionCompletionHandler = nil;
        completionHandler();
      
        // NSLog(@"\n\n");
        // NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
        // NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
        // NSLog(@"END BackGround Session #1 ");
        // NSLog(@"\n\n");
        // NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
        // NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
    }

 }

***/


-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
  //    BLog();
}

-(BOOL)cancelDownload
{
    if (_downloadTask1.state == NSURLSessionTaskStateRunning) {
        [_downloadTask1 cancel];
        return YES;
}
    else return NO;
}

-(void)dealloc
{
}
@end
