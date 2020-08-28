import Foundation

extension Decodable {
    static func parse(jsonFile: String) -> Self? {
        guard let bundleURL = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
            let data = try? Data(contentsOf: bundleURL),
            let output = try? JSONDecoder().decode(self, from: data)
            else { return nil }
        return output
    }

    static func parse(data: Data) -> Self? {
        return try? JSONDecoder().decode(self, from: data)
    }
}
