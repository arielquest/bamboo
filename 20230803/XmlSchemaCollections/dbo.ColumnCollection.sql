CREATE XML SCHEMA COLLECTION [dbo].[ColumnCollection] AS
N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified"><xsd:element name="Columns"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="Column" minOccurs="0" maxOccurs="unbounded"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any processContents="skip" minOccurs="0" /></xsd:sequence><xsd:attribute name="Name" type="ColumnName" use="required" /><xsd:attribute name="DataType" type="DataType" use="required" /><xsd:attribute name="IsNull" type="xsd:boolean" /><xsd:attribute name="Encrypted" type="xsd:boolean" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:simpleType name="ColumnName"><xsd:restriction base="xsd:string"><xsd:minLength value="1" /><xsd:maxLength value="128" /></xsd:restriction></xsd:simpleType><xsd:simpleType name="DataType"><xsd:restriction base="xsd:string"><xsd:enumeration value="Int16" /><xsd:enumeration value="Int32" /><xsd:enumeration value="Int64" /><xsd:enumeration value="DateTime" /><xsd:enumeration value="Double" /><xsd:enumeration value="Float" /><xsd:enumeration value="Guid" /><xsd:enumeration value="Boolean" /><xsd:enumeration value="String" /><xsd:enumeration value="Xml" /><xsd:enumeration value="TimeSpan" /></xsd:restriction></xsd:simpleType></xsd:schema>'
GO
GRANT EXECUTE
	ON XML SCHEMA COLLECTION::[dbo].[ColumnCollection]
	TO [portalapp_role]
GO
GRANT EXECUTE
	ON XML SCHEMA COLLECTION::[dbo].[ColumnCollection]
	TO [portal_database_configuration_role]
GO
