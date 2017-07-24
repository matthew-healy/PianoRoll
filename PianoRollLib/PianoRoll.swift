struct PianoRoll {
    private var notes: [Note] = []
    private let timeStepCount: Int
    private let midiRange = 0...127

    var numberOfPitches: Int {
        return midiRange.count
    }

    var numberOfTimeSteps: Int {
        return timeStepCount
    }

    init(timeStepCount: Int) {
        assert(timeStepCount > 0)
        self.timeStepCount = timeStepCount
    }

    func render(with renderer: NoteRendering) {
        renderer.render(notes: notes)
    }

    mutating func add(_ note: Note) throws {
        try validate(pitch: note.pitch)
        guard isValid(position: note.position) && !overlapsExistingNote(note) else {
            throw PianoRollError.invalidPosition
        }
        guard hasValidLength(note) else {
            throw PianoRollError.invalidLength
        }
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

    private func overlapsExistingNote(_ note: Note) -> Bool {
        return !notes.filter(note.hasOverlap).isEmpty
    }

    mutating func removeNote(withPitch pitch: Int, atTime time: Int) throws {
        try validate(pitch: pitch)
        guard isValid(position: time) else {
            throw PianoRollError.invalidPosition
        }
        notes = notes.filter { note -> Bool in
            guard note.pitch == pitch else { return true }
            let validPositions = note.position...(note.position + note.length)
            return !validPositions.contains(time)
        }
    }

    func hasNote(withPitch pitch: Int, atTime time: Int) -> Bool {
        guard isValid(position: time) else { return false }
        let proxyNote = Note(pitch: pitch, length: 1, position: time)
        return overlapsExistingNote(proxyNote)
    }
}
