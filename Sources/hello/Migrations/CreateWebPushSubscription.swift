import Fluent
import FluentSQL

struct CreateWebPushSubscription: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("web_push_subscriptions")
            .id()
            .field("endpoint", .string, .required)
            .field("p256dh", .string, .required)
            .field("auth", .string, .required)
            .create()
    }

    func revert(on database: any Database) async throws {
        try await database.schema("web_push_subscriptions").delete()
    }
}