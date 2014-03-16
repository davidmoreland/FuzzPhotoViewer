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
    int tablerow = indexPath.row;
    
    NSDictionary *cellDataDictionary = self.appDelegate.mainFuzzDataArray[tablerow];
      NSString *dataType = [cellDataDictionary objectForKey:   @"type"];
    
    // image loading
        if([dataType isEqualToString:@"image"])
    {
        NSString *dataURL = [cellDataDictionary objectForKey:@"data"];

        //get image from web
        [self loadImageFromURL:dataType atIndexRow:tablerow];
        if([self.appDelegate.photoArray count] == indexPath.row +1)
        {
            //   cell.imageView.image = self.appDelegate.photoArray[indexPath.row];
            
            NSLog(@"______________________");
            NSLog(@"______________________");
            NSLog(@"Image: %@",self.appDelegate.photoArray[indexPath.row]);
            NSLog(@"______________________");
            NSLog(@"______________________");
            
            cell.imageView.image = self.appDelegate.photoArray[indexPath.row];
        }
    }
    else
    {
        if(!self.appDelegate.photoArray)
        {
            self.appDelegate.photoArray = [[NSMutableArray alloc]init];
            self.appDelegate.photoArray[indexPath.row] = @"n/a";
            
        }
        else
        {
            //   self.appDelegate.photoArray[indexPath.row] = @"n/a";
        }
    }
    //   cell.dataImage = [UIImage imageWithData:;;]
    return cell;
           return cell;
}


-(UIWebView *)loadImageFromURL:(NSString *)URLString atIndexRow:(int)row
{
    
    
   NSURL *url = [NSURL URLWithString:URLString];
    
    NSURLRequest *urlRequest =[NSURLRequest requestWithURL:url];
   
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:nil completionHandler:nil];
    
    //[self.webView loadRequest:self.urlRequest];
    UIWebView *imageView;
    [imageView loadRequest:urlRequest];
    
    return imageView;
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
