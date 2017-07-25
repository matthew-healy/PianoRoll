@testable import PianoRollLib

class MockNoteRenderable: NoteRenderable {
    var didRender = false
    var spyRenderer: NoteRendering?
    func render(with renderer: NoteRendering) {
        didRender = true
        spyRenderer = renderer
    }
}
