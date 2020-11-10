//
//  ObservableSectionBuilder.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/30/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import mongKitCore

@_functionBuilder
public struct ObservableSectionBuilder {

  let register    : (UICollectionView) -> Void

  let canDequeue  : (UICollectionView, IndexPath, AnyHashable) -> Bool
  
  let dequeueCell : (UICollectionView, IndexPath, AnyHashable) -> UICollectionViewCell?

  let sizeCell    : (UICollectionView, IndexPath, CGSize, AnyHashable) -> CGSize

  public static func buildExpression<Item: UICollectionViewCell & CollectionCell>(
    _ item: Item.Type) -> ObservableSectionBuilder {
    ObservableSectionBuilder { cv in
      Item.register(collectionView: cv)
    } canDequeue:   { (cv, ip, data) -> Bool in
      data.base is Item.Item && Item.shouldDequeue(data.base as! Item.Item, at: ip, collectionView: cv)
    } dequeueCell:  { (cv, ip, data) -> UICollectionViewCell? in
      tell(cv.dequeueReusableCell(withReuseIdentifier: Item.cellIdentifier, for: ip) as! Item) {
        $0.populate(data.base as! Item.Item, at: ip, collectionView: cv)
      }
    } sizeCell:     { (cv, ip, rf, data) -> CGSize in
      Item.measure(data.base as! Item.Item, at: ip, collectionView: cv, referenceSize: rf)
    }
  }

  public static func buildBlock(
    _ items: ObservableSectionBuilder...) -> ObservableSectionBuilder {
    ObservableSectionBuilder { cv in
      items.forEach { $0.register(cv) }
    } canDequeue:   { (cv, ip, data) -> Bool in
      !items.map({ $0.canDequeue(cv, ip, data) }).isEmpty
    } dequeueCell:  { (cv, ip, data) -> UICollectionViewCell? in
      items.first(where: { $0.canDequeue(cv, ip, data) })?.dequeueCell(cv, ip, data)
    } sizeCell:     { (cv, ip, rf, data) -> CGSize in
      items.first(where: { $0.canDequeue(cv, ip, data) })?.sizeCell(cv, ip, rf, data) ?? .zero
    }
  }
}
