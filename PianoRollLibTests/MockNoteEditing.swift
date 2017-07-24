@testable import PianoRollLib

class MockNoteEditing: NoteEditing {
    var didAddNote = false
    var spyAddedNote: Note?
    func add(_ note: Note) throws {
        didAddNote = true
        spyAddedNote = note
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
