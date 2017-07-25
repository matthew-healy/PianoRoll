@testable import PianoRollLib

class MockNoteRendering: NoteRendering {
    var didRender = false
    var spyRenderedNotes: [Note] = []
    func render(notes: [Note]) {
        didRender = true
        spyRenderedNotes = notes
    }
}
