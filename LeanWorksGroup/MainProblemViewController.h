//
//  MainProblemViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 17/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainProblemViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textProblemName;
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonBack;
//@property (strong, nonatomic) IBOutlet UITableView *tableQuestion;
//@property (strong, nonatomic) IBOutlet UITableViewCell *questionCell;
//@property (strong, nonatomic) IBOutlet UITableViewCell *buttonCell;
@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;

@property NSMutableDictionary *dicPareto;
@property BOOL historico;

@end
