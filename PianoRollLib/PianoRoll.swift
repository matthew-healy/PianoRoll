struct PianoRoll {
    private var notes: [Note] = []

    func render(with renderer: NoteRendering) {
        renderer.render(notes: notes)
    }

    mutating func add(_ note: Note) throws {
        guard isValid(pitch: note.pitch) else {
            throw PianoRollError.pitchOutOfRange
        }
        guard isValid(length: note.length) else {
            throw PianoRollError.invalidLength
        }
        notes.append(note)
    }
    
    private func isValid(pitch: Int) -> Bool {
        return pitch >= 0 && pitch < 128
    }
    
    private func isValid(length: Int) -> Bool {
        return length > 0
    }
}
