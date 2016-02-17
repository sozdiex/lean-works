//
//  ActionPlanCell.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 12/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionPlanCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cause;
@property (weak, nonatomic) IBOutlet UILabel *action;
@property (weak, nonatomic) IBOutlet UILabel *activity;
@property (weak, nonatomic) IBOutlet UILabel *responsible;
@property (weak, nonatomic) IBOutlet UILabel *documentGenerated;
@property (weak, nonatomic) IBOutlet UILabel *documentModified;
@property (weak, nonatomic) IBOutlet UILabel *dateStartPlan;
@property (weak, nonatomic) IBOutlet UILabel *dateFinishPlan;
@property (weak, nonatomic) IBOutlet UILabel *dateStartRealized;
@property (weak, nonatomic) IBOutlet UILabel *dateFinishRealized;

@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UILabel *lbl4;
@property (weak, nonatomic) IBOutlet UILabel *lbl5;
@property (weak, nonatomic) IBOutlet UILabel *lbl6;

@property (weak, nonatomic) IBOutlet UILabel *lblFecha1;
@property (weak, nonatomic) IBOutlet UILabel *lblFecha2;
@property (weak, nonatomic) IBOutlet UILabel *lblFecha3;
@property (weak, nonatomic) IBOutlet UILabel *lblFecha4;




@end
