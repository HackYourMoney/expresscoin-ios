//
//  NSObject + reusableIdentifier.swift
//  expresscoin
//
//  Created by 이동건 on 2018. 1. 12..
//  Copyright © 2018년 이동건. All rights reserved.
//

import Foundation

extension NSObject {
    static var resuableIdentifier: String {
        return String(describing: self)
    }
}
