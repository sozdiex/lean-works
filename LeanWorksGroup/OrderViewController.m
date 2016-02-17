//
//  OrderViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 21/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "OrderViewController.h"
#import "CauseCell.h"
#import "FailureAnalysisViewController.h"
#import "RoketFetcher.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

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
    [self.mainTable setEditing:YES animated:YES];
    if(self.historico){
        self.arraySelected = [self.dicIshikawa objectForKey:@"arraySelected"];
    }
    
     self.lblPrimero.text =NSLocalizedString(@"lblPrimero", nil);
     self.lblSegundo.text =NSLocalizedString(@"lblSegundo", nil);
     self.lblTercero.text =NSLocalizedString(@"lblTercero", nil);
     self.lblCuarto.text =NSLocalizedString(@"lblCuarto", nil);
     self.lblQuinto.text =NSLocalizedString(@"lblQuinto", nil);
    
    self.lblTitulo.text = [NSString stringWithFormat:NSLocalizedString(@"lblTitleOrder", nil),[self.dicPareto objectForKey:@"mainProblem"]];
    [self.btnNext setTitle:NSLocalizedString(@"btnSiguiente", nil) forState:UIControlStateNormal];
    [self.btnBack setTitle:NSLocalizedString(@"btnBack", nil)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextStep:(id)sender {
    FailureAnalysisViewController *favc = [self.storyboard instantiateViewControllerWithIdentifier:@"FailureAnalysisView"];
    favc.failuresArray = self.arraySelected;
    [self.dicIshikawa setObject:self.arraySelected forKey:@"arraySelected"];
    favc.dicIshikawa = self.dicIshikawa;
    favc.dicPareto = self.dicPareto;
    if(!self.historico)
        [RoketFetcher createJson:self.dicPareto :self.dicIshikawa :@"FailureAnalysisView"];
    favc.historico = self.historico;
    [self presentViewController:favc animated:YES completion:nil];
    
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arraySelected count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CauseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell" forIndexPath:indexPath];
    NSDictionary *data = [self.arraySelected objectAtIndex:indexPath.row];
    cell.causeName = [data objectForKey:@"name"];
    cell.labelCauseName.text = cell.causeName;
    
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
toIndexPath:(NSIndexPath *)toIndexPath {
    NSMutableDictionary *item = [self.arraySelected objectAtIndex:fromIndexPath.row];
    [self.arraySelected removeObject:item];
    [self.arraySelected insertObject:item atIndex:toIndexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{}

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
