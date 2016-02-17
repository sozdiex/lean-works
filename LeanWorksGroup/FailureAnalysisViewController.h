//
//  FailureAnalysisViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 12/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"

@interface FailureAnalysisViewController : ECSlidingViewController

@property (weak, nonatomic) IBOutlet UITableView *tableFailureAnalysis;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (strong, nonatomic) NSMutableArray *failuresArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@property NSMutableDictionary *dicIshikawa;
@property NSMutableDictionary *dicPareto;
@property BOOL historico;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleView;

@end
