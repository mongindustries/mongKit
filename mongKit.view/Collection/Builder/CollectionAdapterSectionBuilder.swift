//
//  CollectionAdapterSectionBuilder.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/27/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import ReactiveSwift

@_functionBuilder
public struct CollectionAdapterSectionBuilder {
  public static func buildExpression<Item: CollectionAdapterSection>
    (_ item: Item) -> AnySection {
    AnySection(item) }

  public static func buildBlock
    (_ items: AnySection...) -> AnySection {
    AnySection(items) }
}

public struct AnySection: Hashable, CollectionAdapterSection {
  public static func == (lhs: AnySection, rhs: AnySection) -> Bool {
    lhs.hashValue == rhs.hashValue
  }

  public typealias Item        = AnyHashable
  public typealias Supplement  = AnyHashable

  public let list             : ReactiveSwift.Property<Array<Item>>
  public var supplementarylist: ReactiveSwift.Property<Array<AnyHashable>>

  let config: (UICollectionView) -> Void
  let dequeC: (UICollectionView, IndexPath, AnyHashable) -> UICollectionViewCell
  let dequeS: (UICollectionView, IndexPath, AnyHashable) -> UICollectionReusableView

  init<Section: CollectionAdapterSection>(_ section: Section) {
    list = section.list.map { $0.map { AnyHashable($0) } }
    supplementarylist = section.supplementarylist.map { $0.map { AnyHashable($0) } }

    config = { cv in
      section.configure(cv) }
    dequeC = { cv, ip, d in
      section.dequeueCell(cv, at: ip, data: d.base as! Section.Item) }
    dequeS = { cv, ip, d in
      section.dequeueSupplementaryView(cv, at: ip, data: d.base as! Section.Supplement) }
  }

  init(_ sections: [AnySection]) {

    list              = .init(value: sections.map { AnyHashable($0) })
    supplementarylist = .init(value: sections.map { AnyHashable($0) })

    config  = { cv in
      sections.forEach {
        $0.configure(cv) } }
    dequeC = { cv, ip, d in
      sections[ip.section].dequeueCell(cv, at: ip, data: d) }
    dequeS = { cv, ip, d in
      sections[ip.section].dequeueSupplementaryView(cv, at: ip, data: d) }
  }

  public func hash(
    into hasher: inout Hasher) {
    hasher.combine(list.value)
  }
  
  public func configure(
    _ collectionView  : UICollectionView) {
    config(collectionView)
  }

  public func dequeueCell(
    _ collectionView  : UICollectionView,
    at indexPath      : IndexPath,
    data              : AnyHashable) -> UICollectionViewCell {
    dequeC(collectionView, indexPath, data)
  }
  
  public func dequeueSupplementaryView(
    _ collectionView  : UICollectionView,
    at indexPath      : IndexPath,
    data              : AnyHashable) -> UICollectionReusableView {
    dequeS(collectionView, indexPath, data)
  }
}

public struct EmptySection: CollectionAdapterSection {
  public typealias Item       = Never
  public typealias Supplement = Never

  public var list = ReactiveSwift.Property<Array<Item>>(value: [])
  public var supplementarylist = ReactiveSwift.Property<Array<Never>>(value: [])

  public func configure(
    _ collectionView  : UICollectionView) {
    fatalError()
  }

  public func dequeueCell(
    _ collectionView  : UICollectionView,
    at indexPath      : IndexPath,
    data              : Item) -> UICollectionViewCell {
  }

  public func dequeueSupplementaryView(
    _ collectionView  : UICollectionView,
    at indexPath      : IndexPath,
    data              : Supplement) -> UICollectionReusableView {
  }
}
