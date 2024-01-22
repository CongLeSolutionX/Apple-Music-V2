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
    }
    
    private func setupUI(){
        self.view.backgroundColor = .yellow
        self.title = albumViewModel?.albumName
        self.navigationItem.title = albumViewModel?.albumName
    }
}
