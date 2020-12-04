//
//  NetworkFailCell.swift
//  mongKitSample
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
 
import mongKitView

class NetworkFailCell: UICollectionViewCell, Nibbed, CollectionCell {
  static var cellIdentifier: String = "network-fail"

  static func measure(_ item: URLError, at indexPath: IndexPath, collectionView: UICollectionView, referenceSize: CGSize) -> CGSize {
    CGSize(width: referenceSize.width, height: referenceSize.height - (collectionView.adjustedContentInset.top + collectionView.adjustedContentInset.bottom))
  }
  
  typealias Item = URLError

  func populate(_ data: Item, at indexPath: IndexPath, collectionView: UICollectionView) {
    labelInfo.text = data.localizedDescription
  }
  
  @IBOutlet weak var labelInfo: UILabel!
}
