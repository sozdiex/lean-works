//
//  SixCausesViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 21/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "SixCausesViewController.h"
#import "CauseCell.h"
#import "FactorsViewController.h"

@interface SixCausesViewController ()

@property (strong, nonatomic) NSMutableArray *causesArray;
@property (strong, nonatomic) NSString *selected;
@property (strong, nonatomic) NSMutableArray *arraySelected;

@end

@implementation SixCausesViewController

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
    self.causesArray = [[NSMutableArray alloc] init];
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:@"Mano de obra o gente" forKey:@"name"];
    NSMutableDictionary *dictionary2 = [[NSMutableDictionary alloc] init];
    [dictionary2 setObject:@"Métodos" forKey:@"name"];
    NSMutableDictionary *dictionary3 = [[NSMutableDictionary alloc] init];
    [dictionary3 setObject:@"Máquinas o equipo" forKey:@"name"];
    NSMutableDictionary *dictionary4 = [[NSMutableDictionary alloc] init];
    [dictionary4 setObject:@"Material" forKey:@"name"];
    NSMutableDictionary *dictionary5 = [[NSMutableDictionary alloc] init];
    [dictionary5 setObject:@"Mediciones o inspección" forKey:@"name"];
    NSMutableDictionary *dictionary6 = [[NSMutableDictionary alloc] init];
    [dictionary6 setObject:@"Medio ambiente" forKey:@"name"];
    
    [self.causesArray addObject:dictionary];
    [self.causesArray addObject:dictionary2];
    [self.causesArray addObject:dictionary3];
    [self.causesArray addObject:dictionary4];
    [self.causesArray addObject:dictionary5];
    [self.causesArray addObject:dictionary6];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.causesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CauseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CausePrincipalCell" forIndexPath:indexPath];
    NSDictionary *data = [self.causesArray objectAtIndex:indexPath.row];
    cell.causeName = [data objectForKey:@"name"];
    cell.labelCauseName.text = cell.causeName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.arraySelected = [self.causesTotalArray objectAtIndex:indexPath.row];
    self.selected = [[self.causesArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    FactorsViewController *fvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FactorsView"];
    fvc.selected = self.selected;
    fvc.arraySelected = self.arraySelected;
    [self presentViewController:fvc animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @" ";
}

@end
