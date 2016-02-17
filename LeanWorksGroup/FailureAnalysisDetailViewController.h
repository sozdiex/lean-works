//
//  FailureAnalysisDetailViewController.h
//  LeanWorksGroup
//
//  Created by Jazmin Hernandez on 06/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FailureAnalysisDetailViewController : UIViewController<UITextFieldDelegate>

    @property int index;
    @property (strong, nonatomic) id delegate;
    @property (strong, nonatomic) NSString *causeName;
    @property (strong, nonatomic) NSMutableArray *failuresArray;

    @property (weak, nonatomic) IBOutlet UITextField *why1;
    @property (weak, nonatomic) IBOutlet UITextField *why2;
    @property (weak, nonatomic) IBOutlet UITextField *why3;
    @property (weak, nonatomic) IBOutlet UITextField *why4;
    @property (weak, nonatomic) IBOutlet UITextField *why5;
    @property (weak, nonatomic) IBOutlet UIButton *buttonSave;
    @property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonCancel;
    @property (weak, nonatomic) IBOutlet UILabel *lblCausa;

    /*@property (strong, nonatomic) IBOutlet UITableViewCell *why1Cell;
    @property (strong, nonatomic) IBOutlet UITableViewCell *why2Cell;
    @property (strong, nonatomic) IBOutlet UITableViewCell *why3Cell;
    @property (strong, nonatomic) IBOutlet UITableViewCell *why4Cell;
    @property (strong, nonatomic) IBOutlet UITableViewCell *why5Cell;*/

@end




