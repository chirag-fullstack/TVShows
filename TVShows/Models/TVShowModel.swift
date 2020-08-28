import Foundation

struct TVShow {
    let id: String
    let title: String
    let year: Int
    let seasons: Int

    init(id: String? = nil, title: String, year: Int, seasons: Int) {
        self.id = id ?? UUID().uuidString
        self.title = title
        self.year = year
        self.seasons = seasons
    }
}
