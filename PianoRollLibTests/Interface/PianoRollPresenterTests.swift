import XCTest
@testable import PianoRollLib

class PianoRollPresenterTests: XCTestCase {
    
    func test_render_callsDisplayOnView() {
        let mockView = MockPianoRollView()
        let subject = PianoRollPresenter(view: mockView)
        subject.render(notes: [])
        XCTAssertTrue(mockView.didDisplay)
    }
    
}
