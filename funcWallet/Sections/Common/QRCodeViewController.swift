//
//  QRCodeViewController.swift
//  funcWallet
//
//  Created by XiaoLu on 2018/11/3.
//  Copyright © 2018 Cryptape. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader

@objc protocol QRCodeViewControllerDelegate: class {
    func didBackQRCodeMessage(codeResult: String)
    @objc optional func qrcodeReaderDidCancel()
}

class QRCodeViewController: UIViewController {
    weak var delegate: QRCodeViewControllerDelegate?
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showSwitchCameraButton = false
            $0.cancelButtonTitle = "Exit"
            $0.showTorchButton = true
        }
        return QRCodeReaderViewController(builder: builder)
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !QRCodeReader.isAvailable() {
            let alert = UIAlertController(title: "Hint", message: "Camera does not work", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Discover", style: .destructive, handler: { (_) in
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Show QR"
        readerVC.delegate = self
        view.addSubview(readerVC.view)
        addChild(readerVC)
    }
}

extension QRCodeViewController: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        navigationController?.popViewController(animated: true)
        delegate?.didBackQRCodeMessage(codeResult: result.value)
    }

    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        navigationController?.popViewController(animated: true)
        delegate?.qrcodeReaderDidCancel?()
    }
}
