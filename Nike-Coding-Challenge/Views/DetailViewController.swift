//
//  DetailViewController.swift
//  Nike-Coding-Challenge
//
//  Created by Ritu Patel on 10/20/19.
//  Copyright © 2019 Ritu Patel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController  {
    
    // MARK:- Instance member
    
    private var safeArea: UILayoutGuide!
    

    //MARK:- UI Elements
    
    private let albumImageView : UIImageView = UIImageView.createImageView()
    
    private let albumNameLabel : UILabel = UILabel.createBoldLabel()
    
    private let artistNameLabel: UILabel = UILabel.createLabel()
    
    private let genreLabel : UILabel = UILabel.createLabel()
    
    private let releaseLabel : UILabel = UILabel.createLabel()
    
    private let copyRightLabel : UILabel = UILabel.createLabel()
    
    private let iTunesbutton : ItunesButton = {
        
        let btn = ItunesButton(type: .system)
        btn.backgroundColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
        btn.tintColor = .white
        btn.layer.cornerRadius = 3.0
        btn.setTitle("iTunes Store", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(itunesButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    //MARK:- View life cycle method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildScreen()
    }
    
    
    //MARK:- Instnace function
    
    private func buildScreen() {
        
        view.backgroundColor = .white
        
        safeArea = view.layoutMarginsGuide
        
        let width = safeArea.layoutFrame.size.width
        
        let scrollView = UIScrollView()
        
        self.view.addSubview(scrollView)
        
        // Add scrollView's constraints
        
        scrollView.anchor(top: safeArea.topAnchor, left: view.leftAnchor, bottom: safeArea.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: width, height: 0, enableInsets: false)
        
        // Set height and width of ImageView
        
        albumImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 300, enableInsets: false)
        
        // Create stackView and add constraints
        
        let stackView = UIStackView(arrangedSubviews: [albumImageView, albumNameLabel, artistNameLabel, genreLabel, releaseLabel, copyRightLabel])
        
        scrollView.addSubview(stackView)
        
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .center
        
        stackView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: width, height: 0, enableInsets: false)
        
        scrollView.addSubview(iTunesbutton)
        
        // Add Constraints for iTunes Store button
        
        iTunesbutton.anchor(top: nil, left: scrollView.leftAnchor, bottom: nil, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 35, enableInsets: false)
        
        NSLayoutConstraint(item: stackView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: iTunesbutton, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: iTunesbutton, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: safeArea, attribute: .bottom, multiplier: 1.0, constant: -20.0).isActive = true
        NSLayoutConstraint(item: iTunesbutton, attribute: .bottom, relatedBy: .equal, toItem: scrollView, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        
    }
    
    //MARK:- Action
    
    /**
    This will called when user taps on Music button
    
    - Parameter sender: sender which is tapped
    */
    
    @objc func itunesButtonTapped(_ sender: ItunesButton) {
        
        guard let urlStr = sender.url else{
            print("url is nil")
            return
        }
        
        if let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}


//MARK:- Interface

extension DetailViewController: AlbumViewDelegate {
    
    /**
     This method will be called when row is selected on previous viewController (ViewController).
     
     Set all UI elements using feedResult
     
     - Parameter feedResult: feedResult to display on UI elements
    */
    
    func didSelect(with feedResult: FeedResult?) {
        
        albumImageView.loadImage(with: feedResult?.artworkUrl100)
        
        albumNameLabel.text = feedResult?.name
        
        artistNameLabel.text = "Artist: " + (feedResult?.artistName ?? "N/A")
        
        let genre = feedResult?.genres.first ?? Genre()
        genreLabel.text = "Genre: " + (genre?.name ?? "N/A")
        
        releaseLabel.text =  "Released: " + (feedResult?.releaseDate ?? "N/A")
        
        copyRightLabel.text = feedResult?.copyright
        
        iTunesbutton.url = feedResult?.artistUrl
    }

}


//MARK:- Interface

class ItunesButton: UIButton {
    var url : String?
}
