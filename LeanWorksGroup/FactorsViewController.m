//
//  FactorsViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 21/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "FactorsViewController.h"
#import "CauseCell.h"
#import "OrderViewController.h"
#import "RoketFetcher.h"
#import "CustomAlertViewController.h"

@interface FactorsViewController (){
    BOOL load;
}

@end

@implementation FactorsViewController

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
    self.btnNext.layer.borderWidth = 1.0f;
    self.btnNext.layer.cornerRadius = 7.0f;
    self.btnNext.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
    
    self.lblTitulo.text = [NSString stringWithFormat:NSLocalizedString(@"lblTitleFactor", nil),[self.dicPareto objectForKey:@"mainProblem"]];
    [self.btnBack setTitle:NSLocalizedString(@"btnBack", nil)];
    [self.btnNext setTitle:NSLocalizedString(@"btnSiguiente", nil) forState:UIControlStateNormal];
    
    load = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    
    if(!load){
        if(!self.historico)
            [self.mainTable reloadData];
    }
    load = NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)close:(id)sender {
     [self dismissViewControllerAnimated:NO completion:Nil];
    /*
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Manufactura"] && [[ud objectForKey:@"ishikawa"] isEqualToString:@"Medición"]) {
        [self dismissViewControllerAnimated:NO completion:^{
            [self.istvc dismissViewControllerAnimated:NO completion:^{
                [self.icvc dismissViewControllerAnimated:NO completion:nil];
            }];
        }];
    }
    else {
        [self dismissViewControllerAnimated:NO completion:^{
            [self.isfvc dismissViewControllerAnimated:NO completion:^{
                [self.isthreevc dismissViewControllerAnimated:NO completion:^{
                    [self.istvc dismissViewControllerAnimated:NO completion:^{
                        [self.icvc dismissViewControllerAnimated:NO completion:nil];
                    }];
                }];
            }];
        }];
    }*/
}

- (IBAction)nextStep:(id)sender {
    NSArray *selected = [self.mainTable indexPathsForSelectedRows];
    NSMutableArray *arraySelected = [[NSMutableArray alloc] init];
    
    if(self.historico){
        arraySelected = [self.dicIshikawa objectForKey:@"arraySelected"];
    }else{
        for (NSIndexPath *index in selected) {
            [arraySelected addObject:[self.arraySelected objectAtIndex:index.row]];
        }
    }
    
    
    if(arraySelected.count< 5){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Es necesario agregar al menos 5 factores",nil);
        [self presentViewController:vc animated:YES completion:nil];
    }
    else if(arraySelected.count >5){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Solo se permiten agregar 5 factores como máximo",nil);
        [self presentViewController:vc animated:YES completion:nil];
    }
    else{
        OrderViewController *ovc = [self.storyboard instantiateViewControllerWithIdentifier:@"OrderView"];
        ovc.arraySelected = arraySelected;
        [self.dicIshikawa setObject:arraySelected forKey:@"arraySelected"];
        ovc.dicIshikawa = self.dicIshikawa;
        ovc.dicPareto = self.dicPareto;
        if(!self.historico)
            [RoketFetcher createJson:self.dicPareto :self.dicIshikawa :@"OrderView"];
        
        ovc.historico = self.historico;

        [self presentViewController:ovc animated:YES completion:nil];
    }
    
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arraySelected count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CauseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FactorItemCell" forIndexPath:indexPath];
    NSDictionary *data = [self.arraySelected objectAtIndex:indexPath.row];
    cell.causeName = [data objectForKey:@"name"];
    cell.labelCauseName.text = cell.causeName;
    
    if([self.dicIshikawa objectForKey:@"arraySelected"]){
        NSMutableArray *arrayTem = [_dicIshikawa objectForKey:@"arraySelected"];
        
        for (int i = 0; i < [arrayTem count]; i++) {
            NSDictionary *dicTem = [arrayTem objectAtIndex:i];
            
            if([[dicTem objectForKey:@"name"] isEqualToString:[data objectForKey:@"name"]]){
               
                [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                
            
                
                if(self.historico){
                    [cell setUserInteractionEnabled:NO];
                     cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }else{
                    [arrayTem removeObjectAtIndex:i];
                    [self.dicIshikawa setObject:arrayTem forKey:@"arraySelected"];
                }
                
                return cell;
            }else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
        }
    }
    if(self.historico){
        [cell setUserInteractionEnabled:NO];
    }
    
    return cell;
}

/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.arraySelected removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {}
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
   // cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
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

@end
