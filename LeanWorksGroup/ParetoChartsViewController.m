//
//  ParetoChartsViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 21/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "ParetoChartsViewController.h"
#import "PNChart.h"
#import "CincoWDosHViewController.h"
#import "RoketFetcher.h"
#import "CustomAlertViewController.h"

@interface ParetoChartsViewController ()

@end

@implementation ParetoChartsViewController
@synthesize lblLimite1,lblLimite10,lblLimite2,lblLimite3,lblLimite4,lblLimite5,lblLimite6,lblLimite7,lblLimite8,lblLimite9,lblLimite0;
@synthesize lblNombre1,lblNombre2,lblNombre3,lblNombre4,lblNombre5;

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
    
    self.lblFechaInicio.text = NSLocalizedString(@"Date Start", nil);
    self.lblFechaFin.text = NSLocalizedString(@"Date Finish", nil);
    [self.btnBack setTitle:NSLocalizedString(@"btnBack", nil)];
    [self.btnSiguiente setTitle:NSLocalizedString(@"btnSiguiente", nil) forState:UIControlStateNormal];
    [self.lblTitleView setText:NSLocalizedString(@"Grafica Pareto", nil)];
    self.causesArray = [self.dicPareto objectForKey:@"causesArray"];
    NSLog(@"Datos Pareto: %@",self.dicPareto);
    
    if([self.causesArray count] == 5){
        [self drawGrafic];
        self.viewGrafic.hidden = NO;
    }else{
        self.viewGrafic.hidden = YES;
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Error al Graficar, usted no tiene 5 Paretos.",nil);
        [self presentViewController:vc animated:YES completion:nil];
        
    }

    if([self.dicPareto objectForKey:@"dateStart"]){
        if([[self.dicPareto objectForKey:@"FrecuenciaMedidaValue"]doubleValue] > 0)
            self.txtFechaInicio.text = [[self.dicPareto objectForKey:@"dateStart"] substringToIndex:10];
        else
            self.txtFechaInicio.text = [self.dicPareto objectForKey:@"dateStart"];
    }
    if([self.dicPareto objectForKey:@"dateFinish"]){
        if([[self.dicPareto objectForKey:@"FrecuenciaMedidaValue"]doubleValue] > 0)
            self.txtFechaFin.text = [[self.dicPareto objectForKey:@"dateFinish"] substringToIndex:10];
        else
            self.txtFechaFin.text = [self.dicPareto objectForKey:@"dateFinish"];
    }
    
    /*if([self.dicPareto objectForKey:@"TypeUsser"]){
        if([[self.dicPareto objectForKey:@"TypeUsser"]boolValue]){
            self.btnSavePareto.hidden = YES;
            self.btnSiguiente.hidden = NO;
        }else{
            self.btnSavePareto.hidden = NO;
            self.btnSiguiente.hidden = YES;
        }
    }else{
        self.btnSavePareto.hidden = YES;
        self.btnSiguiente.hidden = NO;
    }*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Charts

-(void)drawCharts {
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 0, 515, 324)];
    [barChart setXLabels:@[@"1", @"2", @"3", @"4", @"5"]];
    [barChart setYValues:@[@1, @9, @2, @5, @3]];
    [barChart setStrokeColor:[UIColor colorWithRed:(244.0/255.0) green:(124.0/255.0) blue:(70.0/255.0) alpha:1.0]];
    [barChart strokeChart];
    [self.chart addSubview:barChart];
    
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 0, 515, 324)];
    lineChart.backgroundColor = [UIColor clearColor];
    [lineChart setXLabels:@[@"1", @"2", @"3", @"4", @"5", @"6", @"7"]];
    
    // Line Chart Nr.1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2, @127.2, @176.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = [UIColor colorWithRed:(244.0/255.0) green:(124.0/255.0) blue:(70.0/255.0) alpha:1.0];
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [[data01Array objectAtIndex:index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // Line Chart Nr.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2, @167.2, @276.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = [UIColor colorWithRed:(244.0/255.0) green:(124.0/255.0) blue:(70.0/255.0) alpha:1.0];
    data02.itemCount = lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [[data02Array objectAtIndex:index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    lineChart.chartData = @[data01, data02];
    [lineChart strokeChart];
    
    [self.chartLine addSubview:lineChart];
}

#pragma mark - Hardcode

- (void)hardcode {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    UIImage *image;
    
    if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Servicios"]) {
        image = [UIImage imageNamed:@"chart1.png"];
        [image drawInRect:CGRectMake(0, 0, 651, 399)];
        [self.imageChart setImage:image];
    }
    else if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Manufactura"]) {
        image = [UIImage imageNamed:@"chart2.png"];
        [image drawInRect:CGRectMake(0, 0, 651, 399)];
        [self.imageChart setImage:image];
    }
}

#pragma mark - IBAction

/*- (IBAction)btnSavePareto:(id)sender {
    NSLog(@"%@",self.dicPareto);
    if([[self.dicPareto objectForKey:@"EstatusGuardado"] isEqualToString:@"0"]){
        RoketFetcher *roket = [[RoketFetcher alloc]init];
        int id_problema = [roket savePareto:self.dicPareto];
    
        if(id_problema > 0)
            [roket setEstatusTrue:[[self.dicPareto objectForKey:@"id_JSON"]integerValue]];
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Se guardo con exito, podra ver el flujo desde la seccion historico.",nil);
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Este flujo ya se encuentra guardado, si desea ver el flujo vaya ala seccion de historico.",nil);
        [self presentViewController:vc animated:YES completion:nil];
    }

    
}*/

- (IBAction)nextStep:(id)sender {
    CincoWDosHViewController *cwdhvc = [self.storyboard instantiateViewControllerWithIdentifier:@"5w2hView"];
    if([self.dicPareto objectForKey:@"dicIshikawa"]){
        cwdhvc.dicIshikawa = [self.dicPareto objectForKey:@"dicIshikawa"];
        //[self.dicPareto removeObjectForKey:@"dicIshikawa"];
    }

    cwdhvc.dicPareto = self.dicPareto;
    if(!self.historico)
        [RoketFetcher createJson:self.dicPareto :Nil :@"5w2hView"];
    
    cwdhvc.historico = self.historico;
    [self presentViewController:cwdhvc animated:YES completion:nil];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIStyle

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)drawGrafic{
    

    NSMutableDictionary *myDicTem1 = [self.causesArray objectAtIndex:0];
    NSMutableDictionary *myDicTem2 = [self.causesArray objectAtIndex:1];
    NSMutableDictionary *myDicTem3 = [self.causesArray objectAtIndex:2];
    NSMutableDictionary *myDicTem4 = [self.causesArray objectAtIndex:3];
    NSMutableDictionary *myDicTem5 = [self.causesArray objectAtIndex:4];

    lblNombre1.text = [myDicTem1 objectForKey:@"name"];
    lblNombre2.text = [myDicTem2 objectForKey:@"name"];
    lblNombre3.text = [myDicTem3 objectForKey:@"name"];
    lblNombre4.text = [myDicTem4 objectForKey:@"name"];
    lblNombre5.text = [myDicTem5 objectForKey:@"name"];
    
    
    //Porcentajes
    double num1 = [[myDicTem1 objectForKey:@"accumulatedPercentage"] doubleValue];
    double num2 = [[myDicTem2 objectForKey:@"accumulatedPercentage"] doubleValue];
    double num3 = [[myDicTem3 objectForKey:@"accumulatedPercentage"] doubleValue];
    double num4 = [[myDicTem4 objectForKey:@"accumulatedPercentage"] doubleValue];
    double num5 = [[myDicTem5 objectForKey:@"accumulatedPercentage"] doubleValue];
    
    NSArray *yArray = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0],
                       [NSNumber numberWithDouble:num1],
                       [NSNumber numberWithDouble:num2],
                       [NSNumber numberWithDouble:num3],
                       [NSNumber numberWithDouble:num4],
                       [NSNumber numberWithDouble:num5],
                       nil];
    
    //Frecuencia
    double FrecuenciaNum1 = [[myDicTem1 objectForKey:@"frecuency"] doubleValue];
    double FrecuenciaNum2 = [[myDicTem2 objectForKey:@"frecuency"] doubleValue];
    double FrecuenciaNum3 = [[myDicTem3 objectForKey:@"frecuency"] doubleValue];
    double FrecuenciaNum4 = [[myDicTem4 objectForKey:@"frecuency"] doubleValue];
    double FrecuenciaNum5 = [[myDicTem5 objectForKey:@"frecuency"] doubleValue];
    
    double Frecuenciamax = FrecuenciaNum1 + FrecuenciaNum2 + FrecuenciaNum3 + FrecuenciaNum4 + FrecuenciaNum5;
    
    if(Frecuenciamax == 0){
        Frecuenciamax = 1;
    }
    
    NSArray *arrayFrecuencia = [NSArray arrayWithObjects:[NSNumber numberWithDouble:0],
                                [NSNumber numberWithDouble:FrecuenciaNum1],
                                [NSNumber numberWithDouble:FrecuenciaNum2],
                                [NSNumber numberWithDouble:FrecuenciaNum3],
                                [NSNumber numberWithDouble:FrecuenciaNum4],
                                [NSNumber numberWithDouble:FrecuenciaNum5],
                                nil];
    
    
    //DIBUJADO DE LINEAS
    UIGraphicsBeginImageContext(CGSizeMake(500, 500));
    CGContextRef contexto3 = UIGraphicsGetCurrentContext();
    
    UIBezierPath *ejeslinea = [UIBezierPath bezierPath];
    [ejeslinea setLineWidth:2.0];
    
    [ejeslinea moveToPoint:CGPointMake(0, 0)];
    [ejeslinea addLineToPoint:CGPointMake(0, 0)];
    //int i = 24;
    for(int i =0; i <= 500; i = i+50){
        [ejeslinea addLineToPoint:CGPointMake(0, i)];
        [ejeslinea addLineToPoint:CGPointMake(500, i)];
        [ejeslinea addLineToPoint:CGPointMake(0, i)];
    }
    CGContextSetStrokeColorWithColor(contexto3, [UIColor lightGrayColor].CGColor);
    [ejeslinea stroke];
    
    UIImage *LineasImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    
    //DIBUJADO DE EJES
    UIGraphicsBeginImageContext(CGSizeMake(500, 250));
    CGContextRef contexto = UIGraphicsGetCurrentContext();
    
    UIBezierPath *ejes = [UIBezierPath bezierPath];
    [ejes setLineWidth:2.0];
    
    [ejes moveToPoint:CGPointMake(0, 0)];
    [ejes addLineToPoint:CGPointMake(0, 250)];
    [ejes addLineToPoint:CGPointMake(500, 250)];
    [ejes addLineToPoint:CGPointMake(500, 0)];
    
    CGContextSetStrokeColorWithColor(contexto, [UIColor blackColor].CGColor);
    [ejes stroke];
    int pasoLetras = 30;
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:17.0];
    for (int i=1; i< [arrayFrecuencia count]; i++) {
        
        
         NSString *string = [NSString stringWithFormat:@"%@",[arrayFrecuencia objectAtIndex:i]];
        int yi = [[arrayFrecuencia objectAtIndex:i] doubleValue];
        double porciento = yi * 100/Frecuenciamax;
        
        yi = 250* (porciento /100);

        if(yi<20){
            yi+=20;
        }
        
        CGRect textBounds = CGRectMake(pasoLetras, 250-yi, 300 , 60);
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,[NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
        
        [string drawInRect:textBounds withAttributes:attrsDictionary];
        pasoLetras += 100;
    }
    pasoLetras = 50;
    
    for (int i=1; i<[yArray count]; i++) {
        
        double yi = [[yArray objectAtIndex:i] doubleValue];
        yi = (250 * (yi /100));
        
        NSString *string = [NSString stringWithFormat:@"%d%%",[[yArray objectAtIndex:i] intValue]];
        CGRect textBounds;
        if([[yArray objectAtIndex:i] intValue] > 90)
             textBounds = CGRectMake(pasoLetras, 250-yi, 300 , 60);
        else
             textBounds = CGRectMake(pasoLetras, 250-yi-20, 300 , 60);
        
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,[NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
        
        [string drawInRect:textBounds withAttributes:attrsDictionary];
        pasoLetras += 100;

    
    }
    
    
    
    UIImage *ejesImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    //Dibujando curvas
    
    
    UIGraphicsBeginImageContext(CGSizeMake(500, 250));
    CGContextRef contextoCurvas = UIGraphicsGetCurrentContext();
    
    UIBezierPath *ejesCurvas = [UIBezierPath bezierPath];
    [ejesCurvas setLineWidth:5.0];
    
    //se crean los puntos dentro del ciclo donde se hace la grafica
    /*[ejesCurvas moveToPoint:CGPointMake(40, 160)];
     [ejesCurvas addLineToPoint:CGPointMake(40, 162)];
     [ejesCurvas addLineToPoint:CGPointMake(40, 160)];
     [ejesCurvas addLineToPoint:CGPointMake(42, 160)];
     [ejesCurvas addLineToPoint:CGPointMake(40, 160)];
     [ejesCurvas addLineToPoint:CGPointMake(38, 160)];
     [ejesCurvas addLineToPoint:CGPointMake(40, 160)];
     [ejesCurvas addLineToPoint:CGPointMake(40, 158)];
     [ejesCurvas addLineToPoint:CGPointMake(40, 160)];*/
    
    
    //se pego al final para agregar arriba de la grafica
    /*
     CGContextSetStrokeColorWithColor(contextoCurvas, [UIColor blackColor].CGColor);
     [ejesCurvas stroke];
     
     UIImage *CurvasImage = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     
     UIImageView *CurvasImageView = [[UIImageView alloc]initWithImage:CurvasImage];
     [CurvasImageView setFrame:CGRectMake(40, 120, 700, 400)];
     [self.view addSubview:CurvasImageView];
     */
    
    
    //DIBUJADO DE GRÁFICA
    int paso = 50;
    UIGraphicsBeginImageContext(CGSizeMake(500, 250));
    CGContextRef contexto2 = UIGraphicsGetCurrentContext();
    
    UIBezierPath *grafica = [UIBezierPath bezierPath];
    [grafica setLineWidth:1.0];
    
    double yInicio = [[yArray objectAtIndex:1] doubleValue];
    yInicio = (250 * (yInicio /100));
    
    double aumento = yInicio /25;
    double yInicioPuntos = aumento;
    [grafica moveToPoint:CGPointMake(0, 250)];
    
    for(int i = 2; i < 50; i+=2){

        [grafica addLineToPoint:CGPointMake(i, 250-yInicioPuntos)];
     
        //[grafica moveToPoint:CGPointMake(i, 250-yInicioPuntos-(aumento/2))];
        [grafica moveToPoint:CGPointMake(i+1, 250-yInicioPuntos-(aumento/2))];
           yInicioPuntos += aumento;
    }
    
    for (int i=1; i<[yArray count]; i++) {
        
        double yi = [[yArray objectAtIndex:i] doubleValue];
        yi = (250 * (yi /100));
        
        [grafica addLineToPoint:CGPointMake(paso, 250-yi)];
        
        //puntos
        [ejesCurvas moveToPoint:CGPointMake(paso, 250-yi)];
        
        [ejesCurvas addLineToPoint:CGPointMake(paso, 250-yi + 2)];
        [ejesCurvas addLineToPoint:CGPointMake(paso, 250-yi)];
        
        [ejesCurvas addLineToPoint:CGPointMake(paso +2, 250-yi)];
        [ejesCurvas addLineToPoint:CGPointMake(paso, 250-yi)];
        
        [ejesCurvas addLineToPoint:CGPointMake(paso -2, 250-yi)];
        [ejesCurvas addLineToPoint:CGPointMake(paso, 250-yi)];
        
        [ejesCurvas addLineToPoint:CGPointMake(paso, 250-yi -2)];
        [ejesCurvas addLineToPoint:CGPointMake(paso, 250-yi)];
        paso += 100;
        
    }
    
    CGContextSetStrokeColorWithColor(contexto2, [UIColor blackColor].CGColor);
    [grafica stroke];
    CGContextSetFillColorWithColor(contexto2, [UIColor colorWithRed:1 green:0 blue:0 alpha:0.25].CGColor);
    //[grafica fill];
    UIImage *graficaImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //agregando los puntos
    CGContextSetStrokeColorWithColor(contextoCurvas, [UIColor blackColor].CGColor);
    [ejesCurvas stroke];
    
    UIImage *CurvasImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //terminan los puntos
    
    
    //DIBUJADO DE GRÁFICA
    
    double constante = (double)Frecuenciamax/10;
    double constanteSum = constante;
    
    lblLimite0.text = @"0.00";
    lblLimite1.text = [NSString stringWithFormat:@"%0.2f",constanteSum];
    lblLimite2.text = [NSString stringWithFormat:@"%0.2f",constanteSum += constante];
    lblLimite3.text = [NSString stringWithFormat:@"%0.2f",constanteSum += constante];
    lblLimite4.text = [NSString stringWithFormat:@"%0.2f",constanteSum += constante];
    lblLimite5.text = [NSString stringWithFormat:@"%0.2f",constanteSum += constante];
    lblLimite6.text = [NSString stringWithFormat:@"%0.2f",constanteSum += constante];
    lblLimite7.text = [NSString stringWithFormat:@"%0.2f",constanteSum += constante];
    lblLimite8.text = [NSString stringWithFormat:@"%0.2f",constanteSum += constante];
    lblLimite9.text = [NSString stringWithFormat:@"%0.2f",constanteSum += constante];
    lblLimite10.text = [NSString stringWithFormat:@"%0.2f",constanteSum += constante];
    

    
    int pasoFrecuencia = 50;
    
    UIGraphicsBeginImageContext(CGSizeMake(500, 250));
    CGContextRef contextoBarras = UIGraphicsGetCurrentContext();
    
    UIBezierPath *graficaBarras = [UIBezierPath bezierPath];
    [graficaBarras setLineWidth:1.0];
    UIImage *BarrasImageGreen;
    UIImage *BarrasImage;
    
    for (int i=1; i<[arrayFrecuencia count]; i++) {
        
        int yi = [[arrayFrecuencia objectAtIndex:i] intValue];
        //15000x100/58000
        double porciento = yi * 100/Frecuenciamax;
        //) /100;
        yi = 250* (porciento /100);
        
        [graficaBarras moveToPoint:CGPointMake(pasoFrecuencia, 250-yi)];
        //[graficaBarras addLineToPoint:CGPointMake(pasoFrecuencia, 500-yi)];
        [graficaBarras addLineToPoint:CGPointMake(pasoFrecuencia-20, 250-yi)];
        [graficaBarras addLineToPoint:CGPointMake(pasoFrecuencia-20, 250)];
        [graficaBarras addLineToPoint:CGPointMake(pasoFrecuencia+20, 250)];
        [graficaBarras addLineToPoint:CGPointMake(pasoFrecuencia+20, 250-yi)];
        [graficaBarras addLineToPoint:CGPointMake(pasoFrecuencia, 250-yi)];
        
        pasoFrecuencia += 100;
        
        if(i==1){
            CGContextSetFillColorWithColor(contextoBarras, [UIColor colorWithRed:62/255.0f green:151/255.0f blue:54/255.0f alpha:1.0f].CGColor);
            [graficaBarras stroke];
            
            [graficaBarras fill];
            BarrasImageGreen = UIGraphicsGetImageFromCurrentImageContext();
        }else if(i==5){
            CGContextSetStrokeColorWithColor(contextoBarras, [UIColor blackColor].CGColor);
            [graficaBarras stroke];
            //[UIColor colorWithRed:62/255.0f green:151/255.0f blue:54/255.0f alpha:1.0f];
            CGContextSetFillColorWithColor(contextoBarras, [UIColor whiteColor].CGColor);
            [graficaBarras fill];
            BarrasImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        
        
        /*if(i==1 && [[arrayFrecuencia objectAtIndex:1]integerValue] > [[arrayFrecuencia objectAtIndex:5]integerValue]){
            CGContextSetFillColorWithColor(contextoBarras, [UIColor colorWithRed:62/255.0f green:151/255.0f blue:54/255.0f alpha:1.0f].CGColor);
            [graficaBarras stroke];
            
            [graficaBarras fill];
            BarrasImageGreen = UIGraphicsGetImageFromCurrentImageContext();
        } else if(i == 4 && [[arrayFrecuencia objectAtIndex:1]integerValue] < [[arrayFrecuencia objectAtIndex:5]integerValue]){
            CGContextSetStrokeColorWithColor(contextoBarras, [UIColor blackColor].CGColor);
            [graficaBarras stroke];
            //[UIColor colorWithRed:62/255.0f green:151/255.0f blue:54/255.0f alpha:1.0f];
            CGContextSetFillColorWithColor(contextoBarras, [UIColor whiteColor].CGColor);
            [graficaBarras fill];
            BarrasImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();

            //iniciando un nuevo context
            UIGraphicsBeginImageContext(CGSizeMake(500, 250));
            contextoBarras = UIGraphicsGetCurrentContext();
            
            graficaBarras = [UIBezierPath bezierPath];
            [graficaBarras setLineWidth:1.0];
            
        }else if(i ==5 && [[arrayFrecuencia objectAtIndex:1]integerValue] > [[arrayFrecuencia objectAtIndex:5]integerValue]){
            CGContextSetStrokeColorWithColor(contextoBarras, [UIColor blackColor].CGColor);
            [graficaBarras stroke];
            //[UIColor colorWithRed:62/255.0f green:151/255.0f blue:54/255.0f alpha:1.0f];
            CGContextSetFillColorWithColor(contextoBarras, [UIColor whiteColor].CGColor);
            [graficaBarras fill];
            BarrasImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }else if(i==5 && [[arrayFrecuencia objectAtIndex:1]integerValue] < [[arrayFrecuencia objectAtIndex:5]integerValue]){
            CGContextSetFillColorWithColor(contextoBarras, [UIColor whiteColor].CGColor);
            //CGContextSetFillColorWithColor(contextoBarras, [UIColor colorWithRed:62/255.0f green:151/255.0f blue:54/255.0f alpha:1.0f].CGColor);
            [graficaBarras stroke];
            
            [graficaBarras fill];
            BarrasImageGreen = UIGraphicsGetImageFromCurrentImageContext();
        }*/
    }

   
    //Pintando imagenes
    int x = 110;
    int y = 10;
    int width = 500;
    int height = 250;
    //lienas atras
    UIImageView *LienasImageView = [[UIImageView alloc]initWithImage:LineasImage];
    [LienasImageView setFrame:CGRectMake(x, y, width, height)];
    [self.viewGrafic addSubview:LienasImageView];
    
    //pintnado grafica de barras
    UIImageView *BarrasImageView = [[UIImageView alloc]initWithImage:BarrasImage];
    [BarrasImageView setFrame:CGRectMake(x, y, width , height)];
    [self.viewGrafic addSubview:BarrasImageView];
    
    UIImageView *BarrasGreenImageView = [[UIImageView alloc]initWithImage:BarrasImageGreen];
    [BarrasGreenImageView setFrame:CGRectMake(x, y, width , height)];
    [self.viewGrafic addSubview:BarrasGreenImageView];
    
    //grafica Lienas
    UIImageView *graficaImageView = [[UIImageView alloc]initWithImage:graficaImage];
    [graficaImageView setFrame:CGRectMake(x, y, width , height)];
    [self.viewGrafic addSubview:graficaImageView];
    
    //pintando puntos
    UIImageView *CurvasImageView = [[UIImageView alloc]initWithImage:CurvasImage];
    [CurvasImageView setFrame:CGRectMake(x, y, width, height)];
    [self.viewGrafic addSubview:CurvasImageView];
    
    //lados
    UIImageView *ejesImageView = [[UIImageView alloc]initWithImage:ejesImage];
    [ejesImageView setFrame:CGRectMake(x, y, width, height)];
    [self.viewGrafic addSubview:ejesImageView];

}


@end
