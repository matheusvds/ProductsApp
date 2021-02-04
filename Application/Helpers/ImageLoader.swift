import Foundation
import SDWebImage
import UIKit
import UI

protocol ImageLoader {
    func set(imageView: UIImageView, with url: String, completion: @escaping (UIImage?) -> Void)
}

class UIImageLoader: ImageLoader {
    func set(imageView: UIImageView, with url: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else {
            debugPrint("Malformed string")
            return
        }
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        imageView.sd_imageTransition = .fade
        imageView.sd_setImage(with: url, placeholderImage: .none, options: SDWebImageOptions.progressiveLoad) { (image, error, _, _) in
            if let _ = error {
                imageView.image = UIImage(named: "notFound", in: Bundle(for: type(of: self)), with: .none)
                imageView.contentMode = .center
            }
            completion(image)
        }
    }
}
