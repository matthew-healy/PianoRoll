import XCTest
@testable import PianoRollLib

class AddRemoveNoteInteractorTests: XCTestCase {
    
    var mockNoteEditing: MockNoteEditing!
    var mockDelegate: MockAddRemoveNoteInteractionDelegate!
    var subject: AddRemoveNoteInteractor!

    override func setUp() {
        mockNoteEditing = MockNoteEditing()
        mockDelegate = MockAddRemoveNoteInteractionDelegate()
        subject = AddRemoveNoteInteractor(noteEditor: mockNoteEditing, delegate: mockDelegate)
    }

    // MARK: tapReceived(at:) tests

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

    func test_tapReceived_noNoteAtPitch3Time2_addsNoteThere() {
        let expected: PianoRollCoordinate = .create(pitch: 3, time: 2)
        subject.tapReceived(at: expected)
        XCTAssertEqual(expected, mockNoteEditing.spyAddedNoteCoordinate)
    }

    func test_tapReceived_noNoteAtPitch12Time9_addsNoteThere() {
        let expected: PianoRollCoordinate = .create(pitch: 12, time: 9)
        subject.tapReceived(at: expected)
        XCTAssertEqual(expected, mockNoteEditing.spyAddedNoteCoordinate)
    }

    func test_tapReceived_noteExistsAtPitch1Time30_removesNoteThere() {
        mockNoteEditing.stubHasNote = true
        let expected: PianoRollCoordinate = .create(pitch: 1, time: 30)
        subject.tapReceived(at: expected)
        XCTAssertEqual(expected, mockNoteEditing.spyRemovedNoteCoordinate)
    }

    func test_tapReceived_noteExistsAtPitch22Time4_removesNoteThere() {
        mockNoteEditing.stubHasNote = true
        let expected: PianoRollCoordinate = .create(pitch: 22, time: 4)
        subject.tapReceived(at: expected)
        XCTAssertEqual(expected, mockNoteEditing.spyRemovedNoteCoordinate)
    }

    func test_tapReceived_addNoteThrowsError_passesErrorToInteractionDelegate() {
        mockNoteEditing.stubAddNoteError = .pitchOutOfRange
        subject.tapReceived(at: .create())
        XCTAssertEqual(.pitchOutOfRange, mockDelegate.spyReceivedError)
    }

    func test_tapReceived_removeNoteThrowsError_passesErrorToInteractionDelegate() {
        mockNoteEditing.stubRemoveNoteError = .invalidPosition
        mockNoteEditing.stubHasNote = true
        subject.tapReceived(at: .create())
        XCTAssertEqual(.invalidPosition, mockDelegate.spyReceivedError)
    }

}
