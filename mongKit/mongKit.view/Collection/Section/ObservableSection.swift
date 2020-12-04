//
//  ObservableSection.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/27/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import ReactiveSwift

public struct ObservableSection<Item: Hashable>: CollectionAdapterSection {

  public let list : ReactiveSwift.Property<[Item]>

  let builder     : ObservableSectionBuilder

  init(
    listening                           : ReactiveSwift.Property<[Item]>,
    @ObservableSectionBuilder _ builder : () -> ObservableSectionBuilder) {

    self.builder  = builder()
    list          = listening
  }

  public func configure(
    _ collectionView  : UICollectionView) {
    builder.register(collectionView)
  }

  public func measureCell(
    _ collectionView  : UICollectionView,
    at indexPath      : IndexPath,
    referenceSize     : CGSize,
    data              : Item) -> CGSize {
    builder.sizeCell(collectionView, indexPath, referenceSize, AnyHashable(data))
  }

  public func dequeueCell(
    _ collectionView  : UICollectionView,
    at indexPath      : IndexPath,
    data              : Item) -> UICollectionViewCell {
    if let cell = builder.dequeueCell(collectionView, indexPath, AnyHashable(data)) {
      return cell
    } else {
      fatalError()
    }
  }

  public typealias Item       = Item
}

public func observableSection<Item: Hashable>(
  listening items: ReactiveSwift.Property<[Item]>,
  @ObservableSectionBuilder builder: () -> ObservableSectionBuilder) -> ObservableSection<Item> {
  .init(listening: items, builder)
}
