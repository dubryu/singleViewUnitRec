//
//  delayValue.h
//  RecThroughUnit
//
//  Created by KatayamaRyusuke on 2015/04/15.
//  Copyright (c) 2015年 片山隆介. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface delayValue : NSObject{
    
    AudioUnit *delayAudioUnit_;
    //デフォルト値の保存用
    Float32 dryWetMix_;
    Float32 time_;
    Float32 feedback_;
    Float32 lowpass_;
}

@property (atomic)Float32 dryWetMix;
@property (atomic)Float32 time;
@property (atomic)Float32 feedback;
@property (atomic)Float32 lowpass;

- (id)initWithDelayUnit:(AudioUnit)delayAudioUnit;

@end
