protocol NoteEditing {
    func add(_ note: Note) throws
    func removeNote(at coordinate: PianoRollCoordinate) throws
    func hasNote(at coordinate: PianoRollCoordinate) -> Bool
}

class PianoRoll: NoteEditing {
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

    func add(_ note: Note) throws {
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
        let proxyNote = Note(pitch: coordinate.pitch, length: 1, position: coordinate.time)
        return overlapsExistingNote(proxyNote)
    }
}
