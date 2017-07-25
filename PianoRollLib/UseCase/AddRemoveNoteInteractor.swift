class AddRemoveNoteInteractor {
    private let noteEditor: NoteEditing
    private let renderable: NoteRenderable
    private unowned let renderer: NoteRendering
    private unowned let delegate: AddRemoveNoteInteractionDelegate

    init(noteEditor: NoteEditing, renderable: NoteRenderable, renderer: NoteRendering, delegate: AddRemoveNoteInteractionDelegate) {
        self.noteEditor = noteEditor
        self.renderable = renderable
        self.renderer = renderer
        self.delegate = delegate
    }

    func tapReceived(at coordinate: PianoRollCoordinate) {
        do {
            try handleTap(at: coordinate)
            renderable.render(with: renderer)
        } catch {
            guard let error = error as? PianoRollError else { return }
            delegate.received(error: error)
        }
    }

    private func handleTap(at coordinate: PianoRollCoordinate) throws {
        if noteEditor.hasNote(at: coordinate) {
            try noteEditor.removeNote(at: coordinate)
        } else {
            try noteEditor.addNote(at: coordinate)
        }
    }
}
