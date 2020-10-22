//
//  UICollectionView+.swift
//  mongKit
//
//  Created by Michael Ong on 9/7/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//
import UIKit

extension UICollectionView {
  public convenience init<StyleConfig: StyleConfiguration>(
    _ collectionViewLayout  : UICollectionViewLayout,
    style                   : StyleConfig,
    layout                  : LayoutConfiguration = FrameLayout(frame: .zero)) {
    self.init(frame: .zero, collectionViewLayout: collectionViewLayout)

    mongConstructed = true
    
    self.style = StyleWrapper(style)
  }
}
