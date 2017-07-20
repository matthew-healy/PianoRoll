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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PianoRollCollectionViewCell.identifier, for: indexPath)
        for note in notes where note.pitch == indexPath.section && note.position == indexPath.row {
            cell.backgroundColor = .yellow
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pianoRoll.numberOfTimeSteps
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return pianoRoll.numberOfPitches
    }
}
