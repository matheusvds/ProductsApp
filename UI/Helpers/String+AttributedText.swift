import Foundation
import UIKit

extension String {
    
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range:NSMakeRange(0,attributeString.length)
        )
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughColor,
            value: UIColor.darkGray,
            range: NSMakeRange(0,attributeString.length)
        )
        return attributeString
    }
    
}
