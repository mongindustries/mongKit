//
//  CollectionAdapter.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/27/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import Foundation

import ReactiveSwift

///
/// Extensible, composable data source for `UICollectionView`.
///
/// ### Preamble
///
/// This class is an adapter for a `UICollectionView`.
/// It operates by holding a list of `CollectionAdapterSection`s.
///
/// Diffing is done automatically by updating the section's `list`
/// property, or calling the `update` method to re-render the sections.
///
/// Accessing section and item data on the frontend is done by calling `section(at:)`
/// and `item(for:at:)` or `item(for:)` methods.
///
/// Measuring cell size is done by calling `size(for:referenceSize:)`.
/// `UICollectionView` also has an extension initializer that creates the adapter
/// with an intial user configurable set of sections to display.
///
/// ### Creating sections:
///
/// A section can be defined by conforming to the `CollectionAdapterSection` protocol:
///
///   ~~~
///   protocol CollectionAdapterSection {
///     var list: Property<Array<Item>>
///     var supplementaryList: Property<Array<Supplement>>
///
///     func register(...)
///
///     func measureCell(...)
///     func dequeueCell(...)
///
///     func dequeueSupplementaryCell(...)
///   }
///   ~~~
///
///   There are two predefined adapter sections which covers the majority of the adapter's use case,
///    namely `ObservableSection` and `DisplayStateSection`:
///   - `ObservableSection` observes a reactive array of `Item`s and updates the list when the value
///   gets updated by an assignment to `MutableProperty.value` of the observed instance.
///   - `DisplayStateSection` observes a `DisplayState`, presenting a `LoadCell` while loading, an
///   `ItemCell` when there is data, and a `FailCell` when it fails.
///
/// ### Building sections:
///
/// An initial section is required when the adapter is initialized. This
/// ensures that the collection view is hydrated upon load and won't cause
/// UI jumps when data is added later on. For asynchronous data, a placeholder
/// section is recommended to indicate the list is fetching data.
///
/// Updating sections can be done using the `update(_)` method. It takes a
/// function builder closure of sections to be displayed next. Do note that
/// adding same `hashValue` items to the adapter is not supported, and may
/// cause illegal program state. Section insertion, removal, and updates are
/// automatically handled by the adapter.
///
/// ### Definining section data:
///
/// `CollectionAdapterSection`'s `list` property takes care of the current
/// section data set. This is set to an immutable `Property<[Item]>` instead
/// of the `Mutable` counterpart as its the author's discersion to expose
/// list mutability to the client. The list will be automatically updated when
/// the `list` property sends a new value emission.
///
/// ### Determining cell item size:
///
/// It is necessary for a collection view layout to obtain sizing information for
/// a cell before rendering, thus the adapter exposes a `size(for:referenceSize:)`
/// method for such scenarios. This obtains the ideal cell size for a cell instance.
/// To customize the default implementation, conform the `measure` static function
/// on your `CollectionCell` implementation.
///
public class CollectionAdapter: NSObject, UICollectionViewDataSource, Scopeable {

  var section: [AnySection] {
    didSet {
      scope = .init(.init())

      section.forEach { $0.configure(collectionView!) }
      performSectionDiffing(oldValue: oldValue)
    }
  }

  weak var collectionView: UICollectionView?
    
  public weak var supplementaryDelegate: CollectionAdapterSupplementaryDelegate?

  public var scope: ScopedDisposable<CompositeDisposable> = .init(.init())

  /// Creates an instance of `CollectionAdapter` with an initial set of sections to display.
  /// - Parameters:
  ///   - collectionView: The collection view instance to bind the data source to.
  ///   - items: The initial collection view configuration.
  public init(
    for collectionView: UICollectionView,
    @CollectionAdapterSectionBuilder _ items: () -> [AnySection]) {

    self.collectionView = collectionView
    section             = items()

    super.init()

    collectionView.dataSource = self

    section.forEach { $0.configure(collectionView) }
    listenForRowChanges()
  }

  public func section(at index: Int) -> AnySection? {
    section[index]
  }

  public func item(
    for indexPath: IndexPath) -> AnyHashable? {
    section[indexPath.section].list.value[indexPath.row]
  }

  public func item<Return: Hashable>(
    for indexPath: IndexPath,
    as: Return.Type) -> Return? {
    section[indexPath.section].list.value[indexPath.row].base as? Return
  }

  public func update(
    @CollectionAdapterSectionBuilder _ items: () -> [AnySection]) {
    section = items()
  }

  public func update(
    with items: () -> [AnySection]) {
    section = items()
  }
}

extension CollectionAdapter: CollectionLayoutDelegate {
  
  public func sizeForItem(
    at indexPath: IndexPath, with size: CGSize) -> CGSize {
    section[indexPath.section].measureCell(collectionView!, at: indexPath, referenceSize: size, data: item(for: indexPath)!)
  }

  public func sizeForSupplementary(at indexPath: IndexPath, kind: String, with referenceSize: CGSize) -> CGSize {
    guard let supplementary = supplementaryDelegate else {
      return .zero
    }
    
    let hpri: UILayoutPriority
    let vpri: UILayoutPriority
    
    if referenceSize.width == UIView.layoutFittingCompressedSize.width {
      hpri = .fittingSizeLevel
    } else {
      hpri = .required
    }
    
    if referenceSize.height == UIView.layoutFittingCompressedSize.height {
      vpri = .fittingSizeLevel
    } else {
      vpri = .required
    }

    return supplementary
      .supplementaryCell        (for: collectionView!, at: indexPath, with: kind)
      .systemLayoutSizeFitting  (referenceSize, withHorizontalFittingPriority: hpri, verticalFittingPriority: vpri)
  }
}

// MARK: UICollectionViewDataSource

extension CollectionAdapter {
  
  public func numberOfSections  (
    in collectionView                       : UICollectionView) -> Int {
    section.count
  }

  public func collectionView    (
    _ collectionView                        : UICollectionView,
    numberOfItemsInSection index            : Int) -> Int {
    section[index].list.value.count
  }

  public func collectionView    (
    _ collectionView                        : UICollectionView,
    cellForItemAt indexPath                 : IndexPath) -> UICollectionViewCell {
    // TODO: for CollectionLayout, check if section is HLinear.
    // If so, dequeue a special horizontal collection view.
    section[indexPath.section].dequeueCell(
      collectionView,
      at  : indexPath,
      data: item(for: indexPath)!)
  }

  public func collectionView    (
    _ collectionView                        : UICollectionView,
    viewForSupplementaryElementOfKind kind  : String,
    at indexPath                            : IndexPath) -> UICollectionReusableView {
    guard let delegate = supplementaryDelegate else {
        fatalError()
    }

    return delegate.supplementaryCell(for: self.collectionView!, at: indexPath, with: kind)
  }
}

// MARK: Engine

extension CollectionAdapter {

  private func performSectionDiffing  (oldValue: [AnySection]) {

    guard let cv = collectionView else {
      fatalError()
    }

    // TODO: for now
    cv.reloadData()
    listenForRowChanges()
  }

  private func listenForRowChanges    () {
    section
      .enumerated ()
      .forEach    { index, section in
        scope += section.list
          .producer
          .combinePrevious  ()
          .startWithValues  { [unowned self] oldItems, newItems in

            guard let cv = collectionView else {
              fatalError()
            }

            // TODO: for now
            cv.reloadSections([ index ])
          }
      }
  }
}
