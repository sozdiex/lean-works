//
//  CauseDetailViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 18/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CauseDetailViewController : UIViewController<UITextFieldDelegate>
@property int index;
@property (strong, nonatomic) id delegate;
@property (strong, nonatomic) NSString *causeName;
@property (strong, nonatomic) NSMutableArray *causesArray;

@property (weak, nonatomic) IBOutlet UILabel *lblClase;
@property (weak, nonatomic) IBOutlet UITextField *txtFrecuency;
@property (weak, nonatomic) IBOutlet UILabel *lblFreuency;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonCancel;

//@property (strong, nonatomic) IBOutlet UITableViewCell *frecuencyCell;


@end