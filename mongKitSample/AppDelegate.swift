//
//  AppDelegate.swift
//  mongKitSample
//
//  Created by Michael Ong on 8/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit
 
import mongKitView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  lazy var rootWindow =  {
    tell(UIWindow(frame: UIScreen.main.bounds)) {
      $0.rootViewController = UIStoryboard(name: "Application", bundle: .main).instantiateInitialViewController()
    }
  }()

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    mongKit.initialize()
    networkLocator    ()

    #if targetEnvironment(macCatalyst)

    UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .forEach { scene in
        scene.titlebar?.titleVisibility = .hidden
        scene.sizeRestrictions?.minimumSize = .init(width: 480, height: 620)
      }

    rootWindow.canResizeToFitContent = true

    #endif

    rootWindow.makeKeyAndVisible()

    return true
  }
}
