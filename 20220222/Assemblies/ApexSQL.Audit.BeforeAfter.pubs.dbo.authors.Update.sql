CREATE ASSEMBLY [ApexSQL.Audit.BeforeAfter.pubs.dbo.authors.Update]
	AUTHORIZATION [dbo]
	FROM 0x4D5A90000300000004000000FFFF0000B800000000000000400000000000000000000000000000000000000000000000000000000000000000000000800000000E1FBA0E00B409CD21B8014CCD21546869732070726F6772616D2063616E6E6F742062652072756E20696E20444F53206D6F64652E0D0D0A2400000000000000504500004C0103000B58CA600000000000000000E00002210B010B00000C000000080000000000007E2B00000020000000400000000000100020000000020000040000000000000004000000000000000080000000020000000000000300408500001000001000000000100000100000000000001000000000000000000000002C2B00004F000000004000008004000000000000000000000000000000000000006000000C00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000080000000000000000000000082000004800000000000000000000002E74657874000000840B000000200000000C000000020000000000000000000000000000200000602E72737263000000800400000040000000060000000E0000000000000000000000000000400000402E72656C6F6300000C0000000060000000020000001400000000000000000000000000004000004200000000000000000000000000000000602B00000000000048000000020005006C210000C00900000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000133002009100000001000011730E00000A0A0672010000706F0F00000A068004000004730E00000A8005000004730E00000A0B0772010000706F0F00000A07720D0000706F0F00000A07721F0000706F0F00000A0772310000706F0F00000A07723D0000706F0F00000A07724D0000706F0F00000A0772570000706F0F00000A0772630000706F0F00000A07726B0000706F0F00000A0780060000042A9A727D00007072850000707E040000047E050000047E0600000472950000701716281100000A2A9A727D00007072850000707E040000047E050000047E0600000472950000701617281100000A2A9A727D00007072850000707E040000047E050000047E0600000472950000701717281100000A2A1E02281200000A2A000042534A4201000100000000000C00000076342E302E33303331390000000005006C00000084020000237E0000F00200007403000023537472696E6773000000006406000038010000235553009C070000100000002347554944000000AC0700001402000023426C6F620000000000000002000001571C02080900000000FA25330016000001000000120000000200000006000000\
0500000012000000030000000E0000000100000001000000010000000400000000000A000100000000000600800079000600C100A60006002B01190106004201190106005F0119010600780119010600910119010600AC0119010600CB0119010600E60119010600FF0179000600340215020600480219010600810261020600A10261020A001C0301030E004A0353001200C100A60000000000010000000000010001000100000040005300050001000100518087000A00518092000A0051809E000A003100C800C3003100D600C3003100EA00C3005020000000009118F700CA000100ED20000000009600FE00CA00010014210000000096000501CA0001003B210000000096000C01CA00010062210000000086181301CE00010019001301D20021001301D20029001301D20031001301D20039001301D20041001301D20049001301D20051001301D20059001301D70061001301D70069001301D20071001301DC0079001301CE000C001301CE000C00F102E70081001301CE0089005F031B0109001301CE000E0004000D000E0008001C000E000C0023002E0023009C012E002B00B5012E006300EB012E000B0063012E00130083012E001B0089012E006B00F4012E00330083012E003B0083012E004B0083012E005300830140008300FA00600083003301800083004B01ED00E10004800000E407040004080000000000000000BF02000004000000000000000000000001007000000000000400000000000000000000000100F50200000000E407040004080000000000001201300300000000020000000000000000000000010070000000000000000000003C4D6F64756C653E004170657853514C2E41756469742E4265666F726541667465722E707562732E64626F2E617574686F72732E5570646174652E646C6C004265666F7265416674657254726967676572004170657853514C2E41756469742E4265666F72654166746572436C72006D73636F726C69620053797374656D004F626A656374005441424C455F4E414D4500534348454D415F4E414D4500434F4C554D4E530053797374656D2E436F6C6C656374696F6E732E47656E65726963004C697374603100735F7072696D6172794B65797300735F6164646974696F6E616C436F6C756D6E7300735F636F6C756D6E4C697374002E6363746F720044656C65746500496E7365727400557064617465002E63746F720053797374656D2E5265666C656374696F6E00417373656D626C795469746C6541747472696275746500417373656D626C794465736372697074696F6E41747472696275746500417373656D626C7950726F6475637441747472696275746500417373656D626C79436F6D70616E7941747472696275746500417373656D626C79436F707972696768744174\
7472696275746500417373656D626C79436F6E66696775726174696F6E41747472696275746500417373656D626C7954726164656D61726B41747472696275746500417373656D626C7943756C7475726541747472696275746500434C53436F6D706C69616E744174747269627574650053797374656D2E52756E74696D652E496E7465726F70536572766963657300436F6D56697369626C6541747472696275746500417373656D626C7956657273696F6E4174747269627574650053797374656D2E52756E74696D652E436F6D70696C6572536572766963657300436F6D70696C6174696F6E52656C61786174696F6E734174747269627574650052756E74696D65436F6D7061746962696C697479417474726962757465004170657853514C2E41756469742E4265666F726541667465722E707562732E64626F2E617574686F72732E557064617465004164640053797374656D2E44617461004D6963726F736F66742E53716C5365727665722E5365727665720053716C54726967676572417474726962757465004170657853514C2E41756469742E4265666F7265416674657200547269676765724461746150726F636573736F72005472696767657250726F63657373696E6700000000000B610075005F00690064000011610075005F006C006E0061006D0065000011610075005F0066006E0061006D006500000B700068006F006E006500000F610064006400720065007300730000096300690074007900000B7300740061007400650000077A0069007000001163006F006E00740072006100630074000007640062006F00000F61007500740068006F007200730000809F5B00610075005F00690064005D002C005B00610075005F006C006E0061006D0065005D002C005B00610075005F0066006E0061006D0065005D002C005B00700068006F006E0065005D002C005B0061006400640072006500730073005D002C005B0063006900740079005D002C005B00730074006100740065005D002C005B007A00690070005D002C005B0063006F006E00740072006100630074005D000000007437533DCC36DA448B03C9F92C012BF00008B77A5C561934E08902060E0E61007500740068006F007200730006640062006F00809E5B00610075005F00690064005D002C005B00610075005F006C006E0061006D0065005D002C005B00610075005F0066006E0061006D0065005D002C005B00700068006F006E0065005D002C005B0061006400640072006500730073005D002C005B0063006900740079005D002C005B00730074006100740065005D002C005B007A00690070005D002C005B0063006F006E00740072006100630074005D000606151209010E0300000103200001042001010E0420010102042001010805151209010E05\
20010113000C0702151209010E151209010E1701000100540E054576656E740A464F522044454C455445083B936D7FBC8F6B28170008010E0E151249010E151249010E151249010E0E02021701000100540E054576656E740A464F5220494E534552541701000100540E054576656E740A464F52205550444154451F01001A4170657853514C204175646974204265666F72652D416674657200000501000000001201000D4170657853514C204175646974000018010013517565737420536F66747761726520496E632E000035010030C2A9203230313920517565737420536F66747761726520496E632E20414C4C205249474854532052455345525645442E00000801000800000000001E01000100540216577261704E6F6E457863657074696F6E5468726F77730100542B000000000000000000006E2B0000002000000000000000000000000000000000000000000000602B0000000000000000000000005F436F72446C6C4D61696E006D73636F7265652E646C6C0000000000FF25002000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100100000001800008000000000000000000000000000000100010000003000008000000000000000000000000000000100000000004800000058400000240400000000000000000000240434000000560053005F00560045005200530049004F004E005F0049004E0046004F0000000000BD04EFFE000001000400E407000004080400E407000004083F000000000000000400000002000000000000000000000000000000440000000100560061007200460069006C00650049006E0066006F00000000002400040000005400720061006E0073006C006100740069006F006E00000000000000B00484030000010053007400720069006E006700460069006C00650049006E0066006F00000060030000010030003000300030003000340062003000000048001400010043006F006D00700061006E0079004E0061006D0065000000000051007500650073007400200053006F00660074007700610072006500200049006E0063002E00000060001B000100460069006C0065004400650073006300720069007000740069006F006E00000000004100700065007800530051004C0020004100750064006900740020004200650066006F00720065002D0041006600740065007200000000003C000E000100460069006C006500560065007200730069006F006E000000000032003000\
320030002E0034002E0032003000350032002E00300000008C003600010049006E007400650072006E0061006C004E0061006D00650000004100700065007800530051004C002E00410075006400690074002E004200650066006F0072006500410066007400650072002E0070007500620073002E00640062006F002E0061007500740068006F00720073002E005500700064006100740065002E0064006C006C0000008400300001004C006500670061006C0043006F0070007900720069006700680074000000A90020003200300031003900200051007500650073007400200053006F00660074007700610072006500200049006E0063002E00200041004C004C0020005200490047004800540053002000520045005300450052005600450044002E0000009400360001004F0072006900670069006E0061006C00460069006C0065006E0061006D00650000004100700065007800530051004C002E00410075006400690074002E004200650066006F0072006500410066007400650072002E0070007500620073002E00640062006F002E0061007500740068006F00720073002E005500700064006100740065002E0064006C006C0000003C000E000100500072006F0064007500630074004E0061006D006500000000004100700065007800530051004C00200041007500640069007400000040000E000100500072006F006400750063007400560065007200730069006F006E00000032003000320030002E0034002E0032003000350032002E003000000044000E00010041007300730065006D0062006C0079002000560065007200730069006F006E00000032003000320030002E0034002E0032003000350032002E003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\
002000000C000000803B00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	WITH PERMISSION_SET = SAFE
GO
