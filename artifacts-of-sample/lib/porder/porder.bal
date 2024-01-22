import porder.mschema;

type EdiSerialize isolated function (anydata) returns string|error;
type EdiDeserialize isolated function (string) returns anydata|error;

public enum EDI_NAME {
    EDI_schema = "schema"
}

public isolated function getEDINames() returns string[] {
    return ["schema"];
}

public isolated function fromEdiString(string ediText, EDI_NAME ediName) returns anydata|error {
    EdiDeserialize? ediDeserialize = ediDeserializers[ediName];
    if ediDeserialize is () {
        return error("EDI deserializer is not initialized for EDI type: " + ediName);
    }
    return ediDeserialize(ediText);
}

public isolated function toEdiString(anydata data, EDI_NAME ediName) returns string|error {
    EdiSerialize? ediSerialize = ediSerializers[ediName];
    if ediSerialize is () {
        return error("EDI serializer is not initialized for EDI type: " + ediName);
    }
    return ediSerialize(data);
}

final readonly & map<EdiDeserialize> ediDeserializers = {
        "schema": mschema:transformFromEdiString
};

final readonly & map<EdiSerialize> ediSerializers = {
        "schema": mschema:transformToEdiString
};
    