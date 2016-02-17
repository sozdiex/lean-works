//
//  BusinessRegistrationViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 18/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusinessRegistrationViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *buttonRegister;
@property (strong, nonatomic) IBOutlet UITableView *tableRegister;
@property (strong, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *usernameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *passwordCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *ConfirmPasswordCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *emailCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *buttonRegisterCell;

@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UITextField *txtUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtPasswordConfirm;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;

@property (strong, nonatomic) IBOutlet UIButton *btnSave;

@end
