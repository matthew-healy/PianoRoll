@testable import PianoRollLib

class MockPianoRollView: PianoRollViewing {
    var didDisplay = false
    func display() {
        didDisplay = true
    }
}
