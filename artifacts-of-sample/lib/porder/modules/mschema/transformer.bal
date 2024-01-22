
type InternalType EDI_schema_SimpleOrder;

public isolated function transformFromEdiString(string ediText) returns anydata|error {
    EDI_schema_SimpleOrder data = check fromEdiString(ediText);
    return transformRead(data);
}

isolated function transformRead(EDI_schema_SimpleOrder data) returns InternalType => data;

public isolated function transformToEdiString(anydata content) returns string|error {
    EDI_schema_SimpleOrder data = transformWrite(check content.ensureType());
    return toEdiString(data);
}

isolated function transformWrite(InternalType data) returns EDI_schema_SimpleOrder => data;
    