# Flash ⚡️
[![Swift Version](https://img.shields.io/badge/Swift-5.8-brightgreen.svg)](http://swift.org)
[![Vapor Version](https://img.shields.io/badge/Vapor-4-30B6FC.svg)](http://vapor.codes)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/nodes-vapor/flash/master/LICENSE)

This package allows you to display Flash messages between your views.

![image](https://github.com/nodes-vapor/flash/blob/master/flash.png)

# Installation

Add `Flash` to the package dependencies (in your `Package.swift` file):

```swift
dependencies: [
    ...,
    .package(url: "https://github.com/nodes-vapor/flash.git", from: "4.0.0")
]
```

as well as to your target (e.g. "App"):

```swift
targets: [
    ...
    .target(
        name: "App",
        dependencies: [... "Flash" ...]
    ),
    ...
]
```

## Getting started 🚀

First make sure that you've imported Flash everywhere when needed:

```swift
import Flash
```

### Adding the middleware

You can either add the Flash middleware globally by doing:

```swift
func configure(_ app: Application) throws {
    app.middleware.use(FlashMiddleware())
}
```

Alternatively, you can add the middleware to individual route groups where needed:

```swift
router.grouped([SessionsMiddleware(driver: app.sessions.driver), FlashMiddleware()]) { router in
    // .. routes
}
```

Please note that the `SessionsMiddleware` needs to be added to the same route groups where Flash is added.

### Adding the Leaf tag

In order to render Flash messages, you will need to add the Flash Leaf tag to your application:

```swift
func configure(_ app: Application) throws {
    app.leaf.tags["flashes"] = FlashTag()
}
```

## Using Flash messages

With Flash set up, you are now able to redirect while adding a Flash message, given a `Request`:

```swift
request.redirect(to: "/users").flash(.success, "Successfully saved")
request.redirect(to: "/users").flash(.info, "Email sent")
request.redirect(to: "/users").flash(.warning, "Updated user")
request.redirect(to: "/users").flash(.error, "Something went wrong")
```

### Example of HTML

This package comes with a Leaf tag that makes it easy and convenient to display Flash messages. We suggest to use the [Bootstrap package](https://github.com/nodes-vapor/bootstrap) for rendering Bootstrap elements, but this package does not depend on it.

It's possible to loop through the different kinds of messages using:

- `all`: All Flash messages no matter the kind.
- `successes`: All Flash messages of type `success`.
- `information`: All Flash messages of type `info`.
- `warnings`: All Flash messages of type `warning`.
- `errors`: All Flash messages of type `error`.

Further, using the `message` property you will be able to pull out the message of the Flash message. You can also get the kind by using the `kind` property. This property will hold one of the following values: `success`, `info`, `warning` or `error`. Lastly, you can use the `bootstrapClass` to get the relevant Bootstrap class:

- `success` will return `success`.
- `info` will return `info`.
- `warning` will return `warning`.
- `error` will return `danger`.

#### Not using the Bootstrap package

Without using any dependencies, this is how Flash messages could be rendered:

```html
<div class="alerts">
    #(flashes)
</div>
```

Using the example above, this is how they are going to be rendered:

```html
<div class="alerts">
    <div class="alert alert-success" role="alert">
        Successfully saved
    </div>
    <div class="alert alert-info" role="alert">
        Email sent
    </div>
    <div class="alert alert-warning" role="alert">
        Updated user
    </div>
    <div class="alert alert-danger" role="alert">
        Something went wrong
    </div>
</div>
```

## 🏆 Credits

This package is developed and maintained by the Vapor team at [Nodes](https://www.nodesagency.com).

## 📄 License

This package is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT)
