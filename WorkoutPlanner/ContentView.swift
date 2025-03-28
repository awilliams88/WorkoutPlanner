import SwiftUI

struct ContentView: View {
    @State private var workouts: [Workout] = []
    @State private var newWorkoutName: String = ""
    @State private var sets: Int = 3
    @State private var reps: Int = 10
    @State private var restTime: Int = 60
    @State private var duration: TimeInterval = 1800

    var body: some View {
        NavigationView {
            VStack {
                TextField("Workout Name", text: $newWorkoutName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                HStack {
                    Text("Sets:")
                    TextField("3", value: $sets, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }
                .padding(.horizontal)

                HStack {
                    Text("Reps:")
                    TextField("10", value: $reps, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }
                .padding(.horizontal)

                HStack {
                    Text("Rest Time (sec):")
                    TextField("60", value: $restTime, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }
                .padding(.horizontal)

                HStack {
                    Text("Duration (sec):")
                    TextField("1800", value: $duration, formatter: NumberFormatter())
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                }
                .padding(.horizontal)

                Button("Add Workout") {
                    let workout = Workout(name: newWorkoutName, sets: sets, reps: reps, restTime: restTime, duration: duration)
                    workouts.append(workout)
                    newWorkoutName = ""
                    sets = 3
                    reps = 10
                    restTime = 60
                    duration = 1800

                    HealthKitManager.shared.saveWorkout(duration: duration) { success, error in
                        if success {
                            print("Workout saved to HealthKit")
                        } else {
                            print("Failed to save workout: \(String(describing: error))")
                        }
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)

                List(workouts) { workout in
                    WorkoutView(workout: workout)
                }

                Spacer()
            }
            .navigationTitle("Workout Planner")
            .onAppear {
                HealthKitManager.shared.requestAuthorization { success, error in
                    if success {
                        print("HealthKit access granted")
                    } else {
                        print("HealthKit authorization failed: \(String(describing: error))")
                    }
                }
            }
        }
    }
}
