import XCTest
@testable import PianoRollLib

class AddRemoveNoteInteractorTests: XCTestCase {
    
    var mockNoteEditing: MockNoteEditing!
    var subject: AddRemoveNoteInteractor!

    override func setUp() {
        mockNoteEditing = MockNoteEditing()
        subject = AddRemoveNoteInteractor(noteEditor: mockNoteEditing)
    }

    // MARK: tapReceived(at:) tests

    func test_tapReceived_noNoteAtCoordinate_addsNote() {
        subject.tapReceived(at: .create())
        XCTAssertTrue(mockNoteEditing.didAddNote)
    }

    func test_tapReceived_noteExistsAtCoordinate_removesNote() {
        mockNoteEditing.stubHasNote = true
        subject.tapReceived(at: .create())
        XCTAssertTrue(mockNoteEditing.didRemoveNote)
    }

    func test_tapReceived_noNoteAtCoordinate_doesNotRemoveNote() {
        subject.tapReceived(at: .create())
        XCTAssertFalse(mockNoteEditing.didRemoveNote)
    }

    func test_tapReceived_noteExistsAtCoordinate_doesNotAddNote() {
        mockNoteEditing.stubHasNote = true
        subject.tapReceived(at: .create())
        XCTAssertFalse(mockNoteEditing.didAddNote)
    }

    func test_tapReceived_pitch1time1_checksForNoteAtCoordinate() {
        let expected: PianoRollCoordinate = .create(pitch: 1, time: 1)
        subject.tapReceived(at: expected)
        XCTAssertEqual(expected, mockNoteEditing.spyHasNoteAtCoordinate)
    }

    func test_tapReceived_pitch7time12_checkedCoordinateIsNotHardcoded() {
        let expected: PianoRollCoordinate = .create(pitch: 7, time: 12)
        subject.tapReceived(at: expected)
        XCTAssertEqual(expected, mockNoteEditing.spyHasNoteAtCoordinate)
    }

}
