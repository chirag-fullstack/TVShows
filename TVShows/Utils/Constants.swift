import Foundation
import UIKit

struct Constants {
    struct Keys {
        static let id = "id"
        static let title = "title"
        static let year = "year"
        static let seasons = "seasons"
    }

    struct FileNames {
        static let parseCredentials = "parseCredentials"
    }

    struct DesignProperties {
        static let cornerRadius: CGFloat = 10
        static let shadowRadius: CGFloat = 3
        static let shadowOffset = CGSize(width: 0, height: 2)
        static let shadowOpacity: Float = 0.2
    }

    struct ErrorMessages {
        static let errorTitle = "Error"
    }

    struct Other {
        // swiftlint:disable:next line_length
        static let imageURL = "https://cdn.thenationroar.com/wp-content/uploads/2020/04/sherlock-tv-series-wallpaper-scaled.jpg"
    }

    struct Strings {
        static let doneTitle = "Done"
        static let cancelTitle = "Cancel"
    }
}
