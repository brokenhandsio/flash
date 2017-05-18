import PackageDescription

let package = Package(
    name: "Flash",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
        .Package(url: "https://github.com/vapor/auth-provider.git", majorVersion: 1)
    ]
)
