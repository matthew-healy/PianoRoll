import Foundation

typealias NoteViewModel = Bool

struct PianoRollViewModel {
    let pitchCount: Int
    let timeStepCount: Int
    private let items: Set<IndexPath>

    init(pitchCount: Int, timeStepCount: Int, items: [(Int, Int)]) {
        self.pitchCount = pitchCount
        self.timeStepCount = timeStepCount
        self.items = Set(items.map { IndexPath(pitch: $0.0, time: $0.1) })
    }

    func item(at indexPath: IndexPath) -> NoteViewModel {
        return items.contains(indexPath)
    }
}
