//
//  AlbumTableViewCell.swift
//  Nike-Coding-Challenge
//
//  Created by Ritu Patel on 10/20/19.
//  Copyright © 2019 Ritu Patel. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    //MARK:- UI Elements
    
    private let albumNameLabel : UILabel = UILabel.createBoldLabel()
    
    private let artistNameLabel : UILabel = UILabel.createLabel()
    
    private let albumImageView : UIImageView = UIImageView.createImageView()
    
    
    //MARK:- TablViewCell Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(albumImageView)
        
        // albumImageView constraints
        
        NSLayoutConstraint(item: albumImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        
        albumImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 90, enableInsets: false)
        
        NSLayoutConstraint(item: albumImageView, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .top, multiplier: 1.0, constant: 5).isActive = true
        
        NSLayoutConstraint(item: albumImageView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -5.0).isActive = true
        
        
        // Created view to add two labels inside it
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.addSubview(albumNameLabel)
        view.addSubview(artistNameLabel)
        
        albumNameLabel.textAlignment = .left
        artistNameLabel.textAlignment = .left
        
        // Constraints for view and labels
        
        NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: view, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: self, attribute: .top, multiplier: 1.0, constant: 5.0).isActive = true
        NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: self, attribute: .bottom, multiplier: 1.0, constant: -5.0).isActive = true
        NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: albumImageView, attribute: .trailing, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 5.0).isActive = true
        
        albumNameLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)

        artistNameLabel.anchor(top: albumNameLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false)
    
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        albumImageView.image = nil
    }
}

//MARK:- Interface

extension AlbumTableViewCell {
    
    /**
    Configure the cell by loading an image, set text of all labels
    
    - Parameter feedResult: configure cell with feedResult object
    */
    
    func configureCell(with feedResult: FeedResult?) {
        self.albumNameLabel.text = feedResult?.name
        self.artistNameLabel.text = feedResult?.artistName
        albumImageView.loadImage(with: feedResult?.artworkUrl100)
    }

}
