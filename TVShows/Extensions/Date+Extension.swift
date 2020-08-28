import Foundation

extension Date {
    static var yearValue: Int {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        return Int(yearString)!
    }
}
