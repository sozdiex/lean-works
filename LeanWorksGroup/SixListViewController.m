//
//  SixListViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 21/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "SixListViewController.h"
#import "CauseCell.h"
#import "IshikawaDiagramViewController.h"

@interface SixListViewController ()

@property (strong, nonatomic) NSMutableArray *causesArray;

@end

@implementation SixListViewController

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
    [dictionary setObject:@"1" forKey:@"id"];
    [dictionary setObject:@"Mano de obra o gente" forKey:@"name"];
    NSMutableDictionary *dictionary2 = [[NSMutableDictionary alloc] init];
    [dictionary2 setObject:@"2" forKey:@"id"];
    [dictionary2 setObject:@"Métodos" forKey:@"name"];
    NSMutableDictionary *dictionary3 = [[NSMutableDictionary alloc] init];
    [dictionary3 setObject:@"3" forKey:@"id"];
    [dictionary3 setObject:@"Máquinas o equipo" forKey:@"name"];
    NSMutableDictionary *dictionary4 = [[NSMutableDictionary alloc] init];
    [dictionary4 setObject:@"4" forKey:@"id"];
    [dictionary4 setObject:@"Material" forKey:@"name"];
    NSMutableDictionary *dictionary5 = [[NSMutableDictionary alloc] init];
    [dictionary5 setObject:@"5" forKey:@"id"];
    [dictionary5 setObject:@"Mediciones o inspección" forKey:@"name"];
    NSMutableDictionary *dictionary6 = [[NSMutableDictionary alloc] init];
    [dictionary6 setObject:@"6" forKey:@"id"];
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
    CauseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SixItemCell" forIndexPath:indexPath];
    NSDictionary *data = [self.causesArray objectAtIndex:indexPath.row];
    cell.causeName = [data objectForKey:@"name"];
    cell.labelCauseName.text = cell.causeName;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.causesArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IshikawaDiagramViewController *idvc = self.delegate;
    NSDictionary *data = [self.causesArray objectAtIndex:indexPath.row];
    [idvc.btnCategories setTitle:[data objectForKey:@"name"] forState:UIControlStateNormal];
    idvc.selectOption = data;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Categorías";
}

@end
