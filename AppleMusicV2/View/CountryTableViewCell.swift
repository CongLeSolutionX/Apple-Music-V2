//
//  CountryTableViewCell.swift
//  AppleMusicV2
//
//  Created by CONG LE on 12/7/23.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CountryCell"
    
    lazy var albumNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var myImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "house")!)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(albumNameLabel)
        stackView.addArrangedSubview(artistNameLabel)
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(myImageView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            // Set the constraints for the imageView
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            myImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            myImageView.widthAnchor.constraint(equalToConstant: 50),
            myImageView.heightAnchor.constraint(equalToConstant: 50),
            
            // Set the constraints for the stackView
            stackView.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: AlbumViewModel) {
        self.albumNameLabel.text = viewModel.albumName
        self.artistNameLabel.text = viewModel.artistName
    }
}
