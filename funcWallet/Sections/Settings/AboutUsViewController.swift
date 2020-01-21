//
//  AboutUsViewController.swift
//  funcWallet
//
//  Created by XiaoLu on 2018/9/7.
//  Copyright © 2018年 Cryptape. All rights reserved.
//

import UIKit
import SafariServices

class AboutUsViewController: UITableViewController {
    @IBOutlet private weak var versionLabel: UILabel!
    @IBOutlet weak var sourceCodeLabel: UILabel!
    @IBOutlet weak var infuaDetailLabel: UILabel!
    @IBOutlet weak var openSeaDetailLabel: UILabel!
    @IBOutlet weak var peckShieldDetailLabel: UILabel!
    @IBOutlet weak var citaDetailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings.About.AboutUs".localized()
        sourceCodeLabel.text = "Settings.About.SourceCode".localized()
        setVersionLabel()
    }

    private var projectGithubUrls = [
        "https://github.com/dev-kononov/funcoin-ios",

    ]


    private func setVersionLabel() {
        let majorVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        versionLabel.text = "Version \(majorVersion) (\(build))"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var urlString: String?
        if indexPath.section == 1 {
            urlString = projectGithubUrls[indexPath.row]
        } 
        if let urlString = urlString {
            let safariController = SFSafariViewController(url: URL(string: urlString)!)
            self.present(safariController, animated: true, completion: nil)
        }
    }
}
