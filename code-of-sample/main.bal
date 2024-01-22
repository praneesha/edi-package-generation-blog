import ballerina/io;
import citymart/porder.mschema;

public function main() returns error? {
    string ediText = check io:fileReadString("resources/order_data.edi");
    mschema:EDI_schema_SimpleOrder myOrder = check mschema:fromEdiString(ediText);

    mschema:Items_Type[] sorted = from var e in myOrder.items
        order by e?.quantity descending
        select e;

    io:println(sorted);
}

