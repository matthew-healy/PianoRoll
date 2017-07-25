import XCTest
@testable import PianoRollLib

class PianoRollPresenterTests: XCTestCase {
    
    // MARK: render tests

    func test_render_callsDisplayOnView() {
        let mockView = MockPianoRollView()
        let subject = PianoRollPresenter(view: mockView)
        subject.render(notes: [], onGridWith: .create())
        XCTAssertTrue(mockView.didDisplay)
    }
    
}
