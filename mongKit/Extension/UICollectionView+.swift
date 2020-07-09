//
//  UICollectionView+.swift
//  mongKit
//
//  Created by Michael Ong on 9/7/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

extension UICollectionView {

  public convenience init(_ layout: UICollectionViewLayout, @ConstructorComponentBuilder _ builder: () -> Style) {
    self.init(frame: .zero, collectionViewLayout: layout)

    mongConstructed = true
    styleConfig     = builder().styles
  }

  public convenience init(_ cvlayout: UICollectionViewLayout, @ConstructorComponentBuilder _ builder: () -> ConstructorComponent) {
    self.init(frame: .zero, collectionViewLayout: cvlayout)

    let config      = builder()

    mongConstructed = true

    layout          = config.layout // defer execution of layout instructions
    styleConfig     = config.style.styles

    buildChildren(config.children())
  }
}
