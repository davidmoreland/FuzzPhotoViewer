#import "FTB_ALLTableViewController.h"

@interface FTBImageMWebTransfer : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) FTB_ALLTableViewController *allTVC;
@property (nonatomic) NSIndexPath *indexPath;

-(BOOL)cancelDownload;
-(void)getImage:(NSString *)imageURLString;

@end
