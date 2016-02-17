//
//  CompanySectorViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 17/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanySectorViewController : UIViewController<UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableSector;
@property NSMutableDictionary *dicPareto;
@property BOOL historico;

@end
