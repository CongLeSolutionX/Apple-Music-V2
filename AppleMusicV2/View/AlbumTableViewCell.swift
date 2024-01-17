//
//  CountryTableViewCell.swift
//  AppleMusicV2
//
//  Created by CONG LE on 12/7/23.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    static let reuseIdentifier = "albumTableViewCell"
    
    lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold) // Larger and bold for the album name
        label.textColor = .black // Or any color appropriate for your design
        label.numberOfLines = 0 // Allows for multi-line if needed
        //label.lineBreakMode = .byWordWrapping // This ensures that words are not split across lines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular) // Slightly smaller and regular weight for the artist name
        label.textColor = .darkGray // A more subdued color for the artist name
        label.numberOfLines = 0 // Allows for multi-line if needed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var artworkImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "house")!)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
        return imageView
    }()
    
    private(set) lazy var rightButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "albumRightButton"
        
        // Using SF Symbols (for iOS 13+)
        if let image = UIImage(systemName: "ellipsis") {
            button.setImage(image, for: .normal)
            button.tintColor = .gray
        } else {
            button.setTitle("…", for: .normal) // Using Unicode character for ellipsis
            button.setTitleColor(.gray, for: .normal)
        }
        button.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
        return button
    }()
    
    lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(albumNameLabel)
        stackView.addArrangedSubview(artistNameLabel)
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(artworkImageView)
        stackView.addArrangedSubview(labelsStackView)
        stackView.addArrangedSubview(rightButton)
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .center
        
        // We need the labelsStackView to take up as much space as possible
        // between the myImageView and rightButton,
        // so we can set its contentHuggingPriority to a lower value.
        // This tells the layout system that the labelsStackView
        // can stretch more than the other views when distributing the available space.
        labelsStackView.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellStackView)
        
        NSLayoutConstraint.activate([
            cellStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cellStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // For contentHuggingPriority to work, make sure that myImageView and rightButton
            // have intrinsic content sizes or explicit width constraints as 50
            artworkImageView.widthAnchor.constraint(equalToConstant: 50),
            rightButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: AlbumViewModel) {
        self.albumNameLabel.text = viewModel.albumName
        self.artistNameLabel.text = viewModel.artistName
 
        NetworkService.shared.fetchImage(from: viewModel.artworkUrlLink) { [weak self ] (result: Result<UIImage, NetworkError>) in
            switch result {
            case .success(let image):
                self?.artworkImageView.image = image
            case .failure(let networkError):
                // TODO: Need to present this error message to the user
                print(networkError)
            }
        }
    }
    
    @objc private func didTapRightButton() {
          print("Right button was tapped.")
          // We can also call a delegate method or use a closure to notify the view controller
      }
}
