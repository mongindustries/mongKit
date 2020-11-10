//
//  NetworkLoadCell.swift
//  mongKitSample
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import mongKitCore
import mongKitView

class NetworkLoadCell: UICollectionViewCell, Nibbed, CollectionCell {
  static var cellIdentifier: String = "network-load"

  typealias Item = DisplayStateSection<NetworkResponse, URLError>.Load

  func populate(_ data: Item, at indexPath: IndexPath, collectionView: UICollectionView) {

  }
}
