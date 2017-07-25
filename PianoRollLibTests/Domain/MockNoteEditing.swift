@testable import PianoRollLib

class MockNoteEditing: NoteEditing {
    var didAddNote = false
    var spyAddedNoteCoordinate: PianoRollCoordinate?
    var stubAddNoteError: PianoRollError?
    func addNote(at coordinate: PianoRollCoordinate) throws {
        didAddNote = true
        spyAddedNoteCoordinate = coordinate
        if let error = stubAddNoteError {
            throw error
        }
    }

    var didRemoveNote = false
    var spyRemovedNoteCoordinate: PianoRollCoordinate?
    var stubRemoveNoteError: PianoRollError?
    func removeNote(at coordinate: PianoRollCoordinate) throws {
        didRemoveNote = true
        spyRemovedNoteCoordinate = coordinate
        if let error = stubRemoveNoteError {
            throw error
        }
    }

    var stubHasNote = false
    var spyHasNoteAtCoordinate: PianoRollCoordinate?
    func hasNote(at coordinate: PianoRollCoordinate) -> Bool {
        spyHasNoteAtCoordinate = coordinate
        return stubHasNote
    }
}
