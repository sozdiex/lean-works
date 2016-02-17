//
//  SectorCell.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 17/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectorCell : UITableViewCell

@property (strong, nonatomic) NSString *sectorName;
@property (strong, nonatomic) NSString *sectorDescription;

@property (weak, nonatomic) IBOutlet UILabel *labelSectorName;

@end
