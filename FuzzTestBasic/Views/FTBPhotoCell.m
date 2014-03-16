//
//  FTBPhotoCell.m
//  FuzzTestBasic
//
//  Created by Dave on 3/11/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import "FTBPhotoCell.h"
@interface FTBPhotoCell()
{
    
}

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation FTBPhotoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
     
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
