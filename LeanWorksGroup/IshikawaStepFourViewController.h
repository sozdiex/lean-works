//
//  IshikawaFourViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 12/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IshikawaStepFourViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) id ivc;
@property (retain, nonatomic) id icvc;
@property (retain, nonatomic) id istvc;
@property (retain, nonatomic) id isthreevc;
@property (strong, nonatomic) NSString *mainTitle;
@property (strong, nonatomic) NSString *textOption;
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UIButton *btnBackStep;
@property (weak, nonatomic) IBOutlet UIButton *btnNextStep;
@property (weak, nonatomic) IBOutlet UITextField *txtOption;

@property (strong, nonatomic) IBOutlet UITableViewCell *questionCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *buttonsCell;

@end
