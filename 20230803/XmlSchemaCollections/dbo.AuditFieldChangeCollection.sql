CREATE XML SCHEMA COLLECTION [dbo].[AuditFieldChangeCollection] AS
N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified"><xsd:element name="FieldChanges"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="FieldChange" maxOccurs="unbounded"><xsd:complexType><xsd:complexContent><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:element name="PreviousValue" type="xsd:string" /><xsd:element name="NewValue" type="xsd:string" /></xsd:sequence><xsd:attribute name="Field" use="required"><xsd:simpleType><xsd:restriction base="xsd:string"><xsd:minLength value="1" /><xsd:maxLength value="128" /></xsd:restriction></xsd:simpleType></xsd:attribute></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element></xsd:schema>'
GO
GRANT EXECUTE
	ON XML SCHEMA COLLECTION::[dbo].[AuditFieldChangeCollection]
	TO [portalapp_role]
GO
