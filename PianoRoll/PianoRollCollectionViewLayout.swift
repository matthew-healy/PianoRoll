import UIKit

class PianoRollCollectionViewLayout: UICollectionViewLayout {
    private let cellSide = 44
    let columnCount = 128
    let rowCount = 32

    var cache: [UICollectionViewLayoutAttributes] = []

    override var collectionViewContentSize: CGSize {
        return CGSize(width: cellSide * columnCount, height: cellSide * rowCount)
    }

    override func prepare() {
        guard cache.isEmpty else { return }

        let xOffset: [Int] = (0..<columnCount).map { $0 * 44 }
        var yOffset: [Int] = .init(repeating: 0, count: columnCount)
        var column = 0

        for item in 0..<(rowCount * columnCount) {
            let indexPath = IndexPath(item: item, section: 0)
            let frame = CGRect(x: xOffset[column], y: yOffset[column], width: cellSide, height: cellSide)

            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attribute.frame = frame
            cache.append(attribute)

            yOffset[column] = yOffset[column] + cellSide

            column = column >= (columnCount - 1) ? 0 : column + 1
        }

    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }
}
