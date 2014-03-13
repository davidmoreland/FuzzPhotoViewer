//
//  FTB_ALLTableViewController.h
//  FuzzTestBasic
//
//  Created by Dave on 3/11/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTB_ALLTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *fetchedDataArray;
@property (nonatomic, strong) UIImageView *cellImageView;
@property (nonatomic, strong) UIImage *cellImage;

@end
