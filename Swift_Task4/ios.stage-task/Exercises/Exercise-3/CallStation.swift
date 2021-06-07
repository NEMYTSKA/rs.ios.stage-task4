import Foundation

final class CallStation {
    var userSet: Set <User> = []
    var userArray = [User]()
    var usersCallArray = [Call]()
    
    var arrayCallID = [CallID]()
    
}

extension User: Hashable {
    func hash(into hasher: inout Hasher) { }
    
}

extension CallStation: Station {
    func users() -> [User] {
        return Array(userSet)
    }

    func add(user: User) {
        userSet.insert(user)
    }

    func remove(user: User) {

    }

    func execute(action: CallAction) -> CallID? {
        switch action {
        case .start(from: let a, to: let b):
            let callID_1 = CallID()
            //arrayCallID.append(callID_1)
            
            var call = Call(id: callID_1, incomingUser: b, outgoingUser: a, status: .calling)
            usersCallArray.append(call)
            
            return callID_1
        case .answer(from: let a):
            let callID_2 = CallID()
            //arrayCallID.append(callID_2)
            
            
            
            return callID_2
        default:
            return nil
        }
//        return nil
    }

    func calls() -> [Call] {
        return usersCallArray
    }

    func calls(user: User) -> [Call] {
        []
    }

    func call(id: CallID) -> Call? {
        nil
    }

    func currentCall(user: User) -> Call? {
        return usersCallArray[0]
    }
}

