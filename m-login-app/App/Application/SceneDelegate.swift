//
//  SceneDelegate.swift
//  m-login-app
//
//  Created by Normann Joseph on 06.04.20.
//  Copyright © 2020 SWM Services GmbH. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let window = window else { return }
        let viewControllerInstanceFactory = ViewControllerInstanceFactory()
        applicationCoordinator = ApplicationCoordinator(window: window, viewControllerInstanceFactory: viewControllerInstanceFactory)
        applicationCoordinator?.start()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let context = URLContexts.first,
            let action = context.url.host,
            let sourceBundle = context.options.sourceApplication else {
                return
        }
        print("requested target: \(context.url.absoluteString)")
        MLoginCore.shared.externalAppContext = ExternalAppContext(absoluteUrl: context.url.absoluteString, requestedAction: RequestedAppAction(rawValue: action), sourceApplicationBundle: sourceBundle)
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
          let urlToOpen = userActivity.webpageURL else {
            return
        }

        print("requested target: \(urlToOpen)")
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        MLoginCore.shared.externalAppContext = nil
    }


}

