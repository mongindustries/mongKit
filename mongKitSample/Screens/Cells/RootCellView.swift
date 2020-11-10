//
//  RootCellView.swift
//  mongKitSample
//
//  Created by Michael Ong on 11/1/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import mongKitCore
import mongKitView

class RootCellView: UICollectionViewCell, Nibbed, CollectionCell {

  struct Item: Hashable {
    let feature: String
    let featureDescription: String
  }

  static var cellIdentifier: String = "root-item"

  func populate(
    _ data: Item,
    at indexPath: IndexPath,
    collectionView: UICollectionView) {
    feature           .text = data.feature
    featureDescription.text = data.featureDescription
  }

  @IBOutlet weak var heroImage          : UIImageView!

  @IBOutlet weak var feature            : UILabel!

  @IBOutlet weak var featureDescription : UILabel!
}
