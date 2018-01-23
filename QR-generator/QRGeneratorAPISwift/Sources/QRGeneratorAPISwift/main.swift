import Foundation
import PerfectHTTP
import PerfectHTTPServer

var routes = Routes()
routes.add(method: .get, uri: "/seed") {
    request, response in
    
    // create seed model
    var seed = Seed()
    seed.seed = String.random()
    
    // only available for OSX 10.12
    if #available(OSX 10.12, *) {
        
        // create expiresAt date string
        let date = Date(timeIntervalSinceNow: 60)
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.timeZone = TimeZone.ReferenceType.local
        let formatDateString = dateFormatter.string(from: date)
        seed.expiresAt = formatDateString
    }
    
    response.setHeader(.contentType, value: "application/json")
    try? response.setBody(json: seed.toJSON())
        .completed()
}

do {
    // start http server
    try HTTPServer.launch(
        .server(name: "localhost", port: 3000, routes: routes))
} catch {
    fatalError("\(error)")
}
