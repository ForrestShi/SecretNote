//
//  PasswordViewController.m
//  SecretNote
//
//  Created by Shi Lin on 4/2/13.
//  Copyright (c) 2013 DFA. All rights reserved.
//

#import "PasswordViewController.h"
#import "AppSetting.h"
#import <QuartzCore/QuartzCore.h>

@interface PasswordViewController ()<UITextFieldDelegate>
@end

@implementation PasswordViewController
@synthesize passwordField;

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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [self.view addGestureRecognizer:tap];
    
    self.enterButton.enabled = NO;
    self.sendPwdButton.alpha = 0;
}

- (void)onTap{
    [self.passwordField resignFirstResponder];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//http://stackoverflow.com/questions/10294451/animating-uitextfield-to-indicate-a-wrong-password

-(void)shakeAnimation:(UIView*) view {
    const int reset = 5;
    const int maxShakes = 6;
    
    //pass these as variables instead of statics or class variables if shaking two controls simultaneously
    static int shakes = 0;
    static int translate = reset;
    
    
    [UIView animateWithDuration:(0.09-(shakes*.01)) // reduce duration every shake from .09 to .04
                          delay:0.01f//edge wait delay
                        options:(enum UIViewAnimationOptions) UIViewAnimationCurveEaseInOut
                     animations:^{
                         view.transform = CGAffineTransformMakeTranslation(translate, 0);
                         
                     }
                     completion:^(BOOL finished){
                         if(shakes < maxShakes){
                             shakes++;
                             
                             //throttle down movement
                             if (translate>0)
                                 translate--;
                             
                             //change direction
                             translate*=-1;
                             [self shakeAnimation:view];
                         } else {
                             view.transform = CGAffineTransformIdentity;
                             shakes = 0;//ready for next time
                             translate = reset;//ready for next time
                             return;
                         }
                     }];
}

int direction = 1;
int offset = 16;
int shakes = 0;

- (void)shakeView:(UIView*)shakedView{
    
    [UIView animateWithDuration:(0.09 - .01*shakes ) delay:.01 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //        
        //shakedView.transform = CGAffineTransformConcat(shakedView.transform, CGAffineTransformMakeTranslation(offset * direction, 0));
        
        shakedView.transform = CGAffineTransformMakeTranslation(offset * direction, 0);
    
    } completion:^(BOOL finished) {
    
        shakes++;
        offset--;
        direction *= -1;
        
        if (shakes > 8 ) {
            shakes = 0;
            offset = 16;
            direction = 1;
            
            shakedView.transform = CGAffineTransformIdentity;
            return ;
            
        }else{
            [self shakeView:shakedView];
        }
    }];
}

static int wrongPwdTimers = 0;

-(IBAction)enter:(id)sender{
        
    if ([AppSetting isPasswordCorrect:self.passwordField.text]) {
        //correct
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else{
        wrongPwdTimers ++;
        
        if (wrongPwdTimers > 5 ) {
            wrongPwdTimers = 0;
            
            [UIView animateWithDuration:0.3 animations:^{
                self.sendPwdButton.alpha = 1.;
                self.sendPwdButton.hidden = NO;
                self.containerView.alpha = 0;
                
            } completion:^(BOOL finished) {
            }];            
            return;
        }
        [UIMenuController sharedMenuController].menuVisible = NO;
        [self.passwordField selectAll:nil];
        [self.passwordField setClearsOnBeginEditing:YES];
        //[self shakeAnimation:self.containerView];
        [self shakeView:self.containerView];
    }
}
-(IBAction)forgotPwd:(id)sender{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.containerView.alpha = 1.;
        self.sendPwdButton.alpha = 0.;
    } completion:^(BOOL finished) {
    }];

    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    [UIView animateWithDuration:.3 animations:^{
//        self.view.transform = CGAffineTransformMakeTranslation(0., -216/2);
//    } completion:^(BOOL finished) {
//        
//    }];
    
    self.enterButton.enabled = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
//    [UIView animateWithDuration:.3 animations:^{
//        self.view.transform = CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//        
//    }];

    if (textField.text && textField.text.length > 0 ) {
            self.enterButton.enabled = YES;
    }else{
        self.enterButton.enabled = NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self enter:nil];
    return YES;
}

@end
