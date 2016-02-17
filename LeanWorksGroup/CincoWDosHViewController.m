//
//  CincoWDosHViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 08/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "CincoWDosHViewController.h"
#import "IshikawaViewController.h"
#import "RoketFetcher.h"
#import "CustomAlertViewController.h"

@interface CincoWDosHViewController ()

@end

@implementation CincoWDosHViewController

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
    
    [self.lblNoEditable setText:NSLocalizedString(@"(No editable)", nil)];
    [self.lblNoEditable2 setText:NSLocalizedString(@"(No editable)", nil)];
    [self.lblNoEditable3 setText:NSLocalizedString(@"(No editable)", nil)];
    
    self.lblTitle2.text = NSLocalizedString(@"lblTitle5W2h2", nil);
    self.lblTitle.text = NSLocalizedString(@"lblTitle5W2h", nil);
    [self.btnBack setTitle:NSLocalizedString(@"btnBack", nil)];
    [self.btnNext setTitle:NSLocalizedString(@"btnSiguiente", nil) forState:UIControlStateNormal];
    
	// Do any additional setup after loading the view.
    self.btnNext.layer.borderWidth = 1.0f;
    self.btnNext.layer.cornerRadius = 7.0f;
    self.btnNext.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
    //[self hardcode];
    
    NSMutableArray *causesArray = [self.dicPareto objectForKey:@"causesArray"];
    if(causesArray){
        NSMutableDictionary *dicCausas = [causesArray objectAtIndex:0];
        self.textWhat.text = [dicCausas objectForKey:@"name"];
        
        int frecInt = [[dicCausas objectForKey:@"frecuency"]integerValue];
        double frecDou = [[dicCausas objectForKey:@"frecuency"]doubleValue];
        if(frecDou-frecInt == 0.0f){
             self.textHowMuch.text = [NSString stringWithFormat:@"%d",frecInt];
        }else{
            self.textHowMuch.text = [NSString stringWithFormat:@"%0.2f",frecDou];
        }
       
    }
   
    
    if(self.historico){
        self.textWho.enabled = NO;
        self.textWhy.enabled = NO;
        self.textWhen.enabled = NO;
        self.textWhere.enabled = NO;
        self.textHow.enabled = NO;
        self.textHowMuch.enabled = NO;
        self.textWhat.enabled = NO;
    }else{
        self.textWho.enabled = YES;
        self.textWhy.enabled = NO;
        self.textWhen.enabled = YES;
        self.textWhere.enabled = YES;
        self.textHow.enabled = YES;
        self.textHowMuch.enabled = NO;
        self.textWhat.enabled = NO;
    }
    
    if(!self.dicIshikawa){
        self.dicIshikawa = [[NSMutableDictionary alloc]init];
    }else{
        self.textWho.text = [self.dicIshikawa objectForKey:@"who"];
        self.textWhy.text = [self.dicIshikawa objectForKey:@"why"];
        self.textWhen.text = [self.dicIshikawa objectForKey:@"when"];
        self.textWhere.text = [self.dicIshikawa objectForKey:@"where"];
        self.textHow.text = [self.dicIshikawa objectForKey:@"how"];
        
        if([self.textWhat.text isEqualToString:@""])
            self.textWhat.text = [self.dicIshikawa objectForKey:@"what"];
        
        if([self.textHowMuch.text isEqualToString:@""])
            self.textHowMuch.text = [self.dicIshikawa objectForKey:@"HowMuch"];
    }
}

- (void)hardcode {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Servicios"]) {
        self.textWhat.text = @"Ventas";
        self.textWho.text = @"Departamento de ventas";
        self.textWhy.text = @"";
        self.textWhen.text = @"Último trimestre del año";
        self.textWhere.text = @"Sucursal de Culiacán";
        self.textHow.text = @"Bajas";
        self.textHowMuch.text = @"$1,000,000.00";
    }
    else if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Manufactura"]) {
        self.textWhat.text = @"Calidad";
        self.textWho.text = @"Línea de pintura";
        self.textWhy.text = @"";
        self.textWhen.text = @"Turno nocturno";
        self.textWhere.text = @"Planta de Puebla";
        self.textHow.text = @"Mala";
        self.textHowMuch.text = @"169 piezas mensuales";
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)showMenu:(id)sender {
    self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InitView"];
}

- (IBAction)nextStep:(id)sender {
    if([self.textWhat.text isEqualToString:@""] || [self.textWho.text isEqualToString:@""] || [self.textWhen.text isEqualToString:@""] || [self.textWhere.text isEqualToString:@""] || [self.textHow.text isEqualToString:@""] || [self.textHowMuch.text isEqualToString:@""]){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Los Campos marcados (*) son obligatorios",nil);
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    IshikawaViewController *ivc = [self.storyboard instantiateViewControllerWithIdentifier:@"IshikawaView"];
    ivc.what = self.textWhat.text;
    ivc.who = self.textWho.text;
    ivc.why = self.textWhy.text;
    ivc.when = self.textWhen.text;
    ivc.where = self.textWhere.text;
    ivc.how = self.textHow.text;
    ivc.howMuch = self.textHowMuch.text;
    ivc.dicPareto = self.dicPareto;
    if(!self.historico)
        [RoketFetcher createJson:self.dicPareto :self.dicIshikawa :@"IshikawaView"];
    
    
    ivc.historico = self.historico;
    
    [self.dicIshikawa setObject:self.textWhat.text forKey:@"what"];
    [self.dicIshikawa setObject:self.textWho.text forKey:@"who"];
    [self.dicIshikawa setObject:self.textWhy.text forKey:@"why"];
    [self.dicIshikawa setObject:self.textWhen.text forKey:@"when"];
    [self.dicIshikawa setObject:self.textWhere.text forKey:@"where"];
    [self.dicIshikawa setObject:self.textHow.text forKey:@"how"];
    [self.dicIshikawa setObject:self.textHowMuch.text forKey:@"HowMuch"];
    
    ivc.dicIshikawa = self.dicIshikawa;
    
    [self presentViewController:ivc animated:YES completion:nil];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            cell = self.whatCell;
            break;
        case 1:
            cell = self.whoCell;
            break;
        case 2:
            cell = self.whyCell;
            break;
        case 3:
            cell = self.whenCell;
            break;
        case 4:
            cell = self.whereCell;
            break;
        case 5:
            cell = self.howCell;
            break;
        case 6:
            cell = self.howMuchCell;
            break;
        case 7:
            cell = self.buttonCell;
            break;
    }
    return cell;
}*/

#pragma mark - UIStyle

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
