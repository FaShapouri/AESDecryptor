//
//  ViewController.swift
//  AESDecryptor
//
//  Created by FaShapouri on 9/9/20.
//  Copyright © 2020 Individual. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var decryptionViewModel : DecryptionViewModel! = {
        
        let temp = DecryptionViewModel()
        return temp
        } ()
    
    @IBOutlet var decryptionView : DecryptionView! = {

        let temp = DecryptionView()
        return temp
    } ()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decryptionView.layer.cornerRadius = 8
        decryptionView.delegate = decryptionViewModel
        decryptionViewModel.cryption.bind { [unowned self](value) in
            self.decryptionView.resultOfDownloadTextView?.text = value.cryptedText
            self.decryptionView.resultOfEncryptionTextView?.text = value.plainText
        }
        
    }
    
}

