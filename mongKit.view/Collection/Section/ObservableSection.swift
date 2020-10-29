//
//  ObservableSection.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/27/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import ReactiveSwift

import mongKitCore

public struct ObservableSection<Item: Hashable, Supplement: Hashable>: CollectionAdapterSection {

  public var list               : ReactiveSwift.Property<Array<Item>>
  public var supplementarylist  : ReactiveSwift.Property<Array<Item>>

  let builder: ObservableSectionBuilder

  init(
    listening                           : MutableProperty<Array<Item>>,
    @ObservableSectionBuilder _ builder : () -> ObservableSectionBuilder) {

    self.builder      = builder()

    list              = listening.map { $0 }
    supplementarylist = .init(value: []) // TODO: mark supplementary items
  }

  public func configure(
    _ collectionView  : UICollectionView) {
    builder.register(collectionView)
  }

  public func dequeueCell(
    _ collectionView  : UICollectionView,
    at indexPath      : IndexPath,
    data              : Item) -> UICollectionViewCell {
    fatalError()
  }
  
  public func dequeueSupplementaryView(
    _ collectionView  : UICollectionView,
    at indexPath      : IndexPath,
    data              : Supplement) -> UICollectionReusableView {
    fatalError()
  }

  public typealias Item       = Item
  public typealias Supplement = Supplement
}

public func observableSection<Item: Hashable>(
  listening items: MutableProperty<Array<Item>>,
  @ObservableSectionBuilder builder: () -> ObservableSectionBuilder) -> ObservableSection<Item, Never> {
  .init(listening: items, builder)
}
