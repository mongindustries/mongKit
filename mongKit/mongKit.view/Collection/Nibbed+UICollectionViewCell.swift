//
//  Nibbed+UICollectionViewCell.swift
//  mongKit.view
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//

import UIKit

extension Nibbed where Self: UICollectionViewCell & CollectionCell {

  public static var staticCell: UICollectionViewCell? {
    nib.instantiate(withOwner: nil, options: nil)[0] as? Self
  }

  public static func register(
    collectionView  : UICollectionView) {
    collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
  }
}
