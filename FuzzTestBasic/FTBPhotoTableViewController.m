//
//  FTBPhotoTableViewController.m
//  FuzzTestBasic
//
//  Created by Dave on 3/12/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import "FTBPhotoTableViewController.h"
#import "FTBPhotoCell.h"
#import "FTBImageWebTransfer.h"

@interface FTBPhotoTableViewController ()
@end

@implementation FTBPhotoTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.appDelegate = (FTBAppDelegate *) [[UIApplication sharedApplication] delegate];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.appDelegate.mainFuzzDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PhotoCell";
    FTBPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(!cell)
    {
        cell = [[FTBPhotoCell alloc]init];
    }
    
    // Configure the cell...
    [self configureCell:cell atIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

-(UITableViewCell *)configureCell:(FTBPhotoCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *cellDataDictionary = self.appDelegate.mainFuzzDataArray[indexPath.row];
      NSString *dataType = [cellDataDictionary objectForKey:   @"type"];
    
    if([dataType isEqualToString:@"image"])
    {
        //get image from web
        [self loadImageFromURL:[cellDataDictionary objectForKey:@"data"] atIndexRow:indexPath];
       
        if(indexPath.row == [self.appDelegate.photoArray count])
        {
        cell.imageView.image = self.appDelegate.photoArray[indexPath.row];
        
        NSLog(@"______________________");
        NSLog(@"______________________");
        NSLog(@"Image: %@",cell.imageView.image);
        NSLog(@"______________________");
        NSLog(@"______________________");
        }
    }
    //   cell.dataImage = [UIImage imageWithData:;;]
    return cell;
}


-(void)loadImageFromURL:(NSString *)URLString atIndexRow:(NSIndexPath *)indexPath
{
    FTBImageMWebTransfer *imageDownloader = [[FTBImageMWebTransfer alloc]init];
  //  imageDownloader.allTVC = self;
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
