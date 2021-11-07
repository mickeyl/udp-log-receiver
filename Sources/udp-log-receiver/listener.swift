//
//  File.swift
//  
//
//  Created by Dr. Michael 'Mickey' Lauer on 07.11.21.
//
#if os(Linux)
import Glibc
#endif
#if canImport(ObjectiveC)
import Darwin
#endif

import Foundation

class Listener {
    
    private lazy var sockFd = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP)
    
    var addr: sockaddr_in
    var formatter: Formatter!

    init(port: UInt16) {
        self.addr = sockaddr_in()
        let addr_len = UInt8(MemoryLayout.size(ofValue: addr))
        addr.sin_len = addr_len
        addr.sin_port = in_port_t(port.bigEndian)
        addr.sin_family = sa_family_t(AF_INET)
        addr.sin_addr.s_addr = inet_addr("0.0.0.0")
    }

    func listen(formatter: Formatter) throws {

        let bindSuccess: Int32 = withUnsafePointer(to: &self.addr) { sockaddrInPtr in
            let sockaddrPtr = UnsafeRawPointer(sockaddrInPtr).assumingMemoryBound(to: sockaddr.self)
            return bind(self.sockFd, sockaddrPtr, UInt32(MemoryLayout<sockaddr_in>.stride))
        }
        let bufSize = 65535
        let buf = malloc(bufSize)
        var sockaddrlen = socklen_t(MemoryLayout.size(ofValue: self.addr))
        
        print("listening...")

        while true {
            
            let sockPointer = withUnsafeMutablePointer(to: &self.addr) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1, {$0})
            }
            let bytesRead = recvfrom(self.sockFd, buf, bufSize, 0, sockPointer, &sockaddrlen)
            let data = Data(bytes: buf!, count: bytesRead)
            let string = String(data: data, encoding: .utf8)!
            formatter.output(line: string)
        }
    }
}
