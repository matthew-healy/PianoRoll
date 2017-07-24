@testable import PianoRollLib

class MockNoteRenderable: NoteRenderable {
    var didRender = false
    func render(with renderer: NoteRendering) {
        didRender = true
    }
}
