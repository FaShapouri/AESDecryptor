//
//  AESDecryptorTests.swift
//  AESDecryptorTests
//
//  Created by FaShapouri on 9/9/20.
//  Copyright © 2020 Individual. All rights reserved.
//

import XCTest
@testable import AESDecryptor

class AESDecryptorTests: XCTestCase {

    var viewModel: DecryptionViewModel!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = DecryptionViewModel()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInvalidSecretKey128() {
        testChangeSizeTo128()
        XCTAssertFalse(viewModel.secretKeyIsValid("0p9o8"))
    }
    
    func testInvalidSecretKey256() {
        testChangeSizeTo256()
        XCTAssertFalse(viewModel.secretKeyIsValid("0p9o8"))
        
    }

    func testChangeModeToECB() {
        viewModel.cryptionModeChanged(to: .ECB)
        XCTAssertEqual(viewModel.cryption.value.mode, .ECB)
    }

    func testChangeModeToCBC() {
        viewModel.cryptionModeChanged(to: .CBC)
        XCTAssertEqual(viewModel.cryption.value.mode, .CBC)
    }

    
    func testChangeSizeTo128() {
        viewModel.cryptionSizeChanged(to: .Bit128)
        XCTAssertEqual(viewModel.cryption.value.size, .Bit128)
    }

    func testChangeSizeTo256() {
        viewModel.cryptionSizeChanged(to: .Bit256)
        XCTAssertEqual(viewModel.cryption.value.size, .Bit256)
    }
    
    func testDecryptCBC128() {
        testChangeModeToCBC()
        testChangeSizeTo128()
        viewModel.cryption.value.cryptedText = "l6bwPm154F+8ag8guASDvg=="
        viewModel.cryption.value.key = "0p9o8i7u6y5t4r3e"
        viewModel.decrypt(cryption: &viewModel!.cryption.value)
        XCTAssertEqual(viewModel.cryption.value.plainText, "Hey man")
    }

    func testDecryptCBC256() {
        testChangeModeToCBC()
        testChangeSizeTo256()
        viewModel.cryption.value.cryptedText = "WVeKiob11gJ4U7ZLIrKAnA=="
        viewModel.cryption.value.key = "0p9o8i7u6y5t4r3e0p9o8i7u6y5t4r3e"
        viewModel.decrypt(cryption: &viewModel!.cryption.value)
        XCTAssertEqual(viewModel.cryption.value.plainText, "Hey man")
    }

    func testDecryptECB128() {
        testChangeModeToECB()
        testChangeSizeTo128()
        viewModel.cryption.value.cryptedText = "3tfaGV/om4zzZi0u+fYohQ=="
        viewModel.cryption.value.key = "0p9o8i7u6y5t4r3e"
        viewModel.decrypt(cryption: &viewModel!.cryption.value)
        XCTAssertEqual(viewModel.cryption.value.plainText, "Hey man")
    }
    
    func testDecryptECB256() {
        testChangeModeToECB()
        testChangeSizeTo256()
        viewModel.cryption.value.cryptedText = "MjqQHos4MVTgY9sm8epBUA=="
        viewModel.cryption.value.key = "0p9o8i7u6y5t4r3e0p9o8i7u6y5t4r3e"
        viewModel.decrypt(cryption: &viewModel!.cryption.value)
        XCTAssertEqual(viewModel.cryption.value.plainText, "Hey man")

    }

    func testDownloadContentOfURL() {
        //I am not sure my idea about test of this method
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
