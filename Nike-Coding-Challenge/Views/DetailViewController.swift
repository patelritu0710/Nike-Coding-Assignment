//
//  DetailViewController.swift
//  Nike-Coding-Challenge
//
//  Created by Ritu Patel on 10/20/19.
//  Copyright © 2019 Ritu Patel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController  {

    private var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildScreen()
    }
    
    private func buildScreen() {
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
    }
}

extension DetailViewController: AlbumViewDelegate {
    
    func didSelect(with feedResult: FeedResult?) {
        
    }

}
