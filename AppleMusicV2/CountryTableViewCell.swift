//
//  CountryTableViewCell.swift
//  AppleMusicV2
//
//  Created by CONG LE on 12/7/23.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CountryCell"
    
    lazy var countryNameRegionAndCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var capitalLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(countryNameRegionAndCodeLabel)
        stackView.addArrangedSubview(capitalLabel)
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: AlbumViewModel) {
        self.countryNameRegionAndCodeLabel.text = viewModel.albumName
        self.capitalLabel.text = viewModel.artistName
    }
}
