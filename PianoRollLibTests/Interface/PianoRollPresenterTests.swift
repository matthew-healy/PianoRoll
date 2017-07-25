import XCTest
@testable import PianoRollLib

class PianoRollPresenterTests: XCTestCase {
    
    var mockView: MockPianoRollView!
    var subject: PianoRollPresenter!

    override func setUp() {
        mockView = MockPianoRollView()
        subject = PianoRollPresenter(view: mockView)
    }

    // MARK: render tests

    func test_render_callsDisplayOnView() {
        subject.render(notes: [], onGridWith: .create())
        XCTAssertTrue(mockView.didDisplay)
    }
    
    func test_render_dimension0By0_displaysViewModelWithCorrectDimension() {
        let expected: PianoRollViewModel = .create()
        subject.render(notes: [], onGridWith: .create())
        XCTAssertEqual(expected, mockView.spyDisplayedViewModel)
    }

    func test_render_dimension6By2_displaysViewModelWith1TimeStep() {
        let expected: PianoRollViewModel = .create(pitchCount: 6, timeStepCount: 2)
        subject.render(notes: [], onGridWith: .create(pitches: 6, timeSteps: 2))
        XCTAssertEqual(expected, mockView.spyDisplayedViewModel)
    }

}
