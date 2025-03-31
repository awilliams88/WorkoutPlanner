import SwiftUI

struct WorkoutDetailView: View {
    var workout: Workout

    var body: some View {
        VStack(spacing: 20) {
            Text(workout.name)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Sets: \(workout.sets)")
                .font(.title2)

            Text("Reps: \(workout.reps)")
                .font(.title2)

            Text("Rest Time: \(workout.restTime) seconds")
                .font(.title2)

            Text("Duration: \(Int(workout.duration)) seconds")
                .font(.title2)

            HStack {
                Text("Completed:")
                    .font(.title2)
                Image(systemName: workout.isCompleted ? "checkmark.circle.fill" : "xmark.circle")
                    .foregroundColor(workout.isCompleted ? .green : .red)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.blue.opacity(0.2))
                .shadow(radius: 10)
        )
        .padding()
        .navigationTitle("Workout Details")
    }
}
