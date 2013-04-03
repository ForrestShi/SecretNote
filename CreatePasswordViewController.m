//
//  CreatePasswordViewController.m
//  SecretNote
//
//  Created by Shi Lin on 4/2/13.
//  Copyright (c) 2013 DFA. All rights reserved.
//

#import "CreatePasswordViewController.h"
#import "AppSetting.h"


@interface CreatePasswordViewController ()<UITextFieldDelegate>

@end

@implementation CreatePasswordViewController

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
    // Do any additional setup after loading the view from its nib.
    self.wrongPwdLabel.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField           // became first responder
{
    textField.textColor = [UIColor blackColor];
    if (textField == self.pwdField2 || textField == self.pwdField1 ) {
        textField.secureTextEntry = YES;
        self.wrongPwdLabel.hidden = YES;
    }
    
    if (textField == self.emailField ) {
        [UIView animateWithDuration:0.5 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, -216);
        }];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField            // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
{
    if (textField == self.pwdField2 ) {
        if (![self.pwdField2.text isEqualToString:self.pwdField1.text] && textField.text.length > 0 ) {
            [UIView animateWithDuration:0.5 animations:^{
                self.pwdField2.textColor = [UIColor lightGrayColor];
            }];
            self.wrongPwdLabel.hidden = NO;
        }
    }
    
    if (textField == self.emailField ) {
        [UIView animateWithDuration:0.5 animations:^{
            self.view.transform = CGAffineTransformIdentity;
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)finishCreatingPassword:(id)sender{
    if ([self.pwdField1.text isEqualToString:self.pwdField2.text] && self.pwdField2.text.length > 0 ) {
        [AppSetting savePassword:self.pwdField2.text emailAddress:self.emailField.text];
        [AppSetting setupPassword];
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

@end
