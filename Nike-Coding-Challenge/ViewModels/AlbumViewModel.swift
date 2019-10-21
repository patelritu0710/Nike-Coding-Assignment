//
//  AlbumViewModel.swift
//  Nike-Coding-Challenge
//
//  Created by Ritu Patel on 10/20/19.
//  Copyright © 2019 Ritu Patel. All rights reserved.
//

import Foundation

class AlbumViewModel {
    
    private var album : Album?
    
    /// Make albumView as weak in order to avoid retain cycle
    
    weak var albumView: AlbumView?
    
    /// Inject AlbumView protocol, for notifying View if any update in viewModel
    
    init(albumView: AlbumView) {
        self.albumView = albumView
    }
    
    var count: Int {
        return album?.feed?.results.count ?? 0
    }
    
    var feedResult: [FeedResult?] {
        return album?.feed?.results ?? [FeedResult]()
    }
    
    /**
     Fetch the list of albums with details
     
     On success, Assign result to ablum, notify view that viewModel has update of success
     
     On failure, Notify view that viewModel has update of failure/error
     */
    
    func fetchAlbums() {
        
        guard let url = URL(string: Endpoints.url.rawValue) else {
            return
        }
        
        NetworkManager().fetchData(WithUrl: url, objectType: Album.self) {[unowned self] (result, error) in
            
            if let error = error {
                
                self.albumView?.displayErrorOnAlertView(with:error)
                
            } else{
                
                DispatchQueue.main.async {
                    
                    self.album = result ?? Album()
                    
                    self.albumView?.insertRowsInTableView()
                }
            }
        }
    }
}


//MARK: Protocol

protocol AlbumView: class {
    func insertRowsInTableView()
    func displayErrorOnAlertView(with error:Error)
}
