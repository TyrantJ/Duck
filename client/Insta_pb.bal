import ballerina/grpc;
import ballerina/protobuf;
import ballerina/protobuf.types.empty;
import ballerina/protobuf.types.wrappers;

public const string INSTA_DESC = "0A0B496E7374612E70726F746F1205496E7361741A1B676F6F676C652F70726F746F6275662F656D7074792E70726F746F1A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F22340A04706F737412180A076D65737361676518012001280952076D65737361676512120A0474696D65180220012809520474696D65225C0A0F5265616374696F6E4D657373616765122B0A087265616374696F6E18012001280E320F2E496E7361742E5265616374696F6E52087265616374696F6E121C0A096D657373616765496418022001280952096D657373616765496422770A055477656574120E0A0269641801200128095202696412180A076D65737361676518022001280952076D65737361676512120A0474696D65180320012809520474696D6512140A056C696B657318042001280352056C696B6573121A0A08636F6D6D656E74731805200328095208636F6D6D656E747322480A0E636F6D6D656E744D65737361676512180A07636F6D6D656E741801200128095207636F6D6D656E74121C0A096D657373616765496418022001280952096D65737361676549642A210A085265616374696F6E12080A046C696B651000120B0A074469736C696B65100132DE010A05496E73617412280A0B706F73744D657373616765120B2E496E7361742E706F73741A0C2E496E7361742E547765657412430A0B6C696B654D65737361676512162E496E7361742E5265616374696F6E4D6573736167651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565122E0A07636F6D6D656E7412152E496E7361742E636F6D6D656E744D6573736167651A0C2E496E7361742E547765657412360A0C766965774D6573736167657312162E676F6F676C652E70726F746F6275662E456D7074791A0C2E496E7361742E54776565743001620670726F746F33";

public isolated client class InsatClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, INSTA_DESC);
    }

    isolated remote function postMessage(post|ContextPost req) returns Tweet|grpc:Error {
        map<string|string[]> headers = {};
        post message;
        if req is ContextPost {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Insat.Insat/postMessage", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Tweet>result;
    }

    isolated remote function postMessageContext(post|ContextPost req) returns ContextTweet|grpc:Error {
        map<string|string[]> headers = {};
        post message;
        if req is ContextPost {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Insat.Insat/postMessage", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Tweet>result, headers: respHeaders};
    }

    isolated remote function likeMessage(ReactionMessage|ContextReactionMessage req) returns string|grpc:Error {
        map<string|string[]> headers = {};
        ReactionMessage message;
        if req is ContextReactionMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Insat.Insat/likeMessage", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return result.toString();
    }

    isolated remote function likeMessageContext(ReactionMessage|ContextReactionMessage req) returns wrappers:ContextString|grpc:Error {
        map<string|string[]> headers = {};
        ReactionMessage message;
        if req is ContextReactionMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Insat.Insat/likeMessage", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: result.toString(), headers: respHeaders};
    }

    isolated remote function comment(commentMessage|ContextCommentMessage req) returns Tweet|grpc:Error {
        map<string|string[]> headers = {};
        commentMessage message;
        if req is ContextCommentMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Insat.Insat/comment", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Tweet>result;
    }

    isolated remote function commentContext(commentMessage|ContextCommentMessage req) returns ContextTweet|grpc:Error {
        map<string|string[]> headers = {};
        commentMessage message;
        if req is ContextCommentMessage {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("Insat.Insat/comment", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Tweet>result, headers: respHeaders};
    }

    isolated remote function viewMessages() returns stream<Tweet, grpc:Error?>|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("Insat.Insat/viewMessages", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, _] = payload;
        TweetStream outputStream = new TweetStream(result);
        return new stream<Tweet, grpc:Error?>(outputStream);
    }

    isolated remote function viewMessagesContext() returns ContextTweetStream|grpc:Error {
        empty:Empty message = {};
        map<string|string[]> headers = {};
        var payload = check self.grpcClient->executeServerStreaming("Insat.Insat/viewMessages", message, headers);
        [stream<anydata, grpc:Error?>, map<string|string[]>] [result, respHeaders] = payload;
        TweetStream outputStream = new TweetStream(result);
        return {content: new stream<Tweet, grpc:Error?>(outputStream), headers: respHeaders};
    }
}

public class TweetStream {
    private stream<anydata, grpc:Error?> anydataStream;

    public isolated function init(stream<anydata, grpc:Error?> anydataStream) {
        self.anydataStream = anydataStream;
    }

    public isolated function next() returns record {|Tweet value;|}|grpc:Error? {
        var streamValue = self.anydataStream.next();
        if (streamValue is ()) {
            return streamValue;
        } else if (streamValue is grpc:Error) {
            return streamValue;
        } else {
            record {|Tweet value;|} nextRecord = {value: <Tweet>streamValue.value};
            return nextRecord;
        }
    }

    public isolated function close() returns grpc:Error? {
        return self.anydataStream.close();
    }
}

public client class InsatTweetCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendTweet(Tweet response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextTweet(ContextTweet response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class InsatStringCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendString(string response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextString(wrappers:ContextString response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextTweetStream record {|
    stream<Tweet, error?> content;
    map<string|string[]> headers;
|};

public type ContextPost record {|
    post content;
    map<string|string[]> headers;
|};

public type ContextTweet record {|
    Tweet content;
    map<string|string[]> headers;
|};

public type ContextReactionMessage record {|
    ReactionMessage content;
    map<string|string[]> headers;
|};

public type ContextCommentMessage record {|
    commentMessage content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: INSTA_DESC}
public type post record {|
    string message = "";
    string time = "";
|};

@protobuf:Descriptor {value: INSTA_DESC}
public type Tweet record {|
    string id = "";
    string message = "";
    string time = "";
    int likes = 0;
    string[] comments = [];
|};

@protobuf:Descriptor {value: INSTA_DESC}
public type ReactionMessage record {|
    Reaction reaction = like;
    string messageId = "";
|};

@protobuf:Descriptor {value: INSTA_DESC}
public type commentMessage record {|
    string comment = "";
    string messageId = "";
|};

public enum Reaction {
    like, Dislike
}

