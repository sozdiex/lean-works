//
//  ActionPlanViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 18/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "ActionPlanViewController.h"
#import "ActionPlanCell.h"
#import "ActionPlanGraphViewController.h"
#import "SelectCauseViewController.h"
#import "FailureAnalysisViewController.h"
#import "DateActionPlanViewController.h"
#import "ActionPlanDetailViewController.h"
#import "RoketFetcher.h"
#import "CustomAlertViewController.h"

@interface ActionPlanViewController(){
    int countActionArray;
    }
    @property (nonatomic, strong) DateActionPlanViewController *dapvc;
    @property (nonatomic, strong) UIPopoverController *datePopover;
    @property (nonatomic,strong)  ActionPlanDetailViewController *apdvc;
//@property (strong, nonatomic) SelectCauseViewController *scvc;
@end


@implementation ActionPlanViewController

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

    [self.buttonCausa setTitle:NSLocalizedString(@"btn1", nil) forState:UIControlStateNormal];
    [self.btnNext setTitle:NSLocalizedString(@"btnSiguiente", nil)];
    [self.btnBack setTitle:NSLocalizedString(@"btnBack", nil)];
    [self.buttonSave setTitle:NSLocalizedString(@"Agregar", nil) forState:UIControlStateNormal];

	// Do any additional setup after loading the view.
    self.buttonSave.layer.borderWidth = 1.0f;
    self.buttonSave.layer.cornerRadius = 7.0f;
    self.buttonSave.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
    [self.buttonCausa setTitle:NSLocalizedString(@"btn1", nil) forState:UIControlStateNormal];
    self.buttonCausa.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonCausa.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.arrayCausaSelect = [[NSMutableArray alloc]init];
    [self.arrayCausaSelect addObject:NSLocalizedString(@"btn1", nil)];
    //[self hardcode];
    
    if([self.dicIshikawa objectForKey:@"actionArray"])
        self.actionArray = [self.dicIshikawa objectForKey:@"actionArray"];
    
    if(!self.actionArray)
        self.actionArray = [[NSMutableArray alloc]init];
    
    if(self.historico){
        countActionArray = [self.actionArray count];
    }
    
    if(false){//self.historico){
        self.viewForm.hidden = YES;
        //self.tableForm.hidden = YES;
        self.tableData.hidden = YES;
        self.tableDataFull.hidden = NO;
        //[self.tableData setFrame:CGRectInset(self.view.bounds,40, 320)];
        [self.tableDataFull reloadData];
    }else{
        self.viewForm.hidden = NO;
        //self.tableForm.hidden = NO;
        self.tableData.hidden = NO;
        self.tableDataFull.hidden = YES;
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertAccepted) name:@"alertAccepted" object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"-%@-", [self.arrayCausaSelect objectAtIndex:0]);
    [self.buttonCausa setTitle:[self.arrayCausaSelect objectAtIndex:0] forState: UIControlStateNormal];
    self.buttonCausa.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonCausa.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.buttonCausa.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonCausa.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.txtAccion.text= @"";
    self.txtActividad.text =@"";
    self.txtResponsable.text =@"";
    self.txtDocumentoGenerar.text =@"";
    self.txtDocumentoModificar.text = @"";
    self.txtDocumentoGenerar.enabled = YES;
    self.txtDocumentoModificar.enabled = YES;
    
    [self.buttonFechaInicialPlan setTitle:@"dd/mm/yyyy" forState: UIControlStateNormal];
    [self.buttonFechaFinalPlan setTitle:@"dd/mm/yyyy" forState: UIControlStateNormal];
    [self.buttonFechaInicialRealizado setTitle:@"dd/mm/yyyy" forState: UIControlStateNormal];
    [self.buttonFechaFinalRealizado setTitle:@"dd/mm/yyyy" forState: UIControlStateNormal];

    [self.tableData deselectRowAtIndexPath:[self.tableData indexPathForSelectedRow] animated:YES];
    [self.tableData reloadData];
    [self.tableDataFull deselectRowAtIndexPath:[self.tableDataFull indexPathForSelectedRow] animated:YES];
    [self.tableDataFull reloadData];
}



- (void)hardcode {
    self.actionArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Servicios"]) {
        
        //[self.buttonCausa setTitle:@"Falta personal capacitado" forState:UIControlStateNormal];
       // self.txtAccion.text = @"Curso de programación";
       // self.txtActividad.text = @"Curso de programación";
        //self.txtResponsable.text = @"José López";
    //    [self.date setTitle:@"28/02/2014" forState:UIControlStateNormal];
    //    [self.dateEnd setTitle:@"28/02/2014" forState:UIControlStateNormal];
        
        [dic setValue:@"Falta de equipo" forKey:@"cause"];
        [dic setValue:@"Conseguir financiamiento" forKey:@"action"];
        [dic setValue:@"Actividad 1" forKey:@"activity"];
        [dic setValue:@"Administración" forKey:@"responsible"];
        [dic setValue:@"Generado" forKey:@"documentGenerated"];
        [dic setValue:@"" forKey:@"documentModified"];
        [dic setValue:@"30/01/2014" forKey:@"dateStartPlan"];
        [dic setValue:@"18/02/2014" forKey:@"dateFinishPlan"];
        [dic setValue:@"28/03/2014" forKey:@"dateStartRealized"];
        [dic setValue:@"18/04/2014" forKey:@"dateFinishRealized"];
        [self.actionArray addObject:dic];
        
        dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"Falta de equipo" forKey:@"cause"];
        [dic setValue:@"Reparar lo que ya se tiene" forKey:@"action"];
        [dic setValue:@"Actividad 2" forKey:@"activity"];
        [dic setValue:@"Mantenimiento" forKey:@"responsible"];
        [dic setValue:@"" forKey:@"documentGenerated"];
        [dic setValue:@"Modificado" forKey:@"documentModified"];
        [dic setValue:@"02/02/2014" forKey:@"dateStartPlan"];
        [dic setValue:@"15/03/2014" forKey:@"dateFinishPlan"];
        [dic setValue:@"28/03/2014" forKey:@"dateStartRealized"];
        [dic setValue:@"18/04/2014" forKey:@"dateFinishRealized"];
        [self.actionArray addObject:dic];
    }
    else if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Manufactura"]) {
        
        //[self.buttonCausa setTitle:@"Falta de organización" forState:UIControlStateNormal];
      //  self.txtAccion.text = @"Establecer horarios";
       // self.txtActividad.text = @"Planificar actividades";
       // self.txtResponsable.text = @"José López";
      //  [self.date setTitle:@"28/02/2014" forState:UIControlStateNormal];
      //  [self.dateEnd setTitle:@"28/02/2014" forState:UIControlStateNormal];
        
        [dic setValue:@"No se ha definido la boquilla correcta" forKey:@"cause"];
        [dic setValue:@"Definir boquilla correcta" forKey:@"action"];
        [dic setValue:@"Realizar prueba con dif. boquilla" forKey:@"activity"];
        [dic setValue:@"Jefe de producción" forKey:@"responsible"];
        [dic setValue:@"" forKey:@"documentGenerated"];
        [dic setValue:@"Modificado" forKey:@"documentModified"];
        [dic setValue:@"28/03/2014" forKey:@"dateStartPlan"];
        [dic setValue:@"15/04/2014" forKey:@"dateFinishPlan"];
        [dic setValue:@"28/03/2014" forKey:@"dateStartRealized"];
        [dic setValue:@"16/04/2014" forKey:@"dateFinishRealized"];
        [self.actionArray addObject:dic];
        
        dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"El proceso de espreado no está estandarizado" forKey:@"cause"];
        [dic setValue:@"Estandarizar proceso" forKey:@"action"];
        [dic setValue:@"Mapear el proceso" forKey:@"activity"];
        [dic setValue:@"Ing" forKey:@"responsible"];
        [dic setValue:@"Generado" forKey:@"documentGenerated"];
        [dic setValue:@"" forKey:@"documentModified"];
        [dic setValue:@"20/03/2014" forKey:@"dateStartPlan"];
        [dic setValue:@"18/04/2014" forKey:@"dateFinishPlan"];
        [dic setValue:@"28/03/2014" forKey:@"dateStartRealized"];
        [dic setValue:@"18/04/2014" forKey:@"dateFinishRealized"];
        [self.actionArray addObject:dic];
        

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)close:(id)sender {
    FailureAnalysisViewController *favc = [[FailureAnalysisViewController alloc] init];
    favc.failuresArray = self.failuresArray;
    //[self presentViewController:favc animated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)saveActionPlan:(id)sender {
   
    if([self.actionArray count] <= 0){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Debe de registar una actividad para continuar",nil);
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    ActionPlanGraphViewController *apgvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ActionPlanGraphView"];
    apgvc.actionArray = _actionArray;

    [self.dicIshikawa setObject:self.actionArray forKey:@"actionArray"];
    apgvc.dicIshikawa = self.dicIshikawa;
    apgvc.dicPareto = self.dicPareto;
    
    if(!self.historico)
        [RoketFetcher createJson:self.dicPareto :self.dicIshikawa :@"ActionPlanGraphView"];
    else{
        if([self.actionArray count] == countActionArray){
            //no se agregego actividad
            apgvc.actividadModificada = NO;
        } else{
            //se agrega al menos una actividad
            apgvc.actividadModificada = YES;
            apgvc.countActionArray = countActionArray;
        }
    }
    

    apgvc.historico = self.historico;
 
    
    [self presentViewController:apgvc animated:YES completion:nil];
}
- (IBAction)selectCause:(id)sender {
    SelectCauseViewController *scvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectCauseView"];
    scvc.failuresArray= self.failuresArray;
    scvc.arrayCausaSelect= self.arrayCausaSelect;
    [self presentViewController:scvc animated:YES completion:nil];
   
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

- (IBAction)agregar:(id)sender {
     NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
     dic = [[NSMutableDictionary alloc] init];
    
     [dic setValue:self.buttonCausa.titleLabel.text forKey:@"cause"];
    //Valida que tenga una acción
    if([self.txtAccion.text isEqual: @""]){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Es necesario ingresar una Acción / contramedida",nil);
        [self presentViewController:vc animated:YES completion:nil];
        return;
        
    }
    else
    {
        [dic setValue:self.txtAccion.text forKey:@"action"];
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
        [dic setValue:self.txtActividad.text forKey:@"activity"];
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
        [dic setValue:self.txtResponsable.text forKey:@"responsible"];
    }
   
    //Si tiene el formato dd/mm/yyyy quiere decir que no es fecha y lo asigna vacio
    if([self.buttonFechaInicialPlan.titleLabel.text isEqual: @"dd/mm/yyyy"]){
        [dic setValue:@"" forKey:@"dateStartPlan"];
    }
    else{
        [dic setValue:self.buttonFechaInicialPlan.titleLabel.text forKey:@"dateStartPlan"];
    }
    
    if([self.buttonFechaFinalPlan.titleLabel.text  isEqual: @"dd/mm/yyyy"]){
        [dic setValue:@"" forKey:@"dateFinishPlan"];
    }
    else{
        [dic setValue:self.buttonFechaFinalPlan.titleLabel.text forKey:@"dateFinishPlan"];
    }
    
    if([self.buttonFechaInicialRealizado.titleLabel.text  isEqual: @"dd/mm/yyyy"]){
        [dic setValue:@"" forKey:@"dateStartRealized"];
    }
    else{
        [dic setValue:self.buttonFechaInicialRealizado.titleLabel.text forKey:@"dateStartRealized"];
    }
    
    if([self.buttonFechaFinalRealizado.titleLabel.text  isEqual: @"dd/mm/yyyy"]){
        [dic setValue:@"" forKey:@"dateFinishRealized"];
    }
    else{
        [dic setValue:self.buttonFechaFinalRealizado.titleLabel.text forKey:@"dateFinishRealized"];
    }
    //Valida que la fecha final del plan NO sea menor a la fecha inicial
   if(![self.buttonFechaInicialPlan.titleLabel.text isEqual: @"dd/mm/yyyy"] && ![self.buttonFechaFinalPlan.titleLabel.text  isEqual: @"dd/mm/yyyy"]){
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
    if(![self.buttonFechaInicialRealizado.titleLabel.text isEqual: @"dd/mm/yyyy"] && ![self.buttonFechaFinalRealizado.titleLabel.text  isEqual: @"dd/mm/yyyy"]){
        
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
        
        /*unsigned flags = NSDayCalendarUnit;
        NSDateComponents *difference = [[NSCalendar currentCalendar] components:flags fromDate:fechaInicial toDate:fechaFinal options:0];
        
        int dayDiff = [difference day];*/
        if(dias<0)
        {
            CustomAlertViewController* vc = [CustomAlertViewController new];
            vc.text = NSLocalizedString(@"La fecha final del la actividad realizada es menor que la fecha inicial",nil);
            [self presentViewController:vc animated:YES completion:nil];
            return;
            
        }
    }
    [dic setValue:self.txtDocumentoGenerar.text forKey:@"documentGenerated"];
    [dic setValue:self.txtDocumentoModificar.text forKey:@"documentModified"];

    [self.actionArray addObject:dic];
    [self.tableData reloadData];
    //self.buttonCausa.titleLabel.text= @"Seleccione una causa";
    self.buttonCausa.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buttonCausa.titleLabel.textAlignment = NSTextAlignmentCenter;
    //self.txtAccion.text= @"";
    self.txtActividad.text =@"";
    //self.txtResponsable.text =@"";
    self.txtDocumentoGenerar.text =@"";
    self.txtDocumentoModificar.text = @"";
    self.txtDocumentoGenerar.enabled = YES;
    self.txtDocumentoModificar.enabled = YES;
    //self.buttonFechaInicialPlan.titleLabel.text= @"dd/mm/yyyy";
    //self.buttonFechaFinalPlan.titleLabel.text= @"dd/mm/yyyy";
    //self.buttonFechaInicialRealizado.titleLabel.text= @"dd/mm/yyyy";
    //self.buttonFechaFinalRealizado.titleLabel.text= @"dd/mm/yyyy";
}

#pragma mark - Table View

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableData  || tableView ==self.tableDataFull) {
        return 260.0;
    }
    /*else if (tableView == self.tableForm) {
        if (indexPath.row == 8)
            return 64.0;
        return 45.0;
    }*/
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableData  || tableView ==self.tableDataFull) {
        return 1;
    }
    /*else if (tableView == self.tableForm) {
        return 1;
    }*/
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableData  || tableView ==self.tableDataFull) {
        return [self.actionArray count];
    }
    /*else if (tableView == self.tableForm) {
        return 8;
    }*/
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableData || tableView == self.tableDataFull) {
        self.apdvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ActionPlanDetailView"];
        self.apdvc.actionArray = self.actionArray;
        self.apdvc.index = (int)indexPath.row;
        self.apdvc.delegate = self;
        if(self.historico){
            if(indexPath.row < countActionArray)
                self.apdvc.historico = self.historico;
            else
                self.apdvc.historico = NO;
        } else {
            self.apdvc.historico = self.historico;
        }
        
        [self.tableData deselectRowAtIndexPath:[self.tableData indexPathForSelectedRow] animated:YES];
        
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"¿Desea editar el elemento?",nil);
        vc.alertQuestion = YES;
        [self presentViewController:vc animated:YES completion:nil];
        
        /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lean Works Group" message:@"¿Desea editar el elemento?" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"OK", nil];
        alert.tag = 1;
        [alert show];*/
    }
}

- (void)tableView:(UITableView *)tableData commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.row < countActionArray) {
            [_tableData reloadData];
            return;
        }
        
        [self.actionArray removeObjectAtIndex:indexPath.row];
        [_tableData beginUpdates];
        [self tableData];
        [_tableData deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_tableData endUpdates];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableData || tableView ==self.tableDataFull) {
        ActionPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActionPlanCell" forIndexPath:indexPath];
              NSDictionary *data = [self.actionArray objectAtIndex:indexPath.row];
        
        cell.cause.text               = [data objectForKey:@"cause"];
        cell.action.text              = [data objectForKey:@"action"];
        cell.activity.text            = [data objectForKey:@"activity"];
        cell.responsible.text         = [data objectForKey:@"responsible"];
        cell.documentGenerated.text   = [data objectForKey:@"documentGenerated"];
        cell.documentModified.text    = [data objectForKey:@"documentModified"];
        cell.dateStartPlan.text       = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:@"dateStartPlan"]];
        cell.dateFinishPlan.text      = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:@"dateFinishPlan"]];
        cell.dateStartRealized.text   = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:@"dateStartRealized"]];
        cell.dateFinishRealized.text  = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:@"dateFinishRealized"]];
        
        [cell.lbl1 setText:NSLocalizedString(@"lbl1", nil)];
        [cell.lbl2 setText:NSLocalizedString(@"lbl2", nil)];
        [cell.lbl3 setText:NSLocalizedString(@"lbl3", nil)];
        [cell.lbl4 setText:NSLocalizedString(@"lbl4", nil)];
        [cell.lbl5 setText:NSLocalizedString(@"lbl5", nil)];
        [cell.lbl6 setText:NSLocalizedString(@"lbl6", nil)];
        [cell.lblFecha1 setText:NSLocalizedString(@"lblFecha1", nil)];
        [cell.lblFecha2 setText:NSLocalizedString(@"lblFecha2", nil)];
        [cell.lblFecha3 setText:NSLocalizedString(@"lblFecha3", nil)];
        [cell.lblFecha4 setText:NSLocalizedString(@"lblFecha4", nil)];
        
        /*if(self.historico){
            [cell setUserInteractionEnabled:NO];
        }*/
        
        return cell;
    }
    /*else if (tableView == self.tableForm) {
        UITableViewCell *cell;
        
        if(self.historico){
            [cell setUserInteractionEnabled:NO];
        }
        
        switch (indexPath.row) {
            case 0:
                cell = self.causaCell;
                break;
            case 1:
                cell = self.accionCell;
                break;
            case 2:
                cell = self.actividadesCell;
                break;
            case 3:
                cell = self.fechaPlanCell;
                break;
            case 4:
                cell = self.responsableCell;
                break;
            case 5:
                cell = self.documentoGenerarCell;
                break;
            case 6:
                cell = self.documentoModificarCell;
                break;
            case 7:
                cell = self.fechaRealizadoCell;
                break;
        }
        return cell;
    }*/
    return nil;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *header = @"";
    
    if (tableView == self.tableData  || tableView ==self.tableDataFull) {
         header = NSLocalizedString(@"Actividades", nil);
      /*  header = @"Causa                            Acción                        Actividad                  Responsable      Fecha Plan Inicio      Fecha Plan Fin      Fecha Realizado Inicio      Fecha Realizado Fin";*/
    }
    return header;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   if (tableView == self.tableData) {
        return NSLocalizedString(@"Eliminar",nil);
    }
    return  @"";
}

#pragma mark - AlertCustomAcepted

-(void)alertAccepted{
    NSLog(@"Dismissed SecondViewController");
    [self presentViewController:self.apdvc animated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView tag] == 1) {
        if (buttonIndex == 1) {
            [self presentViewController:self.apdvc animated:YES completion:nil];
        }
        else {
            [self.tableData deselectRowAtIndexPath:[self.tableData indexPathForSelectedRow] animated:YES];
        }
    }
}

#pragma mark - UIStyle

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
