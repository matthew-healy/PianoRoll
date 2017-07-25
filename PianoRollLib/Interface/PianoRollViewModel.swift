import Foundation

typealias NoteViewModel = Bool

struct PianoRollViewModel {
    private let dimension: GridDimension
    private let items: Set<IndexPath>

    var pitchCount: Int {
        return dimension.pitches
    }

    var timeStepCount: Int {
        return dimension.timeSteps
    }

    init(dimension: GridDimension, items: [(Int, Int)]) {
        self.dimension = dimension
        self.items = Set(items.map { IndexPath(pitch: $0.0, time: $0.1) })
    }

    func item(at indexPath: IndexPath) -> NoteViewModel {
        return items.contains(indexPath)
    }
}
