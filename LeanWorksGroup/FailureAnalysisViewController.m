//
//  FailureAnalysisViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 12/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "FailureAnalysisViewController.h"
#import "FailureAnalysisCell.h"
#import "ActionPlanViewController.h"
#import "FailureAnalysisDetailViewController.h"
#import "RoketFetcher.h"
#import "CustomAlertViewController.h"

@interface FailureAnalysisViewController (){
    int rowSelecte;
}

@end

@implementation FailureAnalysisViewController

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

    [self.btnBack setTitle:NSLocalizedString(@"btnBack", nil)];
    [self.lblTitleView setText:NSLocalizedString(@"Analisis de fallas", nil)];
    [self.btnNext setTitle:NSLocalizedString(@"btnSiguiente", nil) forState:UIControlStateNormal];
    
	// Do any additional setup after loading the view.
    self.btnNext.layer.borderWidth = 1.0f;
    self.btnNext.layer.cornerRadius = 7.0f;
    self.btnNext.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertAccepted) name:@"alertAccepted" object:nil];
    
    if([self.dicIshikawa objectForKey:@"arrayWhy"])
        self.failuresArray = [self.dicIshikawa objectForKey:@"arrayWhy"];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tableFailureAnalysis deselectRowAtIndexPath:[self.tableFailureAnalysis indexPathForSelectedRow] animated:YES];
    [self.tableFailureAnalysis reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableFailureAnalysis deselectRowAtIndexPath:[self.tableFailureAnalysis indexPathForSelectedRow] animated:YES];
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

- (IBAction)nextStep:(id)sender {
    ActionPlanViewController *apvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ActionPlanView"];
    [self.dicIshikawa setObject:self.failuresArray forKey:@"arrayWhy"];
    apvc.failuresArray = self.failuresArray;
    [self.dicIshikawa setObject:self.failuresArray forKey:@"failuresArray"];
    apvc.dicIshikawa = self.dicIshikawa;
    apvc.dicPareto = self.dicPareto;
    
    if(!self.historico)
        [RoketFetcher createJson:self.dicPareto :self.dicIshikawa :@"ActionPlanView"];
    
    apvc.historico = self.historico;
    
    [self presentViewController:apvc animated:YES completion:nil];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.failuresArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FailureAnalysisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FailureAnalysisCell" forIndexPath:indexPath];
    NSDictionary *data = [self.failuresArray objectAtIndex:indexPath.row];
    cell.causeName.text = [data objectForKey:@"name"];
    
    cell.why.text =  [data objectForKey:@"why1"];
    cell.why2.text = [data objectForKey:@"why2"];
    cell.why3.text = [data objectForKey:@"why3"];
    cell.why4.text = [data objectForKey:@"why4"];
    cell.why5.text = [data objectForKey:@"why5"];
    
    if(self.historico){
        [cell setUserInteractionEnabled:NO];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.failuresArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    rowSelecte = (int)indexPath.row;
    /*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Lean Works Group" message:@"¿Desea editar el elemento?" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"OK", nil];
    alert.tag = 1;
    [alert show];*/
    [self.tableFailureAnalysis deselectRowAtIndexPath:[self.tableFailureAnalysis indexPathForSelectedRow] animated:YES];
    
    CustomAlertViewController* vc = [CustomAlertViewController new];
    vc.text = NSLocalizedString(@"¿Desea editar el elemento?",nil);
    vc.alertQuestion = YES;
    [self presentViewController:vc animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Causa                            Why                    Why                    Why                    Why                    Why";
}

#pragma mark - AlertViewCustom
-(void)alertAccepted{
    NSLog(@"Dismissed SecondViewController");
    FailureAnalysisDetailViewController *fadvc;
    fadvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FailureAnalysisDetailView"];
    NSDictionary *data = [self.failuresArray objectAtIndex:rowSelecte];
    fadvc.index = rowSelecte;
    fadvc.delegate = self;
    fadvc.causeName = [data objectForKey:@"name"];
    fadvc.failuresArray = self.failuresArray;
    [self presentViewController:fadvc animated:YES completion:nil];
}

/*#pragma mark - AlertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView tag] == 1) {
        if (buttonIndex == 1) {
            
            [self presentViewController:self.fadvc animated:YES completion:nil];
        }
        else {
            [self.tableFailureAnalysis deselectRowAtIndexPath:[self.tableFailureAnalysis indexPathForSelectedRow] animated:YES];
        }
    }
}*/

#pragma mark - UIStyle

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
