//
//  CreatePasswordViewController.h
//  SecretNote
//
//  Created by Shi Lin on 4/2/13.
//  Copyright (c) 2013 DFA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreatePasswordViewController : UIViewController

@property (nonatomic,weak) IBOutlet UITextField *pwdField1;
@property (nonatomic,weak) IBOutlet UITextField *pwdField2;
@property (nonatomic,weak) IBOutlet UITextField *emailField;
@property (nonatomic,weak) IBOutlet UILabel     *wrongPwdLabel;

- (IBAction)finishCreatingPassword:(id)sender;

@end
