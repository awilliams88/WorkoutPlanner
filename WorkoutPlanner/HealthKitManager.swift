import HealthKit

class HealthKitManager {
    static let shared = HealthKitManager()
    let healthStore = HKHealthStore()

    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, nil)
            return
        }

        let typesToShare: Set = [HKObjectType.workoutType()]
        let typesToRead: Set = [HKObjectType.workoutType()]

        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
            completion(success, error)
        }
    }

    func saveWorkout(duration: TimeInterval, completion: @escaping (Bool, Error?) -> Void) {
        let startDate = Date()
        let endDate = startDate.addingTimeInterval(duration)

        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .functionalStrengthTraining

        let builder = HKWorkoutBuilder(healthStore: healthStore, configuration: configuration, device: .local())
        builder.beginCollection(withStart: startDate) { success, error in
            if !success {
                completion(false, error)
                return
            }

            builder.endCollection(withEnd: endDate) { success, error in
                if !success {
                    completion(false, error)
                    return
                }

                builder.finishWorkout { workout, error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
            }
        }
    }

    func loadWorkouts(completion: @escaping ([HKWorkout]?, Error?) -> Void) {
        let workoutType = HKObjectType.workoutType()
        let query = HKSampleQuery(sampleType: workoutType, predicate: nil, limit: 0, sortDescriptors: nil) { _, results, error in
            completion(results as? [HKWorkout], error)
        }
        healthStore.execute(query)
    }
}
