//
//  AlbumDetailViewController.swift
//  AppleMusicV2
//
//  Created by CONG LE on 1/22/24.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    var albumViewModel: AlbumViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.configureViewsWithViewModel()
    }
    
    private func setupUI(){
        self.view.backgroundColor = .yellow
        self.title = albumViewModel?.albumName
        self.navigationItem.title = albumViewModel?.albumName
        self.view.addSubview(labelsStackView)
        
        NSLayoutConstraint.activate([
            labelsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            labelsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            labelsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
    lazy var artworkUrlLink: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0  // Allows for multi-line if needed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0 // Allows for multi-line if needed
        label.lineBreakMode = .byWordWrapping // This ensures that words are not split across lines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0 // Allows for multi-line if needed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var releaseDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var albumKind: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var         contentAdvisoryRating: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var albumSampleURLLinkString: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(artworkUrlLink)
        stackView.addArrangedSubview(albumNameLabel)
        stackView.addArrangedSubview(artistNameLabel)
        stackView.addArrangedSubview(albumKind)
        stackView.addArrangedSubview(contentAdvisoryRating)
        stackView.addArrangedSubview(releaseDate)
        stackView.addArrangedSubview(albumSampleURLLinkString)
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()
    
    
    private func configureViewsWithViewModel() {
        guard let viewModel = albumViewModel else { return }
        albumNameLabel.text = viewModel.albumName
        artistNameLabel.text = viewModel.artistName
        artworkUrlLink.text = viewModel.artworkUrlLink
        albumKind.text = viewModel.albumKind
        contentAdvisoryRating.text = viewModel.contentAdvisoryRating
        releaseDate.text = viewModel.releaseDate
        albumSampleURLLinkString.text = viewModel.urlLinkString
    }
}
