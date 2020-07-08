//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

// The abstract factory interface declares a set of methods that return different abstract products.
protocol GUIFactory {
    func createButton() -> Button?
    func createCheckbox() -> Checkbox?
}

// Concrete factory
class WinFactory: GUIFactory {
    
    func createButton() -> Button? {
        return WinButton()
    }
    
    func createCheckbox() -> Checkbox? {
        return WinCheckbox()
    }
}

// Concrete factory
class MacFactory: GUIFactory {
    func createButton() -> Button? {
        return MacButton()
    }
    
    func createCheckbox() -> Checkbox? {
        return MacCheckbox()
    }
}

// Base interfaces of products.
protocol Button {
    func paint()
}

protocol Checkbox {
    func paint()
}

// Concrete products are created by corresponding concrete factories.
class WinButton: Button {
    func paint() {
        print("paint win button")
    }
}

class MacButton: Button {
    func paint() {
        print("paint mac button")
    }
}

class WinCheckbox: Checkbox {
    func paint() {
        print("paint win checkbox")
    }
}

class MacCheckbox: Checkbox {
    func paint() {
        print("paint mac checkbox")
    }
}

// The client code works with factories and products only through abstract types: GUIFactory, Button and Checkbox. This lets you pass any factory or product subclass to the client code without breaking it.
class Application {
    private var factory: GUIFactory?
    private var button: Button?
    
    init(with factory: GUIFactory) {
        self.factory = factory
    }
    
    func createUI() {
        button = factory?.createButton()
    }
    
    func paint() {
        button?.paint()
    }
}

// The application picks the factory type depending on the current configuration or environment settings and creates it at runtime
class ApplicationConfigurator {
    
    enum OS {
        case Windows
        case Mac
    }
    
    func main(with os: OS) {
        let application = Application(with: readApplicationConfigFile(with: os))
        
        application.createUI()
        application.paint()
    }
    
    func readApplicationConfigFile(with os: OS) -> GUIFactory {
        switch os {
        case .Windows:
            return WinFactory()
        case .Mac:
            return MacFactory()
        }
    }
}

print(ApplicationConfigurator().main(with: .Mac))

