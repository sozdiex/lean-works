//
//  LoginViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 18/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UIButton *buttonLogin;
@property (strong, nonatomic) IBOutlet UITableView *tableLogin;
@property (strong, nonatomic) IBOutlet UITableViewCell *userCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *passwordCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *buttonLoginCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *buttonsCell;

@property (strong, nonatomic) IBOutlet UITextField *txtUser;
@property (strong, nonatomic) IBOutlet UITextField *txtPassWord;

@end
