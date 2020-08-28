import Foundation

extension String {

    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func isEmpty() -> Bool {
        return self.trimmed.isEmpty
    }
}
