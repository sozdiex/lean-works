//
//  ActionPlanGraphViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 24/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "ActionPlanGraphViewController.h"
#import "ActionPlanGraphCell.h"
#import "XCMultiSortTableView.h"
#import "RoketFetcher.h"
#import "CustomAlertViewController.h"
#import <MessageUI/MessageUI.h>

@interface ActionPlanGraphViewController (){
    NSMutableArray *headData;
    NSMutableArray *leftTableData;
    NSMutableArray *tableData;
    
    double milSegInicial;
    double milSegFin;
}

@property (strong, nonatomic) NSMutableArray *optionsArray;

@end

@implementation ActionPlanGraphViewController

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
    [self.btnAtras setTitle:NSLocalizedString(@"btnBack", nil)];
    [self.lblTitleView setText:NSLocalizedString(@"Plan de accion grafica", nil)];
    [self.btnSave setTitle:NSLocalizedString(@"Guardar", nil) forState:UIControlStateNormal];
    self.btnSave.layer.borderWidth = 1.0f;
    self.btnSave.layer.cornerRadius = 7.0f;
    self.btnSave.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
    
    //[self hardcode];
    
    [self initData:[self getSemanas]];
    
    if(self.historico && !self.actividadModificada){
        [self.btnSave setHidden:YES];
    }else{
        [self.btnSave setHidden:NO];
    }
    
    
    XCMultiTableView *tableView = [[XCMultiTableView alloc] initWithFrame:CGRectInset(self.view.bounds,40, 320)];
    tableView.leftHeaderEnable = NO;
    [tableView setDatasource:(id<XCMultiTableViewDataSource>)self];
    [self.view addSubview:tableView];
}

- (void)initData:(int)semanas {
    NSString *lineaContinua = @"––––––––––––";
    NSString *flechaContinua = @"––––––––––► ";
    NSString *lineaPunteada = @"--------------------";
    NSString *flechaPunteada = @"-------------► ";
    NSString *stringVacio = @"";
    
    headData = [[NSMutableArray alloc]init];
    [headData addObject:@"No."];
    [headData addObject:NSLocalizedString(@"Accion", nil)];
    [headData addObject:NSLocalizedString(@"Actividad", nil)];
    [headData addObject:NSLocalizedString(@"Responsable", nil)];
    for (int i = 0; i< semanas; i++) {
        [headData addObject:[NSString stringWithFormat:NSLocalizedString(@"S%d",nil),i+1]];
    }

    
    tableData = [[NSMutableArray alloc] init];
    bool renglon = YES;
    int numRenglon = 0;
    double x = milSegInicial;
    NSMutableArray *twoR = [[NSMutableArray alloc]init];
    for (int i = 0; i < [self.actionArray count]*2; i++) {
        
        NSMutableDictionary *myDic = [self.actionArray objectAtIndex:numRenglon];
        NSMutableArray *ary = [[NSMutableArray alloc]init];
        bool fechaFin = NO;
        bool fechanInicio = NO;
        double milInicio = 0;
        double milFin  = 0;
        
        
        
        double milTemp = x;
        double  dia = 1*24*60*60*1000;
        if(renglon){
            renglon = NO;
            
            if(![[myDic objectForKey:@"dateStartPlan"] isEqualToString:@""]){
                fechanInicio = YES;
                milInicio = [self getMiliSegundos:[myDic objectForKey:@"dateStartPlan"]];
            }
            if(![[myDic objectForKey:@"dateFinishPlan"] isEqualToString:@""]){
                fechaFin = YES;
                milFin = [self getMiliSegundos:[myDic objectForKey:@"dateFinishPlan"]];
            }
            
            int TempSemana =[self getSemanasWithRange:[myDic objectForKey:@"dateStartPlan"]:[myDic objectForKey:@"dateFinishPlan"]];
            
            
            for (int j = 0; j < [headData count]; j++) {
                
                if(![[myDic objectForKey:@""]isEqualToString:@""]){
                    
                }
                if(j == 0){
                    [ary addObject:[NSNumber numberWithInt:numRenglon+1]];
                }else if (j == 1) {
                    [ary addObject:[myDic objectForKey:@"action"]];
                }else if (j == 2) {
                    [ary addObject:[myDic objectForKey:@"activity"]];
                }
                else if (j == 3) {
                    [ary addObject:[myDic objectForKey:@"responsible"]];
                }else{
                    if( fechanInicio && fechaFin){
                        NSLog(@"inicio: %f \n Fin: %f \n temp:%f ",milInicio , milFin , milTemp);
                        if(milInicio >= milTemp && milInicio <= milTemp + (dia * 7)){
                            if(TempSemana == 1){
                                [ary addObject:flechaContinua];
                            }else{
                                [ary addObject:lineaContinua];
                            }
                            
                            for(int q = 1; q < TempSemana ;q++){
                                if(q < TempSemana-1){
                                    [ary addObject:lineaContinua];
                                }else{
                                    [ary addObject:flechaContinua];
                                    fechaFin= NO;
                                    fechanInicio = NO;
                                    break;
                                }
                                ++j;
                            }
                        }else{
                            [ary addObject:stringVacio];
                            //fechaFin= NO;
                            //fechanInicio = NO;
                        }
                    }else{
                        [ary addObject:stringVacio];
                    }
                    
                    milTemp = milTemp + (dia * 7);
                }
            }
        }else{
            renglon = YES;
            
            if(![[myDic objectForKey:@"dateStartRealized"] isEqualToString:@""]){
                fechanInicio = YES;
                milInicio = [self getMiliSegundos:[myDic objectForKey:@"dateStartRealized"]];
            }
            if(![[myDic objectForKey:@"dateFinishRealized"] isEqualToString:@""]){
                fechaFin = YES;
                milFin = [self getMiliSegundos:[myDic objectForKey:@"dateFinishRealized"]];
            }
            
            int TempSemana =[self getSemanasWithRange:[myDic objectForKey:@"dateStartRealized"]:[myDic objectForKey:@"dateFinishRealized"]];
            
            for (int j = 0; j < [headData count]; j++) {
                if(j == 0){
                    [ary addObject:[NSNumber numberWithInt:numRenglon+1]];
                }else if (j == 1) {
                    [ary addObject:stringVacio];
                }else if (j == 2) {
                    [ary addObject:stringVacio];
                }else if (j == 3) {
                    [ary addObject:stringVacio];
                }else{
                    if( fechanInicio && fechaFin){
                        NSLog(@"inicio: %f \n Fin: %f \n temp:%f ",milInicio , milFin , milTemp);
                        if(milInicio >= milTemp && milInicio <= milTemp + (dia * 7)){
                            //[ary addObject:flechaPunteada];
                            if(TempSemana == 1){
                                [ary addObject:flechaPunteada];
                            }else{
                                [ary addObject:lineaPunteada];
                            }
                            
                            for(int q = 1; q < TempSemana ;q++){
                                if(q < TempSemana-1){
                                    [ary addObject:lineaPunteada];
                                }else{
                                    [ary addObject:flechaPunteada];
                                    fechaFin= NO;
                                    fechanInicio = NO;
                                    break;
                                }
                                ++j;
                            }
                            
                        }else{
                            [ary addObject:stringVacio];
                            //fechaFin= NO;
                            //fechanInicio = NO;
                        }
                    }else{
                        [ary addObject:stringVacio];
                    }
                    
                    milTemp = milTemp + (dia * 7);
                }
            }
            numRenglon++;
        }
        
        
        
        [twoR addObject:ary];
    }
    [tableData addObject:twoR];
}

-(double)getMiliSegundos:(NSString* )date{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy hh:mm"];
    NSString *fecha = [NSString stringWithFormat:@"%@",date];
    
    NSDate *myDateInicio = [df dateFromString: fecha];
    NSTimeInterval timeInMiliseconds = [myDateInicio timeIntervalSince1970];
    double millisecondsInicio = timeInMiliseconds*1000;
    
    return  millisecondsInicio;
}

-(void)getDateMax{
    NSMutableArray *arrayFechas = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < [self.actionArray count]; i++) {
        NSMutableDictionary *myDic = [self.actionArray objectAtIndex:i];
        
        if(![[myDic objectForKey:@"dateStartPlan"] isEqualToString:@""]){
            [arrayFechas addObject:[myDic objectForKey:@"dateStartPlan"]];
        }
        if(![[myDic objectForKey:@"dateStartRealized"] isEqualToString:@""]){
            [arrayFechas addObject:[myDic objectForKey:@"dateStartRealized"]];
        }
        if(![[myDic objectForKey:@"dateFinishPlan"] isEqualToString:@""]){
            [arrayFechas addObject:[myDic objectForKey:@"dateFinishPlan"]];
        }
        if(![[myDic objectForKey:@"dateFinishRealized"] isEqualToString:@""]){
            [arrayFechas addObject:[myDic objectForKey:@"dateFinishRealized"]];
        }
    }
    NSString *dateMax;
    NSString *dateMin;
    if([arrayFechas count]>0){
        dateMax = [arrayFechas objectAtIndex:0];
        dateMin = [arrayFechas objectAtIndex:0];
    }
    
    for (int i = 1; i < [arrayFechas count]; i++) {
        
        NSString *newDate = [arrayFechas objectAtIndex:i];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyyy hh:mm"];
        NSString *fecha = [NSString stringWithFormat:@"%@",dateMax];
        
        NSDate *myDate = [df dateFromString: fecha];
        NSTimeInterval timeInMiliseconds = [myDate timeIntervalSince1970];
        double millisecondsMax = timeInMiliseconds*1000;
        
        fecha = [NSString stringWithFormat:@"%@",newDate];
        myDate = [df dateFromString: fecha];
        timeInMiliseconds = [myDate timeIntervalSince1970];
        double millisecondsNew = timeInMiliseconds*1000;
        
        fecha = [NSString stringWithFormat:@"%@",dateMin];
        myDate = [df dateFromString: fecha];
        timeInMiliseconds = [myDate timeIntervalSince1970];
        double millisecondsMin = timeInMiliseconds*1000;
        
        if(millisecondsNew > millisecondsMax){
            dateMax = newDate;
        }
        
        if(millisecondsNew < millisecondsMin){
            dateMin = newDate;
        }
    }
    NSLog(@"fecha maxicma: %@ \n fecha minima: %@",dateMax, dateMin);
    self.fechaInicial = dateMin;
    self.fechaFinal = dateMax;
}

-(int)getSemanas{
    [self getDateMax];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy hh:mm"];
    NSString *fecha = [NSString stringWithFormat:@"%@",self.fechaInicial];
    
    NSDate *myDateInicio = [df dateFromString: fecha];
    NSTimeInterval timeInMiliseconds = [myDateInicio timeIntervalSince1970];
    double millisecondsInicio = timeInMiliseconds*1000;
    
    milSegInicial = millisecondsInicio;
    
    fecha = [NSString stringWithFormat:@"%@",self.fechaFinal];
    
    NSDate *myDateFin = [df dateFromString: fecha];
    timeInMiliseconds = [myDateFin timeIntervalSince1970];
    double millisecondsFin = timeInMiliseconds*1000;
    milSegFin = millisecondsFin;
    
    double dias = millisecondsFin - millisecondsInicio;
    dias = dias/1000/60/60/24;
    dias = round(dias);
    
    int semanas = round(dias /7);
    if(semanas <1){
        semanas = 1;
    }
    //double  dia = 1*24*60*60*1000;
    //milliseconds = milliseconds + (dia * 7);
    return  semanas;
}

-(int)getSemanasWithRange:(NSString *)dateStart :(NSString *)dateEnd{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy hh:mm"];
    NSString *fecha = [NSString stringWithFormat:@"%@",dateStart];
    
    NSDate *myDateInicio = [df dateFromString: fecha];
    NSTimeInterval timeInMiliseconds = [myDateInicio timeIntervalSince1970];
    double millisecondsInicio = timeInMiliseconds*1000;
    
    milSegInicial = millisecondsInicio;
    
    fecha = [NSString stringWithFormat:@"%@",dateEnd];
    
    NSDate *myDateFin = [df dateFromString: fecha];
    timeInMiliseconds = [myDateFin timeIntervalSince1970];
    double millisecondsFin = timeInMiliseconds*1000;
    milSegFin = millisecondsFin;
    
    double dias = millisecondsFin - millisecondsInicio;
    dias = dias/1000/60/60/24;
    dias = round(dias);
    
    int semanas = round(dias /7);
    if(semanas <1){
        semanas = 1;
    }
    //double  dia = 1*24*60*60*1000;
    //milliseconds = milliseconds + (dia * 7);
    return  semanas;
}

- (void)hardcode {
    self.optionsArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Servicios"]) {
        [dic setValue:@"Conseguir financiamiento" forKey:@"activity"];
        [dic setValue:@"Gerente de finanzas" forKey:@"responsible"];
        [dic setValue:@"------------------------►" forKey:@"sprint"];
        [self.optionsArray addObject:dic];
        
        dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"Reparar el equipo que se tiene" forKey:@"activity"];
        [dic setValue:@"Gerente de mantenimiento" forKey:@"responsible"];
        [dic setValue:@"-----------►" forKey:@"sprint"];
        [self.optionsArray addObject:dic];
        
        dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"Curso de programación (Capacitación)" forKey:@"activity"];
        [dic setValue:@"Gerente de sistemas" forKey:@"responsible"];
        [dic setValue:@"           --------------------------►" forKey:@"sprint"];
        [self.optionsArray addObject:dic];
    }
    else if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Manufactura"]) {
        [dic setValue:@"Realizar pruebas con diferentes boquillas" forKey:@"activity"];
        [dic setValue:@"Jefe de producción" forKey:@"responsible"];
        [dic setValue:@"-----------►" forKey:@"sprint"];
        [self.optionsArray addObject:dic];
        
        dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"Evaluar resultados" forKey:@"activity"];
        [dic setValue:@"Jefe de producción" forKey:@"responsible"];
        [dic setValue:@"             ----►" forKey:@"sprint"];
        [self.optionsArray addObject:dic];
        
        dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"Mapear el proceso" forKey:@"activity"];
        [dic setValue:@"Ing. de línea de pintado" forKey:@"responsible"];
        [dic setValue:@"                   -----►" forKey:@"sprint"];
        [self.optionsArray addObject:dic];
        
        dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"Toma de tiempo y balanceo de la línea" forKey:@"activity"];
        [dic setValue:@"Ing. de línea de pintado" forKey:@"responsible"];
        [dic setValue:@"                          ----►" forKey:@"sprint"];
        [self.optionsArray addObject:dic];
        
        dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"Elaboración de estándares operativos" forKey:@"activity"];
        [dic setValue:@"Ing. de línea de pintado" forKey:@"responsible"];
        [dic setValue:@"                                -----►" forKey:@"sprint"];
        [self.optionsArray addObject:dic];
        
        dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"Capacitación e implementación de estándares operativos" forKey:@"activity"];
        [dic setValue:@"Ing. de línea de pintado" forKey:@"responsible"];
        [dic setValue:@"                                        ----►" forKey:@"sprint"];
        [self.optionsArray addObject:dic];
    }
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
- (void)sendEmail{
    RoketFetcher *roket = [[RoketFetcher alloc]init];
    NSString *pdfPath = [roket makePdf:[self.dicIshikawa objectForKey:@"actionArray"]];
    
    NSString *emailTitle = NSLocalizedString(@"Jade lean - Analisis de fallas",nil);
    NSString *messageBody = NSLocalizedString(@"se adjunta un pdf con el Analisis de fallas",nil);
    //NSArray *toRecipents = [NSArray arrayWithObject:@"armandotr13@gmail.com"];
    
    if([MFMailComposeViewController canSendMail]){
        MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
        mc.mailComposeDelegate = (id<MFMailComposeViewControllerDelegate>)self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        //[mc setToRecipients:toRecipents];
        
        NSData *fileData = [NSData dataWithContentsOfFile:pdfPath];
        
        // Add attachment
        [mc addAttachmentData:fileData mimeType:@"application/pdf" fileName:@"jade lean"];
        
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:nil];
    }else{
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Configure una cuenta en Mail para enviar correo electrónico.",nil);
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (IBAction)btnSave:(id)sender {
    NSLog(@"%@",self.dicPareto);
    
    if(self.actividadModificada){
        NSLog(@"%@",self.actionArray);
        RoketFetcher *roket = [[RoketFetcher alloc]init];
        [roket saveActionFailure:self.actionArray countActionArray:self.countActionArray];
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Se guardo con exito, podra ver el flujo desde la seccion histórico.",nil);
        [self sendEmail];
        [self presentViewController:vc animated:YES completion:nil];
        self.actividadModificada = NO;
        return;
    }
    
    if([[self.dicPareto objectForKey:@"EstatusGuardado"] isEqualToString:@"0"]){
        RoketFetcher *roket = [[RoketFetcher alloc]init];
        int id_problema = [roket savePareto:self.dicPareto];
        if(id_problema > 0){
            [self.dicPareto setObject:@"1" forKey:@"EstatusGuardado"];
            [roket saveIshikawa:self.dicIshikawa :id_problema];
        }
        if([self.dicPareto objectForKey:@"id_JSON"])
            [roket setEstatusTrue:[[self.dicPareto objectForKey:@"id_JSON"] integerValue]];
            CustomAlertViewController* vc = [CustomAlertViewController new];
            vc.text = NSLocalizedString(@"Se guardo con exito, podra ver el flujo desde la seccion histórico.",nil);
        [self sendEmail];
        [self presentViewController:vc animated:YES completion:nil];
        
    }else{
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Este flujo ya se encuentra guardado, si desea ver el flujo vaya ala seccion de histórico.",nil);
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableView

- (NSArray *)arrayDataForTopHeaderInTableView:(XCMultiTableView *)tableView {
    return [headData copy];
}
- (NSArray *)arrayDataForLeftHeaderInTableView:(XCMultiTableView *)tableView InSection:(NSUInteger)section {
    return [tableData objectAtIndex:section];
}

- (NSArray *)arrayDataForContentInTableView:(XCMultiTableView *)tableView InSection:(NSUInteger)section {
    return [tableData objectAtIndex:section];
}


- (NSUInteger)numberOfSectionsInTableView:(XCMultiTableView *)tableView {
    return [tableData count];
}

- (CGFloat)tableView:(XCMultiTableView *)tableView contentTableCellWidth:(NSUInteger)column {
    if (column == 0) {
        return 30.0f;
    }else if(column == 1){
        return 250.0f;
    }else if(column == 2){
        return 250.0f;
    }else if(column == 3){
        return 250.0f;
    }
    return 100.0f;
}

- (CGFloat)tableView:(XCMultiTableView *)tableView cellHeightInRow:(NSUInteger)row InSection:(NSUInteger)section {
    /*if (section == 0) {
     return 60.0f;
     }else {
     return 30.0f;
     }*/
    return 30.0f;
}

- (UIColor *)tableView:(XCMultiTableView *)tableView bgColorInSection:(NSUInteger)section InRow:(NSUInteger)row InColumn:(NSUInteger)column {
    
    //marcar con color un renglon
    if (row == 1 && section == 0) {
        //return [UIColor redColor];
    }
    return [UIColor clearColor];
}

- (UIColor *)tableView:(XCMultiTableView *)tableView headerBgColorInColumn:(NSUInteger)column {
    
    return [UIColor clearColor];
    
    if (column == -1) {
        return [UIColor redColor];
    }else if (column == 1) {
        return [UIColor grayColor];
    }
    return [UIColor clearColor];
}


#pragma mark - UIStyle

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - delegate Send Mail
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
