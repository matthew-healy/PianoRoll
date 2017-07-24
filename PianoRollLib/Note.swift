public struct Note: Equatable {
    public let pitch: Int
    public let length: Int
    public let position: Int

    public init(pitch: Int, length: Int, position: Int) {
        self.pitch = pitch
        self.length = length
        self.position = position
    }

    public static func ==(lhs: Note, rhs: Note) -> Bool {
        return lhs.pitch == rhs.pitch
            && lhs.length == rhs.length
            && lhs.position == rhs.position
    }

    func hasOverlap(with other: Note) -> Bool {
        guard pitch == other.pitch else { return false }
        guard position != other.position else { return true }
        let (first, second) = position < other.position ? (self, other) : (other, self)
        return second.position < first.position + first.length
    }
}
