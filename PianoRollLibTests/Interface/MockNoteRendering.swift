@testable import PianoRollLib

class MockNoteRendering: NoteRendering {
    var didRender = false
    var spyRenderedNotes: [Note] = []
    var spyRenderedDimensions: GridDimensions?
    func render(notes: [Note], onGridWith dimensions: GridDimensions) {
        didRender = true
        spyRenderedNotes = notes
        spyRenderedDimensions = dimensions
    }
}
