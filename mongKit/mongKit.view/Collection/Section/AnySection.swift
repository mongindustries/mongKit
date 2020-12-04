//
//  AnySection.swift
//  mongKit.view
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit

import ReactiveSwift

public struct AnySection: Hashable, CollectionAdapterSection {

  public static func == (lhs: AnySection, rhs: AnySection) -> Bool {
    lhs.hashValue == rhs.hashValue
  }

  public typealias Item = AnyHashable

  public let list: ReactiveSwift.Property<Array<Item>>

  public let base: Any

  let desc: String

  let config: (UICollectionView) -> Void
  
  let sizeCl: (UICollectionView, IndexPath, CGSize, AnyHashable) -> CGSize

  let dequeC: (UICollectionView, IndexPath, AnyHashable) -> UICollectionViewCell

  init<Section: CollectionAdapterSection>(_ section: Section) {
    desc    = String(describing: Section.Item.self)
    list    = section.list.map { $0.map { AnyHashable($0) } }

    base    = section

    config  = { cv in
      section.configure(cv) }
    dequeC  = { cv, ip, d in
      section.dequeueCell(cv, at: ip, data: d.base as! Section.Item) }

    sizeCl = { cv, ip, rs, d in
      section.measureCell(cv, at: ip, referenceSize: rs, data: d.base as! Section.Item) }
  }

  public func hash(
    into hasher       : inout Hasher) {
    hasher.combine(list.value)
  }

  public func configure(
    _ collectionView  : UICollectionView) {
    config(collectionView)
  }

  public func measureCell(
    _ collectionView  : UICollectionView,
    at indexPath      : IndexPath,
    referenceSize     : CGSize,
    data              : AnyHashable) -> CGSize {
    sizeCl(collectionView, indexPath, referenceSize, data)
  }

  public func dequeueCell(
    _ collectionView  : UICollectionView,
    at indexPath      : IndexPath,
    data              : AnyHashable) -> UICollectionViewCell {
    dequeC(collectionView, indexPath, data)
  }
}

extension CollectionAdapterSection {
    public var any: AnySection { AnySection(self) }
}
