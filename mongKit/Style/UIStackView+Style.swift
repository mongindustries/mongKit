//
//  UIStackView+Style.swift
//  mongKit
//
//  Created by Michael Ong on 9/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct VerticalStack: StyleConfiguration {
  public typealias Comp = UIStackView

  public let value: CGFloat

  public init(spacing: CGFloat) {
    value = spacing
  }

  public func apply(_ target: UIStackView) {
    target.axis = .vertical
    target.spacing = value
  }
}

public struct HorizontalStack: StyleConfiguration {
  public typealias Comp = UIStackView

  public let value: CGFloat

  public init(spacing: CGFloat) {
    value = spacing
  }

  public func apply(_ target: UIStackView) {
    target.axis = .horizontal
    target.spacing = value
  }
}

public struct LayoutMarginStack: StyleConfiguration {
  public typealias Comp = UIStackView

  public let value: UIEdgeInsets

  public init(value: UIEdgeInsets) {
    self.value = value
  }

  public func apply(_ target: UIStackView) {
    target.layoutMargins = value
    target.isLayoutMarginsRelativeArrangement = true
  }
}
