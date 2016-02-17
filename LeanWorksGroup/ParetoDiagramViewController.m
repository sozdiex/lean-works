//
//  ParetoDiagramViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 17/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "ParetoDiagramViewController.h"
#import "ParetoCell.h"
#import "CauseDetailViewController.h"
#import "ParetoChartsViewController.h"
#import "RoketFetcher.h"
#import "CustomAlertViewController.h"

@interface ParetoDiagramViewController (){
    int rowSelected;
}



@end

@implementation ParetoDiagramViewController

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
    self.mainProblem = [self.dicPareto objectForKey:@"mainProblem"];
    NSLog(@"%@",self.dicPareto);
    self.causesArray = [[NSMutableArray alloc] init];
    [self hardcode];
    
    self.addCause.layer.borderWidth = 1.0f;
    self.addCause.layer.cornerRadius = 7.0f;
    self.addCause.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
    
    self.btnNext.layer.borderWidth = 1.0f;
    self.btnNext.layer.cornerRadius = 7.0f;
    self.btnNext.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertAccepted) name:@"alertAccepted" object:nil];
   /* NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"frecuency" ascending:NO];
    [self.causesArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];*/
    
    if(self.historico){
        self.addCause.enabled = NO;
        self.textCause.enabled = NO;
    }else{
        self.addCause.enabled = YES;
        self.textCause.enabled = YES;
    }
    
  }

- (void)viewDidAppear:(BOOL)animated {

   /* NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"frecuency" ascending:NO];
    [self.causesArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];*/
    NSMutableDictionary *dicOtro = [self.causesArray lastObject];
    [self.causesArray removeLastObject];
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"frecuency" ascending:NO];
    [self.causesArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    [self.causesArray addObject:dicOtro];
    
    [self.tableCause reloadData];
    self.textCause.text = @"";
    [self.textCause resignFirstResponder];

    [self.tableCause deselectRowAtIndexPath:[self.tableCause indexPathForSelectedRow] animated:YES];
    [self.tableCause reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Hardcode

- (void)hardcode {
    NSString *title = [[NSString alloc] initWithFormat:NSLocalizedString(@"lblDiagram",nil), self.mainProblem];
    self.labelTitle.text = title;
    [self.btnNext setTitle:NSLocalizedString(@"Grafica Pareto", nil) forState:UIControlStateNormal];
    [self.btnBack setTitle:NSLocalizedString(@"btnBack", nil)];
    [self.addCause setTitle:NSLocalizedString(@"Agregar", nil) forState:UIControlStateNormal];
    self.textCause.placeholder = NSLocalizedString(@"txtDiagram1", nil);
    self.labelSubTitle.text = NSLocalizedString(@"lblDiagram2", nil);
    
    if([self.dicPareto objectForKey:@"causesArray"])
        self.causesArray = [self.dicPareto objectForKey:@"causesArray"];
    else
    {
        NSMutableDictionary *factor = [[NSMutableDictionary alloc] init];
        factor = [[NSMutableDictionary alloc] init];
        [factor setValue:NSLocalizedString(@"Otros", nil) forKey:@"name"];
        [factor setValue:@"0" forKey:@"frecuency"];
        [factor setValue:@"0" forKey:@"accumulated"];
        [factor setValue:@"0" forKey:@"percentage"];
        [factor setValue:@"0" forKey:@"accumulatedPercentage"];
        [self.causesArray addObject:factor];
        
    }
    /*
     
     NSMutableDictionary *factor = [[NSMutableDictionary alloc] init];
     
     NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Servicios"]) {
        [factor setValue:@"Ventas bajas" forKey:@"name"];
        [factor setValue:@"100000" forKey:@"frecuency"];
        [factor setValue:@"100000" forKey:@"accumulated"];
        [factor setValue:@"35.7" forKey:@"percentage"];
        [factor setValue:@"35.7" forKey:@"accumulatedPercentage"];
        [self.causesArray addObject:factor];
        
        factor = [[NSMutableDictionary alloc] init];
        [factor setValue:@"Nomina alta" forKey:@"name"];
        [factor setValue:@"70000" forKey:@"frecuency"];
        [factor setValue:@"170000" forKey:@"accumulated"];
        [factor setValue:@"25" forKey:@"percentage"];
        [factor setValue:@"60.7" forKey:@"accumulatedPercentage"];
        [self.causesArray addObject:factor];

        factor = [[NSMutableDictionary alloc] init];
        [factor setValue:@"Cartera vencida" forKey:@"name"];
        [factor setValue:@"55000" forKey:@"frecuency"];
        [factor setValue:@"225000" forKey:@"accumulated"];
        [factor setValue:@"19.6" forKey:@"percentage"];
        [factor setValue:@"80.3" forKey:@"accumulatedPercentage"];
        [self.causesArray addObject:factor];
        
        
        factor = [[NSMutableDictionary alloc] init];
        [factor setValue:@"Renta" forKey:@"name"];
        [factor setValue:@"40000" forKey:@"frecuency"];
        [factor setValue:@"265000" forKey:@"accumulated"];
        [factor setValue:@"14.28" forKey:@"percentage"];
        [factor setValue:@"94.6" forKey:@"accumulatedPercentage"];
        [self.causesArray addObject:factor];
        
        factor = [[NSMutableDictionary alloc] init];
        [factor setValue:@"Otros" forKey:@"name"];
        [factor setValue:@"15000" forKey:@"frecuency"];
        [factor setValue:@"280000" forKey:@"accumulated"];
        [factor setValue:@"5.4" forKey:@"percentage"];
        [factor setValue:@"100" forKey:@"accumulatedPercentage"];
        [self.causesArray addObject:factor];
        
    }
    else if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Manufactura"]) {
        [factor setValue:@"Pintura" forKey:@"name"];
        [factor setValue:@"58" forKey:@"frecuency"];
        [factor setValue:@"58" forKey:@"accumulated"];
        [factor setValue:@"34.3" forKey:@"percentage"];
        [factor setValue:@"34.3" forKey:@"accumulatedPercentage"];
        [self.causesArray addObject:factor];
        
        factor = [[NSMutableDictionary alloc] init];
        [factor setValue:@"Rayones" forKey:@"name"];
        [factor setValue:@"40" forKey:@"frecuency"];
        [factor setValue:@"98" forKey:@"accumulated"];
        [factor setValue:@"23.7" forKey:@"percentage"];
        [factor setValue:@"58.0" forKey:@"accumulatedPercentage"];
        [self.causesArray addObject:factor];
        
        factor = [[NSMutableDictionary alloc] init];
        [factor setValue:@"Otros" forKey:@"name"];
        [factor setValue:@"36" forKey:@"frecuency"];
        [factor setValue:@"134" forKey:@"accumulated"];
        [factor setValue:@"21.3" forKey:@"percentage"];
        [factor setValue:@"79.0" forKey:@"accumulatedPercentage"];
        [self.causesArray addObject:factor];
        
        factor = [[NSMutableDictionary alloc] init];
        [factor setValue:@"Despegado" forKey:@"name"];
        [factor setValue:@"20" forKey:@"frecuency"];
        [factor setValue:@"154" forKey:@"accumulated"];
        [factor setValue:@"11.8" forKey:@"percentage"];
        [factor setValue:@"91.0" forKey:@"accumulatedPercentage"];
        [self.causesArray addObject:factor];
        
        factor = [[NSMutableDictionary alloc] init];
        [factor setValue:@"Golpes" forKey:@"name"];
        [factor setValue:@"15" forKey:@"frecuency"];
        [factor setValue:@"169" forKey:@"accumulated"];
        [factor setValue:@"8.9" forKey:@"percentage"];
        [factor setValue:@"100" forKey:@"accumulatedPercentage"];
        [self.causesArray addObject:factor];
        
    }
    else
    {
        factor = [[NSMutableDictionary alloc] init];
        [factor setValue:@"Otros" forKey:@"name"];
        [factor setValue:@"0" forKey:@"frecuency"];
        [factor setValue:@"0" forKey:@"accumulated"];
        [factor setValue:@"0" forKey:@"percentage"];
        [factor setValue:@"0" forKey:@"accumulatedPercentage"];
        [self.causesArray addObject:factor];

    }*/
   /* NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"frecuency" ascending:NO];
    [self.causesArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];*/
}

#pragma mark - IBAction

- (IBAction)showMenu:(id)sender {
    self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InitView"];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextStep:(id)sender {
    if(self.causesArray.count < 5){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Es necesario agregar 5 factores",nil);
        [self presentViewController:vc animated:YES completion:nil];
    }
    else
    {
        
        for (int i = 0; i <self.causesArray.count-1; i++)
        {
            NSDictionary *currentelement = [self.causesArray objectAtIndex:i];
            double frecuencia =[[currentelement objectForKey:@"frecuency"] doubleValue];
            if(frecuencia<=0)
            {
               
                CustomAlertViewController* vc = [CustomAlertViewController new];
                vc.text = NSLocalizedString(@"Es necesario agregar un valor mayor a 0 (cero) en la frecuencia",nil);
                [self presentViewController:vc animated:YES completion:nil];
                return;
            }
            
        }
        
        ParetoChartsViewController *pcvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ParetoChartsView"];
        [self.dicPareto setObject:self.causesArray forKey:@"causesArray"];
        pcvc.dicPareto = self.dicPareto;
        if(!self.historico)
            [RoketFetcher createJson:self.dicPareto :Nil :@"ParetoChartsView"];

        pcvc.historico = self.historico;
        [self presentViewController:pcvc animated:YES completion:nil];
    }
    

}

- (IBAction)addCause:(id)sender {
    if (self.textCause.text.length == 0) {
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Es necesario agregar un factor",nil);
        [self presentViewController:vc animated:YES completion:nil];
    }
    else
    {
        if(self.causesArray.count < 5)
        {
            NSMutableDictionary *newCause = [[NSMutableDictionary alloc] init];
            [newCause setObject:self.textCause.text forKey:@"name"];
            [newCause setObject:[NSNumber numberWithDouble:0] forKey:@"frecuency"];
            [newCause setObject:@"0" forKey:@"percentage"];
            [newCause setObject:@"0" forKey:@"accumulated"];
            [newCause setObject:@"0" forKey:@"accumulatedPercentage"];
            [self.causesArray insertObject:newCause atIndex:0];
            
            
            NSMutableDictionary *dicOtro = [self.causesArray lastObject];
            [self.causesArray removeLastObject];
            NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"frecuency" ascending:NO];
            [self.causesArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
            [self.causesArray addObject:dicOtro];
            
            [self.tableCause reloadData];
            self.textCause.text = @"";
            [self.textCause resignFirstResponder];
            
        }
        else
        {
            CustomAlertViewController* vc = [CustomAlertViewController new];
            
            vc.text = NSLocalizedString(@"Solo se permiten agregar 5 factores como máximo",nil);
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.causesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ParetoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ParetoCell" forIndexPath:indexPath];
    NSDictionary *data = [self.causesArray objectAtIndex:indexPath.row];
    cell.className.text = [data objectForKey:@"name"];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
 
    double frecuencia =0;
    double porcentaje = 0;
    double acumulado = 0;
    
    for (int i = 0; i < indexPath.row+1; i++)
    {
        NSDictionary *currentelement = [self.causesArray objectAtIndex:i];
        frecuencia+=[[currentelement objectForKey:@"frecuency"] doubleValue];
       
    }
    
    double frecuenciaTotal =0;
    for (int i = 0; i < self.causesArray.count; i++)
    {
        NSDictionary *currentelement = [self.causesArray objectAtIndex:i];
        frecuenciaTotal+=[[currentelement objectForKey:@"frecuency"] doubleValue];
    }
    if(frecuenciaTotal == 0)
    {
        porcentaje=0;
        acumulado=0;
    }
    else
    {
        porcentaje = ([[data objectForKey:@"frecuency"] doubleValue]/frecuenciaTotal)*100;
        acumulado = (frecuencia/frecuenciaTotal)*100;
    }
    
    
    if ([[ud objectForKey:@"unidadMedida"] isEqualToString:@"Pesos"]) {
        cell.frecuency.text= [[NSString alloc] initWithFormat:@"$%@", [data objectForKey:@"frecuency"]];
           
        /*cell.frecuency.text = [[NSString alloc] initWithFormat:@"$%@", [data objectForKey:@"frecuency"]];*/
      
        cell.accumulated.text = [[NSString alloc] initWithFormat:@"$%@",[NSString stringWithFormat:@"%.2f", frecuencia ]];
       
        double value= [[data objectForKey:@"frecuency"]doubleValue];
        if( value <= 0)
        {
            cell.frecuency.textColor = [UIColor redColor];
        }
        else
        {
            cell.frecuency.textColor = [UIColor blackColor];
        }
    }
    else {
        cell.frecuency.text = [[NSString alloc] initWithFormat:@"%@", [data objectForKey:@"frecuency"]];
        cell.accumulated.text = [[NSString alloc] initWithFormat:@"%@", [NSString stringWithFormat:@"%.2f", frecuencia ]];
       
        double value= [[data objectForKey:@"frecuency"]doubleValue];
        if( value <= 0)
        {
            cell.frecuency.textColor = [UIColor redColor];
        }
        else
        {
            cell.frecuency.textColor = [UIColor blackColor];
        }
    }
    
    cell.percentage.text = [NSString stringWithFormat:@"%.2f", porcentaje ];
    cell.accumulatedPercentage.text =[NSString stringWithFormat:@"%.2f", acumulado ];
    
    cell.accumulated.textColor= [UIColor lightGrayColor];
    cell.percentage.textColor= [UIColor lightGrayColor];
    cell.accumulatedPercentage.textColor= [UIColor lightGrayColor];
    
    /* cell.accumulated.backgroundColor = [UIColor lightGrayColor];
    cell.percentage.backgroundColor = [UIColor lightGrayColor];
    cell.accumulatedPercentage.backgroundColor = [UIColor lightGrayColor];*/
    
    [data setValue:[NSString stringWithFormat:@"%.2f", frecuencia ] forKey:@"accumulated"];
    [data setValue:[NSString stringWithFormat:@"%.2f", porcentaje ] forKey:@"percentage"];
    [data setValue:[NSString stringWithFormat:@"%.2f", acumulado ] forKey:@"accumulatedPercentage"];
    
    if(self.historico){
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setUserInteractionEnabled:NO];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if(indexPath.row +1 == [self.causesArray count]){
            [self.tableCause deselectRowAtIndexPath:[self.tableCause indexPathForSelectedRow] animated:YES];
            [self.tableCause reloadData];
            return;
        }
        
        [self.causesArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    rowSelected = (int)indexPath.row;
    [self.tableCause deselectRowAtIndexPath:[self.tableCause indexPathForSelectedRow] animated:YES];
    
    CustomAlertViewController* vc = [CustomAlertViewController new];
    vc.text = NSLocalizedString(@"¿Desea editar el elemento?",nil);
    vc.alertQuestion = YES;
    [self presentViewController:vc animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@                                  %@           %@           %@           %@",NSLocalizedString(@"Factor", nil), NSLocalizedString(@"Frecuencia", nil),NSLocalizedString(@"Acumulado", nil),NSLocalizedString(@"Porcentaje", nil),NSLocalizedString(@"Acumulado", nil) ];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return NSLocalizedString(@"Eliminar",nil);
}

#pragma mark - AlertViewCustom
-(void)alertAccepted{
    NSLog(@"Dismissed SecondViewController");
    CauseDetailViewController *cdvc;
    cdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"CauseDetailView"];
    NSDictionary *data = [self.causesArray objectAtIndex:rowSelected];
    cdvc.delegate = self;
    cdvc.causeName = [data objectForKey:@"name"];
    cdvc.causesArray = self.causesArray;
    cdvc.index = rowSelected;
    [self presentViewController:cdvc animated:YES completion:nil];
}


#pragma mark - UIStyle

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end