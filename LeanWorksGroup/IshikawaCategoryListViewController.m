//
//  IshikawaCategoryListViewController.m
//  LeanWorksGroup
//
//  Created by Armando Trujillo Zazueta  on 14/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "IshikawaCategoryListViewController.h"
#import "IshikawaCategoryViewController.h"

@interface IshikawaCategoryListViewController (){
    NSMutableDictionary *DicM;
    NSMutableArray *arrayMRes;
}

@end

@implementation IshikawaCategoryListViewController

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
    
    if ([self.selectOption isEqualToString:NSLocalizedString(@"m1", nil)]) {
        DicM =  [self.dicIshikawa objectForKey:@"m1"];
    }
    else if ([self.selectOption isEqualToString:NSLocalizedString(@"m2", nil)]) {
        DicM =  [self.dicIshikawa objectForKey:@"m2"];
    }
    else if ([self.selectOption isEqualToString:NSLocalizedString(@"m3", nil)]) {
        DicM =  [self.dicIshikawa objectForKey:@"m3"];
    }
    else if ([self.selectOption isEqualToString:NSLocalizedString(@"m4", nil)]) {
        DicM =  [self.dicIshikawa objectForKey:@"m4"];
    }
    else if ([self.selectOption isEqualToString:NSLocalizedString(@"m5", nil)]) {
        DicM =  [self.dicIshikawa objectForKey:@"m5"];
    }
    else if ([self.selectOption isEqualToString:NSLocalizedString(@"m6", nil)]) {
        DicM =  [self.dicIshikawa objectForKey:@"m6"];
    }
    
    arrayMRes = [DicM objectForKey:@"arrayMRes"];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // here you can reload needful views, for example, tableView:
    [self.tableView reloadData];
}
#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayMRes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IshikawaDetailList"];
    NSArray *data = [arrayMRes objectAtIndex:indexPath.row];
    cell.textLabel.text = [data objectAtIndex:0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IshikawaCategoryViewController *icvc = [self.storyboard instantiateViewControllerWithIdentifier:@"IshikawaCategoryView"];
    //icvc.mainTitle = self.question.text;
    //NSMutableDictionary *data = [self.optionsArray objectAtIndex:indexPath.row];

   // [self.dicIshikawa setObject:self.question.text forKey:@"question"];
    icvc.dicIshikawa = self.dicIshikawa;
    icvc.selectOption = self.selectOption;
    icvc.ivc = self;
    icvc.nuevo = NO;
    icvc.dicSelected = indexPath.row;
    icvc.historico = self.historico;
    [self presentViewController:icvc animated:YES completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.selectOption;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return NSLocalizedString(@"Eliminar",nil);
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //eliminar aqui
        [arrayMRes removeObjectAtIndex:indexPath.row];
        
/*
        [DicM setObject:arrayMRes forKey:@"arrayMRes"];
        
        if ([self.selectOption isEqualToString:@"Colaboradores / Clientes / Personas"]) {
            //DicM =  [self.dicIshikawa objectForKey:@"m1"];
            [self.dicIshikawa setObject:DicM forKey:@"m1"];
        }
        else if ([self.selectOption isEqualToString:@"Máquinas / Equipos"]) {
            [self.dicIshikawa setObject:DicM forKey:@"m2"];
        }
        else if ([self.selectOption isEqualToString:@"Método de Trabajo"]) {
            [self.dicIshikawa setObject:DicM forKey:@"m3"];
        }
        else if ([self.selectOption isEqualToString:@"Materiales"]) {
            [self.dicIshikawa setObject:DicM forKey:@"m4"];
        }
        else if ([self.selectOption isEqualToString:@"Medición"]) {
            [self.dicIshikawa setObject:DicM forKey:@"m5"];
        }
        else if ([self.selectOption isEqualToString:@"Medio Ambiente"]) {
            [self.dicIshikawa setObject:DicM forKey:@"m6"];
        }
        */

        
        //[self.tableView reloadData];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {}
}



#pragma mark - IBAction
- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIStyle
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
