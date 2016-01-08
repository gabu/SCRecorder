//
//  SCFilterImageViewController.m
//  SCRecorderExamples
//
//  Created by Shoya Tsukada on 2016/01/04.
//
//

#import "SCFilterImageViewController.h"
#import "SCRecorder.h"

@interface SCFilterImageViewController ()

@property (weak, nonatomic) IBOutlet SCFilterImageView *videoView;

@property SCRecordSession *recordSession;
@property SCPlayer *player;

@end

@implementation SCFilterImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.recordSession = SCRecordSession.new;
    self.recordSession.fileType = AVFileTypeMPEG4;
    
    self.player = SCPlayer.new;
    self.player.loopEnabled = true;
    self.player.SCImageView = self.videoView;
    
    [PHImageManager.new requestAVAssetForVideo:self.videoAsset options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        
        [self.recordSession addSegment:[SCRecordSessionSegment segmentWithURL:((AVURLAsset *)asset).URL info:nil]];
        [self.player setItemByAsset:[self.recordSession assetRepresentingSegments]];
        [self.player play];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
