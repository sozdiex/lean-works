//
//  ParetoViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 07/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "ParetoViewController.h"
#import "ParetoDiagramViewController.h"
#import "ParetoFrecuencyViewController.h"
#import "RoketFetcher.h"

@interface ParetoViewController ()

@property (strong, nonatomic) NSMutableArray *optionsArray;

@end

@implementation ParetoViewController

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
    NSString *title = [[NSString alloc] initWithFormat:NSLocalizedString(@"lblPareto", nil), self.mainProblem];
    self.labelTitle.text = title;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:NSLocalizedString(@"Unidades",nil) forKey:@"name"];
    [self.optionsArray addObject:dic];
    
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setValue:NSLocalizedString(@"Pesos",nil) forKey:@"name"];
    [self.optionsArray addObject:dic2];
    [self.btnBack setTitle:NSLocalizedString(@"btnBack", nil)];
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

    
    if([self.dicPareto objectForKey:@"unidadMedidaValue"])
        if([[self.dicPareto objectForKey:@"unidadMedidaValue"]integerValue] == indexPath.row){
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
        
    //NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    //[ud setValue:[dic objectForKey:@"name"] forKey:@"unidadMedida"];
    //[ud synchronize];
    
    [self.dicPareto setObject:[dic objectForKey:@"name"] forKey:@"unidadMedida"];
    [self.dicPareto setObject:[NSString stringWithFormat:@"%d",indexPath.row] forKey:@"unidadMedidaValue"];

    ParetoFrecuencyViewController *pfvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ParetoFrecuencyView"];
    //pdvc.mainProblem = self.mainProblem;
    pfvc.dicPareto = self.dicPareto;
    
    if(!self.historico)
        [RoketFetcher createJson:self.dicPareto :Nil :@"ParetoFrecuencyView"];
    
    pfvc.historico = self.historico;
    [self presentViewController:pfvc animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @" ";
}

#pragma mark - UIStyle

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
