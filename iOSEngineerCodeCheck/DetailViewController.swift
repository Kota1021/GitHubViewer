//
//  DetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var ImageView: UIImageView!

    @IBOutlet var TitleLabel: UILabel!

    @IBOutlet var Language: UILabel!

    @IBOutlet var StarCount: UILabel!
    @IBOutlet var WatchCount: UILabel!
    @IBOutlet var ForkCount: UILabel!
    @IBOutlet var IssueCount: UILabel!

    var searchViewController: SearchViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        let repo = searchViewController.repositories[searchViewController.rowIndex]

        Language.text = "Written in \(repo["language"] as? String ?? "")"
        StarCount.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        WatchCount.text = "\(repo["wachers_count"] as? Int ?? 0) watchers"
        ForkCount.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        IssueCount.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
    }

    private func getImage() {
        let repository = searchViewController.repositories[searchViewController.rowIndex]

        TitleLabel.text = repository["full_name"] as? String

        if let owner = repository["owner"] as? [String: Any] {
            if let imgURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: imgURL)!) { data, _, _ in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.ImageView.image = img
                    }
                }.resume()
            }
        }
    }
}
