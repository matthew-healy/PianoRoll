class PianoRollPresenter: NoteRendering {
    private unowned let view: PianoRollViewing

    init(view: PianoRollViewing) {
        self.view = view
    }

    func render(notes: [Note], onGridWith dimensions: GridDimensions) {
        view.display()
    }
}

