//
//  PasswordViewController.h
//  SecretNote
//
//  Created by Shi Lin on 4/2/13.
//  Copyright (c) 2013 DFA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordViewController : UIViewController
@property(nonatomic,weak) IBOutlet UITextField *passwordField;
@property(nonatomic,weak) IBOutlet UIView *containerView;

-(IBAction)enter:(id)sender;
-(IBAction)forgotPwd:(id)sender;

@end
