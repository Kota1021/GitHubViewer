//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    @IBOutlet var ImgView: UIImageView!

    @IBOutlet var TtlLbl: UILabel!

    @IBOutlet var LangLbl: UILabel!

    @IBOutlet var StrsLbl: UILabel!
    @IBOutlet var WchsLbl: UILabel!
    @IBOutlet var FrksLbl: UILabel!
    @IBOutlet var IsssLbl: UILabel!

    var vc1: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        let repo = vc1.repositories[vc1.rowIndex]

        LangLbl.text = "Written in \(repo["language"] as? String ?? "")"
        StrsLbl.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        WchsLbl.text = "\(repo["wachers_count"] as? Int ?? 0) watchers"
        FrksLbl.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        IsssLbl.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
    }

    private func getImage() {
        let repository = vc1.repositories[vc1.rowIndex]

        TtlLbl.text = repository["full_name"] as? String

        if let owner = repository["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { data, _, _ in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.ImgView.image = img
                    }
                }.resume()
            }
        }
    }
}
