class PianoRollInteractor {
    private let noteEditor: NoteEditing

    init(noteEditor: NoteEditing) {
        self.noteEditor = noteEditor
    }

    func tapReceived(at coordinate: PianoRollCoordinate) {
        try! noteEditor.addNote(at: PianoRollCoordinate(pitch: 0, time: 0))
    }
}


