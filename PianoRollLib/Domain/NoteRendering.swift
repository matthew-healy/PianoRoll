typealias GridDimensions = (pitches: Int, timeSteps: Int)

protocol NoteRendering: class {
    func render(notes: [Note], onGridWith dimensions: GridDimensions)
}
