import XCTest
@testable import PianoRollLib

class PianoRollInteractorTests: XCTestCase {
    
    func test_tapReceived_noNoteAtCoordinate_addsNote() {
        let mockNoteEditing = MockNoteEditing()
        let subject = PianoRollInteractor(noteEditor: mockNoteEditing)
        subject.tapReceived(at: .create())
        XCTAssertTrue(mockNoteEditing.didAddNote)
    }

}
