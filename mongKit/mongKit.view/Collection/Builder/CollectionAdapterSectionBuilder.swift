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
        if Item.self == AnySection.self {
            return item as! AnySection
        } else {
            return AnySection(item) } }

    public static func buildBlock
    (_ item: AnySection) -> [AnySection] {
        [item] }
    
    public static func buildBlock
    (_ items: AnySection...) -> [AnySection] {
        items }
    
    public static func buildIf
      (_ item: AnySection?) -> [AnySection] {
        if let item = item {
            return [ item ]
        } else {
            return  []
        } }

    public static func buildEither
      (first item: AnySection) -> AnySection {
        item }

    public static func buildEither
      (second item: AnySection) -> AnySection {
        item }
}
