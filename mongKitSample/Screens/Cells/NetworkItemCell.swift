//
//  NetworkItemCell.swift
//  mongKitSample
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import mongKitCore
import mongKitView

class NetworkItemCell: UICollectionViewCell, Nibbed, CollectionCell {
  static var cellIdentifier: String = "network-item"

  typealias Item = NetworkResponse

  func populate(_ data: Item, at indexPath: IndexPath, collectionView: UICollectionView) {
    labelTitle.text = data.title
    labelDescription.text = data.description
  }
  
  @IBOutlet weak var labelTitle: UILabel!
  
  @IBOutlet weak var labelDescription: UILabel!
}
