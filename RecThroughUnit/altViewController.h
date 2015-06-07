//
//  altViewController.h
//  RecThroughUnit
//
//  Created by KatayamaRyusuke on 2015/02/18.
//  Copyright (c) 2015年 片山隆介. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "reverbValue.h" //3/25
#import "delayValue.h"
#import "altView.h"
@class audioSetup;
@class CaptureSessionController;

@interface altViewController : UIViewController
<AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    AVAudioRecorder *avRecorder;
    AVAudioPlayer *avPlayer;
    
    NSString *portType;
    NSString *portName;
    NSArray *channels;
    //------------------------
    audioSetup *audioSetup_;
    altViewController *altAudioSetup;
    reverbValue *reverbValue_;
    delayValue *delayValue_;
    
    __weak IBOutlet UILabel *dryWetsLabel;
    __weak IBOutlet UISlider *dryWetsSlider;
    __weak IBOutlet UILabel *gainsLabel;
    __weak IBOutlet UISlider *gainsSlider;
    __weak IBOutlet UILabel *minDelayTimesLabel;
    __weak IBOutlet UISlider *minDelayTimesSlider;
    __weak IBOutlet UILabel *maxDelayTimesLabel;
    __weak IBOutlet UISlider *maxDelayTimesSlider;
    __weak IBOutlet UILabel *decayTimesAt0HzLabel;
    __weak IBOutlet UISlider *decayTimesAt0HzSlider;
    __weak IBOutlet UILabel *decayTimesAtNyquistLabel;
    __weak IBOutlet UISlider *decayTimesAtNyquistSlider;
    __weak IBOutlet UILabel *randomizeReflectionLabel;
    __weak IBOutlet UISlider *randomizeReflectionSlider;
    
    UILabel *labelForRevOne;
    UILabel *labelForRevTwo;
    UILabel *labelForRevThree;
    UILabel *labelForRevFour;
    UILabel *labelForRevFive;
    UILabel *labelForRevSix;
    UILabel *labelForRevSeven;
    UILabel *labelForDelayOne;
    UILabel *labelForDelayTwo;
    UILabel *labelForDelayThree;
    UILabel *labelForDelayFour;
    UILabel *labelForEQOne;
    UILabel *labelForEQTwo;
    UILabel *labelForEQThree;
    
    UIButton *buttonSpring;
    UIButton *buttonSummer;
    UIButton *buttonAutumn;
    UIButton *buttonWinter;
    UIButton *playOnlySpring;
    UIButton *playOnlySummer;
    UIButton *playOnlyAutumn;
    UIButton *playOnlyWinter;
    
    UILabel *playBackText;
    UILabel *playBackTextx;
    UILabel *playBackTextxx;
    UILabel *playBackTextxxx;
    
    AVAudioPlayer *Oplayer;
    AVAudioPlayer *Oplayerx;
    AVAudioPlayer *Oplayerxx;
    AVAudioPlayer *Oplayerxxx;
    
    altView *_hogeView;
}

//------------------------
//- (IBAction)didchangeDryWetMixSlider:(UISlider *)sender;
//- (IBAction)didchangeGain:(UISlider *)sender;
//- (IBAction)didchangeMinDelayTime:(UISlider *)sender;
//- (IBAction)didchangeMaxDelayTime:(UISlider *)sender;
//- (IBAction)didchangeDecayTimeAt0Hz:(UISlider *)sender;
//- (IBAction)didchangeDecayTimeAtNyquist:(UISlider *)sender;
//- (IBAction)didchangeRandomizeReflections:(UISlider *)sender;
//- (IBAction)resets;
//- (IBAction)descPort:(id)sender;
//@property (readonly) NSString *portType;

@property (nonatomic,readonly)reverbValue *reverbValue;
@property (nonatomic,readonly)delayValue *delayValue;

//capture
- (void)initCaptureSession;

@property (strong, nonatomic) UISlider *ReverbSliderOne;
@property (strong, nonatomic) UISlider *ReverbSliderTwo;
@property (strong, nonatomic) UISlider *ReverbSliderThree;
@property (strong, nonatomic) UISlider *ReverbSliderFour;
@property (strong, nonatomic) UISlider *ReverbSliderFive;
@property (strong, nonatomic) UISlider *ReverbSliderSix;
@property (strong, nonatomic) UISlider *ReverbSliderSeven;
@property (strong, nonatomic) UISlider *DelaySliderOne;
@property (strong, nonatomic) UISlider *DelaySliderTwo;
@property (strong, nonatomic) UISlider *DelaySliderthree;
@property (strong, nonatomic) UISlider *DelaySliderFour;
@property (strong, nonatomic) UISlider *EQSliderOne;
@property (strong, nonatomic) UISlider *EQSliderTwo;
@property (strong, nonatomic) UISlider *EQSliderThree;

@property (strong, nonatomic) UIButton *buttonSpring;
@property (strong, nonatomic) UIButton *buttonSummer;
@property (strong, nonatomic) UIButton *buttonAutumn;
@property (strong, nonatomic) UIButton *buttonWinter;
@property (strong, nonatomic) UIButton *playOnlySpring;
@property (strong, nonatomic) UIButton *playOnlySummer;
@property (strong, nonatomic) UIButton *playOnlyAutumn;
@property (strong, nonatomic) UIButton *playOnlyWinter;


@end

