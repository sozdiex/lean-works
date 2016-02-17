//
//  CauseDetailViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 18/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//


#import "CauseDetailViewController.h"
#import "ParetoDiagramViewController.h"
#import "CustomAlertViewController.h"

@interface CauseDetailViewController ()

@end


@implementation CauseDetailViewController

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
    [self.buttonSave setTitle:NSLocalizedString(@"Guardar", nil) forState:UIControlStateNormal];
    [self.buttonCancel setTitle:NSLocalizedString(@"Cancelar", nil)];
    [self.lblFreuency setText:NSLocalizedString(@"Frecuencia", nil)];
    
    self.buttonSave.layer.borderWidth = 1.0f;
    self.buttonSave.layer.cornerRadius = 7.0f;
    self.buttonSave.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
   
    NSMutableDictionary *data = [self.causesArray objectAtIndex:self.index];
    self.txtFrecuency.text =[NSString stringWithFormat:@"%@", [data objectForKey:@"frecuency"]];
    self.txtFrecuency.delegate = self;
    [self.lblClase setText:[NSString stringWithFormat:NSLocalizedString(@"clase", nil), self.causeName]];
    
}



- (void)viewDidAppear:(BOOL)animated {
    [self loadView];
    NSMutableDictionary *data = [self.causesArray objectAtIndex:self.index];
    self.txtFrecuency.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"frecuency"]];
    
    [self.buttonSave setTitle:NSLocalizedString(@"Guardar", nil) forState:UIControlStateNormal];
    [self.buttonCancel setTitle:NSLocalizedString(@"Cancelar", nil)];
    [self.lblFreuency setText:NSLocalizedString(@"Frecuencia", nil)];
    [self.lblClase setText:[NSString stringWithFormat:NSLocalizedString(@"clase", nil), self.causeName]];
}



- (void)didReceiveMemoryWarning

{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - TextField
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField selectAll:self];
}



#pragma mark - IBAction
- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)saveDetail:(id)sender {
    
    //NSString *regEx = @"^[Z0-9]*$";
    
    NSString *regEx =@"^[Z0-9]*(\\.\\d+)?$";
    NSPredicate *matchPattern =[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regEx];
    
    NSString *sinEspacio = [self.txtFrecuency.text  stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
    
    BOOL resultMatch =[matchPattern evaluateWithObject:sinEspacio];
    if(!resultMatch)
        
    {
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"La frecuencia no es númerica",nil);
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    if([self.txtFrecuency.text integerValue] != 0)
        
    {

        double frecuencia= [sinEspacio doubleValue];
        int frecuenciaEntera=[sinEspacio intValue];
        if(frecuencia-frecuenciaEntera == 0)
            
        {
            
            self.txtFrecuency.text= [NSString stringWithFormat:@"%d",frecuenciaEntera];
        }
        
        else
            
        {
            self.txtFrecuency.text= [NSString stringWithFormat:@"%.2f",frecuencia];
        }
        
    }

    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setValue:self.causeName forKey:@"name"];
   
    double frecuenciaConver=[self.txtFrecuency.text doubleValue];
    
    [data setValue:[NSNumber numberWithDouble:frecuenciaConver] forKey:@"frecuency"];
    [self.causesArray replaceObjectAtIndex:self.index withObject:data];
    
    ParetoDiagramViewController *pdvc = [[ParetoDiagramViewController alloc] init];
    NSMutableDictionary *dicOtro = [self.causesArray lastObject];
    [self.causesArray removeLastObject];
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"frecuency" ascending:NO];
    [self.causesArray sortUsingDescriptors:[NSArray arrayWithObject:sort]];
    [self.causesArray addObject:dicOtro];
    pdvc.causesArray = self.causesArray;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



/*#pragma mark - TableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:NSLocalizedString(@"clase", nil), self.causeName];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //[self.txtFrecuency.text isEqualToString:@"0"]
    if([self.txtFrecuency.text integerValue] != 0)
        
    {
        double frecuencia= [self.txtFrecuency.text doubleValue];
        int frecuenciaEntera=[self.txtFrecuency.text intValue];
        if(frecuencia-frecuenciaEntera == 0)
        {
            self.txtFrecuency.text= [NSString stringWithFormat:@"%d",frecuenciaEntera];
        }
        else
        {
            self.txtFrecuency.text= [NSString stringWithFormat:@"%.2f",frecuencia];
            
        }
    }
    UITableViewCell *cell;
    switch (indexPath.row) {
            
        case 0:
            
            cell = self.frecuencyCell;
            
            break;
    }
    
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if([self.txtFrecuency.text integerValue] != 0)
        
    {
        double frecuencia= [self.txtFrecuency.text doubleValue];
        int frecuenciaEntera=[self.txtFrecuency.text intValue];
        if(frecuencia-frecuenciaEntera == 0)
        {
            self.txtFrecuency.text= [NSString stringWithFormat:@"%d",frecuenciaEntera];
        }
        else
        {
            self.txtFrecuency.text= [NSString stringWithFormat:@"%.2f",frecuencia];
            
        }
        
    }
    
    
    
}*/



#pragma mark - UI Style

- (UIStatusBarStyle)preferredStatusBarStyle

{
    
    return UIStatusBarStyleLightContent;
    
}



@end