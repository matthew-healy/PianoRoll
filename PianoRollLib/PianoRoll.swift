struct PianoRoll {
    private var notes: [Note] = []
    private let timeStepCount: Int

    init(timeStepCount: Int) {
        assert(timeStepCount > 0)
        self.timeStepCount = timeStepCount
    }

    func render(with renderer: NoteRendering) {
        renderer.render(notes: notes)
    }

    mutating func add(_ note: Note) throws {
        guard isValid(pitch: note.pitch) else {
            throw PianoRollError.pitchOutOfRange
        }
        guard hasValidLength(note) else {
            throw PianoRollError.invalidLength
        }
        guard isValid(position: note.position) && !overlapsExistingNote(note) else {
            throw PianoRollError.invalidPosition
        }
        notes.append(note)
    }
    
    private func isValid(pitch: Int) -> Bool {
        let midiRange = 0..<128
        return midiRange.contains(pitch)
    }
    
    private func hasValidLength(_ note: Note) -> Bool {
        return note.length > 0 && (note.position + note.length) < timeStepCount
    }

    private func isValid(position: Int) -> Bool {
        let positionRange = 0..<timeStepCount
        return positionRange.contains(position)
    }

    private func overlapsExistingNote(_ note: Note) -> Bool {
        return !notes.filter(note.hasOverlap).isEmpty
    }
}
