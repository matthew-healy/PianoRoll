@testable import PianoRollLib

class MockAddRemoveNoteInteractorOutput: AddRemoveNoteInteractorOutput {
    var didReceiveError = false
    var spyReceivedError: PianoRollError?
    func received(error: PianoRollError) {
        didReceiveError = true
        spyReceivedError = error
    }
}
