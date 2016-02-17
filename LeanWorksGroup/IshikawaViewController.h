//
//  IshikawaViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 08/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"

@interface IshikawaViewController : ECSlidingViewController<UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *question;
@property (strong, nonatomic) NSString *what;
@property (strong, nonatomic) NSString *who;
@property (strong, nonatomic) NSString *why;
@property (strong, nonatomic) NSString *when;
@property (strong, nonatomic) NSString *where;
@property (strong, nonatomic) NSString *how;
@property (strong, nonatomic) NSString *howMuch;

@property NSMutableDictionary *dicIshikawa;
@property NSMutableDictionary *dicPareto;
@property BOOL historico;

@property (weak, nonatomic) IBOutlet UITableView *tableOptions;
@property (weak, nonatomic) IBOutlet UIButton *btnSiguiente;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAtras;

@end
