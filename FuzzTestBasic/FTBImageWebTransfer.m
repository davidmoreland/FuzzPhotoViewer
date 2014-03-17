//  Fuzz Test Basic
//  Web Transfers
//
// IOS 7 using  URL Session Class
//
//
// By David Moreland  03.11.14
//

#import "FTBImageWebTransfer.h"

#define kResponseTimeOut = 20;

@interface FTBImageMWebTransfer ()
{
    NSMutableArray *photoArray;
}
//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
//@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic)double downloadProgress;

@property (nonatomic) NSURLSessionDownloadTask *downloadTask1;

@property (nonatomic, strong) NSDate *startDownloadTime;
@property (nonatomic) int fileSize;
@property (nonatomic) int responseWatchDog;
@property (nonatomic, strong) NSURL *dataURL;
@property (nonatomic, strong) NSURL *imageURL;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) FTBAppDelegate *appDelegate;
@end


@implementation FTBImageMWebTransfer

-(FTBImageMWebTransfer *)init
{
    _responseWatchDog = 0;
    
 self.appDelegate = (FTBAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    self.startDownloadTime = [NSDate date];
    //DEBUG
    // NSLog(@"Start Time: %@",self.startDownloadTime);
    
    return self;
}


- (NSURLSession *)session2
{
    static NSURLSession *session2 = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
		session2 = [NSURLSession sessionWithConfiguration:configuration delegate:self.self delegateQueue:nil];
        configuration.timeoutIntervalForRequest = 20;
        
	});
  	return session2;
    
}


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
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            session = nil;
            }
            else
            {  // Download is IMAGE
                [self cancelDownload];
            }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}



-(void)getImage:(NSString *)imageURLString
{
     [self session2];
    
  //  UIImage *image;
   
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
	
     NSURLSessionDownloadTask *imageDownloadTask = [self.session2 downloadTaskWithRequest:request];
  //  NSURLSessionDownloadTask *imageDownloadTask = [[self session2] downloadTaskWithURL:imageURL];
    [imageDownloadTask resume];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
}

/***8
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    NSData *data = [NSData dataWithContentsOfURL:location];
    
   // dispatch_async(dispatch_get_main_queue(), ^{
    
    //  [self.progressView setHidden:YES];
        [self.imageView setImage:[UIImage imageWithData:data]];
        UIImage *image = [UIImage imageWithData:data];
        
        // add image to Array
     //   self.appDelegate.photoArray; = image;
        self.allTVC.cellImage = image;
        
       // self.appDelegate.photoArray:[self.indexPath.row] = image;
        
   // [self.allTVC.cellImage setImage:[UIImage imageWithData:data]];
        NSLog(@" Image in Session: %@", self.allTVC.cellImage);
        
   // });
   
}
***/

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    // We've successfully finished the download. Let's save the file
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *URLs = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = URLs[0];
    
    NSURL *destinationPath = [documentsDirectory URLByAppendingPathComponent:[location lastPathComponent]];
    NSError *error;
    
    // Make sure we overwrite anything that's already there
 //   [fileManager removeItemAtURL:destinationPath error:NULL];
    BOOL success = [fileManager copyItemAtURL:location toURL:destinationPath error:&error];
    
    if (!error)
    {
     //   dispatch_async(dispatch_get_main_queue(), ^{
            
      //  NSData *data = [NSData dataWithContentsOfURL:location];
        NSData *data = [NSData dataWithContentsOfFile:[destinationPath path]];
        
           UIImage *dataImage = [UIImage imageWithData:data];
        //    NSLog(@"dataImage %@",dataImage);
            
        UIImage *image = [UIImage imageWithContentsOfFile:[destinationPath path]];
            NSLog(@"image %@",image);

            if(!self.appDelegate.photoArray)
            {
                if(dataImage)
                {
                    self.appDelegate.photoArray = [[NSMutableArray alloc]initWithObjects:dataImage, nil];
                NSLog(@"ImageTransfer - PhotoArray: %@",self.appDelegate.photoArray[self.row]);
                }
            }
            else
            {
                if(dataImage)
                {
                    self.appDelegate.photoArray[self.row] = dataImage;
                NSLog(@"ImageTransfer - PhotoArray: %@",self.appDelegate.photoArray[self.row]);
                }
            }
            

       // });

    }
    else
    {
        NSLog(@"Couldn't copy the downloaded file");
    }
    session = nil;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}

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
