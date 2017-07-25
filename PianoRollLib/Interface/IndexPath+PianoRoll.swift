import Foundation

extension IndexPath {
    var pitch: Int {
        return self[0]
    }

    var time: Int {
        return self [1]
    }

    init(pitch: Int, time: Int) {
        self.init(indexes: [pitch, time])
    }
}
