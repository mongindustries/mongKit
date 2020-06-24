//
//  Size.swift
//  mongKit
//
//  Created by Michael Ong on 23/6/20.
//  Copyright © 2020 White Cloak Technologies, Inc. All rights reserved.
//

import UIKit

public struct Size: Constraint {
  public var constraint: (UIView) -> [NSLayoutConstraint]

  public init(_ value                               : CGFloat,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = {
      [ tell($0.widthAnchor  .constraint(equalToConstant: value)) { modifier.apply(target: Width.self , $0) } ,
        tell($0.heightAnchor .constraint(equalToConstant: value)) { modifier.apply(target: Height.self, $0) } ] }
  }

  public init(_ size                                : CGSize,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = {
      [ tell($0.widthAnchor  .constraint(equalToConstant: size.width   )) { modifier.apply(target: Width.self , $0) } ,
        tell($0.heightAnchor .constraint(equalToConstant: size.height  )) { modifier.apply(target: Height.self, $0) } ] }
  }

  public init(_ view                                : @escaping @autoclosure () -> UIView,
              @ConstraintModifierBuilder _ builder  : () -> ConstraintModifier = { EmptyConstraintModifier() }) {

    let modifier = builder()

    constraint = {
      let view = view()
      return [
        tell($0.widthAnchor  .constraint(equalTo: view.widthAnchor   )) { modifier.apply(target: Width.self , $0) } ,
        tell($0.heightAnchor .constraint(equalTo: view.heightAnchor  )) { modifier.apply(target: Height.self, $0) } ]
    }
  }
}
