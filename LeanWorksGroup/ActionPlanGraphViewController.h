//
//  ActionPlanGraphViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 24/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"

@interface ActionPlanGraphViewController : ECSlidingViewController<UITableViewDelegate>

@property NSMutableDictionary *dicIshikawa;
@property NSMutableDictionary *dicPareto;
@property BOOL historico;
@property BOOL actividadModificada;
@property int countActionArray;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAtras;
@property (strong, nonatomic) NSMutableArray *actionArray;
@property (strong, nonatomic) NSString *fechaInicial;
@property (strong, nonatomic) NSString *fechaFinal;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleView;

@end
