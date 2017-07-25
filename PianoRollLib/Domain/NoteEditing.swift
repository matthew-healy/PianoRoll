protocol NoteEditing {
    func addNote(at coordinate: PianoRollCoordinate) throws
    func removeNote(at coordinate: PianoRollCoordinate) throws
    func hasNote(at coordinate: PianoRollCoordinate) -> Bool
}

