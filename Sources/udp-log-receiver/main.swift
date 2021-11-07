import ArgumentParser
import Foundation

struct Listen: ParsableCommand {
    @Option(name: .shortAndLong, help: "The UDP port to listen to.")
    var port: Int?
    
    mutating func run() throws {
        
        let formatter = Formatter()

        let port = self.port ?? 5514
        let listener = Listener(port: UInt16(port))
        try listener.listen(formatter: formatter)
        
        print("Listening on port \(port)...")
        
        RunLoop.current.run()
    }
}

Listen.main()
