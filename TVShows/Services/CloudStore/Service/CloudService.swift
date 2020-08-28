import Foundation

typealias CloudStoreServiceResultAddShow = (_ result: Result<TVShow, CloudStoreError>) -> Void
typealias CloudStoreServiceResultGetShows = (_ result: Result<[TVShow], CloudStoreError>) -> Void
typealias CloudStoreServiceResultDeleteShow = (_ result: Result<Bool, CloudStoreError>) -> Void

enum CloudStoreError: Error {
    case badAddRequest
    case showsNotFound
    case unableToDelete

    var localizedDescription: String {
        switch self {
        case .badAddRequest:
            return "Unable to add the new TV show"
        case .showsNotFound:
            return "Unable to fetch the TV shows"
        case .unableToDelete:
            return "Unable to delete the TV show"
        }
    }
}

protocol CloudStoreService {
    func addTVShow(tvShow: TVShow, result: @escaping CloudStoreServiceResultAddShow)
    func getTVShows(result: @escaping CloudStoreServiceResultGetShows)
    func deleteTVShow(tvShow: TVShow, result: @escaping CloudStoreServiceResultDeleteShow)
}
