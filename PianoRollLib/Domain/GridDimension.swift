struct GridDimension: Equatable {
    let pitches: Int
    let timeSteps: Int

    static func ==(lhs: GridDimension, rhs: GridDimension) -> Bool {
        return lhs.pitches == rhs.pitches && lhs.timeSteps == rhs.timeSteps
    }
}
