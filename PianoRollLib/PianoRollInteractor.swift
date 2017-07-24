class PianoRollInteractor {
    private let noteEditor: NoteEditing

    init(noteEditor: NoteEditing) {
        self.noteEditor = noteEditor
    }

    func tapReceived(at coordinate: PianoRollCoordinate) {
        try! noteEditor.add(Note(pitch: 0, length: 1, position: 0))
    }
}


