//
//  FTBTextTableViewController.h
//  FuzzTestBasic
//
//  Created by Dave on 3/12/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTBTextTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) FTBAppDelegate *appDelegate;
@end
