//
//  ActionPlanDetailViewController.m
//  LeanWorksGroup
//
//  Created by Jazmin Hernandez on 15/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "ActionPlanDetailViewController.h"
#import "ActionPlanViewController.h"
#import "DateActionPlanViewController.h"
#import "CustomAlertViewController.h"
#import "RoketFetcher.h"


@interface ActionPlanDetailViewController ()
@property (nonatomic, strong) DateActionPlanViewController *dapvc;
@property (nonatomic, strong) UIPopoverController *datePopover;
@end

@implementation ActionPlanDetailViewController

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
    [self.lblTitleView setText:NSLocalizedString(@"Analisis de fallas", nil)];
    [self.buttonCausa setTitle:NSLocalizedString(@"btn1", nil) forState:UIControlStateNormal];
    NSMutableDictionary *data =       [self.actionArray objectAtIndex:self.index];
    self.buttonCausa.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonCausa.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.buttonCausa.titleLabel.text= [data objectForKey:@"cause"];
    self.txtAccion.text=              [data objectForKey:@"action"];
    self.txtActividad.text=           [data objectForKey:@"activity"];
    self.txtResponsable.text=         [data objectForKey:@"responsible"];
    self.txtDocumentoGenerar.text=    [data objectForKey:@"documentGenerated"];
    self.txtDocumentoModificar.text=  [data objectForKey:@"documentModified"];
    
    [self.buttonFechaInicialPlan setTitle:[data objectForKey:@"dateStartPlan"] forState:UIControlStateNormal];
    [self.buttonFechaFinalPlan setTitle:[data objectForKey:@"dateFinishPlan"] forState:UIControlStateNormal];
    [self.buttonFechaInicialRealizado setTitle:[data objectForKey:@"dateStartRealized"] forState:UIControlStateNormal];
    [self.buttonFechaFinalRealizado setTitle:[data objectForKey:@"dateFinishRealized"] forState:UIControlStateNormal];
    
    //self.txtFrecuency.delegate = self;
    [self.lbl1 setText:NSLocalizedString(@"lbl1", nil)];
    [self.lbl2 setText:NSLocalizedString(@"lbl2", nil)];
    [self.lbl3 setText:NSLocalizedString(@"lbl3", nil)];
    [self.lbl4 setText:NSLocalizedString(@"lbl4", nil)];
    [self.lbl5 setText:NSLocalizedString(@"lbl5", nil)];
    [self.lbl6 setText:NSLocalizedString(@"lbl6", nil)];
    [self.lblFecha1 setText:NSLocalizedString(@"lblFecha1", nil)];
    [self.lblFecha2 setText:NSLocalizedString(@"lblFecha2", nil)];
    [self.lblFecha3 setText:NSLocalizedString(@"lblFecha3", nil)];
    [self.lblFecha4 setText:NSLocalizedString(@"lblFecha4", nil)];
    
    [self.txtAccion setPlaceholder:NSLocalizedString(@"lbl2", nil)];
    [self.txtActividad setPlaceholder:NSLocalizedString(@"lbl3", nil)];
    [self.txtResponsable setPlaceholder:NSLocalizedString(@"lbl4", nil)];
    [self.txtDocumentoGenerar setPlaceholder:NSLocalizedString(@"lbl5", nil)];
    [self.txtDocumentoModificar setPlaceholder:NSLocalizedString(@"lbl6", nil)];

    [self.ButtonCancel setTitle:NSLocalizedString(@"Cancelar", nil)];
    [self.buttonSave setTitle:NSLocalizedString(@"Guardar", nil) forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
    [self loadView];
    
    if(self.historico){
        self.buttonCausa.enabled = NO;
        self.txtAccion.enabled = NO;
        self.txtActividad.enabled = NO;
        self.txtResponsable.enabled = NO;
        self.txtDocumentoGenerar.enabled = NO;
        self.txtDocumentoModificar.enabled = NO;
        self.buttonFechaInicialPlan.enabled = NO;
        self.buttonFechaFinalPlan.enabled = NO;
    }
    
    NSMutableDictionary *data = [self.actionArray objectAtIndex:self.index];
    self.buttonCausa.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonCausa.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.buttonCausa.titleLabel.text= [data objectForKey:@"cause"];
    self.txtAccion.text=              [data objectForKey:@"action"];
    self.txtActividad.text=           [data objectForKey:@"activity"];
    self.txtResponsable.text=         [data objectForKey:@"responsible"];
    self.txtDocumentoGenerar.text=    [data objectForKey:@"documentGenerated"];
    self.txtDocumentoModificar.text=  [data objectForKey:@"documentModified"];
    
    if([data objectForKey:@"dateStartPlan"] && ![[data objectForKey:@"dateStartPlan"] isEqualToString:@""])
        [self.buttonFechaInicialPlan setTitle:[data objectForKey:@"dateStartPlan"] forState:UIControlStateNormal];
    if([data objectForKey:@"dateFinishPlan"] && ![[data objectForKey:@"dateFinishPlan"] isEqualToString:@""])
        [self.buttonFechaFinalPlan setTitle:[data objectForKey:@"dateFinishPlan"] forState:UIControlStateNormal];
    if([data objectForKey:@"dateStartRealized"] && ![[data objectForKey:@"dateStartRealized"] isEqualToString:@""])
        [self.buttonFechaInicialRealizado setTitle:[data objectForKey:@"dateStartRealized"] forState:UIControlStateNormal];
    if([data objectForKey:@"dateFinishRealized"] && ![[data objectForKey:@"dateFinishRealized"] isEqualToString:@""])
        [self.buttonFechaFinalRealizado setTitle:[data objectForKey:@"dateFinishRealized"] forState:UIControlStateNormal];
    
    [self.lblTitleView setText:NSLocalizedString(@"Analisis de fallas", nil)];
    [self.lbl1 setText:NSLocalizedString(@"lbl1", nil)];
    [self.lbl2 setText:NSLocalizedString(@"lbl2", nil)];
    [self.lbl3 setText:NSLocalizedString(@"lbl3", nil)];
    [self.lbl4 setText:NSLocalizedString(@"lbl4", nil)];
    [self.lbl5 setText:NSLocalizedString(@"lbl5", nil)];
    [self.lbl6 setText:NSLocalizedString(@"lbl6", nil)];
    [self.lblFecha1 setText:NSLocalizedString(@"lblFecha1", nil)];
    [self.lblFecha2 setText:NSLocalizedString(@"lblFecha2", nil)];
    [self.lblFecha3 setText:NSLocalizedString(@"lblFecha3", nil)];
    [self.lblFecha4 setText:NSLocalizedString(@"lblFecha4", nil)];
    
    [self.txtAccion setPlaceholder:NSLocalizedString(@"lbl2", nil)];
    [self.txtActividad setPlaceholder:NSLocalizedString(@"lbl3", nil)];
    [self.txtResponsable setPlaceholder:NSLocalizedString(@"lbl4", nil)];
    [self.txtDocumentoGenerar setPlaceholder:NSLocalizedString(@"lbl5", nil)];
    [self.txtDocumentoModificar setPlaceholder:NSLocalizedString(@"lbl6", nil)];
    
    [self.ButtonCancel setTitle:NSLocalizedString(@"Cancelar", nil)];
    [self.buttonSave setTitle:NSLocalizedString(@"Guardar", nil) forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)bloqueaDocumentoGenerar:(id)sender {
    if(self.txtDocumentoGenerar.text.length !=0){
        self.txtDocumentoModificar.text = @"";
        self.txtDocumentoModificar.enabled=NO;
    }
    else
    {
        self.txtDocumentoModificar.enabled=YES;
    }
}

- (IBAction)bloqueaDocumentoModificar:(id)sender {
    if(self.txtDocumentoModificar.text.length !=0){
        
        self.txtDocumentoGenerar.text = @"";
        self.txtDocumentoGenerar.enabled=NO;
    }
    else
    {
        self.txtDocumentoGenerar.enabled=YES;
    }
}
- (IBAction)setFechaInicioPlan:(id)sender {
    [self muestraPop:self.buttonFechaInicialPlan];
}

- (IBAction)setFechaFinPlan:(id)sender {
    [self muestraPop:self.buttonFechaFinalPlan];
}

- (IBAction)setFechaInicioRealizado:(id)sender {
    [self muestraPop:self.buttonFechaInicialRealizado];
}
- (IBAction)setFechaFinRealizado:(id)sender {
    [self muestraPop:self.buttonFechaFinalRealizado];
}

- (void) muestraPop: (UIButton *) _boton {
    if (_dapvc == nil) {
        _dapvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DateActionPlanView"];
    }
    
    if (_datePopover == nil) {
        _dapvc.buttonFecha = _boton;
        _datePopover = [[UIPopoverController alloc] initWithContentViewController:_dapvc];
        [_datePopover presentPopoverFromRect:CGRectMake(801, 401, 300, 200) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        [_datePopover setPopoverContentSize:CGSizeMake(350, 300)];
        [_datePopover presentPopoverFromRect:_boton.bounds inView:_boton permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    } else {
        //The color picker popover is showing. Hide it.
        [_datePopover dismissPopoverAnimated:YES];
        _datePopover = nil;
    }
    
}

- (IBAction)saveDetail:(id)sender {
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    //Valida que tenga una causa seleccionada
    if([self.buttonCausa.titleLabel.text isEqual:NSLocalizedString(@"btn1", nil)]){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Es necesario seleccionar una causa",nil);
        [self presentViewController:vc animated:YES completion:nil];
     
     }
     else
     {
         [data setValue:self.buttonCausa.titleLabel.text forKey:@"cause"];

     }
    
    //Valida que tenga una acción
    if([self.txtAccion.text isEqual: @""]){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Es necesario ingresar una Acción / contramedida",nil);
        [self presentViewController:vc animated:YES completion:nil];
        return;
        
    }
    else
    {
        [data setValue:self.txtAccion.text forKey:@"action"];
    }

    //Valida que tenga una actividad
    if([self.txtActividad.text isEqual: @""]){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Es necesario ingresar una actividad",nil);
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    else
    {
        [data setValue:self.txtActividad.text forKey:@"activity"];
    }
   
    //Valida que tenga un responsable
    if([self.txtResponsable.text isEqual: @""]){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Es necesario ingresar un responsable",nil);
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    else
    {
        [data setValue:self.txtResponsable.text forKey:@"responsible"];
    }
    //Si tiene el formato dd/mm/yyyy quiere decir que no es fecha y lo asigna vacio
    if([self.buttonFechaInicialPlan.titleLabel.text isEqual: @"dd/mm/yyyy hh:mm"]){
        [data setValue:@"" forKey:@"dateStartPlan"];
    }
    else{
        [data setValue:self.buttonFechaInicialPlan.titleLabel.text forKey:@"dateStartPlan"];
    }
    
    if([self.buttonFechaFinalPlan.titleLabel.text  isEqual: @"dd/mm/yyyy hh:mm"]){
        [data setValue:@"" forKey:@"dateFinishPlan"];
    }
    else{
        [data setValue:self.buttonFechaFinalPlan.titleLabel.text forKey:@"dateFinishPlan"];
    }
    
    if([self.buttonFechaInicialRealizado.titleLabel.text  isEqual: @"dd/mm/yyyy hh:mm"]){
        [data setValue:@"" forKey:@"dateStartRealized"];
    }
    else{
        [data setValue:self.buttonFechaInicialRealizado.titleLabel.text forKey:@"dateStartRealized"];

    }
    
    if([self.buttonFechaFinalRealizado.titleLabel.text  isEqual: @"dd/mm/yyyy hh:mm"]){
        [data setValue:@"" forKey:@"dateFinishRealized"];
    }
    else{
         [data setValue:self.buttonFechaFinalRealizado.titleLabel.text forKey:@"dateFinishRealized"];
    }

    //Valida que la fecha final del plan NO sea menor a la fecha inicial
    if(![self.buttonFechaInicialPlan.titleLabel.text isEqual: @"dd/mm/yyyy hh:mm"] && ![self.buttonFechaFinalPlan.titleLabel.text  isEqual: @"dd/mm/yyyy hh:mm"]){
        
        double milSegInicial;
        double milSegFin;
        
        //Fecha inicio
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm:ss"];
        
        NSString *fechaInicia= [NSString stringWithFormat:@"%@ 12:00:00",_buttonFechaInicialPlan.titleLabel.text];
        NSDate *fechaInicial = [dateFormatter dateFromString:fechaInicia];
        NSTimeInterval timeInMiliseconds = [fechaInicial timeIntervalSince1970];
        double millisecondsInicio = timeInMiliseconds*1000;
        
        milSegInicial = millisecondsInicio;
        
        
        
        //Fecha fin
        NSString *fechafin= [NSString stringWithFormat:@"%@ 12:00:00",_buttonFechaFinalPlan.titleLabel.text];
        NSDate *fechaFinal = [dateFormatter dateFromString:fechafin];
        timeInMiliseconds = [fechaFinal timeIntervalSince1970];
        double millisecondsFin = timeInMiliseconds*1000;
        milSegFin = millisecondsFin;
        
        double dias = millisecondsFin - millisecondsInicio;
        dias = dias/1000/60/60/24;
        dias = round(dias);
        
        if(dias<0)
        {
            CustomAlertViewController* vc = [CustomAlertViewController new];
            vc.text = NSLocalizedString(@"La fecha final del plan es menor que la fecha inicial",nil);
            [self presentViewController:vc animated:YES completion:nil];
            return;
            
        }
    }
   
    //Valida que la fecha final del actividad realizada NO sea menor a la fecha inicial
    if(![self.buttonFechaInicialRealizado.titleLabel.text isEqual: @"dd/mm/yyyy hh:mm"] && ![self.buttonFechaFinalRealizado.titleLabel.text  isEqual: @"dd/mm/yyyy hh:mm"]){
        
        double milSegInicial;
        double milSegFin;
        
        //Fecha inicio
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm:ss"];
        
        NSString *fechaInicia= [NSString stringWithFormat:@"%@ 12:00:00",_buttonFechaInicialRealizado.titleLabel.text];
        NSDate *fechaInicial = [dateFormatter dateFromString:fechaInicia];
        NSTimeInterval timeInMiliseconds = [fechaInicial timeIntervalSince1970];
        double millisecondsInicio = timeInMiliseconds*1000;
        
        milSegInicial = millisecondsInicio;
        
        //Fecha fin
        NSString *fechafin= [NSString stringWithFormat:@"%@ 12:00:00",_buttonFechaFinalRealizado.titleLabel.text];
        NSDate *fechaFinal = [dateFormatter dateFromString:fechafin];
        timeInMiliseconds = [fechaFinal timeIntervalSince1970];
        double millisecondsFin = timeInMiliseconds*1000;
        milSegFin = millisecondsFin;
        
        double dias = millisecondsFin - millisecondsInicio;
        dias = dias/1000/60/60/24;
        dias = round(dias);
        
        if(NO)//dias<=0)
        {
            CustomAlertViewController* vc = [CustomAlertViewController new];
            vc.text = NSLocalizedString(@"La fecha final del la actividad realizada es menor que la fecha inicial",nil);
            [self presentViewController:vc animated:YES completion:nil];
            return;
            
        }
    }
   [data setValue:self.txtDocumentoGenerar.text forKey:@"documentGenerated"];
   [data setValue:self.txtDocumentoModificar.text forKey:@"documentModified"];
    NSMutableDictionary *dicTemp = [self.actionArray objectAtIndex:self.index];
    [self.actionArray replaceObjectAtIndex:self.index withObject:data];
    
    if(self.historico){
        [data setValue:[dicTemp objectForKey:@"id_problema"] forKey:@"id_problema"];
        [data setValue:[dicTemp objectForKey:@"id_ishikawa"] forKey:@"id_ishikawa"];
        [data setValue:[dicTemp objectForKey:@"id_analisis"] forKey:@"id_analisis"];
        
        RoketFetcher *roket = [[RoketFetcher alloc]init];
        [roket mdfActionArray:self.actionArray];
    }
    
    ActionPlanViewController *apvc = [[ActionPlanViewController alloc] init];
    apvc.actionArray = self.actionArray;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UI Style

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
