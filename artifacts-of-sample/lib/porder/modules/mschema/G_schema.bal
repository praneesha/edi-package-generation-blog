
import ballerina/edi;

public isolated function fromEdiString(string ediText) returns EDI_schema_SimpleOrder|error {
    edi:EdiSchema ediSchema = check edi:getSchema(schemaJson);
    json dataJson = check edi:fromEdiString(ediText, ediSchema);
    return dataJson.cloneWithType();
}

public isolated function toEdiString(EDI_schema_SimpleOrder data) returns string|error {
    edi:EdiSchema ediSchema = check edi:getSchema(schemaJson);
    return edi:toEdiString(data, ediSchema);    
} 

public isolated function getSchema() returns edi:EdiSchema|error {
    return edi:getSchema(schemaJson);
}

public isolated function fromEdiStringWithSchema(string ediText, edi:EdiSchema schema) returns EDI_schema_SimpleOrder|error {
    json dataJson = check edi:fromEdiString(ediText, schema);
    return dataJson.cloneWithType();
}

public isolated function toEdiStringWithSchema(EDI_schema_SimpleOrder data, edi:EdiSchema ediSchema) returns string|error {
    return edi:toEdiString(data, ediSchema);    
}

public type Header_Type record {|
   string code = "HDR";
   string orderId?;
   string organization?;
   string date?;
|};

public type Items_Type record {|
   string code = "ITM";
   string item?;
   int? quantity?;
|};

public type EDI_schema_SimpleOrder record {|
   Header_Type? header?;
   Items_Type[] items = [];
|};



final readonly & json schemaJson = {"name":"EDI_schema_SimpleOrder", "tag":"Root_mapping", "delimiters":{"segment":"~", "field":"*", "component":":", "subcomponent":"NOT_USED", "repetition":"^"}, "ignoreSegments":[], "preserveEmptyFields":true, "includeSegmentCode":true, "segments":[{"code":"HDR", "tag":"header", "truncatable":true, "minOccurances":0, "maxOccurances":1, "fields":[{"tag":"code", "repeat":false, "required":true, "truncatable":true, "dataType":"string", "startIndex":-1, "length":-1, "components":[]}, {"tag":"orderId", "repeat":false, "required":false, "truncatable":true, "dataType":"string", "startIndex":-1, "length":-1, "components":[]}, {"tag":"organization", "repeat":false, "required":false, "truncatable":true, "dataType":"string", "startIndex":-1, "length":-1, "components":[]}, {"tag":"date", "repeat":false, "required":false, "truncatable":true, "dataType":"string", "startIndex":-1, "length":-1, "components":[]}]}, {"code":"ITM", "tag":"items", "truncatable":true, "minOccurances":0, "maxOccurances":-1, "fields":[{"tag":"code", "repeat":false, "required":true, "truncatable":true, "dataType":"string", "startIndex":-1, "length":-1, "components":[]}, {"tag":"item", "repeat":false, "required":false, "truncatable":true, "dataType":"string", "startIndex":-1, "length":-1, "components":[]}, {"tag":"quantity", "repeat":false, "required":false, "truncatable":true, "dataType":"int", "startIndex":-1, "length":-1, "components":[]}]}], "segmentDefinitions":{}};
    