//
//  DecryptionView.swift
//  AESDecryptor
//
//  Created by FaShapouri on 9/11/20.
//  Copyright © 2020 Individual. All rights reserved.
//

import UIKit

protocol DecryptionViewActionProtocol {
    func downloadingBase64EncryptedContent(fromPath : String)
    func decryptContentSelected(with key:String)
    func cryptionModeChanged(to mode: Mode)
    func cryptionSizeChanged(to size: KeySize)
}
class DecryptionView: UIView {
        
    @IBOutlet var encryptURL: UITextField?
    @IBOutlet var downloadEncryptContent: UIButton?
    @IBOutlet var resultOfDownloadTextView: UITextView?
    @IBOutlet var decryptionMode: UISegmentedControl?
    @IBOutlet var decryptionSize: UISegmentedControl?
    @IBOutlet var secretKey: UITextField?
    @IBOutlet var decryptContent: UIButton?
    @IBOutlet var resultOfEncryptionTextView: UITextView?
    
    var delegate : DecryptionViewActionProtocol!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func downloadEncryptContentSelected(_ sender: Any) {
        if let d = delegate {
            d.downloadingBase64EncryptedContent(fromPath: encryptURL!.text!)
        }
    }

    @IBAction func decryptContentSelected(_ sender: Any) {
        if let d = delegate {
            d.decryptContentSelected(with: secretKey!.text!)
        }
    }

    @IBAction func modeValueChanged(_ sender: Any) {
        if let d = delegate {
            let segment = sender as! UISegmentedControl
            d.cryptionModeChanged(to: (segment.selectedSegmentIndex == 0) ? .CBC : .ECB)
        }
    }
    
    @IBAction func sizeValueChanged(_ sender: Any) {
        if let d = delegate {
            let segment = sender as! UISegmentedControl
            d.cryptionSizeChanged(to: (segment.selectedSegmentIndex == 0) ? .Bit128 : .Bit256)
        }
    }
}
