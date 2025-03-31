import SwiftUI

struct WorkoutView: View {
    var workout: Workout

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(workout.name)
                    .font(.headline)
                    .fontWeight(.bold)
                    .strikethrough(workout.isCompleted, color: .gray)
                    .foregroundColor(workout.isCompleted ? .gray : .primary)
                Spacer()
                if workout.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }

            Text("Sets: \(workout.sets) x \(workout.reps)")
                .font(.subheadline)
                .foregroundColor(workout.isCompleted ? .gray : .primary)

            Text("Rest: \(workout.restTime) sec")
                .font(.subheadline)
                .foregroundColor(workout.isCompleted ? .gray : .primary)

            ProgressView(value: min(Double(workout.duration) / 1800.0, 1.0))
                .progressViewStyle(LinearProgressViewStyle())
                .accentColor(.green)
                .padding(.top, 5)
        }
        .padding()
        .background(workout.isCompleted ? Color.green.opacity(0.1) : Color.blue.opacity(0.1))
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
