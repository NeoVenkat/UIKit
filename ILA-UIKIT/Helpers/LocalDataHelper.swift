
import Foundation

// Getting data from local Json
struct BundleDecoderFromJson {
    static func decodeLandmarkFromBundleToJson() -> [ItemList] {
        let landmarkJson = Bundle.main.path(forResource: UIConstants.imagesData, ofType: UIConstants.fileType)
        let landmarks = try! Data(contentsOf: URL(fileURLWithPath: landmarkJson!), options: .alwaysMapped)
        return try! JSONDecoder().decode([ItemList].self, from: landmarks)
    }
}

