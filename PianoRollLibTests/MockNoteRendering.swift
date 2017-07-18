@testable import PianoRollLib

class MockNoteRendering: NoteRendering {
    var didRender = false
    func render() {
        didRender = true
    }
}
