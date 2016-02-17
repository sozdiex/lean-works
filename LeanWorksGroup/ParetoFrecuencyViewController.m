//
//  ParetoFrecuencyViewController.m
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 21/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "ParetoFrecuencyViewController.h"
#import "RoketFetcher.h"
#import "ParetoFrecuencyDateViewController.h"

@interface ParetoFrecuencyViewController ()

@property (strong, nonatomic) NSMutableArray *optionsArray;

@end

@implementation ParetoFrecuencyViewController

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
    self.optionsArray = [[NSMutableArray alloc] init];
    self.mainProblem = [self.dicPareto objectForKey:@"mainProblem"];
    [self dataFetch];
    
    /*self.btnNext.layer.borderWidth = 1.0f;
     self.btnNext.layer.cornerRadius = 7.0f;
     self.btnNext.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];*/
    
}

- (void)viewDidAppear:(BOOL)animated {
    if(!self.historico){
        [self.tableOptions deselectRowAtIndexPath:[self.tableOptions indexPathForSelectedRow] animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data

- (void)dataFetch {
    [self.btnBack setTitle:NSLocalizedString(@"btnBack", nil)];
    NSString *title = NSLocalizedString(@"lblTituloParetoFrecuency", nil);
    self.labelTitle.text = title;
    //Hora, Dia, Semana, Quincena, Mes
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"Hora", nil) forKey:@"name"]; //0
    [self.optionsArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"dia", nil) forKey:@"name"]; //1
    [self.optionsArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"Semana", nil) forKey:@"name"]; // 2
    [self.optionsArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"Quincena", nil) forKey:@"name"]; // 3
    [self.optionsArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"Mes", nil) forKey:@"name"]; // 4
    [self.optionsArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"Bimestre", nil) forKey:@"name"]; // 5
    [self.optionsArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"Trimestre", nil) forKey:@"name"]; // 6
    [self.optionsArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"Cuatrimestre", nil) forKey:@"name"]; // 7
    [self.optionsArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"Semestre", nil) forKey:@"name"]; // 8
    [self.optionsArray addObject:dic];
    
    dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"Anual", nil) forKey:@"name"]; // 9
    [self.optionsArray addObject:dic];
}

#pragma mark - IBAction

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*- (IBAction)nextStep:(id)sender {
 
 ParetoDiagramViewController *pdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ParetoDiagramView"];
 pdvc.mainProblem = self.mainProblem;
 [self presentViewController:pdvc animated:YES completion:nil];
 }*/

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.optionsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionCell"];
    NSDictionary *data = [self.optionsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [data objectForKey:@"name"];
    
    if(self.historico){
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setUserInteractionEnabled:NO];
    }
    
    if([self.dicPareto objectForKey:@"FrecuenciaMedidaValue"])
        if([[self.dicPareto objectForKey:@"FrecuenciaMedidaValue"]integerValue] == indexPath.row){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
            [cell setUserInteractionEnabled:YES];
        }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dic;
    dic = [self.optionsArray objectAtIndex:indexPath.row];
    
    [self.dicPareto setObject:[dic objectForKey:@"name"] forKey:@"FrecuenciaMedida"];
    [self.dicPareto setObject:[NSString stringWithFormat:@"%d",indexPath.row] forKey:@"FrecuenciaMedidaValue"];
    
    ParetoFrecuencyDateViewController *pfdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ParetoFrecuencyDateView"];
    //pdvc.mainProblem = self.mainProblem;
    pfdvc.dicPareto = self.dicPareto;
    
    if(!self.historico)
        [RoketFetcher createJson:self.dicPareto :Nil :@"ParetoDiagramView"];
    
    pfdvc.historico = self.historico;
    [self presentViewController:pfdvc animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @" ";
}

#pragma mark - UIStyle

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
