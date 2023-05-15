import Leaf
import LeafKit
import Vapor

public struct FlashTag: UnsafeUnescapedLeafTag {
    public init() {}

    public func render(_ ctx: LeafContext) throws -> LeafData {
        guard let request = ctx.request else {
            throw LeafContextError.requestNotPassedToRenderContext
        }

        let result: String = request.flashes.map { flash in
            """
            <div class=\"alert alert-\(flash.kind.bootstrapClass)\" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                \(flash.message)
            </div>
            """
        }.joined(separator: "\n")
        
        return .string(result)
    }
}

enum LeafContextError: Error {
    case requestNotPassedToRenderContext
}

extension LeafContextError {
    var identifier: String {
        switch self {
        case .requestNotPassedToRenderContext: return "requestNotPassedToRenderContext"
        }
    }

    var reason: String {
        switch self {
        case .requestNotPassedToRenderContext: return "Request not passed into render context."
        }
    }
}

