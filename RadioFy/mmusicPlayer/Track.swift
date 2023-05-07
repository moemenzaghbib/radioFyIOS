import SwiftUI
import CoreData

extension Track {
    var listName: String {
        guard let artist = artist, let title = title, artist.count > 0, title.count > 0 else {
            return fileName ?? ""
        }
        return "\(artist) - \(title)"
    }
    
    var artworkImage: UIImage? {
        get {
            if let artworkData = artwork {
                return UIImage(data: artworkData)
            }
            return nil
        }
        set {
            let data = newValue?.rotateImage()?.pngData()
            artwork = data
        }
    }
}

extension Track: Playable {
    var playableFileUrl: URL? {
        let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDir.appendingPathComponent(fileUrl ?? "")
    }
    
    var playableTitle: String {
        get {
            return listName
        }
    }
    
    var playableArtist: String? {
        get {
            return artist
        }
    }
    
    var playableArtwork: UIImage? {
        get {
            return artworkImage
        }
    }
}

protocol Playable {
    var playableFileUrl: URL? { get }
    var playableTitle: String { get }
    var playableArtist: String? { get }
    var playableArtwork: UIImage? { get }
}

extension UIImage {
    func rotateImage() -> UIImage? {
        UIGraphicsBeginImageContext(self.size)
        self.draw(at: CGPoint.zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
