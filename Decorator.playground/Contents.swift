//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

// // General interface of components.
protocol DataSource {
    func writeData()
    func readData()
}

// One of the specific components implements the basic functionality
class FileDataSource: DataSource {
    
    func writeData() {
        print("add data")
    }
    
    func readData() {
        print("read data")
    }
}

// The parent of all decorators which contains the wrapping code.
class DataSourceDecorator: DataSource {
    
    let wrappee: DataSource?
    
    init(with source: DataSource) {
        wrappee = source
    }
    
    func writeData() {
        wrappee?.writeData()
    }
    
    func readData() {
        wrappee?.readData()
    }
}

// Concrete decorators add something of their own to the base behavior of the wrapped component.
class EncryptionDecorator: DataSourceDecorator {
    
    override func writeData() {
        print("write data in EncryptionDecorator")
    }
    
    override func readData() {
        print("read Data in EncryptionDecorator")
        
    }
}

class CompressionDecorator: DataSourceDecorator {
    
    override func writeData() {
        print("write data in CompressionDecorator")
    }
    
    override func readData() {
        print("read Data in CompressionDecorator")
    }
}

// An example of assembly and use of decorators.
class Application {
    
    func dumbUsageExample() {
        var source: DataSource = FileDataSource()
        source.writeData() // add clean data
        
        source = CompressionDecorator(with: source)
        source.writeData() // add compression data
        
        source = EncryptionDecorator(with: source)
        source.writeData() // add encrypt data
        
        source.readData()
    }
}
