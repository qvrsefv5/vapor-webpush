import NIOSSL
import Fluent
import FluentMySQLDriver
import Vapor
import JWT

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // Add HMAC with SHA0-256 signer.
    await app.jwt.keys.add(hmac: "your-secret-key", digestAlgorithm: .sha256)

    var tlsConfig = TLSConfiguration.makeClientConfiguration()
          tlsConfig.certificateVerification = .none
    
    app.databases.use(DatabaseConfigurationFactory.mysql(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? MySQLConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
        tlsConfiguration: tlsConfig
    ), as: .mysql)

    app.migrations.add(CreateTodo())
    app.migrations.add(CreateUser())
    app.migrations.add(CreateToken())
    app.migrations.add(CreateWebPushSubscription())
    
    /** 
    *SESSION*
    **/
//    app.sessions.configuration.cookieName = "refreshToken"

    //  Configures cookie value creation.
//    app.sessions.configuration.cookieFactory = { sessionID in
//            .init(string: sessionID.string,  expires: Date(timeIntervalSinceNow: Constants.refreshTokenExpiration),/* path: "/refresh",*/ isSecure: true,isHTTPOnly: true, sameSite: HTTPCookies.SameSitePolicy.strict)
//    }

    /**
     *CORS*
     */
    let corsConfiguration = CORSMiddleware.Configuration(
            allowedOrigin: .any(["http://localhost:5173", "http://localhost:8081", "https://baliky.etabletka.sk"]),
            allowedMethods: [.GET, .POST, .PUT, .OPTIONS, .DELETE, .PATCH],
            allowedHeaders: [.accept, .authorization, .contentType, .origin, .xRequestedWith, .userAgent, .accessControlAllowOrigin, .accessControlAllowCredentials],
            allowCredentials: true
    )
    let cors = CORSMiddleware(configuration: corsConfiguration)
    
    app.middleware.use(cors, at: .beginning)
    app.middleware.use(app.sessions.middleware)

    // register routes
    try routes(app)
    // webpush
    try configureNotificationService(app)
}
