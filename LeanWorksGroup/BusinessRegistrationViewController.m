//
//  BusinessRegistrationViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 18/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "BusinessRegistrationViewController.h"
#import "RoketFetcher.h"
#import "CustomAlertViewController.h"

@interface BusinessRegistrationViewController ()

@end

@implementation BusinessRegistrationViewController

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
    self.buttonRegister.layer.borderWidth = 1.0f;
    self.buttonRegister.layer.cornerRadius = 7.0f;
    self.buttonRegister.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
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

- (IBAction)btnSave:(id)sender {
    
    if(![self validationEmpty]){
        return;
    }
    
    if(![self.txtPassword.text isEqualToString:self.txtPasswordConfirm.text]){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Las contraseñas no coinciden",nil);
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    if(![RoketFetcher CheckConnection]){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"No hay conexión a Internet. Revisa tu conexión y vuelve a intentarlo.",nil);
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    NSMutableDictionary *dicQuery = [[NSMutableDictionary alloc]init];

    [dicQuery setObject:self.txtUserName.text forKey:@"username"];
    [dicQuery setObject:self.txtPassword.text forKey:@"password"];
    [dicQuery setObject:self.txtEmail.text forKey:@"email"];
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("fetchDayeList", NULL);
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake([[UIScreen mainScreen] applicationFrame].size.width/2.0, [[UIScreen mainScreen] applicationFrame].size.height/2.0)]; // I do this because I'm in landscape mode
    spinner.color =[UIColor blackColor];
    [self.view addSubview:spinner]; // spinner is not visible until started
    [spinner startAnimating];
    
    dispatch_async(downloadQueue, ^{
      NSDictionary *dicResult = [RoketFetcher executeSaveAccount:dicQuery];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *alertMsg;
            if(dicResult){
                if([[dicResult objectForKey:@"succes"] isEqualToString:@"1"]){
                    alertMsg = [NSString stringWithFormat:NSLocalizedString(@"se registro con exito el usuario: %@",nil),self.txtUserName.text];
                }else{
                    alertMsg = [dicResult objectForKey:@"message"];//[NSString stringWithFormat:@" hubo un error al registrar el usuario %@ por favor intener mas tarde",self.txtUserName.text];
                }
            }else{
                alertMsg = NSLocalizedString(@"No se pudo conectar con el servidor, intente mas tarde",nil);
            }
            CustomAlertViewController* vc = [CustomAlertViewController new];
            vc.text = alertMsg;
            [self presentViewController:vc animated:YES completion:nil];

            [spinner stopAnimating];
        });
    });

    
    
}

#pragma mark - Validations
- (BOOL)validateOnSaveTextField:(UITextField*)textfield NoEmpty:(BOOL)empty withRegularExpression:(NSString*)regex AndText:(NSString*)text {
    if ([text isEqualToString:@""]) {
        [textfield setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textfield setTintColor:[UIColor redColor]];
        [textfield setTextColor:[UIColor redColor]];
        NSLog(@"no valido empty");
        return NO;
    } else {
        NSLog(@"regex: %@", regex);
        if ([self validateString:text withPattern:regex] == NO) {
            [textfield setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
            [textfield setTintColor:[UIColor redColor]];
            [textfield setTextColor:[UIColor redColor]];
            NSLog(@"no valido regex");
            return NO;
        }
        else {
            [textfield setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
            [textfield setTintColor:[UIColor blackColor]];
            [textfield setTextColor:[UIColor blackColor]];
            NSLog(@"valido");
            return YES;
        }
    }
}

- (BOOL)validateString:(NSString *)string withPattern:(NSString *)pattern
{
    
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSAssert(regex, @"Unable to create regular expression");
    
    NSRange textRange = NSMakeRange(0, string.length);
    NSRange matchRange = [regex rangeOfFirstMatchInString:string options:NSMatchingReportProgress range:textRange];
    
    BOOL didValidate = NO;
    
    // Did we find a matching range
    if (matchRange.location != NSNotFound)
        didValidate = YES;
    
    return didValidate;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];


    if (textField == self.txtEmail) {
        [self validateOnSaveTextField:textField NoEmpty:YES withRegularExpression:@"^[_a-zA-Z0-9-]+(\\.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*(\\.[a-zA-Z]{2,4})$" AndText:text];
        
        if(range.location == 50){
            if ([self.txtEmail.text length] >= 50) {
                self.txtEmail.text = [self.txtEmail.text substringToIndex:50];
                NSLog(@"calling Limit input");
                [self.txtEmail setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
                [self.txtEmail setTintColor:[UIColor redColor]];
                return NO;
            }
        }
    }
    return YES;
}


-(BOOL)validationEmpty{
    
    BOOL valido = YES;
    if([self.txtUserName.text isEqualToString:@""]){
        valido = NO;
        [self.txtUserName setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    if([self.txtName.text isEqualToString:@""]){
        valido = NO;
        [self.txtName setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    if([self.txtPassword.text isEqualToString:@""]){
        valido = NO;
        [self.txtPassword setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    if([self.txtPasswordConfirm.text isEqualToString:@""]){
        valido = NO;
        [self.txtPasswordConfirm setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    if([self.txtEmail.text isEqualToString:@""]){
        valido = NO;
        [self.txtEmail setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    if(!valido){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Los campos marcados en rojo son obligatorios",nil);
        [self presentViewController:vc animated:YES completion:nil];
        return  valido;
    }
    if(![self validateOnSaveTextField:self.txtEmail NoEmpty:YES withRegularExpression:@"^[_a-zA-Z0-9-]+(\\.[_a-zA-Z0-9-]+)*@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*(\\.[a-zA-Z]{2,4})$" AndText:self.txtEmail.text]
       ){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"El correo electronico no es valido",nil);
        [self presentViewController:vc animated:YES completion:nil];
        return NO;
    }
    return YES;
}

#pragma mark - TableViewRegister

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            cell = self.nameCell;
            break;
        case 1:
            cell = self.usernameCell;
            break;
        case 2:
            cell = self.passwordCell;
            break;
        case 3:
            cell = self.ConfirmPasswordCell;
            break;
        case 4:
            cell = self.emailCell;
            break;
        case 5:
            cell = self.buttonRegisterCell;
            break;
        }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
}

#pragma mark - UIStyle

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
