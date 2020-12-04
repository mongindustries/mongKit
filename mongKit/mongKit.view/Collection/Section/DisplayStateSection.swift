//
//  DisplayStateSection.swift
//  mongKit.view
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit

import ReactiveSwift

public struct DisplayStateSection<
  Payload: Hashable,
  Failure: Error & Hashable>: CollectionAdapterSection {

  public struct Load: Hashable {
    public let index: Int
    public let more : Bool
  }

  public enum State: Hashable {
    case loading(Load   )
    case payload(Payload)
    case failure(Failure)
  }

  public var list               : ReactiveSwift.Property<Array<State>>

  let config                    : (UICollectionView) -> Void

  let measure                   : (UICollectionView, IndexPath, CGSize, State) -> CGSize

  let dequeue                   : (UICollectionView, IndexPath, State) -> UICollectionViewCell


  public init<
    ItemCell: UICollectionViewCell & CollectionCell,
    LoadCell: UICollectionViewCell & CollectionCell,
    FailCell: UICollectionViewCell & CollectionCell>(
    for displayState: ReactiveSwift.Property<DisplayState<[Payload], Failure>>,
    loadInstances: Int = 1,
    item: ItemCell.Type,
    load: LoadCell.Type,
    fail: FailCell.Type) where LoadCell.Item == Load, ItemCell.Item == Payload, FailCell.Item == Failure {

    config            = { cv in
      ItemCell.register(collectionView: cv)
      LoadCell.register(collectionView: cv)
      FailCell.register(collectionView: cv)
    }
    measure           = { cv, ip, rs, ls in
      switch ls {
      case .loading(let item):
        return LoadCell
          .measure(item, at: ip, collectionView: cv, referenceSize: rs)
      case .failure(let item):
        return FailCell
          .measure(item, at: ip, collectionView: cv, referenceSize: rs)
      case .payload(let item):
        return ItemCell
          .measure(item, at: ip, collectionView: cv, referenceSize: rs)
      }
    }
    dequeue           = { cv, ip, ls in
      switch ls {
      case .failure(let item):
        return tell(cv.dequeueReusableCell(withReuseIdentifier: FailCell.cellIdentifier, for: ip) as! FailCell) {
          $0.populate(item, at: ip, collectionView: cv)
        }
      case .loading(let item):
        return tell(cv.dequeueReusableCell(withReuseIdentifier: LoadCell.cellIdentifier, for: ip) as! LoadCell) {
          $0.populate(item, at: ip, collectionView: cv)
        }
      case .payload(let item):
        return tell(cv.dequeueReusableCell(withReuseIdentifier: ItemCell.cellIdentifier, for: ip) as! ItemCell) {
          $0.populate(item, at: ip, collectionView: cv)
        }
      }
    }

    list              = displayState
      .map { (state: DisplayState<[Payload], Failure>) -> [State] in
        switch state {
        case .load:
          return (0..<loadInstances).map { index in State.loading(.init(index: index, more: false)) }
        case .failed    (let failure):
          return [ .failure(failure) ]
        case .loadMore  (let payload):
          return payload.map { State.payload($0) } + [ State.loading(.init(index: 0, more: true)) ]
        case .successful(let payload):
          return payload.map { State.payload($0) }
        }
      }
  }

  public init<
    ItemCell: UICollectionViewCell & CollectionCell,
    LoadCell: UICollectionViewCell & CollectionCell,
    FailCell: UICollectionViewCell & CollectionCell>(
    for displayState: ReactiveSwift.Property<DisplayState<Payload, Failure>>,
    loadInstances: Int = 1,
    item: ItemCell.Type,
    load: LoadCell.Type,
    fail: FailCell.Type) where LoadCell.Item == Load, ItemCell.Item == Payload, FailCell.Item == Failure {

    // I can just self.init(...) this but I'm lazy :P

    list              = .init(value: [])

    config            = { cv in
      ItemCell.register(collectionView: cv)
      LoadCell.register(collectionView: cv)
      FailCell.register(collectionView: cv)
    }
    measure           = { cv, ip, rs, ls in
      switch ls {
      case .loading(let item):
        return LoadCell
          .measure(item, at: ip, collectionView: cv, referenceSize: rs)
      case .failure(let item):
        return FailCell
          .measure(item, at: ip, collectionView: cv, referenceSize: rs)
      case .payload(let item):
        return ItemCell
          .measure(item, at: ip, collectionView: cv, referenceSize: rs)
      }
    }
    dequeue           = { cv, ip, ls in
      switch ls {
      case .failure:
        fatalError()
      case .loading(let item):
        return tell(cv.dequeueReusableCell(withReuseIdentifier: LoadCell.cellIdentifier, for: ip) as! LoadCell) {
          $0.populate(item, at: ip, collectionView: cv)
        }
      case .payload(let item):
        return tell(cv.dequeueReusableCell(withReuseIdentifier: ItemCell.cellIdentifier, for: ip) as! ItemCell) {
          $0.populate(item, at: ip, collectionView: cv)
        }
      }
    }

    list              = displayState
      .map { (state: DisplayState<Payload, Failure>) -> [State] in
        switch state {
        case .load:
          return (0..<loadInstances).map { index in State.loading(.init(index: index, more: false)) }
        case .failed    (let failure):
          return [ .failure(failure) ]
        case .loadMore  (let payload):
          return [ State.payload(payload) ] + [ State.loading(.init(index: 0, more: true)) ]
        case .successful(let payload):
          return [ State.payload(payload) ]
        }
      }
  }


  public func configure(
    _ collectionView  : UICollectionView) {
    config(collectionView)
  }

  public func measureCell(
    _ collectionView  : UICollectionView,
    at indexPath      : IndexPath,
    referenceSize     : CGSize,
    data              : State) -> CGSize {
    measure(collectionView, indexPath, referenceSize, data)
  }

  public func dequeueCell(
    _ collectionView  : UICollectionView,
    at indexPath      : IndexPath,
    data              : State) -> UICollectionViewCell {
    dequeue(collectionView, indexPath, data)
  }
}
