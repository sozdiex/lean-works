//
//  OrderViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 21/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController<UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *arraySelected;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (strong, nonatomic) IBOutlet UILabel *lblTitulo;

@property (strong, nonatomic) IBOutlet UILabel *lblPrimero;
@property (strong, nonatomic) IBOutlet UILabel *lblSegundo;
@property (strong, nonatomic) IBOutlet UILabel *lblTercero;
@property (strong, nonatomic) IBOutlet UILabel *lblCuarto;
@property (strong, nonatomic) IBOutlet UILabel *lblQuinto;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@property NSMutableDictionary *dicIshikawa;
@property NSMutableDictionary *dicPareto;
@property BOOL historico;

@end
