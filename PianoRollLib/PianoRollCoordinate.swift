struct PianoRollCoordinate: Equatable {
    let pitch: Int
    let time: Int

    static func ==(lhs: PianoRollCoordinate, rhs: PianoRollCoordinate) -> Bool {
        return lhs.pitch == rhs.pitch
            && lhs.time == rhs.time

    }
}
