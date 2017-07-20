import UIKit

class PianoRollCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: PianoRollCollectionViewCell.self)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.gray.cgColor
    }
}
