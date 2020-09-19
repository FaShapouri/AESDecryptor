//
//  DecryptionModel.swift
//  AESDecryptor
//
//  Created by FaShapouri on 9/11/20.
//  Copyright © 2020 Individual. All rights reserved.
//

import Foundation
import CryptoSwift


//struct Cryption {
//    var mode: Mode
//    var size: KeySize
//    var key: String
//
//}

//struct Encrypted {
//    var content: String
//}
//
//struct Decrypted {
//
//    var base64Content: String
//    var content: String
//}

enum Mode: Int {
    case CBC = 0
    case ECB = 1
}

enum KeySize: Int {
    case Bit128 = 0
    case Bit256 = 1
}
protocol Cryptor {
    
    var plainText : String { get set }
    var cryptedText : String { get set }
    var key : String { get set }
    var mode: Mode { get set }
    var size: KeySize { get set }
    var algorithmInstance: AES { get }

    mutating func decrypt()
    mutating func encrypt()
}

struct CryptoObject: Cryptor {
    
    var padding : String = "drowssapdrowssap"
    var plainText: String = ""
    var cryptedText: String = ""
    var key : String = ""

    var mode: Mode = .CBC{
        didSet {
            resetAlgorithmInstance()
        }
    }
    var size: KeySize = .Bit128 {
        didSet {
            resetAlgorithmInstance()
        }
    }
    var algorithmInstance: AES {
        get {
            var aes : AES!
            if mode == .CBC {
                do {
                    let mode = CBC(iv: Array(padding.utf8))
                    aes = try AES(key: Array(key.utf8), blockMode: mode, padding: .pkcs7)
                } catch {}
            }
            else if mode == .ECB {
                do {
                    let mode = ECB()
                    aes = try AES(key: Array(key.utf8), blockMode: mode, padding: .pkcs7)
                } catch {}
            }
         return aes
        }
    }
    
    private mutating func resetAlgorithmInstance() {

    }
    mutating func decrypt() {
        print("decrypt cryptedText by \(mode) in \(size)")
        let data = Data(base64Encoded: cryptedText, options: .ignoreUnknownCharacters)
        
        do {
            let cipherText = try algorithmInstance.decrypt(data!.bytes)
        
            let cipherBase64 = cipherText.toBase64()!
        
            print(cipherBase64)
        
            let decodedData = Data(base64Encoded: cipherBase64)!
            if let decodedString = String(data: decodedData, encoding: .utf8) {
                print(decodedString)
                plainText = decodedString
            }
        }catch let error {
            cryptedText = error.localizedDescription

        }
    }
    
    mutating func encrypt() {
        print("encrypt plainText by \(mode) in \(size)")
        do {
            let encrypt = try algorithmInstance.encrypt(Array(plainText.utf8))
            if let encryptBase64 = encrypt.toBase64() {
                print(encryptBase64)
                cryptedText = encryptBase64
            }
        } catch let error {
            cryptedText = error.localizedDescription
        }

    }
}


