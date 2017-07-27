import UIKit
import PianoRollLib

class PianoRollViewController: UIViewController, PianoRollViewing {

    @IBOutlet weak var pianoRollCollectionView: UICollectionView!

    private var viewModel: PianoRollViewModel?
    private var wireframe: PianoRollWireframe?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
        self.wireframe = PianoRollWireframe(view: self)
    }

    private func setUpCollectionView () {
        pianoRollCollectionView.delegate = self
        pianoRollCollectionView.dataSource = self
    }

    func display(viewModel: PianoRollViewModel) {
        self.viewModel = viewModel
        pianoRollCollectionView.reloadData()
    }

    func displayError() {

    }
}

extension PianoRollViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.timeStepCount ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.pitchCount ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PianoRollCollectionViewCell.identifier,
            for: indexPath
        )
        if let itemModel = viewModel?.item(at: indexPath) {
            cell.backgroundColor = itemModel ? .yellow : .white
        }
        return cell
    }
}
