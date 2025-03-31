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
            VStack(spacing: 20) {
                VStack(spacing: 10) {
                    TextField("Workout Name", text: $newWorkoutName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    HStack {
                        Text("Sets:")
                        TextField("", value: $sets, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    .padding(.horizontal)

                    HStack {
                        Text("Reps:")
                        TextField("", value: $reps, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    .padding(.horizontal)

                    HStack {
                        Text("Rest Time (sec):")
                        TextField("", value: $restTime, formatter: NumberFormatter())
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    .padding(.horizontal)

                    HStack {
                        Text("Duration (sec):")
                        TextField("", value: $duration, formatter: NumberFormatter())
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
                            print(success ? "Workout saved" : "Failed: \(String(describing: error))")
                        }

                        NotificationManager.shared.scheduleNotification(for: workout.name, in: 10)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }

                List {
                    ForEach(workouts.indices, id: \.self) { index in
                        NavigationLink(destination: WorkoutDetailView(workout: workouts[index])) {
                            HStack {
                                WorkoutView(workout: workouts[index])
                                Toggle("", isOn: Binding(
                                    get: { workouts[index].isCompleted },
                                    set: { workouts[index].isCompleted = $0 }
                                ))
                                .labelsHidden()
                                .toggleStyle(.switch)
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())

                Spacer()
            }
            .navigationTitle("Workout Planner")
            .onAppear {
                HealthKitManager.shared.requestAuthorization { success, error in
                    print(success ? "Authorized" : "HealthKit auth failed: \(String(describing: error))")
                }
                NotificationManager.shared.requestAuthorization()
            }
        }
    }
}
