//
//  TrendingViewController.swift
//  AppleMusicV2
//
//  Created by CONG LE on 12/7/23.
//

import UIKit
import Foundation

class TrendingAlbumsViewController: UITableViewController {
    var viewModels: ListOfAlbumViewModels

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupViewModel()
        self.viewModels.fetchMusicResults()
        
    }
    
    init(viewModels: ListOfAlbumViewModels) {
        self.viewModels = viewModels
        super.init(style: .plain) // ensure calling designated initializer of the superclass UITableViewController
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   // MARK: - UI Aetup
    private func setupUI(){
        self.view.backgroundColor = .red
        self.title = "List of Countries"
        self.navigationItem.title = "List of Countries"
        self.tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.reuseIdentifier)
    }
    
    // MARK: - ViewModel Setup
    private func setupViewModel() {
        viewModels.onMusicResultFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModels.onError = { [weak self] error in
            DispatchQueue.main.async {
                self?.showErrorAlert(error: error)
            }
        }
    }
    
    private func showErrorAlert(error: NetworkError) {
        let alert = UIAlertController(title: "Network Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.albumViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue Reusable Cell
        guard let countryCell = tableView.dequeueReusableCell(
            withIdentifier: AlbumTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? AlbumTableViewCell else {
            //TODO: Handle the error by displaying an alert or updating the UI as necessary
            print("Could not dequeue reusable CountryTableViewCell")
            return UITableViewCell() // use default UITableViewCell instead
        }
        // Configure the cell using viewModel
        let countryViewModel = viewModels.albumViewModels[indexPath.row]
        countryCell.configure(with: countryViewModel)
        return countryCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewModel = viewModels.albumViewModels[indexPath.row]
        let detailVC = AlbumDetailViewController()
        detailVC.albumViewModel = viewModel
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    // Handle Rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // TODO: Code to handle rotation here
        // For example, you might need to adjust the layout of your cells
    }
}
