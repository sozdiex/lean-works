//
//  ParetoCell.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 07/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParetoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *className;
@property (weak, nonatomic) IBOutlet UILabel *frecuency;
@property (weak, nonatomic) IBOutlet UILabel *accumulated;
@property (weak, nonatomic) IBOutlet UILabel *percentage;
@property (weak, nonatomic) IBOutlet UILabel *accumulatedPercentage;

@end
