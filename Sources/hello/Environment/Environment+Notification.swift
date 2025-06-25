import Vapor
import WebPush

extension Environment {
    struct WebApp: Sendable {
        /// Name of the installed Progressive Web App
        let appName = Environment.get("PWA_APP_NAME")!

        /// Start URL of the installed Progressive Web App
        let startURL = Environment.get("PWA_START_URL")!
    }

    struct WebPush: Sendable {
        /// Authorization key for sending out notifications
        let notifyApiKey = Environment.get("NOTIFY_API_KEY")

        /// Configuration JSON for web push
        let vapidConfig = Environment.get("VAPID_CONFIG")
    }

    /// Evironment values for Web Push
    static let webPush = WebPush()

    /// Evironment values for PWA
    static let webApp = WebApp()
}

extension VAPID.Configuration {
    enum ConfigurationError: Error {
        case missingEnvironmentVariable(String)
        case missingPrimaryKey
    }

    init(
        environment: Environment,
        decoder: JSONDecoder = .init()
    ) throws {
        guard
            let rawVAPIDConfiguration = ProcessInfo.processInfo.environment["VAPID_CONFIG"],

            let configuration = try? JSONDecoder().decode(
                VAPID.Configuration.self, from: Data(rawVAPIDConfiguration.utf8))
        else {
            fatalError(
                "VAPID keys are unavailable, please generate one and add it to the environment.")
        }

        self = configuration
    }
}
