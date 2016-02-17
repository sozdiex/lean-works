 //
//  CompanySectorViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 17/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "CompanySectorViewController.h"
#import "SectorCell.h"
#import "MainProblemViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "RoketFetcher.h"

@interface CompanySectorViewController ()

@property (strong, nonatomic) NSMutableArray *sectorsArray;

@end

@implementation CompanySectorViewController

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
    if(!self.dicPareto){
        self.dicPareto = [[NSMutableDictionary alloc]init];
        [self.dicPareto setObject:@"0" forKey:@"EstatusGuardado"];
    }
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.sectorsArray = [[NSMutableArray alloc] init];
    [self dataFetch];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuView"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tableSector deselectRowAtIndexPath:[self.tableSector indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data

- (void)dataFetch {
    


    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:NSLocalizedString(@"Manufactura", nil) forKey:@"name"];
    [dictionary setObject:NSLocalizedString(@"ManufacturaMsg", nil) forKey:@"description"];
    
    NSMutableDictionary *dictionary2 = [[NSMutableDictionary alloc] init];
    [dictionary2 setObject:NSLocalizedString(@"Servicios", nil) forKey:@"name"];
    [dictionary2 setObject:NSLocalizedString(@"ServiciosMsg", nil) forKey:@"description"];
    
    NSMutableDictionary *dictionary3 = [[NSMutableDictionary alloc] init];
    [dictionary3 setObject:NSLocalizedString(@"Transformacion", nil) forKey:@"name"];
    [dictionary3 setObject:NSLocalizedString(@"TransformacionMsg", nil) forKey:@"description"];
    
    NSMutableDictionary *dictionary4 = [[NSMutableDictionary alloc] init];
    [dictionary4 setObject:NSLocalizedString(@"Educacion", nil) forKey:@"name"];
    [dictionary4 setObject:NSLocalizedString(@"EducacionMsg", nil) forKey:@"description"];
    
    NSMutableDictionary *dictionary5 = [[NSMutableDictionary alloc] init];
    [dictionary5 setObject:NSLocalizedString(@"Personal", nil) forKey:@"name"];
    [dictionary5 setObject:NSLocalizedString(@"PersonalMsg", nil) forKey:@"description"];
    
    [self.sectorsArray addObject:dictionary];
    [self.sectorsArray addObject:dictionary2];
    [self.sectorsArray addObject:dictionary3];
    [self.sectorsArray addObject:dictionary4];
    [self.sectorsArray addObject:dictionary5];
}

#pragma mark - IBAction

- (IBAction)showMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.sectorsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SectorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SectorCell" forIndexPath:indexPath];
    NSDictionary *data = [self.sectorsArray objectAtIndex:indexPath.row];
    
    if(self.historico){
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell setUserInteractionEnabled:NO];
    }
    

    if([self.dicPareto objectForKey:@"seleccionValue"]){
        if([[self.dicPareto objectForKey:@"seleccionValue"] integerValue] == indexPath.row){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
            [cell setUserInteractionEnabled:YES];
        }
    
    }
    cell.sectorName = [data objectForKey:@"name"];
    
    cell.labelSectorName.text = cell.sectorName;
    cell.sectorDescription = [data objectForKey:@"description"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *dic;
    dic = [self.sectorsArray objectAtIndex:indexPath.row];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setValue:[dic objectForKey:@"name"] forKey:@"seleccion"];
    [ud synchronize];
        
    [_dicPareto setObject:[dic objectForKey:@"name"] forKey:@"seleccion"];
    [self.dicPareto setObject:[NSString stringWithFormat:@"%d",indexPath.row] forKey:@"seleccionValue"];

    MainProblemViewController *mpvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainProblemView"];
    mpvc.dicPareto = self.dicPareto;
    mpvc.historico = self.historico;
    
    [self presentViewController:mpvc animated:YES completion:nil];
    
    /* if ([[dic objectForKey:@"name"] isEqualToString:@"Servicios"] || [[dic objectForKey:@"name"] isEqualToString:@"Manufactura"]) {
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setValue:[dic objectForKey:@"name"] forKey:@"seleccion"];
        [ud synchronize];
        
        MainProblemViewController *mpvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MainProblemView"];
        [self presentViewController:mpvc animated:YES completion:nil];
    }
    else {
        [self.tableSector deselectRowAtIndexPath:[self.tableSector indexPathForSelectedRow] animated:YES];
    }*/
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"SeleccioneGiro", nil);
}

@end
