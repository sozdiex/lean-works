//
//  ParetoDiagramViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 17/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"

@interface ParetoDiagramViewController : ECSlidingViewController<UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) NSMutableArray *causesArray;

@property (strong, nonatomic) NSString *mainProblem;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelSubTitle;
@property (weak, nonatomic) IBOutlet UITextField *textCause;
@property (weak, nonatomic) IBOutlet UITableView *tableCause;
@property (weak, nonatomic) IBOutlet UIButton *addCause;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@property NSMutableDictionary *dicPareto;
@property BOOL historico;

@end
