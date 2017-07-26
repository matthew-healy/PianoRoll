@testable import PianoRollLib

class MockPianoRollView: PianoRollViewing {
    var spyDisplayedViewModel: PianoRollViewModel?
    func display(viewModel: PianoRollViewModel) {
        spyDisplayedViewModel = viewModel
    }

    var didDisplayError = false
    func displayError() {
        didDisplayError = true
    }
}
