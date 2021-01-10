//
//  CollectionAdapterSupplementaryDelegate.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/27/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit

public protocol CollectionAdapterSupplementaryDelegate: AnyObject {
  func supplementaryCell(for collectionView: UICollectionView,
                         at indexPath: IndexPath,
                         with identifier: String) -> UICollectionReusableView
}

public protocol CollectionAdapterIndexDelegate: AnyObject {
  func indices(for collectionView: UICollectionView) -> [String]?
  
  func indexPath(_ collectionView: UICollectionView, for index: Int) -> IndexPath
}
