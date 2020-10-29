//
//  CollectionAdapter.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/27/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import Foundation

import mongKitCore
import ReactiveSwift

public class CollectionAdapter: NSObject, UICollectionViewDataSource, Scopeable {

  var section: AnySection {
    didSet {
      scope = .init(.init())

      section.configure(collectionView!)
      performSectionDiffing(oldValue: oldValue)
    }
  }

  weak var collectionView: UICollectionView?
  
  public var scope: ScopedDisposable<CompositeDisposable> = .init(.init())

  public init(
    for collectionView: UICollectionView,
    @CollectionAdapterSectionBuilder _ items: () -> AnySection) {

    self.collectionView = collectionView
    section             = items()

    super.init()

    section.configure(collectionView)
    listenForRowChanges()
  }

  public func item<Return: Hashable>(
    for indexPath: IndexPath) -> Return? {
    (section.list.value[indexPath.section].base as? AnySection)?.list.value[indexPath.row].base as? Return
  }

  public func size(
    for indexPath: IndexPath) -> CGSize {
    .zero
  }

  public func update(
    @CollectionAdapterSectionBuilder _ items: () -> AnySection) {
    section = items()
  }
}

// MARK: UICollectionViewDataSource

extension CollectionAdapter {
  
  public func numberOfSections  (
    in collectionView                       : UICollectionView) -> Int {
    section.list.value.count
  }

  public func collectionView    (
    _ collectionView                        : UICollectionView,
    numberOfItemsInSection index            : Int) -> Int {
    (section.list.value[index].base as! AnySection).list.value.count
  }

  public func collectionView    (
    _ collectionView                        : UICollectionView,
    cellForItemAt indexPath                 : IndexPath) -> UICollectionViewCell {
    section.dequeueCell(
      collectionView,
      at  : indexPath,
      data: (section.list.value[indexPath.section].base as! AnySection).list.value[indexPath.row])
  }
  
  public func collectionView    (
    _ collectionView                        : UICollectionView,
    viewForSupplementaryElementOfKind kind  : String,
    at indexPath                            : IndexPath) -> UICollectionReusableView {
    section.dequeueSupplementaryView(
      collectionView,
      at  : indexPath,
      data: (section.list.value[indexPath.section].base as! AnySection).supplementarylist.value[indexPath.row])
  }
}

// MARK: Engine

extension CollectionAdapter {
  
  private func performSectionDiffing(oldValue: AnySection) {

    let res = diffData(newItems: section.list.value, oldItems: oldValue.list.value) {
      $0.base as? AnySection }

    collectionView?.performBatchUpdates {
      collectionView?.deleteSections(IndexSet(res.toRemove))
      collectionView?.insertSections(IndexSet(res.toInsert))

      for (from, to) in res.toMove {
        collectionView?.moveSection(from, toSection: to)
      }

    } completion: { [unowned self] _ in
      listenForRowChanges()
    }
  }

  private func listenForRowChanges() {

    let sections = section.list.value.map { $0.base as! AnySection }

    sections
      .enumerated ()
      .forEach    { index, section in
        scope += section.list
          .producer
          .combinePrevious  ()
          .startWithValues  { [unowned self] oldItems, newItems in
            let res = diffData(newItems: newItems, oldItems: oldItems) {
              $0.base as? AnySection.Item }

            collectionView?.performBatchUpdates { [unowned self] in
              collectionView?.deleteItems(at: res.toRemove.map { IndexPath(row: $0, section: index) })
              collectionView?.insertItems(at: res.toInsert.map { IndexPath(row: $0, section: index) })

              for (from, to) in res.toMove {
                collectionView?.moveItem(at: .init(row: from, section: index), to: .init(row: to, section: index))
              }

              collectionView?.reloadItems(at: res.toReload.map { IndexPath(row: $0, section: index) })
            } completion: { _ in
            }
          }
      }
  }
}
