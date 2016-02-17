//
//  ParetoChartsViewController.h
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 21/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParetoChartsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) IBOutlet UIButton *btnSiguiente;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;

@property (weak, nonatomic) IBOutlet UILabel *lblTitleView;

@property (weak, nonatomic) IBOutlet UIView *chart;
@property (weak, nonatomic) IBOutlet UIView *chartLine;
@property (strong, nonatomic) IBOutlet UILabel *txtFechaInicio;
@property (strong, nonatomic) IBOutlet UILabel *txtFechaFin;
@property (weak, nonatomic) IBOutlet UILabel *lblFechaInicio;
@property (weak, nonatomic) IBOutlet UILabel *lblFechaFin;

@property (weak, nonatomic) IBOutlet UIImageView *imageChart;
@property NSMutableArray *causesArray;
@property NSMutableDictionary *dicPareto;
@property BOOL historico;

@property (weak, nonatomic) IBOutlet UILabel *lblLimite0;
@property (weak, nonatomic) IBOutlet UILabel *lblLimite1;
@property (weak, nonatomic) IBOutlet UILabel *lblLimite2;
@property (weak, nonatomic) IBOutlet UILabel *lblLimite3;
@property (weak, nonatomic) IBOutlet UILabel *lblLimite4;
@property (weak, nonatomic) IBOutlet UILabel *lblLimite5;
@property (weak, nonatomic) IBOutlet UILabel *lblLimite6;
@property (weak, nonatomic) IBOutlet UILabel *lblLimite7;
@property (weak, nonatomic) IBOutlet UILabel *lblLimite8;
@property (weak, nonatomic) IBOutlet UILabel *lblLimite9;
@property (weak, nonatomic) IBOutlet UILabel *lblLimite10;

@property (weak, nonatomic) IBOutlet UILabel *lblNombre1;
@property (weak, nonatomic) IBOutlet UILabel *lblNombre2;
@property (weak, nonatomic) IBOutlet UILabel *lblNombre3;
@property (weak, nonatomic) IBOutlet UILabel *lblNombre4;
@property (weak, nonatomic) IBOutlet UILabel *lblNombre5;

@property (weak, nonatomic) IBOutlet UIView *viewGrafic;

@end
