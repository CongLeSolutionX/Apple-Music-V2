//
//  AlbumDetailViewController.swift
//  AppleMusicV2
//
//  Created by CONG LE on 1/22/24.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    var albumDetailViewModel: AlbumDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.configureViewsWithViewModel()
    }
    
    private func setupUI(){
        self.view.backgroundColor = .yellow
        self.title = albumDetailViewModel?.albumName
        self.navigationItem.title = albumDetailViewModel?.albumName
        
        self.view.addSubview(labelsStackView)
        self.view.addSubview(artworkImageView)
        
        NSLayoutConstraint.activate([
            artworkImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            artworkImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            artworkImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            labelsStackView.topAnchor.constraint(equalTo: artworkImageView.safeAreaLayoutGuide.bottomAnchor, constant: 8),
            labelsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            labelsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
           
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
    
    
    lazy var artworkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "house")!)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
        return imageView
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
        stackView.addArrangedSubview(artworkUrlLink) // Display the album work
        
        stackView.addArrangedSubview(albumNameLabel)
        stackView.addArrangedSubview(artistNameLabel)
        stackView.addArrangedSubview(albumKind)
        stackView.addArrangedSubview(contentAdvisoryRating)
        stackView.addArrangedSubview(releaseDate)
         
        stackView.addArrangedSubview(albumSampleURLLinkString) // play the sample album audio
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()
    
    
    private func configureViewsWithViewModel() {
        guard let viewModel = albumDetailViewModel else { return }
        //artworkUrlLink.text = viewModel.artworkUrlLink
        
        NetworkService.shared.fetchImage(from: viewModel.artworkUrlLink) { [weak self ] (result: Result<UIImage, NetworkError>) in
            switch result {
            case .success(let image):
                self?.artworkImageView.image = image
            case .failure(let networkError):
                // TODO: Need to present this error message to the user
                print(networkError)
            }
        }
        
        albumNameLabel.text = viewModel.albumName
        artistNameLabel.text = viewModel.artistName
        albumKind.text = viewModel.albumKind
        contentAdvisoryRating.text = viewModel.contentAdvisoryRating
        releaseDate.text = viewModel.releaseDate
        
        albumSampleURLLinkString.text = viewModel.urlLinkString
    }
}
