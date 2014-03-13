

@interface DCMWebTransfer : UIViewController <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSArray *fuzzDataArray;
@property (nonatomic) BOOL isImage;

-(void) start;
-(BOOL)cancelDownload;
//-(UIImage *)getImage:(NSString *)imageURLString;

@end
