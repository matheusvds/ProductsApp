import Foundation
import UIKit

class CircularImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
    
}
