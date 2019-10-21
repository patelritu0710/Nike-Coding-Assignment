//
//  ViewController.swift
//  Nike-Coding-Challenge
//
//  Created by Ritu Patel on 10/20/19.
//  Copyright © 2019 Ritu Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK:- instance variables

    private var activityIndicator: UIActivityIndicatorView!
    private var viewModel: AlbumViewModel?
    
    //MARK:- View life cycle method
    
    /**
    Initialize viewModel,
    Initialize activityIndicator and add it in view,
    Build the screen,
    fetch albums by making network call
    
    */
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        viewModel = AlbumViewModel(albumView: self)
        
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        DispatchQueue.main.async {
            self.buildScreen()
        }
        
        fetchAblums()
    }

    //MARK:- instance functions
    
    /// This builds whole screen
    
    private func buildScreen() {
        view.backgroundColor = .white
    }
    
    /// This makes service call to fetch albums
    
    private func fetchAblums() {
        
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        viewModel?.fetchAlbums()
    }
}

extension ViewController: AlbumView {
    
    /// This updates the tableview after getting success update from ViewModel
    
    func insertRowsInTableView() {
        
    }
    
    /// This displays error on alertView after getting failure update from viewModel
    
    func displayErrorOnAlertView(with error: Error) {
        
    }
    
}

