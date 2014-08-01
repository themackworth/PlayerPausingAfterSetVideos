//
//  ViewController.m
//  PlayerPausingAfterSetVideos
//
//  Created by Mike Moscardini on 8/1/14.
//  Copyright (c) 2014 Brightcove. All rights reserved.
//

#import "ViewController.h"
#import <BCOVPlayerSDK.h>

@interface ViewController ()

@property (nonatomic, strong) id<BCOVPlaybackController> playbackController;
@property (nonatomic, strong) BCOVCatalogService *catalogService;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.playbackController = [[BCOVPlayerSDKManager sharedManager] createPlaybackControllerWithViewStrategy:[[BCOVPlayerSDKManager sharedManager] defaultControlsViewStrategy]];
    self.playbackController.view.frame = CGRectMake(0, 0, 200, 200);
    self.playbackController.autoPlay = NO;
    self.playbackController.autoAdvance = NO;
    [self.view addSubview:self.playbackController.view];

    self.catalogService = [[BCOVCatalogService alloc] initWithToken:@"nFCuXstvl910WWpPnCeFlDTNrpXA5mXOO9GPkuTCoLKRyYpPF1ikig.."];
    [self.catalogService findVideoWithVideoID:@"2149332630001" parameters:nil completion:^(BCOVVideo *video, NSDictionary *jsonResponse, NSError *error) {

        [self.playbackController setVideos:@[ video ]];
        [self.playbackController play];

    }];
}

- (IBAction)advanceToNext:(id)sender
{
    [self.playbackController pause];
    [self.playbackController setVideos:@[]];

    [self.catalogService findVideoWithVideoID:@"2149297066001" parameters:nil completion:^(BCOVVideo *video, NSDictionary *jsonResponse, NSError *error) {

        [self.playbackController setVideos:@[ video ]];
        [self.playbackController play];

    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
