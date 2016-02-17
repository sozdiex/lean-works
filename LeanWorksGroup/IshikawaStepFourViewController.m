//
//  IshikawaFourViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 12/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "IshikawaStepFourViewController.h"
#import "FactorsViewController.h"

@interface IshikawaStepFourViewController ()

@end

@implementation IshikawaStepFourViewController

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
        question = @"¿Por qué los horarios quebrados, falta de tiempo y falta de capacitación provoca en el departamento de ventas de la sucursal de Culiacán durante el último trimestre del año tiene ventas bajas equivalentes a $1,000,000.00?";
        self.txtOption.text = @"Falta de organización";
    }
    else if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Manufactura"]) {
        if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Colaboradores / Clientes / Personas"]) {
            question = @"¿Por qué los horarios quebrados, falta de tiempo y falta de capacitación provoca en línea de pintura en la planta de Puebla del turno nocturno tiene mala calidad equivalente a 169 piezas mensuales?";
            self.txtOption.text = @"Falta de organización";
        }
        else if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Máquinas / Equipos"]) {
            question = @"¿Por qué no se ha estandarizado una boquilla y la boquilla y el espreado son diferentes provoca en línea de pintura en la planta de Puebla del turno nocturno tiene mala calidad equivalente a 169 piezas mensuales?";
            self.txtOption.text = @"No se ha definido la boquilla correcta";
        }
        else if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Método de Trabajo"]) {
            question = @"¿Por qué la manera de espreado no está definida y el tiempo de espreado varia y los tonos se ven diferente provoca en línea de pintura en la planta de Puebla del turno nocturno tiene mala calidad equivalente a 169 piezas mensuales?";
            self.txtOption.text = @"El proceso no está estandarizado";
        }
        else if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Materiales"]) {
            question = @"¿Por qué si no es compatible con la superficie y no tiene buena adhesión y la pintura se desprende provoca en línea de pintura en la planta de Puebla del turno nocturno tiene mala calidad equivalente a 169 piezas mensuales?";
            self.txtOption.text = @"Se cambió de proveedor";
        }
        else if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Medición"]) {
        }
    }
    
    //NSString *title = [[NSString alloc] initWithFormat:@"%@", self.mainTitle];
    self.question.text = question;
}

- (void)viewDidAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView

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
            break;
    }
    return cell;
}

#pragma mark - IBAction

- (IBAction)nextStep:(id)sender {
    FactorsViewController *fvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FactorsView"];
    fvc.ivc = self.ivc;
    fvc.icvc = self.icvc;
    fvc.istvc = self.istvc;
    fvc.isthreevc = self.isthreevc;
    fvc.isfvc = self;
    [self presentViewController:fvc animated:YES completion:nil];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)origin:(id)sender {
    [self dismissViewControllerAnimated:NO completion:^{
        [self.isthreevc dismissViewControllerAnimated:NO completion:^{
            [self.istvc dismissViewControllerAnimated:NO completion:^{
                [self.icvc dismissViewControllerAnimated:NO completion:nil];
            }];
        }];
    }];
}

#pragma mark - UIStyle

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
