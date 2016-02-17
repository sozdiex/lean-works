//
//  IshikawaStepTwoViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 08/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "IshikawaStepTwoViewController.h"
#import "IshikawaStepThreeViewController.h"
#import "IshikawaStepThreeViewController.h"
#import "IshikawaStepFourViewController.h"
#import "FactorsViewController.h"

@interface IshikawaStepTwoViewController ()

@end

@implementation IshikawaStepTwoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self hardcode];
    
    self.btnNextStep.layer.borderWidth = 1.0f;
    self.btnNextStep.layer.cornerRadius = 7.0f;
    self.btnNextStep.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
    
    self.btnBackStep.layer.borderWidth = 1.0f;
    self.btnBackStep.layer.cornerRadius = 7.0f;
    self.btnBackStep.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
}

- (void)hardcode {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *question;
    if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Servicios"]) {
        question = @"¿Por qué la falta de capacitación provoca en el departamento de ventas de la sucursal de Culiacán durante el último trimestre del año tiene ventas bajas equivalentes a $1,000,000.00?";
        self.txtOption.text = @"Falta de tiempo";
    }
    else if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Manufactura"]) {
        if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Colaboradores / Clientes / Personas"]) {
            question = @"¿Por qué la falta de capacitación provoca en línea de pintura en la planta de Puebla del turno nocturno tiene mala calidad equivalente a 169 piezas mensuales?";
            self.txtOption.text = @"Falta de tiempo";
        }
        else if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Máquinas / Equipos"]) {
            question = @"¿Por qué si el espreado se ve diferente provoca en línea de pintura en la planta de Puebla del turno nocturno tiene mala calidad equivalente a 169 piezas mensuales?";
            self.txtOption.text = @"La boquilla es diferente";
        }
        else if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Método de Trabajo"]) {
            question = @"¿Por qué si los tonos se ven diferente provoca en línea de pintura en la planta de Puebla del turno nocturno tiene mala calidad equivalente a 169 piezas mensuales?";
            self.txtOption.text = @"El tiempo del espreado varia";
        }
        else if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Materiales"]) {
            question = @"¿Por qué si la pintura se desprende provoca en línea de pintura en la planta de Puebla del turno nocturno tiene mala calidad equivalente a 169 piezas mensuales?";
            self.txtOption.text = @"No tiene buena adhesión";
        }
        else if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Medición"]) {
            question = @"¿Por qué no tenemos indicadores de calidad provoca en línea de pintura en la planta de Puebla del turno nocturno tiene mala calidad equivalente a 169 piezas mensuales?";
            self.txtOption.text = @"No tenemos tableros citode";
        }
    }
    
    //NSString *title = [[NSString alloc] initWithFormat:@"%@", self.mainTitle];
    self.question.text = question;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)nextStep:(id)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Medición"]) {
        FactorsViewController *fvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FactorsView"];
        fvc.ivc = self.ivc;
        fvc.icvc = self.icvc;
        fvc.istvc = self;
        [self presentViewController:fvc animated:YES completion:nil];
    }
    else {
        IshikawaStepThreeViewController *istvc = [self.storyboard instantiateViewControllerWithIdentifier:@"IshikawaStepThreeView"];
        istvc.ivc = self.ivc;
        istvc.icvc = self.icvc;
        istvc.istvc = self;
        [self presentViewController:istvc animated:YES completion:nil];
    }
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)origin:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        [self.icvc dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            cell = self.questionCell;
            break;
        case 1:
            cell = self.buttonsCell;
    }
    return cell;
}

#pragma mark - UIStyle

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
