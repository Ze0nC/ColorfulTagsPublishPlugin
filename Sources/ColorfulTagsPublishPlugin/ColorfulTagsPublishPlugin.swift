//
//  ColorfulTags.swift
//
//
//  Created by Zhijin Chen on 2020/01/16.
//

import Foundation
import Publish

public protocol ItemColorfier {
    associatedtype Item
    
    var defaultClass: String { get }
    var numberOfVariants: Int { get }
    var variantPrefix: String { get }
    var items: Array<Item> { get }
}

public struct TagColorfier: ItemColorfier {
    public let defaultClass: String
    
    public let numberOfVariants: Int
    
    public let variantPrefix: String
    
    public let items: Array<Tag>
    
    public typealias Item = Tag
    
    private static var shared: TagColorfier = TagColorfier()
    
    private init() {
        self.numberOfVariants = 1
        self.variantPrefix = ""
        self.items = Array<Tag>()
        self.defaultClass = ""
    }
    
    private init<T: Website>(defaultClass: String, variantPrefix: String, numberOfVariants: Int, in context: PublishingContext<T>) {
        self.numberOfVariants = numberOfVariants
        self.variantPrefix = variantPrefix
        self.items = Array<Tag>(context.allTags).sorted()
        self.defaultClass = defaultClass
    }
    
    internal static func setup<T: Website>(defaultClass: String, variantPrefix: String, numberOfVariants: Int, in context: PublishingContext<T>) {
        self.shared = TagColorfier(defaultClass: defaultClass, variantPrefix: variantPrefix, numberOfVariants: numberOfVariants, in: context)
    }
    
    internal static func colorfiedClass(for tag: Tag) -> String {
        if let index = shared.items.firstIndex(of: tag) {
            return "\(shared.defaultClass) \(shared.variantPrefix)-\(index % shared.numberOfVariants)"
        } else {
            return shared.defaultClass
        }
    }
    
}

public extension Tag {
    var colorfiedClass : String { TagColorfier.colorfiedClass(for: self) }
}

public extension Plugin {
    
    /// Plugin to colorfy Tags.
    /// - Parameters:
    ///   - defaultClass: The default class name for Tag. Example: "tag".
    ///   - variantPrefix: The class prefix in css file. Example: "variant".
    ///   - numberOfVariants: The number of color classes in css.
    static func colorfulTags(defaultClass: String, variantPrefix: String, numberOfVariants: Int) -> Self {
        Plugin(name: "ColorfulTags") { context in
            TagColorfier.setup(defaultClass: defaultClass, variantPrefix: variantPrefix, numberOfVariants: numberOfVariants, in: context)
        }
    }
}
