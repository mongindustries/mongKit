//
//  ViewController.swift
//  mongKitSample
//
//  Created by Michael Ong on 8/6/20.
//  Copyright © 2020 mong Industries / White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

import mongKitCore
import mongKitView
import mongKitStructure
import mongKit_networking

import ReactiveSwift
import ReactiveCocoa

struct Response: Decodable {
  let meh: String
}

enum RemoteSource {
  struct Common: Endpoint {
    var path  : URL
    var body  : EndpointBody    = EndpointBodies.None
    var method: EndpointMethod  = .GET

    static var sample = Common(path: URL(string: "https://www.google.com")!)
  }
}

class ViewController: Controller<CustomScrollView> {
  
  class SampleCell: UICollectionViewCell, CollectionCell {
    static var cellIdentifier: String = "item"

    typealias Item = String

    static func measure(
      _ item          : Item,
      at indexPath    : IndexPath,
      collectionView  : UICollectionView) -> CGSize {
      .zero
    }

    func populate(
      _ data          : String,
      at indexPath    : IndexPath,
      collectionView  : UICollectionView) {
    
    }
  }

  class SampleCell2: UICollectionViewCell, CollectionCell {
    static var cellIdentifier: String = "item-2"

    typealias Item = String

    static func measure(
      _ item          : Item,
      at indexPath    : IndexPath,
      collectionView  : UICollectionView) -> CGSize {
      .zero
    }
    
    func populate(
      _ data          : String,
      at indexPath    : IndexPath,
      collectionView  : UICollectionView) {
    
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    rootView.delegate = self

    rootView.backgroundColor = .white
    rootView.alwaysBounceVertical = true

    scope += rootView.line2.reactive.text
          <~ rootView.textField.reactive.continuousTextValues

    let data1 = MutableProperty([ "Hello", "World", "There" ])
    let data2 = MutableProperty([ 10, 100, 1000 ])

    let section1 = observableSection(listening: data1) {
      SampleCell  .self
      SampleCell2 .self
    }
    let section2 = observableSection(listening: data2) {
      SampleCell  .self
      SampleCell2 .self
    }

    let adapter = CollectionAdapter(
      for: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())) {
      section1
      section2
    }

    data1.value = data1.value.reversed()
    data2.value = data2.value.reversed()
  }
}

extension ViewController: CustomScrollViewDelegate {
  func showDeets() {
    present(ViewController(), animated: true, completion: nil)
  }
}
