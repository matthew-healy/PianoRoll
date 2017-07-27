public class PianoRollWireframe {
    private let addRemoveNoteInteractor: AddRemoveNoteInteractor
    private let presenter: PianoRollPresenter

    public init(view: PianoRollViewing) {
        presenter = PianoRollPresenter(view: view)
        let roll = PianoRoll(timeStepCount: 32)
        addRemoveNoteInteractor = AddRemoveNoteInteractor(
            noteEditor: roll,
            renderable: roll,
            renderer: presenter,
            delegate: presenter
        )
        roll.render(with: presenter)
    }
}
