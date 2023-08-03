CREATE XML SCHEMA COLLECTION [dbo].[ResourceTemplate] AS
N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified"><xsd:element name="Template"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="Field" minOccurs="0" maxOccurs="unbounded"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any processContents="skip" minOccurs="0" /></xsd:sequence><xsd:attribute name="Name" type="FieldName" use="required" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:simpleType name="FieldName"><xsd:restriction base="xsd:string"><xsd:minLength value="1" /><xsd:maxLength value="256" /></xsd:restriction></xsd:simpleType></xsd:schema>'
GO
GRANT EXECUTE
	ON XML SCHEMA COLLECTION::[dbo].[ResourceTemplate]
	TO [portalapp_role]
GO
