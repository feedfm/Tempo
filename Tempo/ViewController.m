//
//  ViewController.m
//  Tempo
//
//  Created by Eric Lambrecht on 2/3/17.
//  Copyright © 2017 Feed Media. All rights reserved.
//

#import "ViewController.h"
#import <FeedMedia/FeedMedia.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIStackView *stationContainer;
@property (weak, nonatomic) IBOutlet UITextField *crossfadeSeconds;
@property (weak, nonatomic) IBOutlet UISwitch *fadeInSwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FMAudioPlayer *player = [FMAudioPlayer sharedPlayer];
    [player whenAvailable:^{
        NSLog(@"available!");
        
        player.disableSongStartNotifications = YES;
        
        player.crossfadeInEnabled = YES;
        [_fadeInSwitch setOn:player.crossfadeInEnabled];

        player.secondsOfCrossfade = 6.0;
        _crossfadeSeconds.text = [NSString stringWithFormat:@"%.1f", player.secondsOfCrossfade];
        
        for (FMStation *station in player.stationList) {
            FMPlayPauseButton *button = [[FMPlayPauseButton alloc] init];
            button.station = station;
            button.crossfade = YES;
            
            [button setTitle:station.name forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

            [button setTitleColor:button.tintColor forState:UIControlStateSelected];
            
            [_stationContainer addArrangedSubview:button];
        }
        
    } notAvailable:^{
        // nada
    }];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:_crossfadeSeconds action:@selector(resignFirstResponder)];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    toolbar.items = [NSArray arrayWithObject:barButton];
    
    _crossfadeSeconds.inputAccessoryView = toolbar;
/*
    // copy the text shown in non-highlighted button configs to the highlighted config
    [_warmUpButton setTitle:[_warmUpButton titleForState:UIControlStateNormal]
                   forState:UIControlStateNormal | UIControlStateHighlighted];
    [_warmUpButton setTitle:[_warmUpButton titleForState:UIControlStateSelected]
                   forState:UIControlStateSelected | UIControlStateHighlighted];

    [_highIntensityButton setTitle:[_highIntensityButton titleForState:UIControlStateNormal]
                   forState:UIControlStateNormal | UIControlStateHighlighted];
    [_highIntensityButton setTitle:[_highIntensityButton titleForState:UIControlStateSelected]
                   forState:UIControlStateSelected | UIControlStateHighlighted];

    [_coolDownButton setTitle:[_coolDownButton titleForState:UIControlStateNormal]
                   forState:UIControlStateNormal | UIControlStateHighlighted];
    [_coolDownButton setTitle:[_coolDownButton titleForState:UIControlStateSelected]
                   forState:UIControlStateSelected | UIControlStateHighlighted];
*/
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (IBAction)crossfadeTimeShouldChange:(id)sender {
    FMAudioPlayer *player = [FMAudioPlayer sharedPlayer];

    player.secondsOfCrossfade = [_crossfadeSeconds.text floatValue];
    
    NSLog(@"crossfade seconds set to %f", player.secondsOfCrossfade);
}

- (IBAction)fadeInShouldChange:(id)sender {
    FMAudioPlayer *player = [FMAudioPlayer sharedPlayer];

    player.crossfadeInEnabled = [_fadeInSwitch isOn];
    
    NSLog(@"crossfade in set to %u", player.crossfadeInEnabled);
}

@end
