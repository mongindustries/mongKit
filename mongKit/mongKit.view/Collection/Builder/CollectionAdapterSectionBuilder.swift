//
//  CollectionAdapterSectionBuilder.swift
//  mongKit.view
//
//  Created by Michael Ong on 10/27/20.
//  Copyright © 2020 mong Industries. All rights reserved.
//
import UIKit
import ReactiveSwift

@_functionBuilder
public struct CollectionAdapterSectionBuilder {
  public static func buildExpression<Item: CollectionAdapterSection>
    (_ item: Item) -> AnySection {
    AnySection(item) }

  public static func buildBlock
    (_ items: AnySection...) -> AnySection {
    AnySection(items) }
}
