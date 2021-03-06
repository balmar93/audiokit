// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// When fed with a pulse train, it will generate a series of overlapping grains. 
/// Overlapping will occur when 1/freq < dec, but there is no upper limit on the number of overlaps.
/// 
public class FormantFilter: Node, AudioUnitContainer, Tappable, Toggleable {

    /// Unique four-letter identifier "fofi"
    public static let ComponentDescription = AudioComponentDescription(effect: "fofi")

    /// Internal type of audio unit for this node
    public typealias AudioUnitType = InternalAU

    /// Internal audio unit 
    public private(set) var internalAU: AudioUnitType?

    // MARK: - Parameters

    /// Specification details for centerFrequency
    public static let centerFrequencyDef = NodeParameterDef(
        identifier: "centerFrequency",
        name: "Center Frequency (Hz)",
        address: akGetParameterAddress("FormantFilterParameterCenterFrequency"),
        range: 12.0 ... 20_000.0,
        unit: .hertz,
        flags: .default)

    /// Center frequency.
    @Parameter public var centerFrequency: AUValue

    /// Specification details for attackDuration
    public static let attackDurationDef = NodeParameterDef(
        identifier: "attackDuration",
        name: "Impulse response attack time (Seconds)",
        address: akGetParameterAddress("FormantFilterParameterAttackDuration"),
        range: 0.0 ... 0.1,
        unit: .seconds,
        flags: .default)

    /// Impulse response attack time (in seconds).
    @Parameter public var attackDuration: AUValue

    /// Specification details for decayDuration
    public static let decayDurationDef = NodeParameterDef(
        identifier: "decayDuration",
        name: "Impulse reponse decay time (Seconds)",
        address: akGetParameterAddress("FormantFilterParameterDecayDuration"),
        range: 0.0 ... 0.1,
        unit: .seconds,
        flags: .default)

    /// Impulse reponse decay time (in seconds)
    @Parameter public var decayDuration: AUValue

    // MARK: - Audio Unit

    /// Internal Audio Unit for FormantFilter
    public class InternalAU: AudioUnitBase {
        /// Get an array of the parameter definitions
        /// - Returns: Array of parameter definitions
        public override func getParameterDefs() -> [NodeParameterDef] {
            [FormantFilter.centerFrequencyDef,
             FormantFilter.attackDurationDef,
             FormantFilter.decayDurationDef]
        }

        /// Create the DSP Refence for this node
        /// - Returns: DSP Reference
        public override func createDSP() -> DSPRef {
            akCreateDSP("FormantFilterDSP")
        }
    }

    // MARK: - Initialization

    /// Initialize this filter node
    ///
    /// - Parameters:
    ///   - input: Input node to process
    ///   - centerFrequency: Center frequency.
    ///   - attackDuration: Impulse response attack time (in seconds).
    ///   - decayDuration: Impulse reponse decay time (in seconds)
    ///
    public init(
        _ input: Node,
        centerFrequency: AUValue = 1_000,
        attackDuration: AUValue = 0.007,
        decayDuration: AUValue = 0.04
        ) {
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit { avAudioUnit in
            self.avAudioUnit = avAudioUnit
            self.avAudioNode = avAudioUnit

            guard let audioUnit = avAudioUnit.auAudioUnit as? AudioUnitType else {
                fatalError("Couldn't create audio unit")
            }
            self.internalAU = audioUnit

            self.centerFrequency = centerFrequency
            self.attackDuration = attackDuration
            self.decayDuration = decayDuration
        }
        connections.append(input)
    }
}
