//
//  IshikawaViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 08/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "IshikawaViewController.h"
#import "IshikawaCategoryViewController.h"
#import "IshikawaCell.h"
#import "IshikawaCategoryListViewController.h"
#import "FactorsViewController.h"
#import "RoketFetcher.h"
#import "CustomAlertViewController.h"

@interface IshikawaViewController ()

@property (strong, nonatomic) NSMutableArray *optionsArray;

@end

@implementation IshikawaViewController

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
    if(!self.dicIshikawa){
        self.dicIshikawa = [[NSMutableDictionary alloc]init];
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self hardcode];
}
-(NSString *)periodoES:(NSString *) periodo{
    
    if([[self.dicPareto objectForKey:@"FrecuenciaMedidaValue"]integerValue] == 9){
        return periodo;
    }else{
        return [NSString stringWithFormat:@"por %@",periodo];
    }
    
    return @"";
}

- (void)hardcode {
    
    //Por qué + Quien + Donde + Cuando + Que + Como + Cuanto.
    //NSString *title = [[NSString alloc] initWithFormat:@"¿Por qué en la %@ de la %@ durante %@ tiene %@ %@ equivalentes a $%@?",self.who, self.where, self.when, self.what, self.how, self.howMuch];
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSString *title;
    NSString *userLanguage = [language substringToIndex:2];
    NSString *strPeriodo = [self.dicPareto objectForKey:@"FrecuenciaMedida"];
    
    if([userLanguage isEqualToString:@"es"] || [userLanguage isEqualToString:@"ES"]){
        title = [[NSString alloc] initWithFormat:@"¿Por qué en %@ de %@ durante %@ tiene %@ %@ equivalentes a %@ %@?",[self gramatica:self.who], self.where, self.when, self.what, self.how,[self SignoValue:self.howMuch],[self periodoES:strPeriodo]];
    }else{
        title = [[NSString alloc] initWithFormat:@"Why the %@ in %@ during %@ have %@ %@ equivalent to %@ by %@?",[self isThe:self.who], self.where, self.when , self.how,self.what,[self SignoValue:self.howMuch], strPeriodo];
    }
    
    
    [self.question setText:title];

    self.optionsArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"m1", nil) forKey:@"name"];
    [self.optionsArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"m2", nil) forKey:@"name"];
    [self.optionsArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"m3", nil) forKey:@"name"];
    [self.optionsArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"m4", nil) forKey:@"name"];
    [self.optionsArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"m5", nil) forKey:@"name"];
    [self.optionsArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"m6", nil) forKey:@"name"];
    [self.optionsArray addObject:dic];
    
    [self.btnSiguiente setTitle:NSLocalizedString(@"btnSiguiente", nil) forState:UIControlStateNormal];
    [self.btnAtras setTitle:NSLocalizedString(@"btnBack", nil)];

}

- (void)viewDidAppear:(BOOL)animated {
    [self.tableOptions deselectRowAtIndexPath:[self.tableOptions indexPathForSelectedRow] animated:YES];
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

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnContinuar:(id)sender {
    NSMutableArray *arraySelected = [self getArraySelected];
    
    if([arraySelected count] < 20){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = [NSString stringWithFormat:NSLocalizedString(@"debe capturar un total de 20",nil),[arraySelected count]];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    FactorsViewController *fvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FactorsView"];
    fvc.ivc = self;
    fvc.arraySelected = arraySelected;
    fvc.dicPareto = self.dicPareto;
    //fvc.icvc = self.icvc;
    //fvc.istvc = self.istvc;
    //fvc.isthreevc = self.isthreevc;
    //fvc.isfvc = self;
    fvc.dicIshikawa = self.dicIshikawa;
    
    if(!self.historico)
        [RoketFetcher createJson:self.dicPareto :self.dicIshikawa :@"FactorsView"];
    
    fvc.historico = self.historico;
    [self presentViewController:fvc animated:YES completion:nil];
}

-(IBAction)btnDetail:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    int indexrow = btn.tag;
    NSLog(@"Selected row is: %d",indexrow);
    
    IshikawaCategoryListViewController *ishikawaListVC = [self.storyboard instantiateViewControllerWithIdentifier:@"IshikawaCategoryListViewController"];
    
    ishikawaListVC.mainTitle = self.question.text;
    NSMutableDictionary *data = [self.optionsArray objectAtIndex:indexrow];

    [self.dicIshikawa setObject:self.question.text forKey:@"question"];
    ishikawaListVC.dicIshikawa = _dicIshikawa;
    ishikawaListVC.selectOption = [data objectForKey:@"name"];
    ishikawaListVC.ivc = self;
    ishikawaListVC.historico = self.historico;

    [self presentViewController:ishikawaListVC animated:YES completion:nil];
    
    
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.optionsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IshikawaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IshikawaCell"];
    NSDictionary *data = [self.optionsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [data objectForKey:@"name"];
    cell.btnDetail.tag = indexPath.row;
    [cell.btnDetail addTarget:self action:@selector(btnDetail:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.historico){
        [self.tableOptions deselectRowAtIndexPath:[self.tableOptions indexPathForSelectedRow] animated:YES];
        return;
    }
    
    IshikawaCategoryViewController *icvc = [self.storyboard instantiateViewControllerWithIdentifier:@"IshikawaCategoryView"];
    icvc.mainTitle = self.question.text;
    NSMutableDictionary *data = [self.optionsArray objectAtIndex:indexPath.row];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setValue:[data objectForKey:@"name"] forKey:@"ishikawa"];
    [ud synchronize];
    
    [self.dicIshikawa setObject:self.question.text forKey:@"question"];
    icvc.dicIshikawa = self.dicIshikawa;
    icvc.selectOption = [data objectForKey:@"name"];
    icvc.ivc = self;
    icvc.nuevo = YES;
    
    [self presentViewController:icvc animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @" ";
}

#pragma mark - UIStyle

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Methods

-(NSString *)SignoValue:(NSString *)valor{
    
    if([[self.dicPareto objectForKey:@"unidadMedidaValue"]integerValue] == 1){
        return [NSString stringWithFormat:@"$%@",valor];
    }
    return [NSString stringWithFormat:@"%@ %@",valor ,NSLocalizedString(@"Unidades", nil)];
}

-(NSMutableArray*)getArraySelected{
    NSMutableArray *arraySelected =[[NSMutableArray alloc]init];
    
    for (int x = 0; x < 6; x++) {
        NSString *m = [NSString stringWithFormat:@"m%d",x+1];
        
        if([self.dicIshikawa objectForKey:m]){
            NSMutableDictionary *dicM= [self.dicIshikawa objectForKey:m];
            NSMutableArray *arrayMRes = [dicM objectForKey:@"arrayMRes"];
            for(int i= 0; i < [arrayMRes count]; i++){
                NSMutableArray *arrayM = [arrayMRes objectAtIndex:i];
                for (int j = 0; j < [arrayM count]; j++) {
                    //[arraySelected addObject:[arrayM objectAtIndex:j]];
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    [dic setValue:[arrayM objectAtIndex:j] forKey:@"name"];
                    [arraySelected addObject:dic];
                }
            }

        }
    }
    return arraySelected;
}

-(bool)esProNombre:(NSString *)palabra{
    bool esProNombre = NO;
    
    //NSArray *proNombres = @[@"1", @"b", @"3", @"d"];
    
    return esProNombre;
}

-(bool)exepcionMasculina:(NSString *)palabra{
    palabra = [palabra lowercaseString];
    NSArray *proNombres = @[@"noche", @"piel", @"gente", @"clase", @"imagen", @"nieve", @"mano", @"foto", @"cárcel", @"parte", @"clase", @"clase", @"clase", @"planta"];
    
    for(NSString *tmpProNombre in proNombres){
        if([tmpProNombre isEqualToString:palabra]){
            return YES;
        }
    }
    return NO;
}

-(bool)exepcionFemenindas:(NSString *)palabra{
    palabra = [palabra lowercaseString];
    NSArray *proNombres = @[@"día", @"lápiz", @"sofá", @"camión", @"corazón", @"agua"];
    
    for(NSString *tmpProNombre in proNombres){
        if([tmpProNombre isEqualToString:palabra]){
            return YES;
        }
    }
    return NO;
}
-(NSString *)isThe:(NSString *)texto{
    NSString *strReturn = texto;
    NSString *the = [texto substringToIndex:3];
    if([the isEqualToString:@"the"]){
        strReturn = [texto substringFromIndex:4];
    }
    
    return strReturn;
}

-(NSString *)gramatica:(NSString *)texto{
    
    NSString *palabra = @"";
    
    if([texto length]<2){
        return texto;
    }
    
    for(int i = 0; i < [texto length] ; i++){
        NSRange letterRange = NSMakeRange(i, 1);
        NSString *lastLetter =[texto substringWithRange:letterRange];
        if([lastLetter isEqualToString:@" "]){
            NSRange wordRange = NSMakeRange(0, i);
            palabra = [texto substringWithRange:wordRange];
            break;
        }
    }
    
    if([palabra isEqualToString:@""]){
        palabra = texto;
    }
    
    NSString* sexo = @"";
    
    NSString *lastLetter =[palabra substringFromIndex:[palabra length]-1];
    
    if([lastLetter isEqualToString:@"l"] || [lastLetter isEqualToString:@"o"] || [lastLetter isEqualToString:@"n"] || [lastLetter isEqualToString:@"e"] || [lastLetter isEqualToString:@"r"] || [lastLetter isEqualToString:@"s"]){
        sexo = @"M";
    }else if([lastLetter isEqualToString:@"a"] || [lastLetter isEqualToString:@"d"] || [lastLetter isEqualToString:@"ón"] || [lastLetter isEqualToString:@"z"]){
        sexo =@"F";
    }
    
    lastLetter =[palabra substringFromIndex:[palabra length]-2];
    
    if([lastLetter isEqualToString:@"ma"] || [lastLetter isEqualToString:@"ta"]){
        sexo = @"M";
    }else if([lastLetter isEqualToString:@"is"] || [lastLetter isEqualToString:@"ie"]){
        sexo = @"F";
    }
    
    if([palabra length]>5){
        NSString * ultimas5Letras = [palabra substringFromIndex:[palabra length]-5];
        ultimas5Letras = [ultimas5Letras lowercaseString];
        if([ultimas5Letras isEqualToString:@"umbre"]){
            sexo = @"F";
        }
    }
    
    
    
    bool esPlural = NO;
    
    if([lastLetter isEqualToString:@"es"]){
        esPlural = YES;
        NSRange letterRange = NSMakeRange(0, [palabra length]-2);
        
        NSString *palabraMin =[texto substringWithRange:letterRange];
        NSString *vocal = [lastLetter substringToIndex:1];
        
        if([vocal isEqualToString:@"a"] || [vocal isEqualToString:@"e"] || [vocal isEqualToString:@"i"] || [vocal isEqualToString:@"o"] || [vocal isEqualToString:@"u"]){
            
            letterRange = NSMakeRange(0, [palabra length]-1);
            palabra =[texto substringWithRange:letterRange];
        }else{
            palabra = palabraMin;
        }
    }
    
    //comprobar si es plural o no
    lastLetter =[palabra substringFromIndex:[palabra length]-1];
    if([lastLetter isEqualToString:@"s"]){
        esPlural = YES;
        NSRange letterRange = NSMakeRange(0, [palabra length]-1);
        palabra =[texto substringWithRange:letterRange];
    }
    
    
    //Excepciones por terminacion
    if([self exepcionMasculina:palabra]){
        sexo = @"F";
    }
    if([self exepcionFemenindas:palabra]){
        sexo = @"M";
    }
    
    
    if(esPlural){
        if([sexo isEqualToString:@"F"]){
            //plural femenino
            return [NSString stringWithFormat:@"las %@",texto];
        }else{
            //prual masculino
            return [NSString stringWithFormat:@"los %@",texto];
            
        }
    }
    else{
        if([sexo isEqualToString:@"F"]){
            //singular femenino
            return [NSString stringWithFormat:@"la %@",texto];
        }else{
            //singular masculino
            return [NSString stringWithFormat:@"el %@",texto];
            
        }
        
    }
    
    
    return @"";
}


@end
