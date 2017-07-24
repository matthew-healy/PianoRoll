@testable import PianoRollLib

class MockNoteEditing: NoteEditing {
    var didAddNote = false
    var spyAddedNoteCoordinate: PianoRollCoordinate?
    func addNote(at coordinate: PianoRollCoordinate) throws {
        didAddNote = true
        spyAddedNoteCoordinate = coordinate
    }

    var didRemoveNote = false
    var spyRemovedNoteCoordinate: PianoRollCoordinate?
    func removeNote(at coordinate: PianoRollCoordinate) throws {
        didRemoveNote = true
        spyRemovedNoteCoordinate = coordinate
    }

    var stubHasNote = false
    func hasNote(at coordinate: PianoRollCoordinate) -> Bool {
        return stubHasNote
    }
}
