//
//  ObservableSectionBuilder.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/30/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit

@_functionBuilder
public struct ObservableSectionBuilder {

  let register: (UICollectionView) -> Void

  public static func buildExpression<Item: UICollectionViewCell & CollectionCell>(
    _ item: Item.Type) -> ObservableSectionBuilder {
    ObservableSectionBuilder { cv in
      cv.register(item, forCellWithReuseIdentifier: Item.cellIdentifier)
    }
  }

  public static func buildBlock(
    _ items: ObservableSectionBuilder...) -> ObservableSectionBuilder {
    ObservableSectionBuilder { cv in
      items.forEach {
        $0.register(cv)
      }
    }
  }
}
