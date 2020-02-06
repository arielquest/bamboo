CREATE ASSEMBLY [ApexSQL.Audit.BeforeAfter.dbo.CourseInstructor.Delete]
	AUTHORIZATION [dbo]
	FROM 0x4D5A90000300000004000000FFFF0000B800000000000000400000000000000000000000000000000000000000000000000000000000000000000000800000000E1FBA0E00B409CD21B8014CCD21546869732070726F6772616D2063616E6E6F742062652072756E20696E20444F53206D6F64652E0D0D0A2400000000000000504500004C010300D42ABB5D0000000000000000E00002210B010B00000A00000008000000000000DE2900000020000000400000000000100020000000020000040000000000000004000000000000000080000000020000000000000300408500001000001000000000100000100000000000001000000000000000000000008429000057000000004000006804000000000000000000000000000000000000006000000C00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000080000000000000000000000082000004800000000000000000000002E74657874000000E409000000200000000A000000020000000000000000000000000000200000602E72737263000000680400000040000000060000000C0000000000000000000000000000400000402E72656C6F6300000C0000000060000000020000001200000000000000000000000000004000004200000000000000000000000000000000C029000000000000480000000200050010210000740800000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000133002004500000001000011730E00000A0A0672010000706F0F00000A0672130000706F0F00000A068004000004730E00000A0B0772010000706F0F00000A0772130000706F0F00000A0780050000042A867225000070722D0000707E040000047E05000004724F0000701716281100000A2A867225000070722D0000707E040000047E05000004724F0000701617281100000A2A867225000070722D0000707E040000047E05000004724F0000701717281100000A2A1E02281200000A2A0042534A4201000100000000000C00000076342E302E33303331390000000005006C0000007C020000237E0000E80200006803000023537472696E677300000000500600007C00000023555300CC060000100000002347554944000000DC0600009801000023426C6F620000000000000002000001571C02080900000000FA253300160000010000001200000002000000050000000500000012000000030000000E0000000100000001000000010000000400000000000A00010000000000060084007D000600C500AA0006001B01090106003201090106004F01090106006801090106008101090106009C0109010600\
BB0109010600D60109010600EF017D000600240205020600380209010600710251020600910251020A001003F5020E003E0357001200C500AA000000000001000000000001000100010000004400570005000100010051808B000A00518096000A005180A2000A003100CC0060003100DA0060005020000000009118E70067000100A120000000009600EE0067000100C320000000009600F50067000100E520000000009600FC0067000100072100000000861803016B000100190003016F00210003016F00290003016F00310003016F00390003016F00410003016F00490003016F00510003016F00590003017400610003017400690003016F00710003017900790003016B000C0003016B000C00E5028400810003016B0089005303B800090003016B000E0004000D000E0008002E000E000C0035002E00230034012E002B0045012E0063006E012E000B00FB002E0013001B012E001B0021012E006B0077012E0033001B012E003B001B012E004B001B012E0053001B0140008300970060008300CB0080008300E3008A007E0004800000E307010063060000000000000000AF02000004000000000000000000000001007400000000000400000000000000000000000100E90200000000E30701006306000000000000AF0024030000000002000000000000000000000001007400000000000000003C4D6F64756C653E004170657853514C2E41756469742E4265666F726541667465722E64626F2E436F75727365496E7374727563746F722E44656C6574652E646C6C004265666F7265416674657254726967676572004170657853514C2E41756469742E4265666F72654166746572436C72006D73636F726C69620053797374656D004F626A656374005441424C455F4E414D4500534348454D415F4E414D4500434F4C554D4E530053797374656D2E436F6C6C656374696F6E732E47656E65726963004C697374603100735F7072696D6172794B65797300735F636F6C756D6E4C697374002E6363746F720044656C65746500496E7365727400557064617465002E63746F720053797374656D2E5265666C656374696F6E00417373656D626C795469746C6541747472696275746500417373656D626C794465736372697074696F6E41747472696275746500417373656D626C7950726F6475637441747472696275746500417373656D626C79436F6D70616E7941747472696275746500417373656D626C79436F7079726967687441747472696275746500417373656D626C79436F6E66696775726174696F6E41747472696275746500417373656D626C7954726164656D61726B41747472696275746500417373656D626C7943756C7475726541747472696275746500434C53436F6D706C69616E7441747472696275746500537973\
74656D2E52756E74696D652E496E7465726F70536572766963657300436F6D56697369626C6541747472696275746500417373656D626C7956657273696F6E4174747269627574650053797374656D2E52756E74696D652E436F6D70696C6572536572766963657300436F6D70696C6174696F6E52656C61786174696F6E734174747269627574650052756E74696D65436F6D7061746962696C697479417474726962757465004170657853514C2E41756469742E4265666F726541667465722E64626F2E436F75727365496E7374727563746F722E44656C657465004164640053797374656D2E44617461004D6963726F736F66742E53716C5365727665722E5365727665720053716C54726967676572417474726962757465004170657853514C2E41756469742E4265666F7265416674657200547269676765724461746150726F636573736F72005472696767657250726F63657373696E6700000000001143006F00750072007300650049004400001150006500720073006F006E00490044000007640062006F00002143006F00750072007300650049006E007300740072007500630074006F007200002B5B0043006F007500720073006500490044005D002C005B0050006500720073006F006E00490044005D000000C9D2076D22C662499F7E3DD25AAD325C0008B77A5C561934E08902060E2043006F00750072007300650049006E007300740072007500630074006F00720006640062006F002A5B0043006F007500720073006500490044005D002C005B0050006500720073006F006E00490044005D000606151209010E0300000103200001042001010E0420010102042001010805151209010E0520010113000C0702151209010E151209010E1701000100540E054576656E740A464F522044454C455445083B936D7FBC8F6B28120007010E0E151249010E151249010E0E02021701000100540E054576656E740A464F5220494E534552541701000100540E054576656E740A464F52205550444154451F01001A4170657853514C204175646974204265666F72652D416674657200000501000000001201000D4170657853514C20417564697400001001000B4170657853514C204C4C43000028010023436F707972696768742028432920313939392D32303138204170657853514C204C4C4300000801000800000000001E01000100540216577261704E6F6E457863657074696F6E5468726F7773010000AC2900000000000000000000CE290000002000000000000000000000000000000000000000000000C02900000000000000000000000000000000000000005F436F72446C6C4D61696E006D73636F7265652E646C6C0000000000FF250020001000000000000000000000000000000000000000000000000000000000\
000000000000000000000000000001001000000018000080000000000000000000000000000001000100000030000080000000000000000000000000000001000000000048000000584000000C04000000000000000000000C0434000000560053005F00560045005200530049004F004E005F0049004E0046004F0000000000BD04EFFE000001000100E307000063060100E307000063063F000000000000000400000002000000000000000000000000000000440000000100560061007200460069006C00650049006E0066006F00000000002400040000005400720061006E0073006C006100740069006F006E00000000000000B0046C030000010053007400720069006E006700460069006C00650049006E0066006F00000048030000010030003000300030003000340062003000000038000C00010043006F006D00700061006E0079004E0061006D006500000000004100700065007800530051004C0020004C004C004300000060001B000100460069006C0065004400650073006300720069007000740069006F006E00000000004100700065007800530051004C0020004100750064006900740020004200650066006F00720065002D0041006600740065007200000000003C000E000100460069006C006500560065007200730069006F006E000000000032003000310039002E0031002E0031003600330035002E003000000094003A00010049006E007400650072006E0061006C004E0061006D00650000004100700065007800530051004C002E00410075006400690074002E004200650066006F0072006500410066007400650072002E00640062006F002E0043006F00750072007300650049006E007300740072007500630074006F0072002E00440065006C006500740065002E0064006C006C0000006C00240001004C006500670061006C0043006F007000790072006900670068007400000043006F0070007900720069006700680074002000280043002900200031003900390039002D00320030003100380020004100700065007800530051004C0020004C004C00430000009C003A0001004F0072006900670069006E0061006C00460069006C0065006E0061006D00650000004100700065007800530051004C002E00410075006400690074002E004200650066006F0072006500410066007400650072002E00640062006F002E0043006F00750072007300650049006E007300740072007500630074006F0072002E00440065006C006500740065002E0064006C006C0000003C000E000100500072006F0064007500630074004E0061006D006500000000004100700065007800530051004C00200041007500640069007400000040000E000100500072006F006400750063007400560065007200730069006F00\
6E00000032003000310039002E0031002E0031003600330035002E003000000044000E00010041007300730065006D0062006C0079002000560065007200730069006F006E00000032003000310039002E0031002E0031003600330035002E003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000C000000E03900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	WITH PERMISSION_SET = SAFE
GO
