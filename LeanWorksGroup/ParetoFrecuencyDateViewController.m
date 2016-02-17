//
//  ParetoFrecuencyDateViewController.m
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 28/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "ParetoFrecuencyDateViewController.h"
#import "ParetoDiagramViewController.h"
#import "RoketFetcher.h"

@interface ParetoFrecuencyDateViewController ()

@end

@implementation ParetoFrecuencyDateViewController

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
    
    //Traduccion
    self.lblInicio.text = NSLocalizedString(@"Inicio", nil);
    self.lblTermino.text = NSLocalizedString(@"Termino", nil);
    [self.btnAtras setTitle:NSLocalizedString(@"btnBack", nil)];
    [self.btnContinuar setTitle:NSLocalizedString(@"btnSiguiente", nil) forState:UIControlStateNormal];
    
	// Do any additional setup after loading the view.
    [self.dateStart addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    switch ([[self.dicPareto objectForKey:@"FrecuenciaMedidaValue"]integerValue]) {
        case 0:
            [self.dateStart setDatePickerMode:UIDatePickerModeTime];
            [self.dateFinish setDatePickerMode:UIDatePickerModeTime];
            break;
            
        default:
            [self.dateStart setDatePickerMode:UIDatePickerModeDate];
            [self.dateFinish setDatePickerMode:UIDatePickerModeDate];
            [self.dateFinish setUserInteractionEnabled:NO];
            break;
    }
    
    if(self.historico){
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
         [df setDateFormat:@"dd/MM/yyyy hh:mm"];
        
        NSDate *myDate = [df dateFromString:[self.dicPareto objectForKey:@"dateStart"]];
        self.dateStart.date = myDate;
        myDate = [df dateFromString:[self.dicPareto objectForKey:@"dateFinish"]];
        self.dateFinish.date = myDate;
        
        [self.dateFinish setUserInteractionEnabled:NO];
        [self.dateStart setUserInteractionEnabled:NO];
        
    }else{
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyyy HH:mm"];
        NSDate *myDate;
        
        if([self.dicPareto objectForKey:@"dateStart"])
            myDate = [df dateFromString:[self.dicPareto objectForKey:@"dateStart"]];
        
        if(myDate)
            self.dateStart.date = myDate;
        
        if([self.dicPareto objectForKey:@"dateFinish"])
            myDate = [df dateFromString:[self.dicPareto objectForKey:@"dateFinish"]];
        
        if(myDate)
            self.dateFinish.date = myDate;
        [self dateChanged:self.dateStart];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dateChanged:(id)sender
{
    NSDate *date = self.dateStart.date;
    double  diaMillSec = 1*24*60*60;
    
    if ([[self.dicPareto objectForKey:@"FrecuenciaMedidaValue"]integerValue] == 0){
        self.dateFinish.minimumDate = self.dateStart.date;
        
    }else if ([[self.dicPareto objectForKey:@"FrecuenciaMedidaValue"]integerValue] == 1){
        NSTimeInterval timeInMiliseconds = [date timeIntervalSince1970];
        double milliseconds = timeInMiliseconds;
        milliseconds += diaMillSec;
        timeInMiliseconds = milliseconds;
        date = [NSDate dateWithTimeIntervalSince1970:timeInMiliseconds];
        [self.dateFinish setDate:date animated:YES];
        
    }else if ([[self.dicPareto objectForKey:@"FrecuenciaMedidaValue"]integerValue] == 2){
        NSTimeInterval timeInMiliseconds = [date timeIntervalSince1970];
        double milliseconds = timeInMiliseconds;
        milliseconds += (diaMillSec * 6);
        timeInMiliseconds = milliseconds;
        date = [NSDate dateWithTimeIntervalSince1970:timeInMiliseconds];
        [self.dateFinish setDate:date animated:YES];
        
    }else if ([[self.dicPareto objectForKey:@"FrecuenciaMedidaValue"]integerValue] == 3){
        NSTimeInterval timeInMiliseconds = [date timeIntervalSince1970];
        double milliseconds = timeInMiliseconds;
        milliseconds += (diaMillSec * 14);
        timeInMiliseconds = milliseconds;
        date = [NSDate dateWithTimeIntervalSince1970:timeInMiliseconds];
        [self.dateFinish setDate:date animated:YES];
        
    }else if ([[self.dicPareto objectForKey:@"FrecuenciaMedidaValue"]integerValue] == 4){
        //mes
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        int dia;
        int mes;
        int año;
        NSString* stringDate;
        
        [df setDateFormat:@"MM"];
        mes = [[df stringFromDate:date]integerValue];
        [df setDateFormat:@"yyyy"];
        año = [[df stringFromDate:date]integerValue];
        [df setDateFormat:@"dd"];
        dia = [[df stringFromDate:date]integerValue];
        
        if(mes == 12){
            mes = 1;
            año +=1;
        }else{
            mes += 1;
        }
        
        [df setDateFormat:@"dd/MM/yyyy"];
        stringDate = [NSString stringWithFormat:@"%d/%d/%d",dia,mes,año];
        date = [df dateFromString:stringDate];
        [self.dateFinish setDate:date animated:YES];
    }else if ([[self.dicPareto objectForKey:@"FrecuenciaMedidaValue"]integerValue] == 5){
        //bimestre
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        int dia;
        int mes;
        int año;
        NSString* stringDate;
        
        [df setDateFormat:@"MM"];
        mes = [[df stringFromDate:date]integerValue];
        [df setDateFormat:@"yyyy"];
        año = [[df stringFromDate:date]integerValue];
        [df setDateFormat:@"dd"];
        dia = [[df stringFromDate:date]integerValue];
        
        if(mes == 11){
            mes = 1;
            año +=1;
        }else if(mes == 12){
            mes = 2;
            año +=1;
        }else{
            mes += 2;
        }

        
        [df setDateFormat:@"dd/MM/yyyy"];
        stringDate = [NSString stringWithFormat:@"%d/%d/%d",dia,mes,año];
        date = [df dateFromString:stringDate];
        [self.dateFinish setDate:date animated:YES];
    }else if ([[self.dicPareto objectForKey:@"FrecuenciaMedidaValue"]integerValue] == 6){
        //trimestre
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        int dia;
        int mes;
        int año;
        NSString* stringDate;
        
        [df setDateFormat:@"MM"];
        mes = [[df stringFromDate:date]integerValue];
        [df setDateFormat:@"yyyy"];
        año = [[df stringFromDate:date]integerValue];
        [df setDateFormat:@"dd"];
        dia = [[df stringFromDate:date]integerValue];
        
        if(mes > 9){
            mes += 3;
            mes -= 12;
            año +=1;
        }else{
            mes += 3;
        }

        
        [df setDateFormat:@"dd/MM/yyyy"];
        stringDate = [NSString stringWithFormat:@"%d/%d/%d",dia,mes,año];
        date = [df dateFromString:stringDate];
        [self.dateFinish setDate:date animated:YES];
    }else if ([[self.dicPareto objectForKey:@"FrecuenciaMedidaValue"]integerValue] == 7){
        //cuatrimestre
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        int dia;
        int mes;
        int año;
        NSString* stringDate;
        
        [df setDateFormat:@"MM"];
        mes = [[df stringFromDate:date]integerValue];
        [df setDateFormat:@"yyyy"];
        año = [[df stringFromDate:date]integerValue];
        [df setDateFormat:@"dd"];
        dia = [[df stringFromDate:date]integerValue];
        
        if(mes > 8){
            mes += 4;
            mes -= 12;
            año +=1;
        }else{
            mes += 4;
        }
        
        [df setDateFormat:@"dd/MM/yyyy"];
        stringDate = [NSString stringWithFormat:@"%d/%d/%d",dia,mes,año];
        date = [df dateFromString:stringDate];
        [self.dateFinish setDate:date animated:YES];
    }else if ([[self.dicPareto objectForKey:@"FrecuenciaMedidaValue"]integerValue] == 8){
        //semestre
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        int dia;
        int mes;
        int año;
        NSString* stringDate;
        
        [df setDateFormat:@"MM"];
        mes = [[df stringFromDate:date]integerValue];
        [df setDateFormat:@"yyyy"];
        año = [[df stringFromDate:date]integerValue];
        [df setDateFormat:@"dd"];
        dia = [[df stringFromDate:date]integerValue];
        
        if(mes > 6){
            mes += 6;
            mes -= 12;
            año +=1;
        }else{
            mes += 6;
        }
        
        [df setDateFormat:@"dd/MM/yyyy"];
        stringDate = [NSString stringWithFormat:@"%d/%d/%d",dia,mes,año];
        date = [df dateFromString:stringDate];
        [self.dateFinish setDate:date animated:YES];
    }else if ([[self.dicPareto objectForKey:@"FrecuenciaMedidaValue"]integerValue] == 9){
        //anual
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        int dia;
        int mes;
        int año;
        NSString* stringDate;
        
        [df setDateFormat:@"MM"];
        mes = [[df stringFromDate:date]integerValue];
        [df setDateFormat:@"yyyy"];
        año = [[df stringFromDate:date]integerValue];
        [df setDateFormat:@"dd"];
        dia = [[df stringFromDate:date]integerValue];
        ++año;
        
        [df setDateFormat:@"dd/MM/yyyy"];
        stringDate = [NSString stringWithFormat:@"%d/%d/%d",dia,mes,año];
        date = [df dateFromString:stringDate];
        [self.dateFinish setDate:date animated:YES];
    }
    
}


#pragma mark - IBAction

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnContinuar:(id)sender {
   
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy HH:mm"];
    
    [self.dicPareto setObject:[df stringFromDate:self.dateStart.date] forKey:@"dateStart"];
    [self.dicPareto setObject:[df stringFromDate:self.dateFinish.date] forKey:@"dateFinish"];
    
    ParetoDiagramViewController *pdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ParetoDiagramView"];
    
    pdvc.dicPareto = self.dicPareto;
    
    if(!self.historico)
        [RoketFetcher createJson:self.dicPareto :Nil :@"ParetoDiagramView"];
    
    pdvc.historico = self.historico;
    [self presentViewController:pdvc animated:YES completion:nil];
}


#pragma mark - UIStyle

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
