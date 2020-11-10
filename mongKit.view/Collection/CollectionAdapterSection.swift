//
//  CollectionAdapterSection.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/27/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import Foundation
import ReactiveSwift

public protocol CollectionAdapterSection {
  associatedtype Item: Hashable

  var list: ReactiveSwift.Property<Array<Item>> { get }

  func configure(
    _ collectionView: UICollectionView)

  func measureCell(
    _ collectionView: UICollectionView,
    at indexPath: IndexPath,
    referenceSize: CGSize,
    data: Item) -> CGSize

  func dequeueCell(
    _ collectionView: UICollectionView,
    at indexPath: IndexPath,
    data: Item) -> UICollectionViewCell
}
