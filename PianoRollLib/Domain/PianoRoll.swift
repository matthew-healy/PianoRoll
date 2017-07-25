class PianoRoll: NoteEditing, NoteRenderable {
    private var notes: [Note] = []
    private let timeStepCount: Int
    private let midiRange = 0...127

    init(timeStepCount: Int) {
        assert(timeStepCount > 0)
        self.timeStepCount = timeStepCount
    }

    func render(with renderer: NoteRendering) {
        renderer.render(
            notes: notes,
            onGridWith: (pitches: midiRange.count, timeSteps: timeStepCount)
        )
    }

    func addNote(at coordinate: PianoRollCoordinate) throws {
        try validate(pitch: coordinate.pitch)
        guard isValid(position: coordinate.time) && !overlapsExistingNote(coordinate) else {
            throw PianoRollError.invalidPosition
        }
        let note = Note(pitch: coordinate.pitch, length: 1, position: coordinate.time)
        notes.append(note)
    }
    
    private func validate(pitch: Int) throws {
        guard isValid(pitch: pitch) else {
            throw PianoRollError.pitchOutOfRange
        }
    }

    private func isValid(pitch: Int) -> Bool {
        return midiRange.contains(pitch)
    }
    
    private func hasValidLength(_ note: Note) -> Bool {
        return note.length > 0 && (note.position + note.length) < timeStepCount
    }

    private func isValid(position: Int) -> Bool {
        let positionRange = 0..<timeStepCount
        return positionRange.contains(position)
    }

    private func overlapsExistingNote(_ coordinate: PianoRollCoordinate) -> Bool {
        let proxyNote = Note(pitch: coordinate.pitch, length: 1, position: coordinate.time)
        return !notes.filter(proxyNote.hasOverlap).isEmpty
    }

    func removeNote(at coordinate: PianoRollCoordinate) throws {
        try validate(pitch: coordinate.pitch)
        guard isValid(position: coordinate.time) else {
            throw PianoRollError.invalidPosition
        }
        notes = notes.filter { note -> Bool in
            guard note.pitch == coordinate.pitch else { return true }
            let validPositions = note.position...(note.position + note.length)
            return !validPositions.contains(coordinate.time)
        }
    }

    func hasNote(at coordinate: PianoRollCoordinate) -> Bool {
        guard isValid(position: coordinate.time) else { return false }
        return overlapsExistingNote(coordinate)
    }
}
