@testable import PianoRollLib

class MockPianoRollView: PianoRollViewing {
    var didDisplay = false
    var spyDisplayedViewModel: PianoRollViewModel?
    func display(viewModel: PianoRollViewModel) {
        didDisplay = true
        spyDisplayedViewModel = viewModel
    }
}
