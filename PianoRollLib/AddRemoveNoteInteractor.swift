class AddRemoveNoteInteractor {
    private let noteEditor: NoteEditing

    init(noteEditor: NoteEditing) {
        self.noteEditor = noteEditor
    }

    func tapReceived(at coordinate: PianoRollCoordinate) {
        if noteEditor.hasNote(at: coordinate) {
            try! noteEditor.removeNote(at: coordinate)
        } else {
            try! noteEditor.addNote(at: coordinate)
        }
    }
}


