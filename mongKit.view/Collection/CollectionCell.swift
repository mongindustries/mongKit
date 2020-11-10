//
//  CollectionCell.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/28/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import mongKitCore

public protocol CollectionCell: class {

  associatedtype Item: Hashable

  static var cellIdentifier: String { get }

  static var staticCell: UICollectionViewCell? { get }

  static func register(
    collectionView  : UICollectionView)

  static func measure(
    _   item        : Item,
    at  indexPath   : IndexPath,
    collectionView  : UICollectionView,
    referenceSize   : CGSize) -> CGSize
  
  static func shouldDequeue(
    _ item          : Item,
    at indexPath    : IndexPath,
    collectionView  : UICollectionView) -> Bool

  func populate(
    _   data        : Item,
    at  indexPath   : IndexPath,
    collectionView  : UICollectionView)
}
