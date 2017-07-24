@testable import PianoRollLib

class MockAddRemoveNoteInteractionDelegate: AddRemoveNoteInteractionDelegate {
    var didReceiveError = false
    var spyReceivedError: PianoRollError?
    func received(error: PianoRollError) {
        didReceiveError = true
        spyReceivedError = error
    }
}
