//
//  File.swift
//  
//
//  Created by linhey on 2022/5/8.
//

import XCTest
import Stem
import SwiftGit

class SwiftStatusTests: XCTestCase {
    
    lazy var workFolder = try! FilePath.Folder(path: "~/Downloads/")
    lazy var directory = workFolder.folder(name: "test-clone")
    lazy var repository = "https://github.com/linhay/Arctic"
    
    func test() throws {
        _ = try Git.clone(.defaultTemplate, repository: repository, directory: directory.path)
    }
    
    func testStatus() throws {
        let repo = try Repository(path: directory.path)
        
        let untracked = directory.file(name: "test-untracked")
        let add = directory.file(name: "test-add")
        let modify = directory.file(name: "test-modify")
        
        try [untracked, add, modify].forEach { file in
            try? file.delete()
            try file.create(with: Data([UInt8](repeating: .random(in: 0...100), count: 50)))
        }
        
        try repo.add([], paths: [add.path, modify.path])
        let status = try repo.status()
        print(status)
    }
    
}