//
//  ActionPlanDetailViewController.h
//  LeanWorksGroup
//
//  Created by Jazmin Hernandez on 15/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ActionPlanDetailViewController : UIViewController

@property (strong, nonatomic) NSMutableArray *actionArray;
@property int index;
@property (strong, nonatomic) id delegate;
@property BOOL historico;

@property (weak, nonatomic) IBOutlet UIButton *buttonSave;
@property (weak, nonatomic) IBOutlet UIButton *buttonCausa;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *ButtonCancel;

@property (weak, nonatomic) IBOutlet UITextField *txtAccion;
@property (weak, nonatomic) IBOutlet UITextField *txtActividad;
@property (weak, nonatomic) IBOutlet UITextField *txtResponsable;
@property (weak, nonatomic) IBOutlet UITextField *txtDocumentoGenerar;
@property (weak, nonatomic) IBOutlet UITextField *txtDocumentoModificar;

@property (weak, nonatomic) IBOutlet UIButton *buttonFechaInicialPlan;
@property (weak, nonatomic) IBOutlet UIButton *buttonFechaFinalPlan;
@property (weak, nonatomic) IBOutlet UIButton *buttonFechaInicialRealizado;
@property (weak, nonatomic) IBOutlet UIButton *buttonFechaFinalRealizado;

@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UILabel *lbl4;
@property (weak, nonatomic) IBOutlet UILabel *lbl5;
@property (weak, nonatomic) IBOutlet UILabel *lbl6;
@property (weak, nonatomic) IBOutlet UILabel *lblFecha1;
@property (weak, nonatomic) IBOutlet UILabel *lblFecha2;
@property (weak, nonatomic) IBOutlet UILabel *lblFecha3;
@property (weak, nonatomic) IBOutlet UILabel *lblFecha4;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleView;


@end
