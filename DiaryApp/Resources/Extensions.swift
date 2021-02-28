//
//  Extensions.swift
//  DiaryApp
//
//  Created by Evgenii Kolgin on 17.11.2020.
//

import UIKit

extension UIView {
    public var height:CGFloat {
        return frame.size.height
    }
    
    public var width:CGFloat {
        return frame.size.width
    }
    
    public var top: CGFloat {
        return frame.origin.y
    }
    
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    public var left: CGFloat {
        return frame.origin.x
    }
    
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
}

class HighlightedButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) : UIColor.systemPink
        }
    }
}
