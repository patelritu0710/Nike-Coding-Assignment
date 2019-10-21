//
//  AlbumTableViewCell.swift
//  Nike-Coding-Challenge
//
//  Created by Ritu Patel on 10/20/19.
//  Copyright © 2019 Ritu Patel. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    //MARK: Labels
    
    private let albumNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let artistNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .gray
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let albumImageView : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: ""))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    //MARK: Instance variable
    
    var imageCache = NSCache<NSString, UIImage>()
    
    //MARK: TablViewCell Methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(albumImageView)
        addSubview(albumNameLabel)
        addSubview(artistNameLabel)
        
        albumImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 0, width: 90, height: 0, enableInsets: false)
        
        albumNameLabel.anchor(top: topAnchor, left: albumImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width, height: 0, enableInsets: false)
        
        artistNameLabel.anchor(top: albumNameLabel.bottomAnchor, left: albumImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: frame.size.width, height: 0, enableInsets: false)
        
        
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 5
        addSubview(stackView)
        stackView.anchor(top: topAnchor, left: albumNameLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 5, paddingBottom: 15, paddingRight: 10, width: 0, height: 70, enableInsets: false)
    
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
}

//MARK: Interface

extension AlbumTableViewCell {
    
    /**
    Configure the cell by loading an image, set text of all labels
    
    - Parameter feedResult: configure cell with feedResult object
    */
    
    func configureCell(with feedResult: FeedResult?) {
        DispatchQueue.main.async {
            self.albumNameLabel.text = feedResult?.name
            self.artistNameLabel.text = feedResult?.artistName
            self.loadImage(with: feedResult?.artworkUrl100)
        }
    }
    
    /**
     Add image on albumImage by downloading image from url
     
     Download image and store in cache.
     
     When cell is displayed again, check cache, if cache is not nil then get image from cache and avoid downloading of image from url
     
     - Parameter photoURL: This is the url from where image will be downloaded
     */
    
    func loadImage(with photoURL: String?) {
        
        guard let photoURL = photoURL else {
            return
        }
        
        guard let url = URL(string: photoURL) else {
            return
        }
        
        if let cachedImage = self.imageCache.object(forKey: NSString(string: photoURL)) {
            
            self.setAlbumImageView(with: cachedImage)
            
        }else {
            
            DispatchQueue.global().async {
                
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    
                    if let data = data {
                        self.imageCache.setObject(UIImage(data: data) ?? UIImage(), forKey: NSString(string: photoURL))
                        self.setAlbumImageView(with: UIImage(data: data))
                    }
                    }.resume()
            }
        }
    }
    
    /**
     Set image on albumImageView
     
     - Parameter image: image to add on albumImageView
     */
    
    func setAlbumImageView(with image: UIImage?) {
        
        DispatchQueue.main.async {
            self.albumImageView.image = image
        }
    }

}
