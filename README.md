# hello

💧 A project built with the Vapor web framework.

## Getting Started

To build the project using the Swift Package Manager, run the following command in the terminal from the root of the project:

```bash
swift build
```

To run the project and start the server, use the following command:

```bash
swift run
```

To execute tests, use the following command:

```bash
swift test
```

### Commands to run

generate webpush vapid
https://github.com/mochidev/swift-webpush?tab=readme-ov-file#registering-subscribers

```bash
~/.swiftpm/bin/vapid-key-generator https://example.com
```

output copy to .env as VAPID_CONFIG={...}

need to comment out code that uses .env so it has no problem to run migration

```bash
docker compose build
docker compose up —detach app
docker compose run migrate
```

check directory where is index.html and service worker

```bash
cd ./path/to/index.html
npx http-server -f ./index.html
```

allow notification in browser in system settings

### See more

- [Vapor Website](https://vapor.codes)
- [Vapor Documentation](https://docs.vapor.codes)
- [Vapor GitHub](https://github.com/vapor)
- [Vapor Community](https://github.com/vapor-community)
