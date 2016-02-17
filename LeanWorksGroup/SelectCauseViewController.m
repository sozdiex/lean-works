//
//  SelectCauseViewController.m
//  LeanWorksGroup
//
//  Created by Jazmin Hernandez on 08/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "SelectCauseViewController.h"
#import "ActionPlanViewController.h"
#import "SelectCauseCell.h"

@interface SelectCauseViewController ()

@end

@implementation SelectCauseViewController

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
}

- (void)viewDidAppear:(BOOL)animated {
    [self loadView];
    [self.tableOptions deselectRowAtIndexPath:[self.tableOptions indexPathForSelectedRow] animated:YES];
    
    [self.labelTitle setText:NSLocalizedString(@"Seleccione la causa que desea en el análisis de fallas:", nil)];
    [self.lblTitleView setText:NSLocalizedString(@"Analisis de fallas", nil)];
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
    return [self.failuresArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *celda= [tableView dequeueReusableCellWithIdentifier:@"SelectCauseCell"];
    NSDictionary *data = [self.failuresArray objectAtIndex:indexPath.row];
    celda.textLabel.text=[data objectForKey:@"name"];
    return celda;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSMutableDictionary *dic= [self.failuresArray objectAtIndex:indexPath.row];
    [self.arrayCausaSelect removeAllObjects];
    [self.arrayCausaSelect addObject:[dic objectForKey:@"name"]];
    [self dismissViewControllerAnimated:YES completion:nil];
  
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"Causas", nil);
}


#pragma mark - UIStyle

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
