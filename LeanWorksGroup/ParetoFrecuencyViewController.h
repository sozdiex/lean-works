//
//  ParetoFrecuencyViewController.h
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 21/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParetoFrecuencyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) NSString *mainProblem;
@property (weak, nonatomic) IBOutlet UITableView *tableOptions;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@property NSMutableDictionary *dicPareto;
@property BOOL historico;

@end
