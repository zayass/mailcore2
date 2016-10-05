import Foundation

public class MessageHeader {
    private var nativeInstance:CMessageHeader;
    
    internal func CMessageHeader() -> CMessageHeader {
        return nativeInstance;
    }
    
    internal init(header:CMessageHeader) {
        self.nativeInstance = header;
    }
    
    public init(data:Data) {
        self.nativeInstance = newCMessageHeader();
        self.importHeadersData(data: data);
    }
    
    deinit {
        deleteCMessageHeader(nativeInstance);
    }
    
    /** Message-ID field.*/
    public var messageID : String? {
        set { self.nativeInstance.setMessageID(nativeInstance, newValue?.utf16CString); }
        get { return String(utf16: self.nativeInstance.messageID(nativeInstance)); }
    }
    
    /** Message-ID auto-generated flag.*/
    public var isMessageIDAutoGenerated : Bool {
        get { return self.nativeInstance.isMessageIDAutoGenerated(nativeInstance); }
    }
    
    /** References field. It's an array of message-ids.*/
    public var references : Array<String> {
        set { self.nativeInstance.setReferences(nativeInstance, Array<String>.cast(newValue)); }
        get { return Array<String>.cast(self.nativeInstance.references(nativeInstance)); }
    }
    
    /** In-Reply-To field. It's an array of message-ids.*/
    public var inReplyTo : Array<String> {
        set { self.nativeInstance.setInReplyTo(nativeInstance, Array<String>.cast(newValue)); }
        get { return Array<String>.cast(self.nativeInstance.inReplyTo(nativeInstance)); }
    }
    
    /** To field: recipient of the message. It's an array of MCOAddress.*/
    public var to: Array<Address> {
        set { self.nativeInstance.setTo(nativeInstance, Array<Address>.cast(newValue)); }
        get { return Array<Address>.cast(self.nativeInstance.to(nativeInstance)); }
    }
    
    /** Cc field: cc recipient of the message. It's an array of MCOAddress.*/
    public var cc: Array<Address> {
        set { self.nativeInstance.setCc(nativeInstance, Array<Address>.cast(newValue)); }
        get { return Array<Address>.cast(self.nativeInstance.cc(nativeInstance)); }
    }
    
    /** Bcc field: bcc recipient of the message. It's an array of MCOAddress.*/
    public var bcc: Array<Address> {
        set { self.nativeInstance.setBcc(nativeInstance, Array<Address>.cast(newValue)); }
        get { return Array<Address>.cast(self.nativeInstance.bcc(nativeInstance)); }
    }
    
    /** Reply-To field. It's an array of MCOAddress.*/
    public var replyTo: Array<Address> {
        set { self.nativeInstance.setReplyTo(nativeInstance, Array<Address>.cast(newValue)); }
        get { return Array<Address>.cast(self.nativeInstance.replyTo(nativeInstance)); }
    }
    
    /** Subject of the message.*/
    public var subject: String? {
        set { self.nativeInstance.setSubject(nativeInstance, newValue?.utf16CString); }
        get { return String(utf16: self.nativeInstance.subject(nativeInstance)); }
    }
    
    /** Email user agent name: X-Mailer header.*/
    public var userAgent: String? {
        set { self.nativeInstance.setUserAgent(nativeInstance, newValue?.utf16CString); }
        get { return String(utf16: self.nativeInstance.userAgent(nativeInstance)); }
    }
    
    /** Adds a custom header.*/
    public func setExtraHeaderValue(value: String, name: String) {
        nativeInstance.setExtraHeaderValue(nativeInstance, value.utf16CString, name.utf16CString);
    }
    
    /** Remove a given custom header.*/
    public func removeExtraHeaderForName(name: String) {
        nativeInstance.removeExtraHeaderForName(nativeInstance, name.utf16CString);
    }
    
    /** Returns the value of a given custom header.*/
    public func extraHeaderValueForName(name: String) -> String? {
        return String(utf16: nativeInstance.extraHeaderValueForName(nativeInstance, name.utf16CString));
    }
    
    /** Returns an array with the names of all custom headers.*/
    public func allExtraHeadersNames() -> Array<String> {
        return Array<String>.cast(nativeInstance.allExtraHeadersNames(nativeInstance));
    }
    
    /** Extracted subject (also remove square brackets).*/
    public func extractedSubject() -> String? {
        return String(utf16: nativeInstance.extractedSubject(nativeInstance));
    }
    
    /** Extracted subject (don't remove square brackets).*/
    public func partialExtractedSubject() -> String? {
        return String(utf16: nativeInstance.partialExtractedSubject(nativeInstance));
    }
    
    /** Fill the header using the given RFC 822 data.*/
    public func importHeadersData(data: Data) {
        let bytes: UnsafePointer<Int8>? = data.withUnsafeBytes{(bytes: UnsafePointer<Int8>)-> UnsafePointer<Int8> in
            return bytes;
        }
        nativeInstance.importHeadersData(nativeInstance, bytes, UInt32(data.count));
    }
    
    /** Returns a header that can be used as a base for a reply message.*/
    public func replyHeaderWithExcludedRecipients(excludedRecipients: Array<Address>) -> MessageHeader {
        return MessageHeader(header: nativeInstance.replyHeaderWithExcludedRecipients(nativeInstance, Array<Address>.cast(excludedRecipients)));
    }
    
    /** Returns a header that can be used as a base for a reply all message.*/
    public func replyAllHeaderWithExcludedRecipients(excludedRecipients: Array<Address>) -> MessageHeader {
        return MessageHeader(header: nativeInstance.replyAllHeaderWithExcludedRecipients(nativeInstance, Array<Address>.cast(excludedRecipients)));
    }
    
    /** Returns a header that can be used as a base for a forward message.*/
    public func forwardHeader() -> MessageHeader {
        return MessageHeader(header: nativeInstance.forwardHeader(nativeInstance));
    }
    
}
