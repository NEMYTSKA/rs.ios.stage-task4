import Foundation

final class CallStation {

    var userArray = [User]()
    var usersCallArray = [Call]()

    //var arrayCallID = [CallID]()

}


extension CallStation: Station {

    func users() -> [User] {
        return userArray
    }

    func add(user: User) {
        if !userArray.contains(user) {
            userArray.append(user)
        }
    }

    func remove(user: User) {
        if (userArray.contains(user)) {
            userArray.remove(at: userArray.firstIndex(of: user)!)
        }
    }

    func execute(action: CallAction) -> CallID? {
        switch action {
        case .start(from: let fromUser, to: let toUser):
        if !userArray.contains(fromUser) && !userArray.contains(toUser) {
            return nil
        } else if !userArray.contains(toUser) {
            let call = Call(id: UUID.init(), incomingUser: fromUser, outgoingUser: toUser, status: .ended(reason: .error))
            usersCallArray.append(call)
            return call.id
        }

        if self.currentCall(user: toUser) != nil {
            let call = Call(id: UUID.init(), incomingUser: fromUser, outgoingUser: toUser, status: .ended(reason: .userBusy))
            usersCallArray.append(call)
        } else {
            let call = Call(id: UUID.init(), incomingUser: fromUser, outgoingUser: toUser, status: .calling)
            usersCallArray.append(call)
        }

        if let index = usersCallArray.firstIndex(where: { $0.incomingUser == fromUser && $0.outgoingUser == toUser }) {
            return usersCallArray[index].id
        }

        return nil
            
        case  .answer(from: let user):
        if !userArray.contains(user) {
            if let index = usersCallArray.firstIndex(where: { $0.outgoingUser == user }) {
                usersCallArray[index].status = .ended(reason: .error)
            }
            return nil
        }

        let callId = calls(user: user).first?.id

        if let index = usersCallArray.firstIndex(where: { $0.id == callId }) {
            if usersCallArray[index].status == .calling {
                usersCallArray[index].status = .talk
            }
        }

        return callId
            
        case .end(from: let user):
            let callId = calls(user: user).first?.id

            if usersCallArray.contains(where: { $0.id == callId }) {
                if let index = usersCallArray.firstIndex(where: { $0.id == callId }) {
                    if usersCallArray[index].status == .calling {
                        usersCallArray[index].status = .ended(reason: .cancel)
                    }
                    if usersCallArray[index].status == .talk {
                        usersCallArray[index].status = .ended(reason: .end)
                    }
                }
            }

            return callId
        }
    
    }

    func calls() -> [Call] {
        return usersCallArray
    }

    func calls(user: User) -> [Call] {
        var calls = [Call]()
        for call in usersCallArray {
            if call.incomingUser == user || call.outgoingUser == user {
                calls.append(call)
            }
        }
        return calls
    }

    func call(id: CallID) -> Call? {
        for call in usersCallArray {
            if call.id == id {
                return call
            }
        }
        return nil
    }

    func currentCall(user: User) -> Call? {
        for call in usersCallArray {
            if (call.outgoingUser == user || call.incomingUser == user) && (call.status == .calling || call.status == .talk) {
                return call
            }
        }
        return nil
    }
}
