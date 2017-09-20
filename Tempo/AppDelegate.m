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
    
    [FMAudioPlayer setClientToken:@"86b7e0832777e079716f921ef577bd1ca0fc5f31" secret:@"fa10a06be0fddf7039edbb53b4b5f3b04a43767c"];
    
    return YES;
}

@end
