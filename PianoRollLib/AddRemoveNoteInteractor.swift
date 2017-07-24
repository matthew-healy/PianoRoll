class AddRemoveNoteInteractor {
    private let noteEditor: NoteEditing
    private unowned let delegate: AddRemoveNoteInteractionDelegate

    init(noteEditor: NoteEditing, delegate: AddRemoveNoteInteractionDelegate) {
        self.noteEditor = noteEditor
        self.delegate = delegate
    }

    func tapReceived(at coordinate: PianoRollCoordinate) {
        do {
            try handleTap(at: coordinate)
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
