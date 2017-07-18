struct PianoRoll {
    private var notes: [Note] = []

    func render(with renderer: NoteRendering) {
        renderer.render(notes: notes)
    }

    mutating func addNote(pitch: Int, length: Int) throws {
        guard pitch > 0 else {
            throw PianoRollError.pitchOutOfRange
        }
        notes.append(Note(pitch: 100, length: 4))
    }
}
