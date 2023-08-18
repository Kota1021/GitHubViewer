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

        let repository = searchViewController.repositories[searchViewController.rowIndex]

        Language.text = "Written in \(repository["language"] as? String ?? "")"
        StarCount.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        WatchCount.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        ForkCount.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        IssueCount.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
        getImage()
    }

    private func getImage() {
        let repository = searchViewController.repositories[searchViewController.rowIndex]

        TitleLabel.text = repository["full_name"] as? String

        guard let owner = repository["owner"] as? [String: Any] else { return }
        guard let imageURL = owner["avatar_url"] as? String else { return }
        URLSession.shared.dataTask(with: URL(string: imageURL)!) { data, _, _ in
            let img = UIImage(data: data!)!
            DispatchQueue.main.async {
                self.ImageView.image = img
            }
        }.resume()
    }
}
