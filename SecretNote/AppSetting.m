//
//  AppSetting.m
//  SecretNote
//
//  Created by Shi Lin on 4/2/13.
//  Copyright (c) 2013 DFA. All rights reserved.
//

#import "AppSetting.h"

@implementation AppSetting

+ (BOOL)haveSetupPassword{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"create_pwd"];
}

+ (void)setupPassword{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"create_pwd"];
    [[NSUserDefaults standardUserDefaults] synchronize];  
}

+ (void)savePassword:(NSString*)pwd emailAddress:(NSString*)ea{
    [[NSUserDefaults standardUserDefaults] setValue:pwd forKey:@"pwd"];
    [[NSUserDefaults standardUserDefaults] setValue:ea forKey:@"email"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString*)whatisPassword{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"pwd"];
}

+ (BOOL)isPasswordCorrect:(NSString*)pwd{
    if (pwd && [pwd isEqualToString:[AppSetting whatisPassword]]) {
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)shouldShowPasswordView{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"need_show"];
}

+ (void)needShowPasswordViewNextTime{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"need_show"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
