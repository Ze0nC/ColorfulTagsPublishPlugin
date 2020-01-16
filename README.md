# ColorfulTags Plugin for Publish 


A plugin for making tags have different colors when using  [Publish](https://github.com/johnsundell/publish). 

## Installation
Add `ColorfulTagsPublishPlugin` to your package. 

```swift
let package = Package(
    ...
    dependencies: [
    .package(url: "https://github.com/Ze0nC/ColorfulTagsPublishPlugin", .branch("master"))
    ],
    targets: [
        .target(
            ...
            dependencies: [
                ...
                "ColorfulTagsPublishPlugin"
            ]
        )
    ]
    ...
)
```

## Usage

1. Add the plugin to your build pipeline (after your Markdown files are processed, before HTML files are generated).
```swift
import ColorfulTagsPublishPlugin
...
try MyWebsite().publish(using: [
    .addMarkdownFiles(),
    .installPlugin(.colorfulTags(defaultClass: "tag", variantPrefix: "variant", numberOfVariants: 8)),
    ...
    .generateHTML(withTheme: .foundation),
    ...
])
```

This plugin takes 3 parameters. They are:

- `defaultClass: String` The default class name of tags in HTML. It is `"tag"` in Foundation theme.
- `variantPrefix: String` The variant class name prefix in your CSS file. In the above case, the generated class names will be `variant-0`, `variant-1`, etc.
- `numberOfVariants: Int` The number of variant classes in your CSS file.

2. Modify the codes that produce HTML of tag list in your theme file. In the case of Foundation theme:

Change:

```swift
    ...
    .class("tag"),
    ...
```

To:

```swift
    ...
    .class(tag.colorfiedClass),
    ...
```

You might need to modify more than one places.

If the original theme doesn't specify class with `.class("tag")`, please add  `.class(tag.colorfiedClass)` by your own.


3. Add `background-color` of variant classes in your CSS file. Example:

```css
.variant-0 {background-color: #66293c;}
.variant-1 {background-color: #913e37;}
.variant-2 {background-color: #ca7618;}
.variant-3 {background-color: #a38138;}
.variant-4 {background-color: #2f7176;}
.variant-5 {background-color: #246089;}
.variant-6 {background-color: #498840;}
.variant-7 {background-color: #484781;}
```

In the above example,  `variantPrefix` is `"variant"` and `numberOfVariants` is `8`. 

## Acknowledgement

Thanks to John Sundell (@johnsundell) for creating [Publish](https://github.com/johnsundell/publish)

## License
MIT License
