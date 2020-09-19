//
//  Dynamic.swift
//  AESDecryptor
//
//  Created by FaShapouri on 9/13/20.
//  Copyright © 2020 Individual. All rights reserved.
//

import Foundation

class Dynamic<T> {
    
    typealias Listener = (T) -> ()
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    var value: T { didSet {
        listener?(value)
        }
    }
    init(_ v: T) { value = v
    }
}
