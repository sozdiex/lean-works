//
//  SelectCauseCell.h
//  LeanWorksGroup
//
//  Created by Jazmin Hernandez on 08/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectCauseCell : UITableViewCell

@property (strong, nonatomic) NSString *causeName;
@property (weak, nonatomic) IBOutlet UILabel *labelCauseName;

@end
