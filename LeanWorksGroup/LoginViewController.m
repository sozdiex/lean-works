//
//  LoginViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 18/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "LoginViewController.h"
#import "CompanySectorViewController.h"
#import "BusinessRegistrationViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "RoketFetcher.h"
#import "CustomAlertViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.buttonLogin.layer.borderWidth = 1.0f;
    self.buttonLogin.layer.cornerRadius = 7.0f;
    self.buttonLogin.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuView"];
    }
    
    self.txtUser.placeholder = NSLocalizedString(@"usuario", nil);
    self.txtPassWord.placeholder = NSLocalizedString(@"contra", nil);
    self.buttonLogin.titleLabel.text = NSLocalizedString(@"btnIniciarSesion", nil);
    [self.buttonLogin setTitle:NSLocalizedString(@"btnIniciarSesion", nil) forState:UIControlStateNormal];
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)showMenu:(id)sender {
   [self.slidingViewController anchorTopViewTo:ECRight];
}
- (IBAction)loginSinUsuario:(id)sender {
    CompanySectorViewController *csvc = [self.storyboard instantiateViewControllerWithIdentifier:@"CompanySectorView"];
    NSMutableDictionary *dicPareto = [[NSMutableDictionary alloc]init];
    [dicPareto setObject:[NSNumber numberWithBool:NO] forKey:@"TypeUsser"];
    [dicPareto setObject:@"0" forKey:@"EstatusGuardado"];
    csvc.dicPareto = dicPareto;
    self.slidingViewController.topViewController = csvc;
}

- (IBAction)login:(id)sender {
    
    if(![RoketFetcher CheckConnection]){
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"No hay conexión a Internet. Revisa tu conexión y vuelve a intentarlo",nil);
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    if(![self validationEmpty]){
        return;
    }
    
    NSMutableDictionary *myDicQuery = [[NSMutableDictionary alloc]init];
    [myDicQuery setObject:self.txtUser.text forKey:@"username"];
    [myDicQuery setObject:self.txtPassWord.text forKey:@"password"];
    
    
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("fetchDayeList", NULL);
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake([[UIScreen mainScreen] applicationFrame].size.width/2.0, [[UIScreen mainScreen] applicationFrame].size.height/2.0)]; // I do this because I'm in landscape mode
    spinner.color =[UIColor blackColor];
    [self.view addSubview:spinner]; // spinner is not visible until started
    [spinner startAnimating];
    
    dispatch_async(downloadQueue, ^{
            NSDictionary *dicResult = [RoketFetcher loginAccoun:myDicQuery];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(dicResult){
                if([[dicResult objectForKey:@"success"] boolValue]){
                    CompanySectorViewController *csvc = [self.storyboard instantiateViewControllerWithIdentifier:@"CompanySectorView"];
                    
                    NSMutableDictionary *dicPareto = [[NSMutableDictionary alloc]init];
                    //[dicPareto setObject:[NSNumber numberWithBool:YES] forKey:@"TypeUsser"];
                    [dicPareto setObject:@"0" forKey:@"EstatusGuardado"];
                    csvc.dicPareto = dicPareto;
                    
                    self.slidingViewController.topViewController = csvc;
                }else{
                    CustomAlertViewController* vc = [CustomAlertViewController new];
                    vc.text = [dicResult objectForKey:@"message"];
                    [self presentViewController:vc animated:YES completion:nil];
                }
            }else{
                CustomAlertViewController* vc = [CustomAlertViewController new];
                vc.text = NSLocalizedString(@"No se pudo conectar con el servidor, intente mas tarde",nil);
                [self presentViewController:vc animated:YES completion:nil];
            }

            [spinner stopAnimating];
        });
    });
}

- (IBAction)btnAccountRegistration:(id)sender {
    
    BusinessRegistrationViewController *brvc = [self.storyboard instantiateViewControllerWithIdentifier:@"BusinessRegistrationView"];
    [self presentViewController:brvc animated:YES completion:nil];
}

#pragma mark - Validations
-(BOOL)validationEmpty{
    
    BOOL valido = YES;
    if([self.txtUser.text isEqualToString:@""]){
        valido = NO;
        [self.txtUser setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
    if([self.txtPassWord.text isEqualToString:@""]){
        valido = NO;
        [self.txtPassWord setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    }
        if(!valido){
            CustomAlertViewController* vc = [CustomAlertViewController new];
            vc.text = NSLocalizedString(@"Los campos marcados en rojo son obligatorios",nil);
            [self presentViewController:vc animated:YES completion:nil];
    }
    return  valido;
}


#pragma mark - TableViewLogin
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            cell = self.userCell;
            break;
        case 1:
            cell = self.passwordCell;
            break;
        case 2:
            cell = self.buttonLoginCell;
            break;
        case 3:
            cell = self.buttonsCell;
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
}

@end
