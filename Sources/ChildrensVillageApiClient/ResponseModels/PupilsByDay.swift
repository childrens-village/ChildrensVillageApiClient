import Foundation

public struct PupilsByDay: Decodable {
  let id: Int
  let day: DayOfWeek
  let pupils: [Pupil]
}
