//
//  IshikawaCategoryViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 08/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IshikawaCategoryViewController : UIViewController

@property (retain, nonatomic) id ivc;
@property (strong, nonatomic) NSString *mainTitle;
@property (strong, nonatomic) NSString *selectOption;
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UIButton *btnBackStep;
@property (weak, nonatomic) IBOutlet UIButton *btnNextStep;
@property (weak, nonatomic) IBOutlet UITextField *textOption;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;

//@property (strong, nonatomic) IBOutlet UITableViewCell *questionCell;
//@property (strong, nonatomic) IBOutlet UITableViewCell *buttonsCell;

@property NSMutableDictionary *dicIshikawa;
@property BOOL nuevo;
@property int dicSelected;
@property BOOL historico;

@end
