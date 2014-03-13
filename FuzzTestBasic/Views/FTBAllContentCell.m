//
//  FTBAllContentCell.m
//  FuzzTestBasic
//
//  Created by Dave on 3/11/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import "FTBAllContentCell.h"

@implementation FTBAllContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.imageView.image = nil;
       self.dataID = nil;
       self.description = nil;
    self.dataType = nil;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
