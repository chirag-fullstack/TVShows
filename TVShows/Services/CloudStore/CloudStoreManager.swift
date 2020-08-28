import Foundation

final class CloudStoreManager: CloudStoreService {

    // MARK: Class Varibales

    static let shared = CloudStoreManager()

    // MARK: Varibales

    private let service: CloudStoreService? = ParseCloudService()

    // MARK: Initialiser

    private init() {}

    // MARK: Methods

    func addTVShow(tvShow: TVShow, result: @escaping CloudStoreServiceResultAddShow) {
        self.service?.addTVShow(tvShow: tvShow, result: result)
    }

    func getTVShows(result: @escaping CloudStoreServiceResultGetShows) {
        self.service?.getTVShows(result: result)
    }

    func deleteTVShow(tvShow: TVShow, result: @escaping CloudStoreServiceResultDeleteShow) {
        self.service?.deleteTVShow(tvShow: tvShow, result: result)
    }
}
