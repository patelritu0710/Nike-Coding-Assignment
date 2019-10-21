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
    
    private var tableView = UITableView()
    private var safeArea: UILayoutGuide!
    
    
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

        DispatchQueue.main.async {
            self.buildScreen()
        }
        
        fetchAblums()
    }

    //MARK:- instance functions
    
    /// This builds whole screen
    
    private func buildScreen() {
        
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        setupNavigationItem()
        setupTableView()
        addActivityIndicator()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Top Albums"
    }
    
    private func addActivityIndicator() {
        
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    private func setupTableView() {
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: "AlbumTableViewCell")
        
        let view = UIView()
        tableView.tableFooterView = view
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
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    /// This displays error on alertView after getting failure update from viewModel
    
    func displayErrorOnAlertView(with error: Error) {
        UIAlertController.showAlert(with: error.localizedDescription, on: self)
    }
    
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell") as? AlbumTableViewCell else { return  UITableViewCell()
        }
        
        if viewModel?.feedResult.count ?? 0 >= indexPath.row {
            cell.configureCell(with: viewModel?.feedResult[indexPath.row])
        }
        
        return cell
    }
    
    
}

//MARK:- Interface

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        
        if viewModel?.feedResult.count ?? 0 >= indexPath.row {
            vc.didSelect(with: viewModel?.feedResult[indexPath.row])
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- Protocol

protocol AlbumViewDelegate: class {
    func didSelect(with feedResult: FeedResult?)
}
