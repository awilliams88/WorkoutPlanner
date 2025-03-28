import SwiftUI

struct WorkoutView: View {
    var workout: Workout

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(workout.name)
                .font(.headline)
                .fontWeight(.bold)
            Text("Sets: \(workout.sets) x \(workout.reps)")
                .font(.subheadline)
            Text("Rest: \(workout.restTime) seconds")
                .font(.subheadline)

            ProgressView(value: min(Double(workout.duration) / 1800.0, 1.0))
                .progressViewStyle(LinearProgressViewStyle())
                .accentColor(.green)
                .padding(.top, 5)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 5)
        .animation(.easeInOut, value: workout.duration)
    }
}

#Preview {
    WorkoutView(workout: Workout(name: "Squats", sets: 3, reps: 15, restTime: 60, duration: 1800))
}
