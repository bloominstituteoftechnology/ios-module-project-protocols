//: # Create a Protocol
//: optional add required parameters and methods
protocol MyProtocol {
    
}
//: # Create a Protocol Delegate
//: including any required parameters or methods
protocol MyProtocolDelegate {
    func helloWorld()
}

//: # Create a Delegate Class
//: conforming to your protocol Delegate
class MyDelegateClass: MyProtocolDelegate {
    func helloWorld() {
        print("hello world")
    }
}

//: # Create a class conforming to your protocol
class MyProtocolClass: MyProtocol {
    
    //include an optional instance of the Protocol Delegate you created above
    var delegate: MyProtocolDelegate?
    
    // Implement required functions:
    // helloDelegate calls helloWorld from MyProtocolDelegate
    func helloDelegate() {
        delegate?.helloWorld()
    }
}



var protoClass = MyProtocolClass()
var delegateInstance = MyDelegateClass()

//: If you don't set this, it won't crash, it will compile and run.
protoClass.delegate = delegateInstance
//: ## BUT your delegate function won't be called. delegate is an optional
//: comment the line setting the delegate and run the project to see


protoClass.helloDelegate()
