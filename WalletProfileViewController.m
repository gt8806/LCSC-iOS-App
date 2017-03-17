//
//  WalletProfileViewController.m
//  LCSC
//
//  Created by Janey Valerio on 2/27/17.
//  Copyright © 2017 LCSC. All rights reserved.
//

#import "WalletProfileViewController.h"
#import "LCSC-Swift.h"

@interface WalletProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameDisplay;
@property (weak, nonatomic) IBOutlet UITextField *passwordDisplay;
@property (strong, nonatomic) Authentication *auth;
@property (strong, nonatomic) UIAlertView *alert;


@end

@implementation WalletProfileViewController

- (void)changeDisplaytext:(NSString*)newLogin andPassword:(NSString*)newPassword{
	_usernameDisplay.text = newLogin;
	_passwordDisplay.text = newPassword;
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.passwordDisplay.delegate = self;

    // Do any additional setup after loading the view.
	
	UIImage *img = [[UIImage alloc] init];
	img = [UIImage imageNamed:@"backgroundCollor"];
	self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:img];
	
	_auth = [[Authentication alloc] init];
	
	NSString *username = [_auth getWarriorWalletUsername];
	NSString *password = [_auth getWarriorWalletPassword];
	[self changeDisplaytext:username andPassword:password];
}

-(void)bttTouched{
	
	[self performSegueWithIdentifier:@"pointsBackToMenu" sender:self];
}

//clean the WW profile after tapping clear
- (IBAction)clearTapped:(id)sender {
	[_auth clearWarriorWalletProfile];
	[self changeDisplaytext:@"" andPassword:@""];
}


//Set the profile if it is valid
- (IBAction)signingTapped:(id)sender {
	if ([_auth setProfile:@"warriorWallet" newLogin:_usernameDisplay.text newPassword:_passwordDisplay.text]){
		NSString *newLogin = [_auth getWarriorWalletUsername];
		NSString *newPassword = [_auth getWarriorWalletPassword];
		[self changeDisplaytext:newLogin andPassword:newPassword];
		_alert = [[UIAlertView alloc] init];
		_alert.title = @"Success!";
		_alert.message = @"Your Warrior Wallet username and password were saved.";
		_alert.delegate = self;
		[_alert addButtonWithTitle:@"Ok"];
		[_alert show];
		[self.navigationController popViewControllerAnimated:YES];
	} else {
		_alert = [[UIAlertView alloc] init];
		_alert.title = @"Fail!";
		_alert.message = @"Your username or password have invalid input.";
		_alert.delegate = self;
		[_alert addButtonWithTitle:@"Ok"];
		[_alert show];
	}
	[_usernameDisplay endEditing:YES];
	[_passwordDisplay endEditing:YES];
	
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	if (![_auth setProfile:@"warriorWallet" newLogin:_usernameDisplay.text newPassword:_passwordDisplay.text]){
		NSString *newLogin = [_auth getWarriorWalletUsername];
		NSString *newPassword = [_auth getWarriorWalletPassword];
		[self changeDisplaytext:newLogin andPassword:newPassword];
	}
}


-(BOOL)textFieldShouldReturn:(UITextField *)passwordDisplay
{
	[self signingTapped:self];
	return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
