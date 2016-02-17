//
//  FactorsViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 21/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FactorsViewController : UIViewController

@property (retain, nonatomic) id ivc;
@property (retain, nonatomic) id icvc;
@property (retain, nonatomic) id istvc;
@property (retain, nonatomic) id isthreevc;
@property (retain, nonatomic) id isfvc;

@property (strong, nonatomic) IBOutlet UILabel *lblTitulo;
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (strong, nonatomic) NSString *selected;
@property (strong, nonatomic) NSMutableArray *arraySelected;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@property NSMutableDictionary *dicIshikawa;
@property NSMutableDictionary *dicPareto;
@property BOOL historico;

@end
