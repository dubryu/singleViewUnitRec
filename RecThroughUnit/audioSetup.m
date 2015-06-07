//
//  audioSetup.m
//  RecThroughUnit
//
//  Created by KatayamaRyusuke on 2015/02/17.
//  Copyright (c) 2015年 片山隆介. All rights reserved.
//

#import "audioSetup.h"


@interface audioSetup ()
- (BOOL)setupAudioSession;
@end

@implementation audioSetup
@synthesize samplingRate=samplingRate_;
@synthesize playing;
@synthesize reverbValue=reverbValue_;
//@synthesize stereoStreamFormat;
//@synthesize ioClientFormat;

- (BOOL)setupAudioSession {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 録音と再生が同時に行えるカテゴリを指定
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    NSError *audioSessionError = nil;
    
    // サンプリングレートの設定
    self.samplingRate= 44100.0;
    [session setPreferredSampleRate:
     self.samplingRate error: &audioSessionError];
    
    // デバイスに反映された値を再設定
    self.samplingRate = [session sampleRate];
    
    [session setActive:YES error:nil];
    return YES;
}

- (id)initWithSamplingRate:(Float64)sampleRate {
    self = [super init];
    if (self) {
        self.samplingRate = sampleRate;
        [self setupAudioSession];
    }
    return self;
}

- (void)open {
    static OSStatus ret = noErr;
    
    ret = NewAUGraph(&graph_);
    ret = AUGraphOpen(graph_);
    
    AudioComponentDescription cd;
    cd.componentManufacturer = kAudioUnitManufacturer_Apple;
    cd.componentFlags = 0;
    cd.componentFlagsMask = 0;

    // Audio Unit Graph Nodeの作成
    
    // RemoteIOの作成
    cd.componentType = kAudioUnitType_Output;
    cd.componentSubType = kAudioUnitSubType_RemoteIO;
    // - RemoteIOノードを作成し、AUGraphに追加
    AUNode  remoteIONode;
    ret = AUGraphAddNode(graph_, &cd, &remoteIONode);
    ret = AUGraphNodeInfo(graph_, remoteIONode, NULL, &remoteIOUnit_);
    
    // Converter Unitを作成
    cd.componentType = kAudioUnitType_FormatConverter;
    cd.componentSubType = kAudioUnitSubType_AUConverter;
    // - AUConverterノードを作成し、AUGraphに追加
    AUNode converterNode;
    ret = AUGraphAddNode(graph_, &cd, &converterNode);
    ret = AUGraphNodeInfo(graph_, converterNode, NULL, &converterUnit_);
    
    // Reverb2の作成
    cd.componentType = kAudioUnitType_Effect;
    cd.componentSubType = kAudioUnitSubType_Reverb2;
    // - Reverb2ノードを作成し、AUGraphに追加
    AUNode  reverbNode;
    ret = AUGraphAddNode(graph_, &cd, &reverbNode);
    ret = AUGraphNodeInfo(graph_, reverbNode, NULL, &reverbUnit_);
    
    // MultiChannel Mixerの作成
    cd.componentType = kAudioUnitType_Mixer;
    cd.componentSubType = kAudioUnitSubType_MultiChannelMixer;
    // - MultiChannel Mixerノードを作成し、AUGraphに追加
    AUNode  multiChannelMixerNode;
    ret = AUGraphAddNode(graph_, &cd, &multiChannelMixerNode);
    ret = AUGraphNodeInfo(graph_, multiChannelMixerNode, NULL, &multiChannelMixerUnit_);
    {
        UInt32 value;
        UInt32 size = sizeof(value);
        ret = AudioUnitGetProperty(multiChannelMixerUnit_,
                                   kAudioUnitProperty_ElementCount,
                                   kAudioUnitScope_Input,
                                   0,
                                   &value,
                                   &size);
    }
    
    
    // プロパティ設定
    
    // - Remote IOノードの入力(マイク)を有効化
    const UInt32 enableAudioInput = 1; // 0で無効
    ret = AudioUnitSetProperty(remoteIOUnit_,
                               kAudioOutputUnitProperty_EnableIO,
                               kAudioUnitScope_Input,  // 操作対象のスコープ
                               1, // 操作対象のバス番号
                               &enableAudioInput,
                               sizeof(enableAudioInput));
    //さしあたり出力の有効化(追記)
    const UInt32 enableAudioOutput = 1;
    ret = AudioUnitSetProperty(remoteIOUnit_,
                                  kAudioOutputUnitProperty_EnableIO,
                                  kAudioUnitScope_Output,
                                  0,
                                  &enableAudioOutput,
                                  sizeof(enableAudioOutput));
    
    
    // 各ノードを繋ぐためのASBDの設定
    
    // - Reverb2の入力ASBDを取得
    AudioStreamBasicDescription reverb_desc = {0};
    UInt32 size = sizeof(reverb_desc);
    ret = AudioUnitGetProperty(reverbUnit_, //getされるパラメータのあるオーディオユニット
                               kAudioUnitProperty_StreamFormat, //getされるパラメータの種類
                               kAudioUnitScope_Input,   //パラメータの範囲
                               0, //bus number
                               &reverb_desc,    //パラメータの値をここに格納
                               &size);
    NSCAssert (ret==noErr, @"Error: %d'", (int)ret);
    
    // Converterの出力ASBDにReverb2の入力ASBDを設定
    ret = AudioUnitSetProperty(converterUnit_,
                               kAudioUnitProperty_StreamFormat,
                               kAudioUnitScope_Output,
                               0,
                               &reverb_desc, //上の格納元ポインタからのパラメータの値
                               size);
    NSCAssert (ret==noErr, @"Error: %d'", (int)ret);
    
    
    // ノードの接続（グラフの作成）
    

    // Remote IOからConverterへ接続
    ret = AUGraphConnectNodeInput(graph_,
                                  remoteIONode, 1, //ソースノードのアウトプットバス番号。
                                  converterNode, 0); //ソースノードのインプットバス番号。
    NSCAssert (ret==noErr, @"Error: %d'", (int)ret);
    
    // AUConverterからReverb2へ接続
    ret = AUGraphConnectNodeInput(graph_,
                                  converterNode, 0,
                                  reverbNode, 0);
    NSCAssert (ret==noErr, @"Error: %d'", (int)ret);
    
    // Reverb2からMultiChannel Mixerへ接続
    ret = AUGraphConnectNodeInput(graph_,
                                  reverbNode, 0,
                                  multiChannelMixerNode, 0);
    NSCAssert (ret==noErr, @"Error: %d'", (int)ret);
    
    // MultiChannel MixerからRemote IOへ接続
    ret = AUGraphConnectNodeInput(graph_,
                                  multiChannelMixerNode, 0, //The mixer unit has only one output bus,bus 0.
                                  remoteIONode, 0); //The I/O unit has only one input bus, bus 0.
    NSCAssert (ret==noErr, @"Error: %d'", (int)ret);
    
    //---------------------------------
    // Reverb2へ設定するためのプロキシオブジェクトを作成
    reverbValue_ = [[reverbValue alloc] initWithReverbUnit:reverbUnit_];
    
    //---------------------------------
    // コンソールに現在のAUGraph内の状況を出力(デバッグ)
    CAShow(graph_);
    
    // 準備が整ったので、AUGraphを初期化
    ret = AUGraphInitialize(graph_);
    NSCAssert (ret==noErr, @"Error: %d'", (int)ret);
    
//#pragma mark - callback
//    // Describe format
//    stereoStreamFormat.mSampleRate			= 44100.00;
//    stereoStreamFormat.mFormatID			= kAudioFormatLinearPCM;
//    stereoStreamFormat.mFormatFlags		= kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
//    stereoStreamFormat.mFramesPerPacket	= 1;
//    stereoStreamFormat.mChannelsPerFrame	= 1;
//    stereoStreamFormat.mBitsPerChannel		= 16;
//    stereoStreamFormat.mBytesPerPacket		= 2;
//    stereoStreamFormat.mBytesPerFrame		= 2;
//    
//    //apply upon setting to remote I/O
//    // Apply format
//    ret = AudioUnitSetProperty(remoteIOUnit_,
//                                  kAudioUnitProperty_StreamFormat,
//                                  kAudioUnitScope_Output,
//                                  1,
//                                  &stereoStreamFormat,
//                                  sizeof(stereoStreamFormat));
//    NSCAssert (ret==noErr, @"Error: %d'", (int)ret);
//    ret = AudioUnitSetProperty(remoteIOUnit_,
//                                  kAudioUnitProperty_StreamFormat,
//                                  kAudioUnitScope_Input,
//                                  0,
//                                  &stereoStreamFormat,
//                                  sizeof(stereoStreamFormat));
//    NSCAssert (ret==noErr, @"Error: %d'", (int)ret);
//    //このopenメソッドの中でコールバックをremoteIOUnitに登録（有効範囲はアウトプット）
//    // Set input callback
//    AURenderCallbackStruct callbackStruct;
//    callbackStruct.inputProc = recordingCallback; //このクラスの巻末にコールバック記述あり
//    callbackStruct.inputProcRefCon = (__bridge void *)(self);
//    ret = AudioUnitSetProperty (remoteIOUnit_,
//                          kAudioOutputUnitProperty_SetInputCallback,
//                          kAudioUnitScope_Global,
//                          1,
//                          &callbackStruct,
//                          sizeof(callbackStruct));
//    NSCAssert (ret==noErr, @"Error: %d'", (int)ret);
//    // Set output callback
//    callbackStruct.inputProc = playbackCallback;
//    callbackStruct.inputProcRefCon = (__bridge void *)(self);
//    ret = AudioUnitSetProperty(remoteIOUnit_,
//                                  kAudioUnitProperty_SetRenderCallback,
//                                  kAudioUnitScope_Global,
//                                  0,
//                                  &callbackStruct,
//                                  sizeof(callbackStruct));
//    NSCAssert (ret==noErr, @"Error: %d'", (int)ret);
//
//    //書き込む先のurlの作成
//    NSString *Path = @"sample.aiff";
//    //書き出し側のオーディオファイルのパスを作成する（2008/6/26修正）
//    NSString *outPath =
//    [[Path stringByDeletingPathExtension]
//     stringByAppendingString:@"-export.wav"];
//    //NSURL *outUrl = [NSURL URLWithString:outPath];
//    NSURL *outUrl = [NSURL fileURLWithPath:outPath];
//    
//    //一度に変換するフレーム数
//    UInt32 convertFrames = 1024;
//    //変数の宣言
//    static ExtAudioFileRef outAudioFileRef = NULL;
//    //オーディオファイルの書き込みを行うには以下の関数でオーディオファイルを作成し、ExtAudioFileRefを取得します。
//    ret = ExtAudioFileCreateWithURL(
//                                    (__bridge CFURLRef)outUrl,
//                                    kAudioFileWAVEType,
//                                    &stereoStreamFormat,
//                                    NULL,
//                                    kAudioFileFlags_EraseFile, //上書きする
//                                    &outAudioFileRef);
//    //読み書き両方のクライアントフォーマットを設定する
//    ioClientFormat.mSampleRate = stereoStreamFormat.mSampleRate;
//    ioClientFormat.mFormatID = kAudioFormatLinearPCM;
//    ioClientFormat.mFormatFlags = kAudioFormatFlagsNativeFloatPacked;
//    ioClientFormat.mBitsPerChannel = 32;
//    ioClientFormat.mChannelsPerFrame = stereoStreamFormat.mChannelsPerFrame;
//    ioClientFormat.mFramesPerPacket = 1;
//    ioClientFormat.mBytesPerFrame =
//    ioClientFormat.mBitsPerChannel / 8 *
//    ioClientFormat.mChannelsPerFrame;
//    ioClientFormat.mBytesPerPacket =
//    ioClientFormat.mBytesPerFrame *
//    ioClientFormat.mFramesPerPacket;
//    
//    size = sizeof(ioClientFormat);
//    ret = ExtAudioFileSetProperty(
//                                  outAudioFileRef,
//                                  kExtAudioFileProperty_ClientDataFormat,
//                                  size,
//                                  &ioClientFormat);
//    //オーディオデータの読み書きに使用するメモリ領域を確保する
//    UInt32 allocByteSize = convertFrames * stereoStreamFormat.mBytesPerFrame;
//    //オーディオデータの読み書きに使用するAudioBufferListを作成する
//    static AudioBufferList ioList;
//    ioList.mNumberBuffers = 1;
//    ioList.mBuffers[0].mNumberChannels = stereoStreamFormat.mChannelsPerFrame;
//    ioList.mBuffers[0].mDataByteSize = allocByteSize;
//    ioList.mBuffers[0].mData = nil;
}

- (void)start {
    if (graph_) {
        Boolean isRunning = false;
        OSStatus ret = AUGraphIsRunning(graph_, &isRunning);
        if (ret == noErr && !isRunning) {
            ret = AUGraphStart(graph_);
            NSCAssert (ret==noErr, @"Error: %d'", (int)ret);
        }
    }
}

- (void)stop {
    if (graph_) {
        Boolean isRunning = false;
        OSStatus ret = AUGraphIsRunning(graph_, &isRunning);
        if (ret == noErr && isRunning) {
            ret = AUGraphStop(graph_);
            NSCAssert (ret==noErr, @"Error: %d'", (int)ret);
        }
    }
}

#pragma mark - callback method
//コールバックの内容
//static OSStatus    recordingCallback(
//                           void     *inRefCon,
//                           AudioUnitRenderActionFlags *ioActionFlags,
//                           const AudioTimeStamp *inTimeStamp,
//                           UInt32              inBusNumber,
//                           UInt32              inNumberFrames,
//                           AudioBufferList     *ioData) //このioDataを入力音声データだとしてみる
//{
//    NSLog(@"inNumberFrames = %d",inNumberFrames);
//
//    return noErr;
//}
//
//static OSStatus playbackCallback(void *inRefCon,
//                                 AudioUnitRenderActionFlags *ioActionFlags,
//                                 const AudioTimeStamp *inTimeStamp,
//                                 UInt32 inBusNumber,
//                                 UInt32 inNumberFrames,
//                                 AudioBufferList *ioData) {
//    // Notes: ioData contains buffers (may be more than one!)
//    // Fill them up as much as you can. Remember to set the size value in each buffer to match how
//    // much data is in the buffer.
//    return noErr;
//}

@end
