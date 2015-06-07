

#import <AudioUnit/AudioUnit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "reverbValue.h"
#import "delayValue.h"

// CoreAudio Public Utility
#include "CAStreamBasicDescription.h"
#include "CAComponentDescription.h"
#include "CAAudioBufferList.h"
#include "AUOutputBL.h"

@interface CaptureSessionController : NSObject <AVCaptureAudioDataOutputSampleBufferDelegate> {
@private
    AVCaptureSession            *captureSession;
    AVCaptureDeviceInput        *captureAudioDeviceInput;
    AVCaptureAudioDataOutput    *captureAudioDataOutput;
	
    AUGraph                     auGraph;
    AudioUnit					converterAudioUnit;
	AudioUnit					delayAudioUnit;
    AudioUnit                   reverbUnit;
    AudioChannelLayout          *currentRecordingChannelLayout;
    ExtAudioFileRef             extAudioFile;
    ExtAudioFileRef             extAudioFilex;
    ExtAudioFileRef             extAudioFilexx;
    ExtAudioFileRef             extAudioFilexxx;
	
    AudioStreamBasicDescription currentInputASBD;
    AudioStreamBasicDescription graphOutputASBD;
	AudioBufferList				*currentInputAudioBufferList;
    AUOutputBL                  *outputBufferList;
    
	double						currentSampleTime;
	BOOL						didSetUpAudioUnits;
@public
    reverbValue *reverbValue_;
    delayValue *delayValue_;
}

@property(atomic, getter=isRecording) BOOL recording;
@property(atomic, getter=isRecordingx) BOOL recordingx;
@property(atomic, getter=isRecordingxx) BOOL recordingxx;
@property(atomic, getter=isRecordingxxx) BOOL recordingxxx;
@property                             CFURLRef outputFile;
@property                             CFURLRef outputFilex;
@property                             CFURLRef outputFilexx;
@property                             CFURLRef outputFilexxx;

- (BOOL)setupCaptureSession;
- (void)startCaptureSession;
- (void)stopCaptureSession;
- (void)startRecording;
- (void)startRecordingx;
- (void)startRecordingxx;
- (void)startRecordingxxx;
- (void)stopRecording;
- (void)stopRecordingx;
- (void)stopRecordingxx;
- (void)stopRecordingxxx;

@property (nonatomic,readonly)reverbValue *reverbValue;
@property (nonatomic,readonly)delayValue *delayValue;
@end
