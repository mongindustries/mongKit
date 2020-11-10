	//
//  UICollectionView+Adapter.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/30/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit

var mngkit_adapter = 0x1000_AAAA

extension UICollectionView {

  public var adapter: CollectionAdapter {
    get { objc_getAssociatedObject(self, &mngkit_adapter) as! CollectionAdapter }
    set { objc_setAssociatedObject(self, &mngkit_adapter, newValue, .OBJC_ASSOCIATION_RETAIN) }
  }


  public convenience init(
    _ collectionViewLayout: UICollectionViewLayout = UICollectionViewFlowLayout(),
    @CollectionAdapterSectionBuilder _ sections: () -> AnySection) {
    self.init(frame: .zero, collectionViewLayout: collectionViewLayout)

    adapter = CollectionAdapter(for: self, sections)
  }

  public convenience init<Style: StyleConfiguration>(
    _ collectionViewLayout: UICollectionViewLayout = UICollectionViewFlowLayout(),
    style: Style,
    layout: LayoutConfiguration,
    @CollectionAdapterSectionBuilder _ sections: () -> AnySection) {

    self.init(frame: .zero, collectionViewLayout: collectionViewLayout)

    self.style  = StyleWrapper(style)
    self.layout = layout

    adapter         = CollectionAdapter(for: self, sections)
    mongConstructed = true
  }
}
