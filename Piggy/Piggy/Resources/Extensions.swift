//
//  Extensions.swift
//  Piggy
//
//  Created by ludmyla almeida on 3/10/21.
//  Copyright © 2021 ludmyla almeida. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension UIView {
    
    public var width: CGFloat {
        return frame.size.width
    }
    
    public var height: CGFloat {
        return frame.size.height
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

extension UIColor{
    static let piggyPink = UIColor(red: 253/255.0, green: 106/255.0, blue: 126/255.0, alpha: 1.0 )
}

//extension String {
//    func safeDatabaseKey() -> String {
//        return self.replacingOccurrences(of: "@", with: "-")
//        return self.replacingOccurrences(of: ".", with: "-")
//    }
//}
