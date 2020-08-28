import Foundation
import Parse

class ParseCloudService: CloudStoreService {

    enum ClassName: String {
        case tvShows = "TVShow"
    }

    // MARK: Helper Methods

    private func getPFObject(tvShow: TVShow) -> PFObject {
        let tvShowPFObject = PFObject(className: ClassName.tvShows.rawValue)
        tvShowPFObject[Constants.Keys.id] = tvShow.id
        tvShowPFObject[Constants.Keys.title] = tvShow.title
        tvShowPFObject[Constants.Keys.year] = tvShow.year
        tvShowPFObject[Constants.Keys.seasons] = tvShow.seasons
        return tvShowPFObject
    }

    // MARK: CloudStore Service Implementation

    func addTVShow(tvShow: TVShow, result: @escaping CloudStoreServiceResultAddShow) {
        let tvShowPFObject = getPFObject(tvShow: tvShow)

        tvShowPFObject.saveInBackground { (success, error)  in
            if error != nil {
                result(.failure(.badAddRequest))
                return
            }
            result(.success(tvShow))
        }
    }

    func getTVShows(result: @escaping CloudStoreServiceResultGetShows) {
        let query = PFQuery(className: ClassName.tvShows.rawValue)

        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error != nil {
                result(.failure(.showsNotFound))
            } else if let objects = objects {
                let tvShows = objects.compactMap({
                    TVShow(
                        id: $0[Constants.Keys.id] as? String ?? "",
                        title: $0[Constants.Keys.title] as? String ?? "",
                        year: $0[Constants.Keys.year] as? Int ?? 0,
                        seasons: $0[Constants.Keys.seasons] as? Int ?? 0
                    )
                })
                result(.success(tvShows))
            }
        }
    }

    func deleteTVShow(tvShow: TVShow, result: @escaping CloudStoreServiceResultDeleteShow) {
        let query = PFQuery(className: ClassName.tvShows.rawValue)
        query.whereKey(Constants.Keys.id, equalTo: tvShow.id)
            .findObjectsInBackground { (objects, error) in
                guard let _objectToDelete = objects?.first else {
                    result(.failure(.unableToDelete))
                    return
                }

                _objectToDelete.deleteInBackground(block: { success, error in
                    if error != nil || !success {
                        result(.failure(.unableToDelete))
                        return
                    }
                    result(.success(success))
                })
        }
    }
}
