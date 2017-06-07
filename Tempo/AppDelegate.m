//
//  AppDelegate.m
//  Tempo
//
//  Created by Eric Lambrecht on 2/3/17.
//  Copyright © 2017 Feed Media. All rights reserved.
//

#import "AppDelegate.h"
#import <FeedMedia.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    FMLogSetLevel(FMLogLevelDebug);
    
    [FMAudioPlayer setClientToken:@"90f50229cfb2afb166bde2066bbce0b37baefbab" secret:@"1e920462eb3412bcb1dc036fc57aa64f03f3d50f"];
    
    FMAudioPlayer *player = [FMAudioPlayer sharedPlayer];
    [player whenAvailable:^{
        player.crossfadeInEnabled = YES;
        player.secondsOfCrossfade = 6.0;
        
    } notAvailable:^{
        // nada
    }];
    
    return YES;
}

@end
