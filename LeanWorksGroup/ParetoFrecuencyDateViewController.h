//
//  ParetoFrecuencyDateViewController.h
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 28/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParetoFrecuencyDateViewController : UIViewController

@property NSMutableDictionary *dicPareto;
@property BOOL historico;

@property (strong, nonatomic) IBOutlet UIDatePicker *dateStart;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateFinish;

@property (weak, nonatomic) IBOutlet UIButton *btnContinuar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAtras;
@property (weak, nonatomic) IBOutlet UILabel *lblInicio;
@property (weak, nonatomic) IBOutlet UILabel *lblTermino;

@end
