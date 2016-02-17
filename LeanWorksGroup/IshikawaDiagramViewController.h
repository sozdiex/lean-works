//
//  IshikawaDiagramViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 18/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IshikawaDiagramViewController : UIViewController<UITableViewDelegate>

@property (strong, nonatomic) NSString *mainProblem;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITableView *causesTable;
@property (weak, nonatomic) IBOutlet UITextField *txtCause;
@property (weak, nonatomic) IBOutlet UIButton *btnCategories;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (strong, nonatomic) NSDictionary *selectOption;

@end
