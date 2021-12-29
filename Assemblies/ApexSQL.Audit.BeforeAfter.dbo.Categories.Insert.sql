CREATE ASSEMBLY [ApexSQL.Audit.BeforeAfter.dbo.Categories.Insert]
	AUTHORIZATION [dbo]
	FROM 0x4D5A90000300000004000000FFFF0000B800000000000000400000000000000000000000000000000000000000000000000000000000000000000000800000000E1FBA0E00B409CD21B8014CCD21546869732070726F6772616D2063616E6E6F742062652072756E20696E20444F53206D6F64652E0D0D0A2400000000000000504500004C010300D32ABB5D0000000000000000E00002210B010B00000A00000008000000000000CE2900000020000000400000000000100020000000020000040000000000000004000000000000000080000000020000000000000300408500001000001000000000100000100000000000001000000000000000000000007829000053000000004000005004000000000000000000000000000000000000006000000C00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000080000000000000000000000082000004800000000000000000000002E74657874000000D409000000200000000A000000020000000000000000000000000000200000602E72737263000000500400000040000000060000000C0000000000000000000000000000400000402E72656C6F6300000C0000000060000000020000001200000000000000000000000000004000004200000000000000000000000000000000B029000000000000480000000200050004210000740800000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000133002003A00000001000011730E00000A0A0672010000706F0F00000A068004000004730E00000A0B0772010000706F0F00000A0772170000706F0F00000A0780050000042A86723100007072390000707E040000047E05000004724F0000701716281100000A2A86723100007072390000707E040000047E05000004724F0000701617281100000A2A86723100007072390000707E040000047E05000004724F0000701717281100000A2A1E02281200000A2A42534A4201000100000000000C00000076342E302E33303331390000000005006C0000007C020000237E0000E80200005C03000023537472696E677300000000440600008800000023555300CC060000100000002347554944000000DC0600009801000023426C6F620000000000000002000001571C02080900000000FA253300160000010000001200000002000000050000000500000012000000030000000E0000000100000001000000010000000400000000000A0001000000000006007E0077000600BF00A40006001501030106002C01030106004901030106006201030106007B0103010600960103010600B50103010600D00103010600\
E901770006001E02FF0106003202030106006B024B0206008B024B020A000403E9020E00320351001200BF00A4000000000001000000000001000100010000003E005100050001000100518085000A00518090000A0051809C000A003100C60060003100D40060005020000000009118E100670001009620000000009600E80067000100B820000000009600EF0067000100DA20000000009600F60067000100FC20000000008618FD006B0001001900FD006F002100FD006F002900FD006F003100FD006F003900FD006F004100FD006F004900FD006F005100FD006F005900FD0074006100FD0074006900FD006F007100FD0079007900FD006B000C00FD006B000C00D90284008100FD006B0089004703B8000900FD006B000E0004000D000E00080022000E000C0029002E00230034012E002B0045012E0063006E012E000B00FB002E0013001B012E001B0021012E006B0077012E0033001B012E003B001B012E004B001B012E0053001B0140008300970060008300CB0080008300E3008A007E0004800000E307010063060000000000000000A902000004000000000000000000000001006E00000000000400000000000000000000000100DD0200000000E30701006306000000000000AF0018030000000002000000000000000000000001006E00000000000000003C4D6F64756C653E004170657853514C2E41756469742E4265666F726541667465722E64626F2E43617465676F726965732E496E736572742E646C6C004265666F7265416674657254726967676572004170657853514C2E41756469742E4265666F72654166746572436C72006D73636F726C69620053797374656D004F626A656374005441424C455F4E414D4500534348454D415F4E414D4500434F4C554D4E530053797374656D2E436F6C6C656374696F6E732E47656E65726963004C697374603100735F7072696D6172794B65797300735F636F6C756D6E4C697374002E6363746F720044656C65746500496E7365727400557064617465002E63746F720053797374656D2E5265666C656374696F6E00417373656D626C795469746C6541747472696275746500417373656D626C794465736372697074696F6E41747472696275746500417373656D626C7950726F6475637441747472696275746500417373656D626C79436F6D70616E7941747472696275746500417373656D626C79436F7079726967687441747472696275746500417373656D626C79436F6E66696775726174696F6E41747472696275746500417373656D626C7954726164656D61726B41747472696275746500417373656D626C7943756C7475726541747472696275746500434C53436F6D706C69616E744174747269627574650053797374656D2E52756E74696D652E496E7465726F\
70536572766963657300436F6D56697369626C6541747472696275746500417373656D626C7956657273696F6E4174747269627574650053797374656D2E52756E74696D652E436F6D70696C6572536572766963657300436F6D70696C6174696F6E52656C61786174696F6E734174747269627574650052756E74696D65436F6D7061746962696C697479417474726962757465004170657853514C2E41756469742E4265666F726541667465722E64626F2E43617465676F726965732E496E73657274004164640053797374656D2E44617461004D6963726F736F66742E53716C5365727665722E5365727665720053716C54726967676572417474726962757465004170657853514C2E41756469742E4265666F7265416674657200547269676765724461746150726F636573736F72005472696767657250726F63657373696E67000000000015430061007400650067006F0072007900490044000019430061007400650067006F00720079004E0061006D0065000007640062006F000015430061007400650067006F00720069006500730000375B00430061007400650067006F0072007900490044005D002C005B00430061007400650067006F00720079004E0061006D0065005D000000DE7EE8583779C546834FA0B33ED8903D0008B77A5C561934E08902060E14430061007400650067006F00720069006500730006640062006F00365B00430061007400650067006F0072007900490044005D002C005B00430061007400650067006F00720079004E0061006D0065005D000606151209010E0300000103200001042001010E0420010102042001010805151209010E0520010113000C0702151209010E151209010E1701000100540E054576656E740A464F522044454C455445083B936D7FBC8F6B28120007010E0E151249010E151249010E0E02021701000100540E054576656E740A464F5220494E534552541701000100540E054576656E740A464F52205550444154451F01001A4170657853514C204175646974204265666F72652D416674657200000501000000001201000D4170657853514C20417564697400001001000B4170657853514C204C4C43000028010023436F707972696768742028432920313939392D32303138204170657853514C204C4C4300000801000800000000001E01000100540216577261704E6F6E457863657074696F6E5468726F7773010000A02900000000000000000000BE290000002000000000000000000000000000000000000000000000B029000000000000000000000000000000005F436F72446C6C4D61696E006D73636F7265652E646C6C0000000000FF25002000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000\
00000000000000000000000000000100100000001800008000000000000000000000000000000100010000003000008000000000000000000000000000000100000000004800000058400000F40300000000000000000000F40334000000560053005F00560045005200530049004F004E005F0049004E0046004F0000000000BD04EFFE000001000100E307000063060100E307000063063F000000000000000400000002000000000000000000000000000000440000000100560061007200460069006C00650049006E0066006F00000000002400040000005400720061006E0073006C006100740069006F006E00000000000000B00454030000010053007400720069006E006700460069006C00650049006E0066006F00000030030000010030003000300030003000340062003000000038000C00010043006F006D00700061006E0079004E0061006D006500000000004100700065007800530051004C0020004C004C004300000060001B000100460069006C0065004400650073006300720069007000740069006F006E00000000004100700065007800530051004C0020004100750064006900740020004200650066006F00720065002D0041006600740065007200000000003C000E000100460069006C006500560065007200730069006F006E000000000032003000310039002E0031002E0031003600330035002E003000000088003400010049006E007400650072006E0061006C004E0061006D00650000004100700065007800530051004C002E00410075006400690074002E004200650066006F0072006500410066007400650072002E00640062006F002E00430061007400650067006F0072006900650073002E0049006E0073006500720074002E0064006C006C0000006C00240001004C006500670061006C0043006F007000790072006900670068007400000043006F0070007900720069006700680074002000280043002900200031003900390039002D00320030003100380020004100700065007800530051004C0020004C004C00430000009000340001004F0072006900670069006E0061006C00460069006C0065006E0061006D00650000004100700065007800530051004C002E00410075006400690074002E004200650066006F0072006500410066007400650072002E00640062006F002E00430061007400650067006F0072006900650073002E0049006E0073006500720074002E0064006C006C0000003C000E000100500072006F0064007500630074004E0061006D006500000000004100700065007800530051004C00200041007500640069007400000040000E000100500072006F006400750063007400560065007200730069006F006E00000032003000310039002E0031002E00310036003300\
35002E003000000044000E00010041007300730065006D0062006C0079002000560065007200730069006F006E00000032003000310039002E0031002E0031003600330035002E003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000C000000D03900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	WITH PERMISSION_SET = SAFE
GO