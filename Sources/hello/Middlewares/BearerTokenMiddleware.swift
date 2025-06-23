// import Vapor
// import JWT

// struct BearerTokenMiddleware: AsyncMiddleware {
    
//     func respond(to request: Request, chainingTo next: any AsyncResponder) async throws -> Response {
        
//         // Step 1: Extract the Bearer token from the Authorization header
//         guard let authorizationHeader = request.headers[.authorization].first else {
//             throw Abort(.unauthorized, reason: "Authorization header missing.")
//         }
        
//         // Step 2: Check if the header starts with "Bearer "
//         guard authorizationHeader.hasPrefix("Bearer ") else {
//             throw Abort(.unauthorized, reason: "Invalid authorization header format.")
//         }
        
//         // Step 3: Extract the token after "Bearer "
//         let token = String(authorizationHeader.dropFirst(7))
//         print(token)
//         // Step 4: Verify the token (assuming your payload is a custom struct)
//         do {
//             // Try to decode the token to your payload struct
//             let payload = try await request.jwt.verify(token, as: Payload.self)
            
//             // Attach the decoded user data (or any other info) to the request's context
//             request.auth.login(payload)
            
//         } catch {
//             // If verification fails, throw Unauthorized
//             throw Abort(.unauthorized, reason: "Invalid or expired token.")
//         }
        
//         // Step 5: Continue to the next middleware/route handler
//         return try await next.respond(to: request)
//     }
// }

