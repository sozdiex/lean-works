//
//  SelectCauseViewController.h
//  LeanWorksGroup
//
//  Created by Jazmin Hernandez on 08/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCauseViewController : UIViewController<UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *failuresArray;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UITableView *tableOptions;
@property  (strong,nonatomic) NSMutableArray *arrayCausaSelect;
@property (weak, nonatomic) IBOutlet UIButton *buttonCausa;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleView;
@property (retain,nonatomic) id delegate;
@end
