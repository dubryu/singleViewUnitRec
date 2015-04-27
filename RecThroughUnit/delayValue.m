//
//  delayValue.m
//  RecThroughUnit
//
//  Created by KatayamaRyusuke on 2015/04/15.
//  Copyright (c) 2015年 片山隆介. All rights reserved.
//

#import "delayValue.h"

@interface delayValue ()
- (Float32)valueForParameter:(int)parameter;
- (void)setValue:(Float32)value forParameter:(int)parameter min:(Float32)min max:(Float32)max;
@end

@implementation delayValue

- (id)initWithDelayUnit:(AudioUnit)delayAudioUnit{
    self = [super init];
    if (self) {
        delayAudioUnit_ = delayAudioUnit;
        
        dryWetMix_ = self.dryWetMix;
        time_ = self.time;
        feedback_ = self.feedback;
        lowpass_ = self.lowpass;
        NSLog(@"delayAudioUnit was initialized");
    }
    return self;
}
- (Float32)valueForParameter:(int)parameter {
    Float32 value;
    OSStatus rt = AudioUnitGetParameter(delayAudioUnit_,
                                        parameter,
                                        kAudioUnitScope_Global,
                                        0,
                                        &value);
    if (rt != noErr) {
        NSLog(@"Error getting parameter(%d)", parameter);
        return MAXFLOAT;
    }
    return value;
}
- (void)setValue:(Float32)value forParameter:(int)parameter
             min:(Float32)min max:(Float32)max {
    if (value<min || value>max) {
        NSLog(@"Invalid value(%f)<%f - %f> for parameter(%d). Ignored.",
              value, min, max, parameter);
        return;
    }
    OSStatus rt = AudioUnitSetParameter (delayAudioUnit_,
                                        parameter,
                                        kAudioUnitScope_Global,
                                        0,
                                        value,
                                        0);
    if (rt != noErr) {
        NSLog(@"Error Setting parameter(%d)", parameter);
    }
}
- (Float32)dryWetMix {
    Float32 result;
    AudioUnitGetParameter(delayAudioUnit_,
                          kDelayParam_WetDryMix,
                          kAudioUnitScope_Global,
                          0,
                          &result); //パラメータの格納先
    return result;
}
- (void)setDryWetMix:(Float32)dryWetMix {
    // Global, CrossFade, 0->100, 100
    if (dryWetMix<0.0f || dryWetMix>100.0f) {
        return;
    }
    AudioUnitSetParameter(delayAudioUnit_,
                          kDelayParam_WetDryMix,
                          kAudioUnitScope_Global,
                          0,
                          dryWetMix,
                          0);
    NSLog(@"delayDryWetMix is done");
}


- (Float32)time {
    return [self valueForParameter:kDelayParam_DelayTime];
}
- (void)setTime:(Float32)value {
    // Global, Decibels, -20->20, 0
    [self setValue:value forParameter:kDelayParam_DelayTime
               min:0.0f max:2.0f];
}


- (Float32)feedback {
    return [self valueForParameter:kDelayParam_Feedback];
}
- (void)setFeedback:(Float32)value {
    // Global, Decibels, -20->20, 0
    [self setValue:value forParameter:kDelayParam_Feedback
               min:-100.0f max:100.0f];
}
- (Float32)lowpass {
    return [self valueForParameter:kDelayParam_LopassCutoff];
}
- (void)setLowpass:(Float32)value {
    // Global, Decibels, -20->20, 0
    [self setValue:value forParameter:kDelayParam_LopassCutoff
               min:10.0f max:22050.0f];
}


@end
