//
//  SecondaryCauseViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 21/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondaryCauseViewController : UIViewController<UITableViewDelegate>

@property (strong, nonatomic) NSString *secondaryCause;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@end
