//
//  TDNSObjectExtension.swift
//  TourDe
//
//  Created by Tran Manh Quy on 3/21/18.
//  Copyright © 2018 Yume-sol. All rights reserved.
//

import UIKit

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
    var objectName: String {
        return String(describing: type(of: self))
    }
}
