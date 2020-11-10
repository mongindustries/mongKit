//
//  CollectionLayout.swift
//  mongKit.view
//
//  Created by Michael Ong on 11/2/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import mongKitCore

public protocol CollectionLayoutDelegate {
  func size(for indexPath: IndexPath, referenceSize: CGSize) -> CGSize
}

public class CollectionLayout: UICollectionViewLayout {

  public struct Environment {
    public let horizontalSize   : UIUserInterfaceSizeClass
    public let verticalSize     : UIUserInterfaceSizeClass

    public let collectionBounds : CGRect
    public let collectionInsets : UIEdgeInsets
  }
  
  public enum Span {
    case fractionalWidth   (CGFloat)
    case fractionalHeight  (CGFloat)

    case absolute          (CGFloat)
    case automatic

    func computeSize(for bounds: CGSize) -> CGFloat {
      switch self {
      case .fractionalHeight(let fraction):
        return bounds.height * fraction
      case .fractionalWidth(let fraction):
        return bounds.width * fraction
      case .absolute(let value):
        return value
      case .automatic:
        return .nan
      }
    }
  }

  public enum SpanDirection {
    case horizontal
    case vertical
    
    var perpendicular: SpanDirection {
      switch self {
      case .horizontal:
        return .vertical
      case .vertical:
        return .horizontal
      }
    }
  }

  public enum SpanScrollCharacteristic {
    case none
    case continuous
    case paged(centered: Bool)
  }

  public override var collectionViewContentSize: CGSize { overallSize }

  let callback        : (Int, Environment) -> CollectionLayoutSection
  let rootDirection   : SpanDirection

  var overallSize     : CGSize = .zero

  var cellBounds      : [ IndexPath : UICollectionViewLayoutAttributes ] = [:]
  var prevCellBounds  : [ IndexPath : UICollectionViewLayoutAttributes ] = [:]

  var sectionCache    = [CGSize]()

  var curWidth        = CGFloat(0)

  public init(scrollDirection: SpanDirection, builder: @escaping (Int, Environment) -> CollectionLayoutSection) {
    self.callback       = builder
    self.rootDirection  = scrollDirection

    super.init()
  }

  public required init?(coder: NSCoder) {

    fatalError()
  }

  public override func prepare() {
    super.prepare()

    guard let collectionView = collectionView, collectionView.bounds.size != .zero, cellBounds.isEmpty else {
      return
    }

    let environment = Environment(
      horizontalSize  : collectionView.traitCollection.horizontalSizeClass,
      verticalSize    : collectionView.traitCollection.verticalSizeClass,
      collectionBounds: collectionView.bounds,
      collectionInsets: collectionView.adjustedContentInset)

    var pointer         = CGPoint.zero
    var newOverallSize  = CGSize.zero

    for sectionIndex in 0..<collectionView.numberOfSections {

      var sectionSize   = CGSize.zero
      var groupSizes    = [CGSize]()

      var rows          = (0..<collectionView.numberOfItems(inSection: sectionIndex)).map { $0 }
      let section       = callback(sectionIndex, environment)

      switch section.direction {
      case .horizontal:
        pointer.x += section.inset.left
      case .vertical:
        pointer.y += section.inset.top
      }

      while !rows.isEmpty {

        for group in section.group {

          let cursor: CGPoint

          switch section.direction {
          case .horizontal:
            cursor = CGPoint(x: pointer.x, y: pointer.y + section.inset.top)
          default:
            cursor = CGPoint(x: pointer.x + section.inset.left, y: pointer.y)
          }

          let psize = collectionView.bounds
            .inset(by: collectionView.adjustedContentInset)
            .inset(by: section.inset)
            .size

          let size = buildGroup(
            section       : sectionIndex,
            rows          : &rows,
            cursor        : cursor,
            group,
            parentBounds  : psize)

          switch section.direction {
          case .horizontal:
            pointer.x += size.width
          case .vertical:
            pointer.y += size.height
          }

          groupSizes.append(size)
        }
      }

      let main = groupSizes.reduce(0) { sum, item in item.value(from: section.direction) + sum }
      let perp = groupSizes.reduce(0) { sum, item in max(sum, item.value(from: section.direction.perpendicular)) }

      switch section.direction {
      case .horizontal:
        sectionSize = CGSize(width: main, height: perp)
        pointer.x   += section.inset.right
      case .vertical:
        pointer.y   += section.inset.bottom
        sectionSize = CGSize(width: perp, height: main)
      }

      switch rootDirection {
      case .horizontal:
        newOverallSize.width  += sectionSize.width
        newOverallSize.height = max(sectionSize.height, newOverallSize.height)
      case .vertical:
        newOverallSize.height += sectionSize.height
        newOverallSize.width  = max(sectionSize.width, newOverallSize.width)
      }
    }

    overallSize = newOverallSize
  }
  
  // MARK: Engine

  func buildItem  (
    indexPath: IndexPath,
    cursor: CGPoint,
    _ item: CollectionLayoutItem,
    bias: SpanDirection,
    parentBounds: CGSize) -> CGSize {

    var nominalWidth  = item.width  .computeSize(for: parentBounds)
    var nominalHeight = item.height .computeSize(for: parentBounds)

    if nominalWidth.isNaN || nominalHeight.isNaN {

      let rwdh : CGFloat
      let rhgt : CGFloat

      if nominalWidth.isNaN {
        rwdh = 0
      } else {
        rwdh = nominalWidth
      }

      if nominalHeight.isNaN {
        rhgt = 0
      } else {
        rhgt = nominalHeight
      }

      let size: CGSize

      if let sizer = collectionView?.dataSource as? CollectionLayoutDelegate {
        size = sizer.size(for: indexPath, referenceSize: .init(width: rwdh, height: rhgt))
      } else {
        
        let hfit: UILayoutPriority
        let vfit: UILayoutPriority
        
        if rwdh == UIView.layoutFittingCompressedSize.width {
          hfit = .fittingSizeLevel
        } else {
          hfit = .required
        }
        
        if rhgt == UIView.layoutFittingCompressedSize.height {
          vfit = .fittingSizeLevel
        } else {
          vfit = .required
        }

        size = collectionView!.dataSource!.collectionView(collectionView!, cellForItemAt: indexPath)
          .contentView
          .systemLayoutSizeFitting(.init(width: rwdh, height: rhgt), withHorizontalFittingPriority: hfit, verticalFittingPriority: vfit)
      }

      if nominalWidth.isNaN {
        nominalWidth = size.width
      }

      if nominalHeight.isNaN {
        nominalHeight = size.height
      }
    }

    let size = CGSize(width: nominalWidth, height: nominalHeight)
    cellBounds[indexPath] = tell(UICollectionViewLayoutAttributes(forCellWith: indexPath)) {
      $0.frame = CGRect(origin: cursor, size: size)
    }

    return size
  }

  func buildGroup (
    section: Int,
    rows: inout [Int],
    cursor: CGPoint,
    _ group: CollectionLayoutGroup,
    parentBounds: CGSize) -> CGSize {

    var nominalWidth  = group.width .computeSize(for: parentBounds)
    var nominalHeight = group.height.computeSize(for: parentBounds)

    if nominalWidth.isNaN {
      nominalWidth = parentBounds.width
    }

    if nominalHeight.isNaN {
      nominalHeight = parentBounds.height
    }

    let groupBound    = CGSize(width: nominalWidth, height: nominalHeight)
    var localCursor   = CGPoint.zero

    let prefinalSize  = group.items
      .reduce(CGFloat(0)) { sum, item in
        item.value(from: group.direction, parentSize: parentBounds) + sum + group.spacing } - group.spacing

    if prefinalSize.isNaN {

      let initialSize : CGSize

      switch group.direction {
      case .horizontal:
        initialSize = .init(width: 0, height: CGFloat.leastNormalMagnitude)
      case .vertical:
        initialSize = .init(width: CGFloat.leastNormalMagnitude, height: 0)
      }

      let finalSize = group.items.reduce(initialSize) { (sum: CGSize, item: CollectionLayoutItem) -> CGSize in

        guard !rows.isEmpty else {
          return sum
        }

        switch group.direction {
        case .horizontal:
          localCursor.x = sum.width
        case .vertical:
          localCursor.y = sum.height
        }

        let size : CGSize

        switch item {
        case let group as CollectionLayoutGroup:
          size = buildGroup (section      : section,
                             rows         : &rows,
                             cursor       : cursor + localCursor,
                             group,
                             parentBounds : groupBound)
        default:
          size = buildItem  (indexPath    : IndexPath(row: rows.remove(at: 0), section: section),
                             cursor       : cursor + localCursor,
                             item,
                             bias         : group.direction,
                             parentBounds : groupBound)
        }

        switch group.direction {
        case .horizontal:
          return CGSize(width: sum.width + size.width + group.spacing, height: max(size.height, sum.height))
        case .vertical:
          return CGSize(width: max(size.width, sum.width), height: sum.height + size.height + group.spacing)
        }
      }

      switch group.direction {
      case .horizontal:
        return CGSize(width : finalSize.value(from: group.direction) - group.spacing,
                      height: finalSize.value(from: group.direction.perpendicular))
      case .vertical:
        return CGSize(width : finalSize.value(from: group.direction.perpendicular),
                      height: finalSize.value(from: group.direction) - group.spacing)
      }
    } else {

      let perpendicularSize = group.items.reduce(CGFloat(0)) { sum, item in

        guard !rows.isEmpty else {
          return sum
        }

        let size: CGSize

        switch item {
        case let group  as CollectionLayoutGroup:
          size = buildGroup (
            section       : section,
            rows          : &rows,
            cursor        : cursor + localCursor,
            group,
            parentBounds  : groupBound)
        default:
          size = buildItem  (
            indexPath     : IndexPath(row: rows.remove(at: 0), section: section),
            cursor        : cursor + localCursor,
            item,
            bias          : group.direction,
            parentBounds  : groupBound)
        }

        switch group.direction {
        case .horizontal:
          localCursor.x += size.width
        case .vertical:
          localCursor.y += size.height
        }

        return max(sum, size.value(from: group.direction.perpendicular))
      }

      switch group.direction {
      case .horizontal:
        return CGSize(width: prefinalSize, height: perpendicularSize)
      case .vertical:
        return CGSize(width: perpendicularSize, height: prefinalSize)
      }
    }
  }


  // MARK: Core

  public override func layoutAttributesForElements(
    in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    cellBounds.values.filter { $0.frame.intersects(rect) }
  }

  public override func layoutAttributesForSupplementaryView(
    ofKind elementKind: String,
    at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    nil
  }

  public override func layoutAttributesForItem(
    at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    cellBounds[indexPath]
  }

  public override func layoutAttributesForDecorationView(
    ofKind elementKind: String,
    at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    nil
  }

  // MARK: Invalidation

  public override var developmentLayoutDirection: UIUserInterfaceLayoutDirection { .leftToRight }

  public override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    cellBounds[itemIndexPath]
  }

  public override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    prevCellBounds[itemIndexPath]
  }
  
  public override func invalidateLayout(
    with context: UICollectionViewLayoutInvalidationContext) {
    super.invalidateLayout(with: context)

    if context.invalidateEverything || context.invalidateDataSourceCounts {
      prevCellBounds = cellBounds
      cellBounds.removeAll()
    }

    if collectionView!.bounds.size.value(from: rootDirection) != curWidth {
      prevCellBounds = cellBounds
      cellBounds.removeAll()
    }

    curWidth = collectionView!.bounds.size.value(from: rootDirection)
  }

  public override func shouldInvalidateLayout(
    forBoundsChange newBounds: CGRect) -> Bool {
    if curWidth != newBounds.size.value(from: rootDirection) {
      prevCellBounds = cellBounds
      cellBounds.removeAll()
    }

    curWidth = newBounds.size.value(from: rootDirection)

    return true
  }
  
  public override func shouldInvalidateLayout(
    forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes,
    withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
    return false // coerced, because auto layout is a dick
  }
}

func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
  CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

extension CGSize {
  func value(from direction: CollectionLayout.SpanDirection) -> CGFloat {
    switch direction {
    case .horizontal:
      return width
    case .vertical:
      return height
    }
  }
}

extension CollectionLayoutItem {
  func value(from direction: CollectionLayout.SpanDirection, parentSize: CGSize) -> CGFloat {
    switch direction {
    case .horizontal:
      return width.computeSize(for: parentSize)
    case .vertical:
      return height.computeSize(for: parentSize)
    }
  }
}
