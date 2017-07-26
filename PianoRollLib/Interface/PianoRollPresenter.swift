class PianoRollPresenter: NoteRendering, AddRemoveNoteInteractorOutput {
    private unowned let view: PianoRollViewing

    init(view: PianoRollViewing) {
        self.view = view
    }

    func render(notes: [Note], onGridWith dimension: GridDimension) {
        let model = PianoRollViewModel(
            dimension: dimension,
            items: notes.map { ($0.pitch, $0.position) }
        )
        view.display(viewModel: model)
    }

    func received(error: PianoRollError) {
        view.displayError()
    }
}

