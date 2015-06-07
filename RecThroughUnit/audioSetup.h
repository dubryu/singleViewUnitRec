//
//  audioSetup.h
//  RecThroughUnit
//
//  Created by KatayamaRyusuke on 2015/02/17.
//  Copyright (c) 2015年 片山隆介. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#import "reverbValue.h"

@interface audioSetup : NSObject
{
    AUGraph graph_;
    Float64 samplingRate_;
    
    AudioUnit remoteIOUnit_;
    AudioUnit reverbUnit_;
    AudioUnit converterUnit_;
    AudioUnit multiChannelMixerUnit_;
    BOOL      playing;
    reverbValue *reverbValue_;
    
//    //add
//    AudioStreamBasicDescription stereoStreamFormat;
//    AudioStreamBasicDescription ioClientFormat;
}
@property (nonatomic)Float64 samplingRate;
@property (getter = isPlaying)  BOOL playing;
@property (nonatomic,readonly)reverbValue *reverbValue;

////add
//@property (readwrite)    AudioStreamBasicDescription stereoStreamFormat;
//@property (readwrite)    AudioStreamBasicDescription ioClientFormat;
//
- (id)initWithSamplingRate:(Float64)sampleRate;
- (void)open;
- (void)start;
- (void)stop;

@end
