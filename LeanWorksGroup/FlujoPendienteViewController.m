//
//  FlujoPendienteViewController.m
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 23/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "FlujoPendienteViewController.h"
#import "ECSlidingViewController.h"
#import "RoketFetcher.h"
#import "CompanySectorViewController.h"

@interface FlujoPendienteViewController (){
    NSMutableArray *arrayEstatus;
}

@end

@implementation FlujoPendienteViewController

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
    RoketFetcher *roket = [[RoketFetcher alloc]init];
    arrayEstatus = [roket getEstatus];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)btnshowProblem:(id)sender {
}

- (IBAction)showMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}
#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayEstatus count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PendienteCell" forIndexPath:indexPath];
    NSDictionary *data = [arrayEstatus objectAtIndex:indexPath.row];
    cell.textLabel.text = [data objectForKey:@"mainProblem"];
    //cell.detailTextLabel.text = [data objectForKey:@"nombre_archivo"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *myDic = [arrayEstatus objectAtIndex:indexPath.row];
    myDic = [RoketFetcher readJson:[myDic objectForKey:@"nombre_archivo"]];
    NSMutableDictionary *dicPareto = [myDic objectForKey:@"dicPareto"];
    
    if([[myDic objectForKey:@"dicIshikawa"] count] > 0)
        [dicPareto setObject:[myDic objectForKey:@"dicIshikawa"] forKey:@"dicIshikawa"];
    
    CompanySectorViewController *csvc = [self.storyboard instantiateViewControllerWithIdentifier:@"CompanySectorView"];
    csvc.dicPareto = dicPareto;
    csvc.historico = NO;
    self.slidingViewController.topViewController = csvc;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Pendientes";
}
@end
