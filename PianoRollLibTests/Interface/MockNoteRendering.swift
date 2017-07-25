@testable import PianoRollLib

class MockNoteRendering: NoteRendering {
    var didRender = false
    var spyRenderedNotes: [Note] = []
    var spyRenderedDimension: GridDimension?
    func render(notes: [Note], onGridWith dimension: GridDimension) {
        didRender = true
        spyRenderedNotes = notes
        spyRenderedDimension = dimension
    }
}
