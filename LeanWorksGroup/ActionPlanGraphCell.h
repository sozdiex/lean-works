//
//  ActionPlanGraphCell.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 24/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionPlanGraphCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *activity;
@property (weak, nonatomic) IBOutlet UILabel *responsible;
@property (weak, nonatomic) IBOutlet UILabel *progress;

@end
