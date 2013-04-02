//
//  AppSetting.h
//  SecretNote
//
//  Created by Shi Lin on 4/2/13.
//  Copyright (c) 2013 DFA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSetting : NSObject

+ (BOOL)haveSetupPassword;
+ (void)setupPassword;

+ (void)savePassword:(NSString*)pwd;
+ (NSString*)whatisPassword;

+ (BOOL)isPasswordCorrect;

+ (BOOL)shouldShowPasswordView;
+ (void)needShowPasswordViewNextTime;

@end
