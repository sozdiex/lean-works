//
//  IshikawaDiagramViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 18/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "IshikawaDiagramViewController.h"
#import "CauseCell.h"
#import "SixListViewController.h"
#import "SecondaryCauseViewController.h"
#import "SixCausesViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"

@interface IshikawaDiagramViewController ()

@property (strong, nonatomic) NSMutableArray *causesArray1;
@property (strong, nonatomic) NSMutableArray *causesArray2;
@property (strong, nonatomic) NSMutableArray *causesArray3;
@property (strong, nonatomic) NSMutableArray *causesArray4;
@property (strong, nonatomic) NSMutableArray *causesArray5;
@property (strong, nonatomic) NSMutableArray *causesArray6;

@end

@implementation IshikawaDiagramViewController

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
    NSString *title = [[NSString alloc] initWithFormat:@"¿Cuáles considera las causas secundarias de su problema (%@)?", self.mainProblem];
    self.labelTitle.text = title;
    self.causesArray1 = [[NSMutableArray alloc] init];
    self.causesArray2 = [[NSMutableArray alloc] init];
    self.causesArray3 = [[NSMutableArray alloc] init];
    self.causesArray4 = [[NSMutableArray alloc] init];
    self.causesArray5 = [[NSMutableArray alloc] init];
    self.causesArray6 = [[NSMutableArray alloc] init];
    
    self.btnNext.layer.borderWidth = 1.0f;
    self.btnNext.layer.cornerRadius = 7.0f;
    self.btnNext.layer.borderColor = [[UIColor colorWithRed:(244.0/255.0) green:(124.0/255.0) blue:(70.0/255.0) alpha:1.0] CGColor];
}

- (IBAction)showMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addCause:(id)sender {
    NSMutableDictionary *newCause = [[NSMutableDictionary alloc] init];
    [newCause setObject:self.txtCause.text forKey:@"name"];
    [newCause setObject:[self.btnCategories titleForState:UIControlStateNormal] forKey:@"category"];
    
    if ([[self.selectOption objectForKey:@"id"] isEqualToString:@"1"]) {
        [self.causesArray1 insertObject:newCause atIndex:0];
    }
    else if ([[self.selectOption objectForKey:@"id"] isEqualToString:@"2"]) {
        [self.causesArray2 insertObject:newCause atIndex:0];
    }
    else if ([[self.selectOption objectForKey:@"id"] isEqualToString:@"3"]) {
        [self.causesArray3 insertObject:newCause atIndex:0];
    }
    else if ([[self.selectOption objectForKey:@"id"] isEqualToString:@"4"]) {
        [self.causesArray4 insertObject:newCause atIndex:0];
    }
    else if ([[self.selectOption objectForKey:@"id"] isEqualToString:@"5"]) {
        [self.causesArray5 insertObject:newCause atIndex:0];
    }
    else if ([[self.selectOption objectForKey:@"id"] isEqualToString:@"6"]) {
        [self.causesArray6 insertObject:newCause atIndex:0];
    }
    
    [self.causesTable reloadData];
    self.txtCause.text = @"";
}

- (IBAction)showSixList:(id)sender {
    SixListViewController *slvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SixListView"];
    slvc.delegate = self;
    [self presentViewController:slvc animated:YES completion:nil];
}

- (IBAction)nextStep:(id)sender {
    SixCausesViewController *scvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SixCausesView"];
    NSMutableArray *arrayTotal = [[NSMutableArray alloc] initWithObjects:self.causesArray1, self.causesArray2, self.causesArray3, self.causesArray4, self.causesArray5, self.causesArray6, nil];
    scvc.causesTotalArray = arrayTotal;
    [self presentViewController:scvc animated:YES completion:nil];
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rows = 0;
    if (section == 0)
        rows = (int)[self.causesArray1 count];
    else if (section == 1)
        rows = (int)[self.causesArray2 count];
    else if (section == 2)
        rows = (int)[self.causesArray3 count];
    else if (section == 3)
        rows = (int)[self.causesArray4 count];
    else if (section == 4)
        rows = (int)[self.causesArray5 count];
    else if (section == 5)
        rows = (int)[self.causesArray6 count];
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CauseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CauseSecondaryCell" forIndexPath:indexPath];
    
    NSDictionary *data = [[NSDictionary alloc] init];
    
    if (indexPath.section == 0) {
        data = [self.causesArray1 objectAtIndex:indexPath.row];
        cell.causeName = [data objectForKey:@"name"];
        cell.labelCauseName.text = cell.causeName;
        return cell;
    }
    else if (indexPath.section == 1) {
        data = [self.causesArray2 objectAtIndex:indexPath.row];
        cell.causeName = [data objectForKey:@"name"];
        cell.labelCauseName.text = cell.causeName;
        return cell;
    }
    else if (indexPath.section == 2) {
        data = [self.causesArray3 objectAtIndex:indexPath.row];
        cell.causeName = [data objectForKey:@"name"];
        cell.labelCauseName.text = cell.causeName;
        return cell;
    }
    else if (indexPath.section == 3) {
        data = [self.causesArray4 objectAtIndex:indexPath.row];
        cell.causeName = [data objectForKey:@"name"];
        cell.labelCauseName.text = cell.causeName;
        return cell;
    }
    else if (indexPath.section == 4) {
        data = [self.causesArray5 objectAtIndex:indexPath.row];
        cell.causeName = [data objectForKey:@"name"];
        cell.labelCauseName.text = cell.causeName;
        return cell;
    }
    else if (indexPath.section == 5) {
        data = [self.causesArray6 objectAtIndex:indexPath.row];
        cell.causeName = [data objectForKey:@"name"];
        cell.labelCauseName.text = cell.causeName;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.causesArray1 removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data = [[NSDictionary alloc] init];
    if (indexPath.section == 0) {
        data = [self.causesArray1 objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 1) {
        data = [self.causesArray2 objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 2) {
        data = [self.causesArray3 objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 3) {
        data = [self.causesArray4 objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 4) {
        data = [self.causesArray5 objectAtIndex:indexPath.row];
    }
    else if (indexPath.section == 5) {
        data = [self.causesArray6 objectAtIndex:indexPath.row];
    }
    
    SecondaryCauseViewController *scvc = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondaryCauseView"];
    scvc.secondaryCause = [data objectForKey:@"name"];
    [self presentViewController:scvc animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    if ([tableView.dataSource tableView:tableView numberOfRowsInSection:section] == 0)
        return title;
    if (section == 0)
        title = @"Mano de obra o gente";
    else if (section == 1)
        title = @"Métodos";
    else if (section == 2)
        title = @"Máquinas o equipos";
    else if (section == 3)
        title = @"Material";
    else if (section == 4)
        title = @"Mediciones o inspección";
    else if (section == 5)
        title = @"Medio ambiente";
    return title;
}

@end