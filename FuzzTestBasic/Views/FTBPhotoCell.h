//
//  FTBAllPhotoCell.h
//  FuzzTestBasic
//
//  Created by Dave on 3/11/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTBPhotoCell : UITableViewCell
@property (nonatomic, strong) NSString *description;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
