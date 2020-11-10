//
//  EmptySection.swift
//  mongKit.view
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import UIKit
import ReactiveSwift

public struct EmptySection: CollectionAdapterSection {
  public typealias Item = Never

  public var list = ReactiveSwift.Property<Array<Item>>(value: [])

  public func configure(
    _ collectionView  : UICollectionView) {
    fatalError()
  }

  public func measureCell(
    _ collectionView: UICollectionView,
    at indexPath: IndexPath,
    referenceSize: CGSize,
    data: Never) -> CGSize {
  }
  
  public func dequeueCell(
    _ collectionView  : UICollectionView,
    at indexPath      : IndexPath,
    data              : Item) -> UICollectionViewCell {
  }
}
