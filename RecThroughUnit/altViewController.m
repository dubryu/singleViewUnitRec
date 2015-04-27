//
//  altViewController.m
//  RecThroughUnit
//
//  Created by KatayamaRyusuke on 2015/02/18.
//  Copyright (c) 2015年 片山隆介. All rights reserved.
//

#import "altViewController.h"
#import "audioSetup.h"
#import "CaptureSessionController.h"

@interface altViewController ()
- (void)updateUI;

//@property (readwrite ,nonatomic ) IBOutlet UIButton *startButton;
//@property (readwrite ,nonatomic ) IBOutlet UILabel *playBackText;
@property (nonatomic, strong   ) IBOutlet CaptureSessionController *captureSessionController;
- (void)buttonAction:(id)sender;

@end

@implementation altViewController

@synthesize ReverbSliderOne,ReverbSliderTwo,ReverbSliderThree,ReverbSliderFour,ReverbSliderFive,ReverbSliderSix,ReverbSliderSeven;
@synthesize DelaySliderOne,DelaySliderTwo,DelaySliderthree,DelaySliderFour;
@synthesize buttonSpring,buttonSummer,buttonAutumn,buttonWinter,playOnlySpring,playOnlySummer,playOnlyAutumn,playOnlyWinter;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIImage *greenImage = [[UIImage imageNamed:@"green_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
//    UIImage *redImage = [[UIImage imageNamed:@"red_button.png"] stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
//    UIImage *reverbMax = [[UIImage imageNamed:@"reverbMax" ]stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
//    UIImage *reverbMin = [[UIImage imageNamed:@"reverbMin" ]stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
    //trying resizableImageWithCapInsets
//    UIEdgeInsets insets = UIEdgeInsetsMake(16, 6, 16, 6);
//    UIImage *delayMax = [[UIImage imageNamed:@"delayMax"]resizableImageWithCapInsets:insets];
//    UIImage *delayMin = [[UIImage imageNamed:@"delayMin"] resizableImageWithCapInsets:insets];
    UIImage *reverbMaxSl = [[UIImage imageNamed:@"reverbMaxSl"]stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
    UIImage *reverbMinSl = [[UIImage imageNamed:@"reverbMinSl"]stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
    UIImage *delayMaxSl = [[UIImage imageNamed:@"delayMaxSl"]stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
    UIImage *delayMinSl = [[UIImage imageNamed:@"delayMinSl"]stretchableImageWithLeftCapWidth:12.0 topCapHeight:0.0];
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    UIImage *backR = [[UIImage imageNamed:@"backColorReverb.png"]resizableImageWithCapInsets:edgeInsets];
    UIImage *backD = [[UIImage imageNamed:@"backColorDelay.png"]resizableImageWithCapInsets:edgeInsets];
    //view for effect label
    CGRect rect = CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height*11/15, self.view.frame.size.width*3/8, self.view.frame.size.height*4/15);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    imageView.image = [UIImage imageNamed:@"reverbTitle"];
    [self.view addSubview:imageView];
    //reverb slider back ground
    CGRect backRect = CGRectMake(self.view.frame.size.width/4, 20, self.view.frame.size.width*3/4, self.view.frame.size.height*7/15);
    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:backRect];
    backImageView.image = backR;
    [self.view addSubview:backImageView];
    //view for delay label
    CGRect rectTwo = CGRectMake(self.view.frame.size.width*5/8, self.view.frame.size.height*11/15, self.view.frame.size.width*3/8, self.view.frame.size.height*4/15);
    UIImageView *imageViewTwo = [[UIImageView alloc]initWithFrame:rectTwo];
    imageViewTwo.image = [UIImage imageNamed:@"delayTitle"];
    [self.view addSubview:imageViewTwo];
    //delay slider back ground
    CGRect backRectD = CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height*7/15+20, self.view.frame.size.width*3/4, self.view.frame.size.height*4/15);
    UIImageView *backImageViewD = [[UIImageView alloc]initWithFrame:backRectD];
    backImageViewD.image = backD;
    [self.view addSubview:backImageViewD];
    //delay slider back ground
//    CGRect backRect = CGRectMake(self.view.frame.size.width/4, 20, self.view.frame.size.width*3/8, self.view.frame.size.height*6/15);
//    UIImageView *backImageView = [[UIImageView alloc]initWithFrame:backRect];
//    backImageView.image = [UIImage imageNamed:@"backColorReverb"];
//    [self.view addSubview:backImageView];
    
//    [self.startButton setBackgroundImage:greenImage forState:UIControlStateNormal];
//    [self.startButton setBackgroundImage:redImage forState:UIControlStateSelected];
#pragma SliderAndLabel for reverb

    UIColor *colorForReverb = [UIColor colorWithRed:0.2 green:0.0 blue:0.4 alpha:0.1];
    ReverbSliderOne.backgroundColor = colorForReverb;
    
    ReverbSliderOne = [[UISlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4,20,self.view.frame.size.width*3/4,self.view.frame.size.height/15)];
    [ReverbSliderOne setMaximumTrackImage:reverbMaxSl forState:UIControlStateNormal];
    [ReverbSliderOne setMinimumTrackImage:reverbMinSl forState:UIControlStateNormal];
    [ReverbSliderOne setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    ReverbSliderOne.maximumValue = 100;
    [self.view addSubview:ReverbSliderOne];
    [ReverbSliderOne addTarget:self action:@selector(didchangeDryWetMixSlider:)forControlEvents:UIControlEventValueChanged];
    //label assciated with changing from slider
    labelForRevOne = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*3/4-20,20,50,15)];
    [self.view addSubview:labelForRevOne];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3/4-200,20,200,15)];
    [titleLabel setText:@"reverbDryWet"];
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    //reverbGain
    ReverbSliderTwo.backgroundColor = colorForReverb;
    ReverbSliderTwo = [[UISlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height/15+20, self.view.frame.size.width*3/4 , self.view.frame.size.height*1/15)];
    [ReverbSliderTwo setMaximumTrackImage:reverbMaxSl forState:UIControlStateNormal];
    [ReverbSliderTwo setMinimumTrackImage:reverbMinSl forState:UIControlStateNormal];
    [ReverbSliderTwo setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    ReverbSliderTwo.maximumValue = 20;
    ReverbSliderTwo.minimumValue = -20;
    [self.view addSubview:ReverbSliderTwo];
    [ReverbSliderTwo addTarget:self action:@selector(didchangeGain:)forControlEvents:UIControlEventValueChanged];
    //label assciated with changing from slider
    labelForRevTwo = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*3/4-20,self.view.frame.size.height/15+20,50,15)];
    [self.view addSubview:labelForRevTwo];
    UILabel *titleLabelGain = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3/4-200,self.view.frame.size.height/15+20,200,15)];
    [titleLabelGain setText:@"reverbGain"];
    titleLabelGain.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabelGain];
    //reverbMin
    ReverbSliderThree = [[UISlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height*2/15+20, self.view.frame.size.width*3/4, self.view.frame.size.height/15)];
    ReverbSliderThree.backgroundColor = colorForReverb;
    [ReverbSliderThree setMaximumTrackImage:reverbMaxSl forState:UIControlStateNormal];
    [ReverbSliderThree setMinimumTrackImage:reverbMinSl forState:UIControlStateNormal];
    [ReverbSliderThree setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    ReverbSliderThree.maximumValue = 1;
    ReverbSliderThree.minimumValue = 0.0001;
    [self.view addSubview:ReverbSliderThree];
    [ReverbSliderThree addTarget:self action:@selector(didchangeMinDelayTime:)forControlEvents:UIControlEventValueChanged];
    //label assciated with changing from slider
    labelForRevThree = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*3/4-20,self.view.frame.size.height*2/15+20,50,15)];
    [self.view addSubview:labelForRevThree];
    UILabel *titleLabelMinDel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3/4-200,self.view.frame.size.height*2/15+20,200,15)];
    [titleLabelMinDel setText:@"reverbMinDelay"];
    titleLabelMinDel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabelMinDel];
    //reverbMax
    ReverbSliderFour = [[UISlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height*3/15+20, self.view.frame.size.width*3/4, self.view.frame.size.height/15)];
    ReverbSliderFour.backgroundColor = colorForReverb;
    [ReverbSliderFour setMaximumTrackImage:reverbMaxSl forState:UIControlStateNormal];
    [ReverbSliderFour setMinimumTrackImage:reverbMinSl forState:UIControlStateNormal];
    [ReverbSliderFour setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    ReverbSliderFour.maximumValue = 1;
    ReverbSliderFour.minimumValue = 0.0001;
    [self.view addSubview:ReverbSliderFour];
    [ReverbSliderFour addTarget:self action:@selector(didchangeMaxDelayTime:)forControlEvents:UIControlEventValueChanged];
    //label assciated with changing from slider
    labelForRevFour = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*3/4-20,self.view.frame.size.height*3/15+20,50,15)];
    [self.view addSubview:labelForRevFour];
    UILabel *titleLabelMaxDel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3/4-200,self.view.frame.size.height*3/15+20,200,15)];
    [titleLabelMaxDel setText:@"reverbMaxDeley"];
    titleLabelMaxDel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabelMaxDel];
    //decayAt0Hz
    ReverbSliderFive = [[UISlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height*4/15+20, self.view.frame.size.width*3/4, self.view.frame.size.height/15)];
    ReverbSliderFive.backgroundColor = colorForReverb;
    [ReverbSliderFive setMaximumTrackImage:reverbMaxSl forState:UIControlStateNormal];
    [ReverbSliderFive setMinimumTrackImage:reverbMinSl forState:UIControlStateNormal];
    [ReverbSliderFive setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    ReverbSliderFive.maximumValue = 20;
    ReverbSliderFive.minimumValue = 0.001;
    [self.view addSubview:ReverbSliderFive];
    [ReverbSliderFive addTarget:self action:@selector(didchangeDecayTimeAt0Hz:)forControlEvents:UIControlEventValueChanged];
    //label assciated with changing from slider
    labelForRevFive = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*3/4-20,self.view.frame.size.height*4/15+20,50,15)];
    [self.view addSubview:labelForRevFive];
    UILabel *titleLabelDecayAtZero = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3/4-200,self.view.frame.size.height*4/15+20,200,15)];
    [titleLabelDecayAtZero setText:@"reverbDecayAt0hz"];
    titleLabelDecayAtZero.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabelDecayAtZero];
    //decayAtNyquist
    ReverbSliderSix = [[UISlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height*5/15+20, self.view.frame.size.width*3/4, self.view.frame.size.height/15)];
    ReverbSliderSix.backgroundColor = colorForReverb;
    [ReverbSliderSix setMaximumTrackImage:reverbMaxSl forState:UIControlStateNormal];
    [ReverbSliderSix setMinimumTrackImage:reverbMinSl forState:UIControlStateNormal];
    [ReverbSliderSix setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    ReverbSliderSix.maximumValue = 20;
    ReverbSliderSix.minimumValue = 0.001;
    [self.view addSubview:ReverbSliderSix];
    [ReverbSliderSix addTarget:self action:@selector(didchangeDecayTimeAtNyquist:)forControlEvents:UIControlEventValueChanged];
    //label assciated with changing from slider
    labelForRevSix = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*3/4-20,self.view.frame.size.height*5/15+20,50,15)];
    [self.view addSubview:labelForRevSix];
    UILabel *titleLabelDecayAtNyquist = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3/4-200,self.view.frame.size.height*5/15+20,200,15)];
    [titleLabelDecayAtNyquist setText:@"reverbDecayAtNyquist"];
    titleLabelDecayAtNyquist.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabelDecayAtNyquist];
    //random
    ReverbSliderSeven = [[UISlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height*6/15+20, self.view.frame.size.width*3/4, self.view.frame.size.height/15)];
    ReverbSliderSeven.backgroundColor = colorForReverb;
    [ReverbSliderSeven setMaximumTrackImage:reverbMaxSl forState:UIControlStateNormal];
    [ReverbSliderSeven setMinimumTrackImage:reverbMinSl forState:UIControlStateNormal];
    [ReverbSliderSeven setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    ReverbSliderSeven.maximumValue = 1000;
    ReverbSliderSeven.minimumValue = 1;
    [self.view addSubview:ReverbSliderSeven];
    [ReverbSliderSeven addTarget:self action:@selector(didchangeRandomizeReflections:)forControlEvents:UIControlEventValueChanged];
    //label assciated with changing from slider
    labelForRevSeven = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*3/4-20,self.view.frame.size.height*6/15+20,200,15)];
    [self.view addSubview:labelForRevSeven];
    UILabel *titleLabelRandom = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3/4-200,self.view.frame.size.height*6/15+20,200,15)];
    [titleLabelRandom setText:@"reverbReflectRandom"];
    titleLabelRandom.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabelRandom];
#pragma delay
    UIColor *colorForDelay = [UIColor colorWithRed:0.0 green:0.5 blue:0.4 alpha:0.1];
    DelaySliderOne = [[UISlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height*7/15+20, self.view.frame.size.width*3/4 , self.view.frame.size.height/15)];
    DelaySliderOne.backgroundColor = colorForDelay;
    [DelaySliderOne setMaximumTrackImage:delayMaxSl forState:UIControlStateNormal];
    [DelaySliderOne setMinimumTrackImage:delayMinSl forState:UIControlStateNormal];
    [DelaySliderOne setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    DelaySliderOne.maximumValue = 100;
    [self.view addSubview:DelaySliderOne];
    [DelaySliderOne addTarget:self action:@selector(didchangeDryWetMixDelay:)forControlEvents:UIControlEventValueChanged];
    //label assciated with changing from slider
    labelForDelayOne = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*3/4-20,self.view.frame.size.height*7/15+20,50,15)];
    [self.view addSubview:labelForDelayOne];
    UILabel *titleLabelDel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3/4-200,self.view.frame.size.height*7/15+20,200,15)];
    [titleLabelDel setText:@"delayDryWet"];
    titleLabelDel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabelDel];
    //forTimeDelay
    DelaySliderTwo = [[UISlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height*8/15+20, self.view.frame.size.width*3/4 , self.view.frame.size.height/15)];
    DelaySliderTwo.backgroundColor = colorForDelay;
    [DelaySliderTwo setMaximumTrackImage:delayMaxSl forState:UIControlStateNormal];
    [DelaySliderTwo setMinimumTrackImage:delayMinSl forState:UIControlStateNormal];
    [DelaySliderTwo setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    DelaySliderTwo.maximumValue = 2;
    [self.view addSubview:DelaySliderTwo];
    [DelaySliderTwo addTarget:self action:@selector(didchangeTimeDelay:)forControlEvents:UIControlEventValueChanged];
    //label assciated with changing from slider
    labelForDelayTwo = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*3/4-20,self.view.frame.size.height*8/15+20,50,15)];
    [self.view addSubview:labelForDelayTwo];
    UILabel *titleLabelDelTime = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3/4-200,self.view.frame.size.height*8/15+20,200,15)];
    [titleLabelDelTime setText:@"delayTime"];
    titleLabelDelTime.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabelDelTime];
    //forFeedback
    DelaySliderthree = [[UISlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height*9/15+20, self.view.frame.size.width*3/4 , self.view.frame.size.height/15)];
    DelaySliderthree.backgroundColor = colorForDelay;
    [DelaySliderthree setMaximumTrackImage:delayMaxSl forState:UIControlStateNormal];
    [DelaySliderthree setMinimumTrackImage:delayMinSl forState:UIControlStateNormal];
    [DelaySliderthree setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    DelaySliderthree.maximumValue = 100;
    DelaySliderthree.minimumValue = -100;
    [self.view addSubview:DelaySliderthree];
    [DelaySliderthree addTarget:self action:@selector(didchangeFeedbakcDelay:)forControlEvents:UIControlEventValueChanged];
    //label assciated with changing from slider
    labelForDelayThree = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*3/4-20,self.view.frame.size.height*9/15+20,50,15)];
    [self.view addSubview:labelForDelayThree];
    UILabel *titleLabelDelFeedback = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3/4-200,self.view.frame.size.height*9/15+20,200,15)];
    [titleLabelDelFeedback setText:@"delayFeedback"];
    titleLabelDelFeedback.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabelDelFeedback];
    //forLowpass
    DelaySliderFour = [[UISlider alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height*10/15+20, self.view.frame.size.width*3/4,self.view.frame.size.height/15)];
    DelaySliderFour.backgroundColor = colorForDelay;
    [DelaySliderFour setMaximumTrackImage:delayMaxSl forState:UIControlStateNormal];
    [DelaySliderFour setMinimumTrackImage:delayMinSl forState:UIControlStateNormal];
    [DelaySliderFour setThumbImage:[UIImage imageNamed:@"sliderThumb.png"] forState:UIControlStateNormal];
    DelaySliderFour.maximumValue = 44100/2;
    DelaySliderFour.minimumValue = 10;
    [self.view addSubview:DelaySliderFour];
    [DelaySliderFour addTarget:self action:@selector(didchangeLowpassDelay:)forControlEvents:UIControlEventValueChanged];
    //label assciated with changing from slider
    labelForDelayFour = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width*3/4-20,self.view.frame.size.height*10/15+20,200,15)];
    [self.view addSubview:labelForDelayFour];
    UILabel *titleLabelLowpass = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*3/4-200,self.view.frame.size.height*10/15+20,200,15)];
    [titleLabelLowpass setText:@"delayLowpass"];
    titleLabelLowpass.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabelLowpass];

    
#pragma - firstButton
    //buttonSpring
    UIImage *springImage = [UIImage imageNamed:@"springButton.png"];
    [springImage drawAtPoint:CGPointMake(0, 0) blendMode:kCGBlendModeNormal alpha:0.1];
    buttonSpring = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/4, self.view.frame.size.height/4)];
    [buttonSpring setBackgroundImage:springImage forState:UIControlStateNormal];
    [buttonSpring addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
    //buttonSpring.backgroundColor = [UIColor blueColor];
    [buttonSpring setTitle:@"pushToRec" forState:UIControlStateNormal];
    [buttonSpring setTitle:@"recording" forState:UIControlStateSelected];
    [buttonSpring setTitle:@"playBackRecordFile" forState:UIControlStateDisabled];
    [self.view addSubview:buttonSpring];
    //OnlyplaySpring
    playOnlySpring = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/4-self.view.frame.size.height/12, self.view.frame.size.width/12, self.view.frame.size.height/12)];
//    UIImage *springPlayback = [UIImage imageNamed:@"playButtonNormal.png"];
//    [springPlayback drawAtPoint:CGPointMake(0, self.view.frame.size.height/4-self.view.frame.size.height/12) blendMode:kCGBlendModeScreen alpha:0.1];
//    [playOnlySpring setBackgroundImage:springPlayback forState:UIControlStateNormal];
    [playOnlySpring addTarget:self action:@selector(playback:) forControlEvents:UIControlEventTouchDown];
    playOnlySpring.backgroundColor = [UIColor blackColor];
    [playOnlySpring setImage:[UIImage imageNamed:@"playButtonNormal.png"] forState:UIControlStateNormal];
    [playOnlySpring setImage:[UIImage imageNamed:@"playButtonSelected.png"] forState:UIControlStateSelected];
    [self.view addSubview:playOnlySpring];
    //displayOnlyforPlaying
    playBackText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    playBackText.text = @"playBacking";
    [self.view addSubview:playBackText];
#pragma - secondButton
    //buttonSummer
    UIImage *summerImage = [UIImage imageNamed:@"summerButton.png"];
    buttonSummer = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/4, self.view.frame.size.width/4, self.view.frame.size.height/4)];
    [buttonSummer setBackgroundImage:summerImage forState:UIControlStateNormal];
    [buttonSummer addTarget:self action:@selector(buttonActionx:) forControlEvents:UIControlEventTouchDown];
    //buttonSummer.backgroundColor =[ UIColor yellowColor];
    [buttonSummer setTitle:@"pushToRec" forState:UIControlStateNormal];
    [buttonSummer setTitle:@"recording" forState:UIControlStateSelected];
    [buttonSummer setTitle:@"playBackRecordFile" forState:UIControlStateDisabled];
    [self.view addSubview:buttonSummer];
    //onlyPlaySummer
    playOnlySummer = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2-self.view.frame.size.height/12, self.view.frame.size.width/12, self.view.frame.size.height/12)];
    [playOnlySummer addTarget:self action:@selector(playbackx:) forControlEvents:UIControlEventTouchDown];
    playOnlySummer.backgroundColor = [UIColor blackColor];
    [playOnlySummer setImage:[UIImage imageNamed:@"playButtonNormal.png"] forState:UIControlStateNormal];
    [playOnlySummer setImage:[UIImage imageNamed:@"playButtonSelected.png"] forState:UIControlStateSelected];
    [self.view addSubview:playOnlySummer];
    //displayOnlyforPlaying
    playBackTextx = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/4, 100, 30)];
    playBackTextx.text = @"playBacking";
    [self.view addSubview:playBackTextx];
#pragma - thirdButton
    //buttonAutumn
    UIImage *autumnImage = [UIImage imageNamed:@"autumnButton.png"];
    buttonAutumn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width/4, self.view.frame.size.height/4)];
    [buttonAutumn setBackgroundImage:autumnImage forState:UIControlStateNormal];
    [buttonAutumn addTarget:self action:@selector(buttonActionxx:) forControlEvents:UIControlEventTouchDown];
    [buttonAutumn setTitle:@"pushToRec" forState:UIControlStateNormal];
    [buttonAutumn setTitle:@"recording" forState:UIControlStateSelected];
    [buttonAutumn setTitle:@"playBackRecordFile" forState:UIControlStateDisabled];
    [self.view addSubview:buttonAutumn];
    //onlyPlayAutumn
    playOnlyAutumn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*3/4-self.view.frame.size.height/12, self.view.frame.size.width/12, self.view.frame.size.height/12)];
    [playOnlyAutumn addTarget:self action:@selector(playbackxx:) forControlEvents:UIControlEventTouchDown];
    playOnlyAutumn.backgroundColor = [UIColor blackColor];
    [playOnlyAutumn setImage:[UIImage imageNamed:@"playButtonNormal.png"] forState:UIControlStateNormal];
    [playOnlyAutumn setImage:[UIImage imageNamed:@"playButtonSelected.png"] forState:UIControlStateSelected];
    [self.view addSubview:playOnlyAutumn];
    //displayOnlyforPlaying
    playBackTextxx = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2, 100, 30)];
    playBackTextxx.text = @"playBacking";
    [self.view addSubview:playBackTextxx];
#pragma - FourthButton
    //buttonWinter
    UIImage *winterImage = [UIImage imageNamed:@"winterButton"];
    buttonWinter = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*3/4, self.view.frame.size.width/4, self.view.frame.size.height/4)];
    [buttonWinter setBackgroundImage:winterImage forState:UIControlStateNormal];
    [buttonWinter addTarget:self action:@selector(buttonActionxxx:) forControlEvents:UIControlEventTouchDown];
//    buttonWinter.backgroundColor = [UIColor redColor];
    [buttonWinter setTitle:@"pushToRec" forState:UIControlStateNormal];
    [buttonWinter setTitle:@"recording" forState:UIControlStateSelected];
    [buttonWinter setTitle:@"playBackRecordFile" forState:UIControlStateDisabled];
    [self.view addSubview:buttonWinter];
    //onlyPlayWinter
    playOnlyWinter = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-self.view.frame.size.height/12, self.view.frame.size.width/12, self.view.frame.size.height/12)];
    [playOnlyWinter addTarget:self action:@selector(playbackxxx:) forControlEvents:UIControlEventTouchDown];
    playOnlyWinter.backgroundColor = [UIColor blackColor];
    [playOnlyWinter setImage:[UIImage imageNamed:@"playButtonNormal.png"] forState:UIControlStateNormal];
    [playOnlyWinter setImage:[UIImage imageNamed:@"playButtonSelected.png"] forState:UIControlStateSelected];
    [self.view addSubview:playOnlyWinter];
    //displayOnlyforPlaying
    playBackTextxxx = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*3/4, 100, 30)];
    playBackTextxxx.text = @"playBacking";
    [self.view addSubview:playBackTextxxx];

}

- (void)viewDidUnload
{
    dryWetsSlider = nil;
    dryWetsLabel = nil;
    gainsSlider = nil;
    gainsLabel = nil;
    minDelayTimesLabel = nil;
    maxDelayTimesLabel = nil;
    minDelayTimesSlider = nil;
    maxDelayTimesSlider = nil;
    decayTimesAt0HzLabel = nil;
    decayTimesAt0HzSlider = nil;
    decayTimesAtNyquistLabel = nil;
    decayTimesAtNyquistSlider = nil;
    randomizeReflectionLabel = nil;
    randomizeReflectionSlider = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//}

////ここで回転していいかの判別をする
//- (BOOL)shouldAutorotate
//{
//        return NO;
//}
//
////どの方向に回転していいかを返す（例ではすべての方向に回転OK）
//- (NSUInteger)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskPortrait;
//}

- (void)viewWillAppear:(BOOL)animated
{
    [self registerForNotifications];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self updateUI];
//    AVAudioSessionRouteDescription *routeDesc =
//    [[AVAudioSession sharedInstance] currentRoute];
//    NSArray *outputs = routeDesc.outputs;
//    for (AVAudioSessionPortDescription *portDesc in outputs) {
//        portType = portDesc.portType; // AVAudioSessionPortHeadphonesなど
//        portName = portDesc.portName;
//        NSLog(@"ポートネーム%@", portName);
//        channels = portDesc.channels; // AVAudioSessionChannelDescription
//        NSLog(@"チャンネル%@", channels);
//    }
//    
//}

- (void)viewWillDisappear:(BOOL)animated
{
    [self unregisterForNotifications];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods
- (void)updateUI {
    reverbValue *defValue = [altAudioSetup reverbValue];
    Float32 value;
    value = [defValue dryWetMix];
    [dryWetsSlider setValue:value animated:YES];
    [dryWetsLabel setText:[NSString stringWithFormat:@"%.2f", value]];
    value = [defValue gain];
    [gainsSlider setValue:value animated:YES];
    [gainsLabel setText:[NSString stringWithFormat:@"%.2f", value]];
    value = [defValue minDelayTime];
    [minDelayTimesSlider setValue:value animated:YES];
    [minDelayTimesLabel setText:[NSString stringWithFormat:@"%.2f", value]];
    value = [defValue maxDelayTime];
    [maxDelayTimesSlider setValue:value animated:YES];
    [maxDelayTimesLabel setText:[NSString stringWithFormat:@"%.2f", value]];
    value = [defValue decayTimeAt0Hz];
    [decayTimesAt0HzSlider setValue:value animated:YES];
    [decayTimesAt0HzLabel setText:[NSString stringWithFormat:@"%.2f", value]];
    value = [defValue decayTimeAtNyquist];
    [decayTimesAtNyquistSlider setValue:value animated:YES];
    [decayTimesAtNyquistLabel setText:[NSString stringWithFormat:@"%.2f", value]];
    value = [defValue randomizeReflections];
    [randomizeReflectionSlider setValue:value animated:YES];
    [randomizeReflectionLabel setText:[NSString stringWithFormat:@"%.2f", value]];
}


#pragma mark - reverbActions
- (void)didchangeDryWetMixSlider:(UISlider *)sender {
    Float32 value = [sender value];
    [[self.captureSessionController reverbValue] setDryWetMix:value];
    [dryWetsLabel setText:[NSString stringWithFormat:@"%.2f", value]];
    //自作ラベルへのスライダー数値の
    [labelForRevOne setText:[NSString stringWithFormat:@"%.2f", value]];
}
- (void)didchangeGain:(UISlider *)sender {
    Float32 value = [sender value];
    [[self.captureSessionController reverbValue] setGain:value];
    [gainsLabel setText:[NSString stringWithFormat:@"%.2f", value]];
    [labelForRevTwo setText:[NSString stringWithFormat:@"%.2f",value]];
}
- (void)didchangeMinDelayTime:(UISlider *)sender {
    Float32 value = [sender value];
    [[self.captureSessionController reverbValue] setMinDelayTime:value];
    [minDelayTimesLabel setText:[NSString stringWithFormat:@"%.2f", value]];
    [labelForRevThree setText:[NSString stringWithFormat:@"%.2f", value]];
}
- (void)didchangeMaxDelayTime:(UISlider *)sender {
    Float32 value = [sender value];
    [[self.captureSessionController reverbValue] setMaxDelayTime:value];
    [maxDelayTimesLabel setText:[NSString stringWithFormat:@"%.2f", value]];
    [labelForRevFour setText:[NSString stringWithFormat:@"%.2f", value]];
}
- (void)didchangeDecayTimeAt0Hz:(UISlider *)sender {
    Float32 value = [sender value];
    [[self.captureSessionController reverbValue] setDecayTimeAt0Hz:value];
    [decayTimesAt0HzLabel setText:[NSString stringWithFormat:@"%.2f", value]];
    [labelForRevFive setText:[NSString stringWithFormat:@"%.2f", value]];
}
- (void)didchangeDecayTimeAtNyquist:(UISlider *)sender {
    Float32 value = [sender value];
    [[self.captureSessionController reverbValue] setDecayTimeAtNyquist:value];
    [decayTimesAtNyquistLabel setText:[NSString stringWithFormat:@"%.2f", value]];
    [labelForRevSix setText:[NSString stringWithFormat:@"%.2f", value]];
}
- (void)didchangeRandomizeReflections:(UISlider *)sender {
    Float32 value = [sender value];
    [[self.captureSessionController reverbValue] setRandomizeReflections:value];
    [randomizeReflectionLabel setText:[NSString stringWithFormat:@"%.2f", value]];
    [labelForRevSeven setText:[NSString stringWithFormat:@"%.2f", value]];
}
#pragma delayAction
- (void)didchangeDryWetMixDelay:(UISlider *)sender {
    Float32 value = [sender value];
    [[self.captureSessionController delayValue] setDryWetMix:value];
    [labelForDelayOne setText:[NSString stringWithFormat:@"%.2f",value]];
}
- (void)didchangeTimeDelay:(UISlider *)sender {
    Float32 value = [sender value];
    [[self.captureSessionController delayValue] setTime:value];
    [labelForDelayTwo setText:[NSString stringWithFormat:@"%.2f",value]];
}
- (void)didchangeFeedbakcDelay:(UISlider *)sender {
    Float32 value = [sender value];
    [[self.captureSessionController delayValue] setFeedback:value];
    [labelForDelayThree setText:[NSString stringWithFormat:@"%.2f",value]];
}
- (void)didchangeLowpassDelay:(UISlider *)sender {
    Float32 value = [sender value];
    [[self.captureSessionController delayValue] setLowpass:value];
    [labelForDelayFour setText:[NSString stringWithFormat:@"%.2f",value]];
}
//- (IBAction)resets {
//    [[self.captureSessionController reverbValue] resetParameters];
//    [self updateUI];
//}

//-(IBAction)descPort:(id)sender{
//    NSLog(@"ポートタイプは%s", [portType UTF8String]);
//    NSArray *availableInputs = [[AVAudioSession sharedInstance] availableInputs];
//    AVAudioSessionPortDescription *port = [availableInputs objectAtIndex:0];
//    NSLog(@"available input is %@", port);
//};


#pragma  - for capture
- (void)initCaptureSession
{
    if ([self.captureSessionController setupCaptureSession]) {
        [self updateUISelected:NO enabled:YES];
        [self updateUISelectedx:NO enabled:YES];
        [self updateUISelectedxx:NO enabled:YES];
        [self updateUISelectedxxx:NO enabled:YES];
    }
    else NSLog(@"Initializing CaptureSessionController failed just BAIL!");
}
- (void)buttonAction:(id)sender
{
        if (self.captureSessionController.isRecording) {
            [self.captureSessionController stopRecording];
            [self updateUISelected:NO enabled:NO];
            [self playRecordedAudio];
        } else {
            [self.captureSessionController startRecording];
            [self updateUISelected:YES enabled:YES];
        }
}
- (void)buttonActionx:(id)sender
{
    if (self.captureSessionController.isRecordingx) {
        [self.captureSessionController stopRecordingx];
        [self updateUISelectedx:NO enabled:NO];
        [self playRecordedAudiox];
    } else {
        [self.captureSessionController startRecordingx];
        [self updateUISelectedx:YES enabled:YES];
    }
}
- (void)buttonActionxx:(id)sender
{
    if (self.captureSessionController.isRecordingxx) {
        [self.captureSessionController stopRecordingxx];
        [self updateUISelectedxx:NO enabled:NO];
        [self playRecordedAudioxx];
    } else {
        [self.captureSessionController startRecordingxx];
        [self updateUISelectedxx:YES enabled:YES];
    }
}

- (void)buttonActionxxx:(id)sender
{
    if (self.captureSessionController.isRecordingxxx) {
        [self.captureSessionController stopRecordingxxx];
        [self updateUISelectedxxx:NO enabled:NO];
        [self playRecordedAudioxxx];
    } else {
        [self.captureSessionController startRecordingxxx];
        [self updateUISelectedxxx:YES enabled:YES];
    }
}

- (void)playback:(id)sender{
    playOnlySpring.selected = YES;
    [self playRecordedAudio];
}
- (void)playbackx:(id)sender{
    playOnlySummer.selected = YES;
    [self playRecordedAudiox];
}
- (void)playbackxx:(id)sender{
    playOnlyAutumn.selected = YES;
    [self playRecordedAudioxx];
}
- (void)playbackxxx:(id)sender{
    playOnlyWinter.selected = YES;
    [self playRecordedAudioxxx];
}

- (void)updateUISelected:(BOOL)selected enabled:(BOOL)enabled
{
//    self.startButton.selected = selected;
//    self.startButton.enabled = enabled;
    buttonSpring.selected = selected;
    buttonSpring.enabled = enabled;
}
- (void)updateUISelectedx:(BOOL)selected enabled:(BOOL)enabled
{
    buttonSummer.selected = selected;
    buttonSummer.enabled = enabled;
}
- (void)updateUISelectedxx:(BOOL)selected enabled:(BOOL)enabled
{
    buttonAutumn.selected = selected;
    buttonAutumn.enabled = enabled;
}
- (void)updateUISelectedxxx:(BOOL)selected enabled:(BOOL)enabled
{
    buttonWinter.selected = selected;
    buttonWinter.enabled =enabled;
}

#pragma mark ======== AVAudioPlayer =========

// when interrupted, just toss the player and we're done
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player
{
    NSLog(@"AVAudioPlayer audioPlayerBeginInterruption");
    if (player == Oplayer) {
        playBackText.hidden = YES;
    }else if(player == Oplayerx){
        playBackTextx.hidden = YES;
    }else if(player == Oplayerxx){
        playBackTextxx.hidden = YES;
    }else if(player == Oplayerxxx){
        playBackTextxxx.hidden =YES;
    }
    [player setDelegate:nil];
    [player release];
    
}

// when finished, toss the player and restart the capture session※再生が終わった後ボタンがフリーズするのはここが原因かも
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    (flag == NO) ?  NSLog(@"AVAudioPlayer unsuccessfull!") :
                    NSLog(@"AVAudioPlayer finished playing");
    if (player == Oplayer) {
        NSLog(@"Oplayer is read successfly");
        [Oplayer setDelegate:nil];
        [Oplayer release];
        playBackText.hidden = YES;
        playOnlySpring.selected = NO;
        
    }else{
        if(player == Oplayerx){
        NSLog(@"Oplayerx is read successfly");
        [Oplayerx setDelegate:nil];
        [Oplayerx release];
        playBackTextx.hidden = YES;
        playOnlySummer.selected = NO;
        }else{
            if(player == Oplayerxx){
                NSLog(@"Oplayerxx is read successfly");
                [Oplayerxx setDelegate:nil];
                [Oplayerxx release];
                playBackTextxx.hidden = YES;
                playOnlyAutumn.selected = NO;
            }else{
                if (player == Oplayerxxx){
                    NSLog(@"Oplayerxxx is read successfly");
                    [Oplayerxxx setDelegate:nil];
                    [Oplayerxxx release];
                    playBackTextxxx.hidden = YES;
                    playOnlyWinter.selected = NO;
                }
            }
        }
    }
    
       //3/25追加
    
    // start the capture session
    [self.captureSessionController startCaptureSession];
    
    
}

// basic AVAudioPlayer implementation to play back recorded file
- (void)playRecordedAudio
{
    NSError *error = nil;
    
    // stop the capture session
    [self.captureSessionController stopCaptureSession];
    
    NSLog(@"Playing Recorded Audio");
    
    // play the result
    Oplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:(NSURL *)self.captureSessionController.outputFile error:nil];
    if (nil == Oplayer) {
        NSLog(@"AVAudioPlayer alloc failed! %@", [error localizedDescription]);
        //[self.startButton setTitle:@"FAIL!" forState:UIControlStateDisabled];
        [buttonSpring setTitle:@"FAIL!" forState:UIControlStateDisabled];
        return;
    }
    
    playBackText.hidden = NO;

    [Oplayer setDelegate:self];
    [Oplayer play];
}
- (void)playRecordedAudiox
{
    NSError *error = nil;
    
    // stop the capture session
    [self.captureSessionController stopCaptureSession];
    
    NSLog(@"Playing Recorded Audio");
    
    // play the result
    Oplayerx = [[AVAudioPlayer alloc] initWithContentsOfURL:(NSURL *)self.captureSessionController.outputFilex error:nil];
    if (nil == Oplayerx) {
        NSLog(@"AVAudioPlayer alloc failed! %@", [error localizedDescription]);
        //[self.startButton setTitle:@"FAIL!" forState:UIControlStateDisabled];
        [buttonSummer setTitle:@"FAIL!" forState:UIControlStateDisabled];
        return;
    }
    
    playBackTextx.hidden = NO;
    
    [Oplayerx setDelegate:self];
    [Oplayerx play];
}
- (void)playRecordedAudioxx
{
    NSError *error = nil;
    
    // stop the capture session
    [self.captureSessionController stopCaptureSession];
    
    NSLog(@"Playing Recorded Audio");
    
    // play the result
    Oplayerxx = [[AVAudioPlayer alloc] initWithContentsOfURL:(NSURL *)self.captureSessionController.outputFilexx error:nil];
    if (nil == Oplayerxx) {
        NSLog(@"AVAudioPlayer alloc failed! %@", [error localizedDescription]);
        //[self.startButton setTitle:@"FAIL!" forState:UIControlStateDisabled];
        [buttonAutumn setTitle:@"FAIL!" forState:UIControlStateDisabled];
        return;
    }
    
    playBackTextxx.hidden = NO;
    
    [Oplayerxx setDelegate:self];
    [Oplayerxx play];
}
- (void)playRecordedAudioxxx
{
    NSError *error = nil;
    
    // stop the capture session
    [self.captureSessionController stopCaptureSession];
    
    NSLog(@"Playing Recorded Audio");
    
    // play the result
    Oplayerxxx = [[AVAudioPlayer alloc] initWithContentsOfURL:(NSURL *)self.captureSessionController.outputFilexxx error:nil];
    if (nil == Oplayerxxx) {
        NSLog(@"AVAudioPlayer alloc failed! %@", [error localizedDescription]);
        //[self.startButton setTitle:@"FAIL!" forState:UIControlStateDisabled];
        [buttonWinter setTitle:@"FAIL!" forState:UIControlStateDisabled];
        return;
    }
    
    playBackTextxxx.hidden = NO;
    
    [Oplayerxxx setDelegate:self];
    [Oplayerxxx play];
}

#pragma mark ======== Notifications =========

// notification handling to do the right thing when the app comes and goes
- (void)registerForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willResignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enableButton)
                                                 name:@"CaptureSessionRunningNotification"
                                               object:nil];
}

- (void)unregisterForNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillResignActiveNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"CaptureSessionRunningNotification"
                                                  object:nil];
}

- (void)willResignActive
{
    NSLog(@"MyViewController willResignActive");
    
    [self updateUISelected:NO enabled:NO];
    [self updateUISelectedx:NO enabled:NO];
    [self updateUISelectedxx:NO enabled:NO];
    [self updateUISelectedxxx:NO enabled:NO];
}

- (void)enableButton
{
    NSLog(@"MyViewController enableButton");
    //再生後にボタンを再度有効化するのに必須（notificationによって実装）
    [self updateUISelected:NO enabled:YES];
    [self updateUISelectedx:NO enabled:YES];
    [self updateUISelectedxx:NO enabled:YES];
    [self updateUISelectedxxx:NO enabled:YES];
    playOnlySpring.selected = NO;
    playOnlySpring.enabled = YES;
    playOnlySummer.selected = NO;
    playOnlySummer.enabled = YES;
    playOnlyAutumn.selected = NO;
    playOnlyAutumn.enabled = YES;
    playOnlyWinter.selected = NO;
    playOnlyWinter.enabled = YES;

}


@end
