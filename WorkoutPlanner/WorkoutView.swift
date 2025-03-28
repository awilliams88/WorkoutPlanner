import SwiftUI

struct WorkoutView: View {
    var workout: Workout

    var body: some View {
        VStack(alignment: .leading) {
            Text(workout.name)
                .font(.headline)
            Text("Sets: \(workout.sets)")
            Text("Reps: \(workout.reps)")
            Text("Rest Time: \(workout.restTime) seconds")
            Text("Duration: \(Int(workout.duration)) seconds")
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}
