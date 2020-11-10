//
//  MainController.swift
//  mongKitSample
//
//  Created by Michael Ong on 8/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

import mongKitCore
import mongKitView
import mongKitStructure

import ReactiveSwift
import ReactiveCocoa

class MainController: UIViewController {
  
  enum Segue: String {
    case viewList = "mongkit.view.list"
  }

  @MutableProperty var features: [RootCellView.Item] = [
    .init(feature: "View",
          featureDescription: "Demonstrates coding view trees using mongKit.view. It displays a list of view configurations and its corresponding code written in mongKit.view"),
    .init(feature: "Networking",
          featureDescription: "Demonstrates executing a network call using mongKit.networking. It calls an API endpoint which then gets loaded into a list for viewing."),
    .init(feature: "Structure",
          featureDescription: "Demonstrates controller-coordinator cooperation using mongKit.structure. This simulates a simple multi-step registration procedure without segues."),
  ]

  lazy var adapter = {
    CollectionAdapter(for: list) {
      observableSection(listening: $features) {
        RootCellView.self
      }
    }
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    list.delegate             = self
    list.contentInset         = .init(top: 20, sides: 20, bottom: 40)
    list.collectionViewLayout = CollectionLayout(scrollDirection: .vertical) { section, env in
      switch env.horizontalSize {
      case .regular:

        let finalBounds = env.collectionBounds
          .inset(by: env.collectionInsets)

        var count = 1
        var ok    = false

        while !ok {
          ok    = (finalBounds.width / CGFloat(count)) <= 375
          count += 1
        }

        return CollectionLayoutSection(direction: .vertical, group: [
          HGroup(width: .fractionalWidth(1), height: .automatic, items: (0..<count).map { _ in
            Item(width: .fractionalWidth(1 / CGFloat(count)), height: .automatic)
          })
        ])
      default:
        return CollectionLayoutSection(direction: .vertical, group: [
          VGroup(width: .fractionalWidth(1), height: .automatic, items: [
            Item(width: .fractionalWidth(1), height: .automatic)
          ])
        ])
      }
    }

    list.adapter              = adapter
  }

  @IBOutlet weak var list: UICollectionView!
}

extension MainController: UICollectionViewDelegate {

  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath) {
    switch adapter.item(for: indexPath, as: RootCellView.Item.self) {
    case features[0]:
      performSegue(withIdentifier: Segue.viewList.rawValue, sender: nil)
    case features[1]:
      navigationController?.pushViewController(NetworkController(nibName: nil, bundle: nil), animated: true)
    case features[2]:
      break
    default:
      break
    }
  }
}
