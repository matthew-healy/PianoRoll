struct Note: Equatable {
    let pitch: Int
    let length: Int
    let position: Int

    static func ==(lhs: Note, rhs: Note) -> Bool {
        return lhs.pitch == rhs.pitch
            && lhs.length == rhs.length
            && lhs.position == rhs.position
    }
}
