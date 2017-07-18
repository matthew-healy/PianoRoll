struct PianoRoll {
    private var notes: [Note] = []

    func render(with renderer: NoteRendering) {
        renderer.render(notes: notes)
    }

    mutating func addNote(pitch: Int, length: Int) throws {
        guard isValid(pitch: pitch) else {
            throw PianoRollError.pitchOutOfRange
        }
        guard isValid(length: length) else {
            throw PianoRollError.invalidLength
        }
        notes = [Note(pitch: pitch, length: length)]
    }
    
    private func isValid(pitch: Int) -> Bool {
        return pitch >= 0 && pitch < 128
    }
    
    private func isValid(length: Int) -> Bool {
        return length > 0
    }
}
