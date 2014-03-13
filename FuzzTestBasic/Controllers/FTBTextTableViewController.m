//
//  FTBTextTableViewController.m
//  FuzzTestBasic
//
//  Created by Dave on 3/12/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import "FTBTextTableViewController.h"
#import "FTBTextContentCell.h"

@interface FTBTextTableViewController ()

@end

@implementation FTBTextTableViewController


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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of sections.
    
    NSLog(@" Number of Rows - TEXT %lu", (unsigned long)[self.appDelegate.mainFuzzDataArray count]);
    
    return [self.appDelegate.mainFuzzDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"TextContentCell";
        FTBTextContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if(!cell)
        {
            cell = [[FTBTextContentCell alloc]init];
        }

    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

    
-(UITableViewCell *)configureCell:(FTBTextContentCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
        
        NSDictionary *cellDataDictionary = self.appDelegate.mainFuzzDataArray[indexPath.row];
    
        cell.dataID.text =[cellDataDictionary objectForKey:@"id"];
        cell.dataType.text = [cellDataDictionary objectForKey:   @"type"];
        cell.data.text = [cellDataDictionary objectForKey:@"data"];
        
        return cell;
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
