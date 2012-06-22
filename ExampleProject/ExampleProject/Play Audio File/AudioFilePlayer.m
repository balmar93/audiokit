//
//  AudioFilePlayer.m
//  ExampleProject
//
//  Created by Aurelius Prochazka on 6/16/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//

#import "AudioFilePlayer.h"

@implementation AudioFilePlayer


-(id) initWithOrchestra:(OCSOrchestra *)orch {
    self = [super initWithOrchestra:orch];
    if (self) {
        
        // INSTRUMENT DEFINITION ===============================================
        
        NSString * file = [[NSBundle mainBundle] pathForResource:@"hellorcb" ofType:@"aif"];
        OCSSoundFileTable * fileTable = [[OCSSoundFileTable alloc] initWithFilename:file];
        [self addFunctionTable:fileTable];
        
        OCSLoopingOscillator * trigger = 
        [[OCSLoopingOscillator alloc] initWithSoundFileTable:fileTable];
        [self addOpcode:trigger];
        
        OCSReverb * reverb = 
        [[OCSReverb alloc] initWithMonoInput:[trigger output1] 
                               FeedbackLevel:[OCSParamConstant paramWithFloat:0.85f] 
                             CutoffFrequency:[OCSParamConstant paramWithInt:12000]];
        
        [self addOpcode:reverb];
        
        // AUDIO OUTPUT ========================================================

        OCSOutputStereo * stereoOutput = 
        [[OCSOutputStereo alloc] initWithInputLeft:[reverb outputLeft] 
                                        InputRight:[reverb outputRight]]; 
        [self addOpcode:stereoOutput];
    }
    return self;
}

-(void) play {
    [self playNoteForDuration:3.0f];
}

@end
