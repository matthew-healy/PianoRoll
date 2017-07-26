struct Note: Equatable {
    let pitch: Int
    let length: Int
    let position: Int

    static func ==(lhs: Note, rhs: Note) -> Bool {
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
