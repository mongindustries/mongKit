//
//  CollectionCell.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/28/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit

public protocol CollectionCell: class {

  associatedtype Item: Hashable

  static var cellIdentifier: String { get }

  static func measure(
    _   item      : Item,
    at  indexPath : IndexPath,
    collectionView: UICollectionView) -> CGSize

  func populate(
    _   data      : Item,
    at  indexPath : IndexPath,
    collectionView: UICollectionView)
}
