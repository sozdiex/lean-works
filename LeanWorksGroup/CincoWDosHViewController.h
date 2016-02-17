//
//  CincoWDosHViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 08/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"

@interface CincoWDosHViewController : ECSlidingViewController

@property BOOL historico;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *textWhat;
@property (weak, nonatomic) IBOutlet UITextField *textWho;
@property (weak, nonatomic) IBOutlet UITextField *textWhy;
@property (weak, nonatomic) IBOutlet UITextField *textWhen;
@property (weak, nonatomic) IBOutlet UITextField *textWhere;
@property (weak, nonatomic) IBOutlet UITextField *textHow;
@property (weak, nonatomic) IBOutlet UITextField *textHowMuch;

//@property (weak, nonatomic) IBOutlet UITableView *tableForm;
@property (weak, nonatomic) IBOutlet UILabel *lblNoEditable;
@property (weak, nonatomic) IBOutlet UILabel *lblNoEditable2;
@property (weak, nonatomic) IBOutlet UILabel *lblNoEditable3;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle2;
/*
@property (strong, nonatomic) IBOutlet UITableViewCell *whatCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *whoCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *whyCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *whenCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *whereCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *howCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *howMuchCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *buttonCell;
*/
@property NSMutableDictionary *dicIshikawa;
@property NSMutableDictionary *dicPareto;
@end
