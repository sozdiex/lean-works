//
//  SectorCell.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 17/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "SectorCell.h"
#import "CustomAlertViewController.h"

@implementation SectorCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {}
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showDetail:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:self.sectorName message:self.sectorDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end
