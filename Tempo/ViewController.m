//
//  ViewController.m
//  Tempo
//
//  Created by Eric Lambrecht on 2/3/17.
//  Copyright © 2017 Feed Media. All rights reserved.
//

#import "ViewController.h"
#import <FeedMedia/FeedMediaUI.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet FMPlayPauseButton *warmUpButton;
@property (weak, nonatomic) IBOutlet FMPlayPauseButton *highIntensityButton;
@property (weak, nonatomic) IBOutlet FMPlayPauseButton *coolDownButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    [self updateButtonStates];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stationChanged:) name:FMAudioPlayerActiveStationDidChangeNotification object:[FMAudioPlayer sharedPlayer]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)stationChanged:(NSNotification *) notification {
    [self updateButtonStates];
}

- (void)updateButtonStates {
    FMAudioPlayer *player = [FMAudioPlayer sharedPlayer];
    
    if (_warmUpButton.station && (_warmUpButton.station == player.activeStation)) {
        _warmUpButton.highlighted = YES;
    } else {
        _warmUpButton.highlighted = NO;
    }

    if (_highIntensityButton.station && (_highIntensityButton.station == player.activeStation)) {
        _highIntensityButton.highlighted = YES;
    } else {
        _highIntensityButton.highlighted = NO;
    }

    if (_coolDownButton.station && (_coolDownButton.station == player.activeStation)) {
        _coolDownButton.highlighted = YES;
    } else {
        _coolDownButton.highlighted = NO;
    }

}

@end
