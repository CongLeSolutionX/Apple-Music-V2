//
//  SceneDelegate.swift
//  AppleMusicV2
//
//  Created by CONG LE on 12/7/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let initialVC = TrendingAlbumsViewController(
            viewModels: ListOfAlbumViewModels(
                repository: AppleMusicRepository(
                    appleMusicService: AppleMusicService()
                )
            )
        )
        
        let window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: initialVC)
       
        window.rootViewController = navigationController
        
        self.window = window
        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

