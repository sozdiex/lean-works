//
//  CauseCell.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 17/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CauseCell : UITableViewCell

@property (strong, nonatomic) NSString *causeName;
@property (weak, nonatomic) IBOutlet UILabel *labelCauseName;

@end
