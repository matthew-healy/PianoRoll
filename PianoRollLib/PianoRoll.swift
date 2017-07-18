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
        guard isValid(length: note.length) else {
            throw PianoRollError.invalidLength
        }
        guard isValid(position: note.position) && !notes.contains(note) else {
            throw PianoRollError.invalidPosition
        }
        notes.append(note)
    }
    
    private func isValid(pitch: Int) -> Bool {
        let midiRange = 0..<128
        return midiRange.contains(pitch)
    }
    
    private func isValid(length: Int) -> Bool {
        return length > 0
    }

    private func isValid(position: Int) -> Bool {
        let positionRange = 0..<timeStepCount
        return positionRange.contains(position)
    }
}
