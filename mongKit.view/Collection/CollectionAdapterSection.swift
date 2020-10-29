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
  associatedtype Supplement: Hashable

  var list: ReactiveSwift.Property<Array<Item>> { get }
  
  var supplementarylist: ReactiveSwift.Property<Array<Item>> { get }
  
  func configure(
    _ collectionView: UICollectionView)
  
  func dequeueCell(
    _ collectionView: UICollectionView,
    at indexPath: IndexPath,
    data: Item) -> UICollectionViewCell
  
  func dequeueSupplementaryView(
    _ collectionView: UICollectionView,
    at indexPath: IndexPath,
    data: Supplement) -> UICollectionReusableView
}
