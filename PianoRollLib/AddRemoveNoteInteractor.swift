class AddRemoveNoteInteractor: NoteRendering {
    private let noteEditor: NoteEditing
    private let renderable: NoteRenderable
    private unowned let delegate: AddRemoveNoteInteractionDelegate

    init(noteEditor: NoteEditing, renderable: NoteRenderable, delegate: AddRemoveNoteInteractionDelegate) {
        self.noteEditor = noteEditor
        self.renderable = renderable
        self.delegate = delegate
    }

    func tapReceived(at coordinate: PianoRollCoordinate) {
        do {
            try handleTap(at: coordinate)
            renderable.render(with: self)
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

    func render(notes: [Note]) {

    }
}
