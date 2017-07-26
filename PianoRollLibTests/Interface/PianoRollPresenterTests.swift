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

    func test_render_notePitch0Time0_displaysItemWithPitch0Time0() {
        let expected: PianoRollViewModel = .create(items: [(0, 0)])
        subject.render(notes: [.create(pitch: 0, position: 0)], onGridWith: .create())
        XCTAssertEqual(expected, mockView.spyDisplayedViewModel)
    }

    func test_render_multipleNotes_displaysThemCorrectly() {
        let expected: PianoRollViewModel = .create(items: [(1, 5), (12, 42)])
        subject.render(
            notes: [.create(pitch: 1, position: 5), .create(pitch: 12, position: 42)],
            onGridWith: .create()
        )
        XCTAssertEqual(expected, mockView.spyDisplayedViewModel)
    }

}
