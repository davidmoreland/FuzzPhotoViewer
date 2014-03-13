//
//  FTBAllContentCell.h
//  FuzzTestBasic
//
//  Created by Dave on 3/11/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTBAllContentCell : UITableViewCell
@property (nonatomic, strong) NSString *description;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *dataID;

@property (weak, nonatomic) IBOutlet UITextField *dataType;
//@property (weak, nonatomic) IBOutlet UITextField *data;
@property (weak, nonatomic) IBOutlet UITextView *data;

@end
