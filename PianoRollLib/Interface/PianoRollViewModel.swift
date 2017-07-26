import Foundation

public typealias NoteViewModel = Bool

public struct PianoRollViewModel: Equatable {
    private let dimension: GridDimension
    private let items: Set<IndexPath>

    public var pitchCount: Int {
        return dimension.pitches
    }

    public var timeStepCount: Int {
        return dimension.timeSteps
    }

    init(dimension: GridDimension, items: [(Int, Int)]) {
        self.dimension = dimension
        self.items = Set(items.map { IndexPath(pitch: $0.0, time: $0.1) })
    }

    public static func ==(lhs: PianoRollViewModel, rhs: PianoRollViewModel) -> Bool {
        return lhs.dimension == rhs.dimension && lhs.items == rhs.items
    }

    public func item(at indexPath: IndexPath) -> NoteViewModel {
        return items.contains(indexPath)
    }
}
