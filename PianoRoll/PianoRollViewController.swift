import UIKit
import PianoRollLib

class PianoRollViewController: UIViewController {

    @IBOutlet weak var pianoRollCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }


    private func setUpCollectionView () {
        pianoRollCollectionView.delegate = self
        pianoRollCollectionView.dataSource = self
    }

}

extension PianoRollViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PianoRollCollectionViewCell.identifier,
            for: indexPath
        )
        return cell
    }
}
