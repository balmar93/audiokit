//
//  AKMarimba.m
//  AudioKit
//
//  Auto-generated on 12/25/14.
//  Copyright (c) 2014 Aurelius Prochazka. All rights reserved.
//
//  Implementation of Csound's marimba:
//  http://www.csounds.com/manual/html/marimba.html
//

#import "AKMarimba.h"
#import "AKManager.h"

@implementation AKMarimba

- (instancetype)initWithFrequency:(AKParameter *)frequency
                        amplitude:(AKParameter *)amplitude
                    stickHardness:(AKConstant *)stickHardness
                   strikePosition:(AKConstant *)strikePosition
                vibratoShapeTable:(AKFunctionTable *)vibratoShapeTable
                 vibratoFrequency:(AKParameter *)vibratoFrequency
                 vibratoAmplitude:(AKParameter *)vibratoAmplitude
           doubleStrikePercentage:(AKConstant *)doubleStrikePercentage
           tripleStrikePercentage:(AKConstant *)tripleStrikePercentage
{
    self = [super initWithString:[self operationName]];
    if (self) {
        _frequency = frequency;
        _amplitude = amplitude;
        _stickHardness = stickHardness;
        _strikePosition = strikePosition;
        _vibratoShapeTable = vibratoShapeTable;
        _vibratoFrequency = vibratoFrequency;
        _vibratoAmplitude = vibratoAmplitude;
        _doubleStrikePercentage = doubleStrikePercentage;
        _tripleStrikePercentage = tripleStrikePercentage;
    }
    return self;
}

- (instancetype)init
{
    self = [super initWithString:[self operationName]];
    if (self) {
        // Default Values
        _frequency = akp(220);
        _amplitude = akp(1);
        _stickHardness = akp(0.5);
        _strikePosition = akp(0.5);
        _vibratoShapeTable = [AKManager standardSineTable];
    
        _vibratoFrequency = akp(0);
        _vibratoAmplitude = akp(0);
        _doubleStrikePercentage = akp(40);
        _tripleStrikePercentage = akp(20);
    }
    return self;
}

+ (instancetype)audio
{
    return [[AKMarimba alloc] init];
}

- (void)setOptionalFrequency:(AKParameter *)frequency {
    _frequency = frequency;
}
- (void)setOptionalAmplitude:(AKParameter *)amplitude {
    _amplitude = amplitude;
}
- (void)setOptionalStickHardness:(AKConstant *)stickHardness {
    _stickHardness = stickHardness;
}
- (void)setOptionalStrikePosition:(AKConstant *)strikePosition {
    _strikePosition = strikePosition;
}
- (void)setOptionalVibratoShapeTable:(AKFunctionTable *)vibratoShapeTable {
    _vibratoShapeTable = vibratoShapeTable;
}
- (void)setOptionalVibratoFrequency:(AKParameter *)vibratoFrequency {
    _vibratoFrequency = vibratoFrequency;
}
- (void)setOptionalVibratoAmplitude:(AKParameter *)vibratoAmplitude {
    _vibratoAmplitude = vibratoAmplitude;
}
- (void)setOptionalDoubleStrikePercentage:(AKConstant *)doubleStrikePercentage {
    _doubleStrikePercentage = doubleStrikePercentage;
}
- (void)setOptionalTripleStrikePercentage:(AKConstant *)tripleStrikePercentage {
    _tripleStrikePercentage = tripleStrikePercentage;
}

- (NSString *)stringForCSD {
    NSMutableString *csdString = [[NSMutableString alloc] init];

    // Constant Values  
    NSString *file = [[NSBundle mainBundle] pathForResource:@"marmstk1" ofType:@"wav"];
    if (!file) {
        file = @"CsoundLib64.framework/Sounds/marmstk1.wav";
    }

    AKSoundFileTable *_strikeImpulseTable;
    _strikeImpulseTable = [[AKSoundFileTable alloc] initWithFilename:file];
    [csdString appendFormat:@"%@\n", [_strikeImpulseTable stringForCSD]];
            
    AKConstant *_maximumDuration = akp(1);        
    [csdString appendFormat:@"%@ marimba ", self];

    if ([_amplitude isKindOfClass:[AKControl class]] ) {
        [csdString appendFormat:@"%@, ", _amplitude];
    } else {
        [csdString appendFormat:@"AKControl(%@), ", _amplitude];
    }

    if ([_frequency isKindOfClass:[AKControl class]] ) {
        [csdString appendFormat:@"%@, ", _frequency];
    } else {
        [csdString appendFormat:@"AKControl(%@), ", _frequency];
    }

    [csdString appendFormat:@"%@, ", _stickHardness];
    
    [csdString appendFormat:@"%@, ", _strikePosition];
    
    [csdString appendFormat:@"%@, ", _strikeImpulseTable];
    
    if ([_vibratoFrequency isKindOfClass:[AKControl class]] ) {
        [csdString appendFormat:@"%@, ", _vibratoFrequency];
    } else {
        [csdString appendFormat:@"AKControl(%@), ", _vibratoFrequency];
    }

    if ([_vibratoAmplitude isKindOfClass:[AKControl class]] ) {
        [csdString appendFormat:@"%@, ", _vibratoAmplitude];
    } else {
        [csdString appendFormat:@"AKControl(%@), ", _vibratoAmplitude];
    }

    [csdString appendFormat:@"%@, ", _vibratoShapeTable];
    
    [csdString appendFormat:@"%@, ", _maximumDuration];
    
    [csdString appendFormat:@"%@, ", _doubleStrikePercentage];
    
    [csdString appendFormat:@"%@", _tripleStrikePercentage];
    return csdString;
}

@end
