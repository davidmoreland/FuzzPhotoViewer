//
//  FTB_ALLTableViewController.m
//  FuzzTestBasic
//
//  Created by Dave on 3/11/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import "FTB_ALLTableViewController.h"
//#import "DCMWebTransfer.h"
#import "FTBAllContentCell.h"
#import "FTBImageWebTransfer.h"


@interface FTB_ALLTableViewController ()
@property (nonatomic, strong) FTBAppDelegate *appDelegate;
//@property (nonatomic, strong) int tableRow;
//@property (weak, nonatomic) IBOutlet FTBAllContentCell *allContentCell;
@end

@implementation FTB_ALLTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.appDelegate = (FTBAppDelegate *) [[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.cellImage = [[UIImage alloc]init];
    self.cellImageView = [[UIImageView alloc]init];
    
       self.appDelegate = (FTBAppDelegate *) [[UIApplication sharedApplication] delegate];
        
    NSLog(@"Fetched Data Count: %lu", (unsigned long)[self.appDelegate.mainFuzzDataArray count]);
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.appDelegate.mainFuzzDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AllCell";
    FTBAllContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    if(!cell)
    {
        cell = [[FTBAllContentCell alloc]init];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


-(UITableViewCell *)configureCell:(FTBAllContentCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *cellDataDictionary = self.appDelegate.mainFuzzDataArray[indexPath.row];
    cell.dataID.text =[cellDataDictionary objectForKey:@"id"];
    cell.dataType.text = [cellDataDictionary objectForKey:   @"type"];
    cell.data.text = [cellDataDictionary objectForKey:@"data"];
    
    if([cell.dataType.text isEqualToString:@"image"])
    {
        //get image from web
        [self loadImageFromURL:[cellDataDictionary objectForKey:@"data"] atIndexRow:indexPath];
        
        cell.imageView.image = self.cellImageView.image;
        
        NSLog(@"______________________");
        NSLog(@"______________________");
        NSLog(@"Image: %@",cell.imageView.image);
        NSLog(@"______________________");
        NSLog(@"______________________");

    }
    
 //   cell.dataImage = [UIImage imageWithData:;;]
    return cell;
}

-(void)loadImageFromURL:(NSString *)URLString atIndexRow:(NSIndexPath *)indexPath
{
    FTBImageMWebTransfer *imageDownloader = [[FTBImageMWebTransfer alloc]init];
    imageDownloader.allTVC = self;
    imageDownloader.indexPath = indexPath;
    
    [imageDownloader getImage:URLString];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
