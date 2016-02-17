//
//  IshikawaStepTwoViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 08/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IshikawaStepTwoViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) id ivc;
@property (retain, nonatomic) id icvc;
@property (strong, nonatomic) NSString *mainTitle;
@property (strong, nonatomic) NSString *textOption;
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UIButton *btnBackStep;
@property (weak, nonatomic) IBOutlet UIButton *btnNextStep;
@property (weak, nonatomic) IBOutlet UITextField *txtOption;

@property (strong, nonatomic) IBOutlet UITableViewCell *questionCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *buttonsCell;

@end
