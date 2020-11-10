//
//  NetworkView.swift
//  mongKitSample
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import mongKitCore
import mongKitView

import ReactiveSwift

class NetworkView: View {

  @MutableProperty var items: DisplayState<[NetworkResponse], URLError> = .load

  @ComponentBuilder override var body: Component {
    UICollectionView(
      CollectionLayout(scrollDirection: .vertical) { (section, environment) -> CollectionLayoutSection in
        switch environment.horizontalSize {
        case .regular:
          return CollectionLayoutSection(direction: .vertical, group: [
            HGroup(width: .fractionalWidth(1), height: .automatic, spacing: 20, items: [
              Item(width: .fractionalWidth(1 / 2), height: .automatic),
              Item(width: .fractionalWidth(1 / 2), height: .automatic),
            ]),
          ])
        default:
          return CollectionLayoutSection(direction: .vertical, group: [
            VGroup(width: .fractionalWidth(1), height: .automatic, items: [
              Item(width: .fractionalWidth(1), height: .automatic),
            ]),
          ])
        }
      },
      style: Style<UICollectionView> {
        \.backgroundColor ~ .white
        \.contentInset ~ UIEdgeInsets(top: 20, sides: 20, bottom: 40)
        Ref(self, ref: \.list)
      },
      layout: AutoLayout {
        Vertical()
        Horizontal(safeAreaLayoutGuide)
      }) {
      DisplayStateSection(
        for           : $items,
        loadInstances : 10,
        item          : NetworkItemCell.self,
        load          : NetworkLoadCell.self,
        fail          : NetworkFailCell.self)
    }
  }
  
  override func didMoveToSuperview() {
    super.didMoveToSuperview()

    backgroundColor = .white
  }

  weak var list: UICollectionView!
}
