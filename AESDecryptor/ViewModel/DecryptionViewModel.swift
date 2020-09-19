//
//  DecryptionViewModel.swift
//  AESDecryptor
//
//  Created by FaShapouri on 9/11/20.
//  Copyright © 2020 Individual. All rights reserved.
//

import Foundation
import CryptoSwift

protocol DecryptionViewModelProtocol {
    
    var cryption : Dynamic<CryptoObject>{get}
}

class DecryptionViewModel: DecryptionViewModelProtocol {
    
    var cryption = Dynamic<CryptoObject>(CryptoObject())
    
    func encrypt(cryption: inout CryptoObject) {
        cryption.encrypt()
    }
    func decrypt(cryption: inout CryptoObject) {
        cryption.decrypt()
    }

}

extension DecryptionViewModel: DecryptionViewActionProtocol {
    
    func cryptionModeChanged(to mode: Mode) {
        cryption.value.mode = mode
    }
    
    func cryptionSizeChanged(to size: KeySize) {
        cryption.value.size = size
    }
    
    func downloadingBase64EncryptedContent(fromPath: String) {
        guard let url = URL(string: fromPath) else {
            //show error message
            return
        }
        DispatchQueue.init(label: "Download").async {
            do {
                let string = try String(contentsOf: url)
                DispatchQueue.main.sync {
                    
                    self.cryption.value.cryptedText = string
                }
            }
            catch let error { print(error)}
        }
    }
    
    func decryptContentSelected(with key:String) {

        if secretKeyIsValid(key) {
            cryption.value.key = key
            decrypt(cryption: &cryption.value)
        }
    }
    
    func secretKeyIsValid(_ key: String) -> Bool {
        if cryption.value.size == .Bit128 && key.count != 16 {
            cryption.value.plainText = "Length of secret key should be 16 for 128 bits key size"
            return false
        }
        if cryption.value.size == .Bit256 && key.count != 32 {
            cryption.value.plainText = "Length of secret key should be 32 for 256 bits key size"
            return false
        }
        return true
    }
}
