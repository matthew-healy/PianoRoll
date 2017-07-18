import XCTest
@testable import PianoRollLib

class PianoRollTests: XCTestCase {
    
    func test_render_callsRenderOnRenderer() {
        let mockRenderer = MockNoteRendering()
        let pianoRoll = PianoRoll()
        pianoRoll.render(with: mockRenderer)
        XCTAssertTrue(mockRenderer.didRender)
    }
    
}
