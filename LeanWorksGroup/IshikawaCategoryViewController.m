//
//  IshikawaCategoryViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 08/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "IshikawaCategoryViewController.h"
#import "IshikawaStepTwoViewController.h"

@interface IshikawaCategoryViewController (){
    
    NSMutableDictionary *DicM;
    NSMutableArray *arrayMRes;
    NSMutableArray *arrayMResDet;
    int answerCurrent;
    bool fristBack;
}

@end

@implementation IshikawaCategoryViewController

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
    [self.btnBack setTitle:NSLocalizedString(@"btnBack", nil)];
    [self.btnBackStep setTitle:NSLocalizedString(@"btnRegresarPuntoOrigen", nil) forState:UIControlStateNormal];
    [self.btnNextStep setTitle:NSLocalizedString(@"btnProfundizar", nil) forState:UIControlStateNormal];
    [self.textOption setPlaceholder:NSLocalizedString(@"lblIshikawaRespuesta", nil)];
    
    NSLog(@"%@",self.dicIshikawa);
    fristBack = YES;
    // Do any additional setup after loading the view.
    if(self.nuevo){

    }else{
        answerCurrent = 0;
    }
    [self hardcode];
    
    self.btnNextStep.layer.borderWidth = 1.0f;
    self.btnNextStep.layer.cornerRadius = 7.0f;
    self.btnNextStep.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
    self.btnBackStep.layer.borderWidth = 1.0f;
    self.btnBackStep.layer.cornerRadius = 7.0f;
    self.btnBackStep.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
    
    if(self.historico){
        self.textOption.enabled = NO;
    }else{
        self.textOption.enabled = YES;
    }
    
}



- (void)hardcode {
    
    self.textOption.text = @"";
    //NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *question;
    /*if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Servicios"]) {
     question = @"¿Por qué en el departamento de ventas de la sucursal de Culiacán durante el último trimestre del año tiene ventas bajas equivalentes a $1,000,000.00?";
     self.textOption.text = @"Falta de capacitación";
     if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Medio Ambiente"]) {
     self.textOption.text = @"Subida del dolar";
     }
     }
     else if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Manufactura"]) {
     
     question = @"¿Por qué la línea de pintura en la planta de Puebla del turno nocturno tiene mala calidad equivalente a 169 piezas mensuales?";
     
     if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Colaboradores / Clientes / Personas"]) {
     
     self.textOption.text = @"Falta de capacitación";
     
     }
     
     else if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Máquinas / Equipos"]) {
     
     self.textOption.text = @"El espreado se ve diferente";
     
     }
     
     else if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Método de Trabajo"]) {
     
     self.textOption.text = @"Los tonos se ven diferente";
     
     }
     
     else if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Materiales"]) {
     
     self.textOption.text = @"Los pintura se desprende";
     
     }
     
     else if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Medición"]) {
     
     self.textOption.text = @"No tenemos indicadores de calidad";
     
     }
     
     else if ([[ud objectForKey:@"ishikawa"] isEqualToString:@"Medio Ambiente"]) {
     
     self.textOption.text = @"Subida del dolar";
     
     }
     
     }*/
    
    
    
    if(!arrayMResDet){
        arrayMResDet = [[NSMutableArray alloc]init];
    }
    
    if ([self.selectOption isEqualToString:NSLocalizedString(@"m1", nil)]) {
        if([self.dicIshikawa objectForKey:@"m1"]){
            DicM = [self.dicIshikawa objectForKey:@"m1"];
        }else{
            DicM = [[NSMutableDictionary alloc]init];
            [DicM setObject:[self.dicIshikawa objectForKey:@"question"] forKey:@"questionM"];
            arrayMRes = [[NSMutableArray alloc]init];
            [DicM setObject:arrayMRes forKey:@"arrayMRes"];
        }
    }
    else if ([self.selectOption isEqualToString:NSLocalizedString(@"m2", nil)]) {
        if([self.dicIshikawa objectForKey:@"m2"]){
            DicM =[self.dicIshikawa objectForKey:@"m2"];
        }else{
            DicM = [[NSMutableDictionary alloc]init];
            [DicM setObject:[self.dicIshikawa objectForKey:@"question"] forKey:@"questionM"];
            arrayMRes = [[NSMutableArray alloc]init];
            [DicM setObject:arrayMRes forKey:@"arrayMRes"];
        }
    }
    else if ([self.selectOption isEqualToString:NSLocalizedString(@"m3", nil)]) {
        if([self.dicIshikawa objectForKey:@"m3"]){
            DicM =[self.dicIshikawa objectForKey:@"m3"];
        }else{
            DicM = [[NSMutableDictionary alloc]init];
            [DicM setObject:[self.dicIshikawa objectForKey:@"question"] forKey:@"questionM"];
            arrayMRes = [[NSMutableArray alloc]init];
            [DicM setObject:arrayMRes forKey:@"arrayMRes"];
        }
    }
    else if ([self.selectOption isEqualToString:NSLocalizedString(@"m4", nil)]) {
        if([self.dicIshikawa objectForKey:@"m4"]){
            DicM =[self.dicIshikawa objectForKey:@"m4"];
        }else{
            DicM = [[NSMutableDictionary alloc]init];
            [DicM setObject:[self.dicIshikawa objectForKey:@"question"] forKey:@"questionM"];
            arrayMRes = [[NSMutableArray alloc]init];
            [DicM setObject:arrayMRes forKey:@"arrayMRes"];
        }
    }
    else if ([self.selectOption isEqualToString:NSLocalizedString(@"m5", nil)]) {
        if([self.dicIshikawa objectForKey:@"m5"]){
            DicM =[self.dicIshikawa objectForKey:@"m5"];
        }else{
            DicM = [[NSMutableDictionary alloc]init];
            [DicM setObject:[self.dicIshikawa objectForKey:@"question"] forKey:@"questionM"];
            arrayMRes = [[NSMutableArray alloc]init];
            [DicM setObject:arrayMRes forKey:@"arrayMRes"];
        }
    }
    else if ([self.selectOption isEqualToString:NSLocalizedString(@"m6", nil)]) {
        if([self.dicIshikawa objectForKey:@"m6"]){
            DicM =[self.dicIshikawa objectForKey:@"m6"];
        }else{
            DicM = [[NSMutableDictionary alloc]init];
            [DicM setObject:[self.dicIshikawa objectForKey:@"question"] forKey:@"questionM"];
            arrayMRes = [[NSMutableArray alloc]init];
            [DicM setObject:arrayMRes forKey:@"arrayMRes"];
        }
    }
    
    NSString *title;
    if(self.nuevo){
        question = [DicM objectForKey:@"questionM"];
        arrayMRes = [DicM objectForKey:@"arrayMRes"];
        
        if(!arrayMResDet){
            arrayMResDet = [[NSMutableArray alloc]init];
        }
        
        if([arrayMResDet count] == 0){
            question = [self.dicIshikawa objectForKey:@"question"];
            [DicM setObject:[self.dicIshikawa objectForKey:@"question"] forKey:@"questionM"];

        }
        
        title = [[NSString alloc] initWithFormat:NSLocalizedString(@"Desde la perspectiva %@ %@",nil), self.selectOption, question];
    }else{
        question = [DicM objectForKey:@"questionM"];
        arrayMRes = [DicM objectForKey:@"arrayMRes"];
        if([arrayMResDet count] == 0){
            question = [self.dicIshikawa objectForKey:@"question"];
            [DicM setObject:[self.dicIshikawa objectForKey:@"question"] forKey:@"questionM"];
        }
        if([arrayMResDet count] > 0){
        }else{
            arrayMResDet = [arrayMRes objectAtIndex:self.dicSelected];
        }
        if(answerCurrent < [arrayMResDet count]){
            self.textOption.text = [arrayMResDet objectAtIndex:answerCurrent];
        }
    
        title = [[NSString alloc] initWithFormat:NSLocalizedString(@"Desde la perspectiva %@ %@",nil), self.selectOption, question];
    }
    self.question.text = title;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - IBAction
- (IBAction)close:(id)sender {
    //  [self dismissViewControllerAnimated:YES completion:nil];
    if([arrayMResDet count] > 0){
        
        if(self.nuevo && fristBack){
            
            [arrayMRes addObject:arrayMResDet];
            
            if([arrayMRes count]>1){
                self.dicSelected = [arrayMRes count]-1;
            }else{
                self.dicSelected = 0;
            }
            
            answerCurrent = [arrayMResDet count];
            fristBack= NO;
        }
        self.nuevo = NO;
     
        if(answerCurrent > 0){
            answerCurrent -= 1;
        }
        
        NSLog(@"%d",answerCurrent);
        self.textOption.text = [arrayMResDet objectAtIndex:answerCurrent];
        
        NSString *question;
        
        NSString *questionOri = [NSString stringWithFormat:@"%@",[self.dicIshikawa objectForKey:@"question"]];
        
        questionOri = [questionOri stringByReplacingOccurrencesOfString:@"¿" withString:@""];
        questionOri = [questionOri stringByReplacingOccurrencesOfString:@"Por qué" withString:@""];
        questionOri = [questionOri stringByReplacingOccurrencesOfString:@"Why" withString:@""];
       
        switch (answerCurrent) {
            case 0:
                question = [NSString stringWithFormat:NSLocalizedString(@"¿Por qué %@",nil), questionOri];
                break;
            case 1:
                question = [NSString stringWithFormat:NSLocalizedString(@"¿Por qué %@ %@",nil),[arrayMResDet objectAtIndex:0], questionOri];
                break;
            case 2:
                question = [NSString stringWithFormat:NSLocalizedString(@"¿Por qué  %@ y %@ %@",nil),[arrayMResDet objectAtIndex:1],[arrayMResDet objectAtIndex:0], questionOri];
                break;
            case 3:
                question = [NSString stringWithFormat:NSLocalizedString(@"¿Por qué  %@, %@ y %@ %@",nil),[arrayMResDet objectAtIndex:2],[arrayMResDet objectAtIndex:1],[arrayMResDet objectAtIndex:0], questionOri];
                break;
            case 4:
                question = [NSString stringWithFormat:NSLocalizedString(@"¿Por qué  %@, %@, %@ y %@ %@",nil),[arrayMResDet objectAtIndex:3],[arrayMResDet objectAtIndex:2],[arrayMResDet objectAtIndex:1],[arrayMResDet objectAtIndex:0], questionOri];
                break;
        }
        [DicM setObject:question forKey:@"questionM"];
        self.question.text = question;
    }
}

- (IBAction)nextStep:(id)sender {
    /* IshikawaStepTwoViewController *istvc = [self.storyboard instantiateViewControllerWithIdentifier:@"IshikawaStepTwoView"];
     istvc.textOption = self.textOption.text;
     istvc.mainTitle = self.mainTitle;
     istvc.icvc = self;
     istvc.ivc = self.ivc;
     [self presentViewController:istvc animated:YES completion:nil];*/
    
    if(![self.textOption.text isEqualToString:@""]){
        NSString *question;
        if(self.nuevo){
            [arrayMResDet addObject:self.textOption.text];
        }else{
            if(answerCurrent < [arrayMResDet count]){
                [arrayMResDet removeObjectAtIndex:answerCurrent];
                [arrayMResDet insertObject:self.textOption.text atIndex:answerCurrent];
            }
            else{
                [arrayMResDet addObject:self.textOption.text];
            }
        }
        
        NSString *questionOri = [NSString stringWithFormat:@"%@",[DicM objectForKey:@"questionM"]];
        
        questionOri = [questionOri stringByReplacingOccurrencesOfString:@"¿" withString:@""];
        questionOri = [questionOri stringByReplacingOccurrencesOfString:@"Por qué" withString:@""];
        questionOri = [questionOri stringByReplacingOccurrencesOfString:@"Why" withString:@""];
        
        if(self.nuevo){
            switch ([arrayMResDet count]) {
                case 1:
                    question = [NSString stringWithFormat:NSLocalizedString(@"¿Por qué %@%@",nil) ,self.textOption.text, questionOri];
                    break;
                case 2:
                    question = [NSString stringWithFormat:NSLocalizedString(@"¿Por qué %@ y %@",nil) ,self.textOption.text, questionOri];
                    break;
                default:
                    question = [NSString stringWithFormat:NSLocalizedString(@"¿Por qué %@, %@",nil) ,self.textOption.text, questionOri];
                    break;
            }
        }else{
            switch (answerCurrent) {
                case 0:
                    question = [NSString stringWithFormat:NSLocalizedString(@"¿Por qué %@%@",nil) ,self.textOption.text, questionOri];
                    break;
                case 1:
                    question = [NSString stringWithFormat:NSLocalizedString(@"¿Por qué %@ y %@",nil) ,self.textOption.text, questionOri];
                    break;
                default:
                    question = [NSString stringWithFormat:NSLocalizedString(@"¿Por qué %@, %@",nil) ,self.textOption.text, questionOri];
                    break;
            }
        }
        
        //[DicM setObject:arrayMRes forKey:@"arrayMRes"];
        [DicM setObject:question forKey:@"questionM"];
        
        if ([self.selectOption isEqualToString:NSLocalizedString(@"m1", nil)]) {
            [self.dicIshikawa setObject:DicM forKey:@"m1"];
        }else if ([self.selectOption isEqualToString:NSLocalizedString(@"m2", nil)]) {
            [self.dicIshikawa setObject:DicM forKey:@"m2"];
        }else if ([self.selectOption isEqualToString:NSLocalizedString(@"m3", nil)]) {
            [self.dicIshikawa setObject:DicM forKey:@"m3"];
        }else if ([self.selectOption isEqualToString:NSLocalizedString(@"m4", nil)]) {
            [self.dicIshikawa setObject:DicM forKey:@"m4"];
        }else if ([self.selectOption isEqualToString:NSLocalizedString(@"m5", nil)]) {
            [self.dicIshikawa setObject:DicM forKey:@"m5"];
        }else if ([self.selectOption isEqualToString:NSLocalizedString(@"m6", nil)]) {
            [self.dicIshikawa setObject:DicM forKey:@"m6"];
        }
        
        ++answerCurrent;
        if([arrayMResDet count] == 5){
            if(self.nuevo){
                [self origin:Nil];
            }else{
                if(answerCurrent == 5){
                    [self origin:Nil];
                }else{
                    [self hardcode];
                }
            }
            
        }else{
            [self hardcode];
        }
    }
}

- (IBAction)origin:(id)sender {
    
    if(![self.textOption.text isEqualToString:@""] || [arrayMResDet count] > 0 ){
        
        NSString *question = [NSString stringWithFormat:@"%@ %@",self.textOption.text,[DicM objectForKey:@"questionM"]];
        if(![self.textOption.text isEqualToString:@""] && [arrayMResDet count] < 5){
            if(self.nuevo){
                [arrayMResDet addObject:self.textOption.text];
            }else{
                if(answerCurrent < [arrayMResDet count]){
                    [arrayMResDet removeObjectAtIndex:answerCurrent];
                    [arrayMResDet insertObject:self.textOption.text atIndex:answerCurrent];
                }
                else{
                    [arrayMResDet addObject:self.textOption.text];
                }
            }
        }
        
        arrayMRes = [DicM objectForKey:@"arrayMRes"];
        if(self.nuevo){
            [arrayMRes addObject:arrayMResDet];
        }else{
            [arrayMRes removeObjectAtIndex:self.dicSelected];
            [arrayMRes insertObject:arrayMResDet atIndex:self.dicSelected];
        }
        
        [DicM setObject:arrayMRes forKey:@"arrayMRes"];
        [DicM setObject:question forKey:@"questionM"];            
        
        if ([self.selectOption isEqualToString:NSLocalizedString(@"m1", nil)]) {
            [self.dicIshikawa setObject:DicM forKey:@"m1"];
        }else if ([self.selectOption isEqualToString:NSLocalizedString(@"m2", nil)]) {
            [self.dicIshikawa setObject:DicM forKey:@"m2"];
        }else if ([self.selectOption isEqualToString:NSLocalizedString(@"m3", nil)]) {
            [self.dicIshikawa setObject:DicM forKey:@"m3"];
        }else if ([self.selectOption isEqualToString:NSLocalizedString(@"m4", nil)]) {
            [self.dicIshikawa setObject:DicM forKey:@"m4"];
        }else if ([self.selectOption isEqualToString:NSLocalizedString(@"m5", nil)]) {
            [self.dicIshikawa setObject:DicM forKey:@"m5"];
        }else if ([self.selectOption isEqualToString:NSLocalizedString(@"m6", nil)]) {
            [self.dicIshikawa setObject:DicM forKey:@"m6"];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*#pragma  mark - TableView
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
*/
#pragma mark - UIStyle
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end