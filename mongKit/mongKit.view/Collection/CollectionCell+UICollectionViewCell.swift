//
//  CollectionCell+UICollectionViewCell.swift
//  mongKit.view
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import mongKitCore

extension CollectionCell where Self : UICollectionViewCell {

  public static var staticCell: UICollectionViewCell? {
    Self(frame: UIScreen.main.bounds)
  }

  public static func register(
    collectionView  : UICollectionView) {
    collectionView.register(self, forCellWithReuseIdentifier: cellIdentifier)
  }

  public static func measure(
    _   item        : Item,
    at  indexPath   : IndexPath,
    collectionView  : UICollectionView,
    referenceSize   : CGSize) -> CGSize {
    let cell = tell(staticCell! as! Self) {
      $0.populate(item, at: indexPath, collectionView: collectionView)
    }

    let hpri : UILayoutPriority

    if referenceSize.width == UIView.layoutFittingCompressedSize.width {
      hpri = .fittingSizeLevel
    } else {
      hpri = .required
    }

    let vpri : UILayoutPriority

    if referenceSize.height == UIView.layoutFittingCompressedSize.height {
      vpri = .fittingSizeLevel
    } else {
      vpri = .required
    }

    let size = cell.contentView.systemLayoutSizeFitting(referenceSize, withHorizontalFittingPriority: hpri, verticalFittingPriority: vpri)
    return .init(width: size.width.rounded(.down), height: size.height.rounded(.up))
  }

  public static func shouldDequeue(
    _ item          : Item,
    at indexPath    : IndexPath,
    collectionView  : UICollectionView) -> Bool {
    true
  }
}
