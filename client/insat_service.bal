import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: INSTA_DESC}
service "Insat" on ep {

    remote function postMessage(post value) returns Tweet|error {
    }
    remote function likeMessage(ReactionMessage value) returns string|error {
    }
    remote function comment(commentMessage value) returns Tweet|error {
    }
    remote function viewMessages() returns stream<Tweet, error?>|error {
    }
}

