import UIKit
import PianoRollLib

class PianoRollViewController: UIViewController {

    @IBOutlet weak var pianoRollCollectionView: UICollectionView!

    fileprivate var pianoRoll: PianoRoll!
    fileprivate var notes: [Note] = [] {
        didSet{
            pianoRollCollectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        setUpPianoRoll()
    }


    private func setUpCollectionView () {
        pianoRollCollectionView.collectionViewLayout = PianoRollCollectionViewLayout()
        pianoRollCollectionView.delegate = self
        pianoRollCollectionView.dataSource = self
    }

    private func setUpPianoRoll() {
        pianoRoll = PianoRoll(timeStepCount: 32)
        pianoRoll.render(with: self)
    }

}

extension PianoRollViewController: NoteRendering {
    func render(notes: [Note]) {
        self.notes = notes
    }
}

extension PianoRollViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PianoRollCollectionViewCell.identifier,
            for: indexPath
        )
        let isNoteHighlighted = !notes.filter { ($0.pitch + 1) * $0.position == indexPath.row }.isEmpty
        cell.backgroundColor = isNoteHighlighted ? .yellow : .white
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pianoRoll.numberOfTimeSteps * pianoRoll.numberOfPitches
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pitch = indexPath.row / pianoRoll.numberOfTimeSteps
        let position = 1
        let note = Note(pitch: pitch, length: 1, position: position)
        do {
            try pianoRoll.add(note)
        } catch {
            do {
                try pianoRoll.removeNote(withPitch: note.pitch, atTime: note.position)
            } catch { }
        }
        pianoRoll.render(with: self)
    }
}
