//
//  IshikawaCategoryListViewController.h
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 14/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IshikawaCategoryListViewController : UIViewController

@property NSMutableDictionary *dicIshikawa;
@property (retain, nonatomic) id ivc;
@property (strong, nonatomic) NSString *mainTitle;
@property (strong, nonatomic) NSString *selectOption;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property BOOL historico;

@end
