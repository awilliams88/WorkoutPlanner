import Foundation

struct Workout: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var sets: Int
    var reps: Int
    var restTime: Int
    var duration: TimeInterval
}
