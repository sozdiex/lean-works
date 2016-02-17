//
//  ParetoViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 07/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParetoViewController : UIViewController<UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) NSString *mainProblem;
//@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UITableView *tableOptions;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@property NSMutableDictionary *dicPareto;
@property BOOL historico;

@end
