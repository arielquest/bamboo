SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TB_FCT_CMS_AGENT_LOGOUT] (
		[PARTITION_URN]             [int] NOT NULL,
		[PARTITION_GLOBAL_URN]      [bigint] NOT NULL,
		[PARTITION_ID]              [int] NOT NULL,
		[CLUSTER_RESOURCE_URN]      [int] NOT NULL,
		[AGENT_URN]                 [int] NOT NULL,
		[SKILLGROUP_URN]            [int] NOT NULL,
		[ACD_URN]                   [int] NOT NULL,
		[LOGOUT_REASONCODE_URN]     [int] NOT NULL,
		[LOGOUT_DATE_UTC_URN]       [int] NULL,
		[LOGOUT_TIME_UTC_URN]       [smallint] NULL,
		[LOGIN_DATE_UTC_URN]        [int] NOT NULL,
		[LOGIN_TIME_UTC_URN]        [smallint] NOT NULL,
		[EXTN_URN]                  [int] NOT NULL,
		[SEQ_NUM]                   [int] NULL,
		[EXTN]                      [char](15) COLLATE Latin1_General_CI_AS NULL,
		[PREFERENCE]                [int] NULL,
		[SK_LEVEL]                  [int] NULL,
		[SK_PERCENT]                [int] NULL,
		[SK_INTR_TYPE]              [int] NULL,
		[LOGON_SKILL2]              [int] NULL,
		[SK_LEVEL2]                 [int] NULL,
		[SK_PERCENT2]               [int] NULL,
		[SK_INTR_TYPE2]             [int] NULL,
		[LOGON_SKILL3]              [int] NULL,
		[SK_LEVEL3]                 [int] NULL,
		[SK_PERCENT3]               [int] NULL,
		[SK_INTR_TYPE3]             [int] NULL,
		[LOGON_SKILL4]              [int] NULL,
		[SK_LEVEL4]                 [int] NULL,
		[SK_PERCENT4]               [int] NULL,
		[SK_INTR_TYPE4]             [int] NULL,
		[LOGON_SKILL5]              [int] NULL,
		[SK_LEVEL5]                 [int] NULL,
		[SK_PERCENT5]               [int] NULL,
		[SK_INTR_TYPE5]             [int] NULL,
		[LOGON_SKILL6]              [int] NULL,
		[SK_LEVEL6]                 [int] NULL,
		[SK_PERCENT6]               [int] NULL,
		[SK_INTR_TYPE6]             [int] NULL,
		[LOGON_SKILL7]              [int] NULL,
		[SK_LEVEL7]                 [int] NULL,
		[SK_PERCENT7]               [int] NULL,
		[SK_INTR_TYPE7]             [int] NULL,
		[LOGON_SKILL8]              [int] NULL,
		[SK_LEVEL8]                 [int] NULL,
		[SK_PERCENT8]               [int] NULL,
		[SK_INTR_TYPE8]             [int] NULL,
		[LOGON_SKILL9]              [int] NULL,
		[SK_LEVEL9]                 [int] NULL,
		[SK_PERCENT9]               [int] NULL,
		[SK_INTR_TYPE9]             [int] NULL,
		[LOGON_SKILL10]             [int] NULL,
		[SK_LEVEL10]                [int] NULL,
		[SK_PERCENT10]              [int] NULL,
		[SK_INTR_TYPE10]            [int] NULL,
		[LOGON_SKILL11]             [int] NULL,
		[SK_LEVEL11]                [int] NULL,
		[SK_PERCENT11]              [int] NULL,
		[SK_INTR_TYPE11]            [int] NULL,
		[LOGON_SKILL12]             [int] NULL,
		[SK_LEVEL12]                [int] NULL,
		[SK_PERCENT12]              [int] NULL,
		[SK_INTR_TYPE12]            [int] NULL,
		[LOGON_SKILL13]             [int] NULL,
		[SK_LEVEL13]                [int] NULL,
		[SK_PERCENT13]              [int] NULL,
		[SK_INTR_TYPE13]            [int] NULL,
		[LOGON_SKILL14]             [int] NULL,
		[SK_LEVEL14]                [int] NULL,
		[SK_PERCENT14]              [int] NULL,
		[SK_INTR_TYPE14]            [int] NULL,
		[LOGON_SKILL15]             [int] NULL,
		[SK_LEVEL15]                [int] NULL,
		[SK_PERCENT15]              [int] NULL,
		[SK_INTR_TYPE15]            [int] NULL,
		[LOGON_SKILL16]             [int] NULL,
		[SK_LEVEL16]                [int] NULL,
		[SK_PERCENT16]              [int] NULL,
		[SK_INTR_TYPE16]            [int] NULL,
		[LOGON_SKILL17]             [int] NULL,
		[SK_LEVEL17]                [int] NULL,
		[SK_PERCENT17]              [int] NULL,
		[SK_INTR_TYPE17]            [int] NULL,
		[LOGON_SKILL18]             [int] NULL,
		[SK_LEVEL18]                [int] NULL,
		[SK_PERCENT18]              [int] NULL,
		[SK_INTR_TYPE18]            [int] NULL,
		[LOGON_SKILL19]             [int] NULL,
		[SK_LEVEL19]                [int] NULL,
		[SK_PERCENT19]              [int] NULL,
		[SK_INTR_TYPE19]            [int] NULL,
		[LOGON_SKILL20]             [int] NULL,
		[SK_LEVEL20]                [int] NULL,
		[SK_PERCENT20]              [int] NULL,
		[SK_INTR_TYPE20]            [int] NULL,
		[LOGON_SKILL21]             [int] NULL,
		[SK_LEVEL21]                [int] NULL,
		[SK_PERCENT21]              [int] NULL,
		[SK_INTR_TYPE21]            [int] NULL,
		[LOGON_SKILL22]             [int] NULL,
		[SK_LEVEL22]                [int] NULL,
		[SK_PERCENT22]              [int] NULL,
		[SK_INTR_TYPE22]            [int] NULL,
		[LOGON_SKILL23]             [int] NULL,
		[SK_LEVEL23]                [int] NULL,
		[SK_PERCENT23]              [int] NULL,
		[SK_INTR_TYPE23]            [int] NULL,
		[LOGON_SKILL24]             [int] NULL,
		[SK_LEVEL24]                [int] NULL,
		[SK_PERCENT24]              [int] NULL,
		[SK_INTR_TYPE24]            [int] NULL,
		[LOGON_SKILL25]             [int] NULL,
		[SK_LEVEL25]                [int] NULL,
		[SK_PERCENT25]              [int] NULL,
		[SK_INTR_TYPE25]            [int] NULL,
		[LOGON_SKILL26]             [int] NULL,
		[SK_LEVEL26]                [int] NULL,
		[SK_PERCENT26]              [int] NULL,
		[SK_INTR_TYPE26]            [int] NULL,
		[LOGON_SKILL27]             [int] NULL,
		[SK_LEVEL27]                [int] NULL,
		[SK_PERCENT27]              [int] NULL,
		[SK_INTR_TYPE27]            [int] NULL,
		[LOGON_SKILL28]             [int] NULL,
		[SK_LEVEL28]                [int] NULL,
		[SK_PERCENT28]              [int] NULL,
		[SK_INTR_TYPE28]            [int] NULL,
		[LOGON_SKILL29]             [int] NULL,
		[SK_LEVEL29]                [int] NULL,
		[SK_PERCENT29]              [int] NULL,
		[SK_INTR_TYPE29]            [int] NULL,
		[LOGON_SKILL30]             [int] NULL,
		[SK_LEVEL30]                [int] NULL,
		[SK_PERCENT30]              [int] NULL,
		[SK_INTR_TYPE30]            [int] NULL,
		[LOGON_SKILL31]             [int] NULL,
		[SK_LEVEL31]                [int] NULL,
		[SK_PERCENT31]              [int] NULL,
		[SK_INTR_TYPE31]            [int] NULL,
		[LOGON_SKILL32]             [int] NULL,
		[SK_LEVEL32]                [int] NULL,
		[SK_PERCENT32]              [int] NULL,
		[SK_INTR_TYPE32]            [int] NULL,
		[LOGON_SKILL33]             [int] NULL,
		[SK_LEVEL33]                [int] NULL,
		[SK_PERCENT33]              [int] NULL,
		[SK_INTR_TYPE33]            [int] NULL,
		[LOGON_SKILL34]             [int] NULL,
		[SK_LEVEL34]                [int] NULL,
		[SK_PERCENT34]              [int] NULL,
		[SK_INTR_TYPE34]            [int] NULL,
		[LOGON_SKILL35]             [int] NULL,
		[SK_LEVEL35]                [int] NULL,
		[SK_PERCENT35]              [int] NULL,
		[SK_INTR_TYPE35]            [int] NULL,
		[LOGON_SKILL36]             [int] NULL,
		[SK_LEVEL36]                [int] NULL,
		[SK_PERCENT36]              [int] NULL,
		[SK_INTR_TYPE36]            [int] NULL,
		[LOGON_SKILL37]             [int] NULL,
		[SK_LEVEL37]                [int] NULL,
		[SK_PERCENT37]              [int] NULL,
		[SK_INTR_TYPE37]            [int] NULL,
		[LOGON_SKILL38]             [int] NULL,
		[SK_LEVEL38]                [int] NULL,
		[SK_PERCENT38]              [int] NULL,
		[SK_INTR_TYPE38]            [int] NULL,
		[LOGON_SKILL39]             [int] NULL,
		[SK_LEVEL39]                [int] NULL,
		[SK_PERCENT39]              [int] NULL,
		[SK_INTR_TYPE39]            [int] NULL,
		[LOGON_SKILL40]             [int] NULL,
		[SK_LEVEL40]                [int] NULL,
		[SK_PERCENT40]              [int] NULL,
		[SK_INTR_TYPE40]            [int] NULL,
		[LOGON_SKILL41]             [int] NULL,
		[SK_LEVEL41]                [int] NULL,
		[SK_PERCENT41]              [int] NULL,
		[SK_INTR_TYPE41]            [int] NULL,
		[LOGON_SKILL42]             [int] NULL,
		[SK_LEVEL42]                [int] NULL,
		[SK_PERCENT42]              [int] NULL,
		[SK_INTR_TYPE42]            [int] NULL,
		[LOGON_SKILL43]             [int] NULL,
		[SK_LEVEL43]                [int] NULL,
		[SK_PERCENT43]              [int] NULL,
		[SK_INTR_TYPE43]            [int] NULL,
		[LOGON_SKILL44]             [int] NULL,
		[SK_LEVEL44]                [int] NULL,
		[SK_PERCENT44]              [int] NULL,
		[SK_INTR_TYPE44]            [int] NULL,
		[LOGON_SKILL45]             [int] NULL,
		[SK_LEVEL45]                [int] NULL,
		[SK_PERCENT45]              [int] NULL,
		[SK_INTR_TYPE45]            [int] NULL,
		[LOGON_SKILL46]             [int] NULL,
		[SK_LEVEL46]                [int] NULL,
		[SK_PERCENT46]              [int] NULL,
		[SK_INTR_TYPE46]            [int] NULL,
		[LOGON_SKILL47]             [int] NULL,
		[SK_LEVEL47]                [int] NULL,
		[SK_PERCENT47]              [int] NULL,
		[SK_INTR_TYPE47]            [int] NULL,
		[LOGON_SKILL48]             [int] NULL,
		[SK_LEVEL48]                [int] NULL,
		[SK_PERCENT48]              [int] NULL,
		[SK_INTR_TYPE48]            [int] NULL,
		[LOGON_SKILL49]             [int] NULL,
		[SK_LEVEL49]                [int] NULL,
		[SK_PERCENT49]              [int] NULL,
		[SK_INTR_TYPE49]            [int] NULL,
		[LOGON_SKILL50]             [int] NULL,
		[SK_LEVEL50]                [int] NULL,
		[SK_PERCENT50]              [int] NULL,
		[SK_INTR_TYPE50]            [int] NULL,
		[LOGON_SKILL51]             [int] NULL,
		[SK_LEVEL51]                [int] NULL,
		[SK_PERCENT51]              [int] NULL,
		[SK_INTR_TYPE51]            [int] NULL,
		[LOGON_SKILL52]             [int] NULL,
		[SK_LEVEL52]                [int] NULL,
		[SK_PERCENT52]              [int] NULL,
		[SK_INTR_TYPE52]            [int] NULL,
		[LOGON_SKILL53]             [int] NULL,
		[SK_LEVEL53]                [int] NULL,
		[SK_PERCENT53]              [int] NULL,
		[SK_INTR_TYPE53]            [int] NULL,
		[LOGON_SKILL54]             [int] NULL,
		[SK_LEVEL54]                [int] NULL,
		[SK_PERCENT54]              [int] NULL,
		[SK_INTR_TYPE54]            [int] NULL,
		[LOGON_SKILL55]             [int] NULL,
		[SK_LEVEL55]                [int] NULL,
		[SK_PERCENT55]              [int] NULL,
		[SK_INTR_TYPE55]            [int] NULL,
		[LOGON_SKILL56]             [int] NULL,
		[SK_LEVEL56]                [int] NULL,
		[SK_PERCENT56]              [int] NULL,
		[SK_INTR_TYPE56]            [int] NULL,
		[LOGON_SKILL57]             [int] NULL,
		[SK_LEVEL57]                [int] NULL,
		[SK_PERCENT57]              [int] NULL,
		[SK_INTR_TYPE57]            [int] NULL,
		[LOGON_SKILL58]             [int] NULL,
		[SK_LEVEL58]                [int] NULL,
		[SK_PERCENT58]              [int] NULL,
		[SK_INTR_TYPE58]            [int] NULL,
		[LOGON_SKILL59]             [int] NULL,
		[SK_LEVEL59]                [int] NULL,
		[SK_PERCENT59]              [int] NULL,
		[SK_INTR_TYPE59]            [int] NULL,
		[LOGON_SKILL60]             [int] NULL,
		[SK_LEVEL60]                [int] NULL,
		[SK_PERCENT60]              [int] NULL,
		[SK_INTR_TYPE60]            [int] NULL,
		[LOGON_SKILL61]             [int] NULL,
		[SK_LEVEL61]                [int] NULL,
		[SK_PERCENT61]              [int] NULL,
		[SK_INTR_TYPE61]            [int] NULL,
		[LOGON_SKILL62]             [int] NULL,
		[SK_LEVEL62]                [int] NULL,
		[SK_PERCENT62]              [int] NULL,
		[SK_INTR_TYPE62]            [int] NULL,
		[LOGON_SKILL63]             [int] NULL,
		[SK_LEVEL63]                [int] NULL,
		[SK_PERCENT63]              [int] NULL,
		[SK_INTR_TYPE63]            [int] NULL,
		[LOGON_SKILL64]             [int] NULL,
		[SK_LEVEL64]                [int] NULL,
		[SK_PERCENT64]              [int] NULL,
		[SK_INTR_TYPE64]            [int] NULL,
		[LOGON_SKILL65]             [int] NULL,
		[SK_LEVEL65]                [int] NULL,
		[SK_PERCENT65]              [int] NULL,
		[SK_INTR_TYPE65]            [int] NULL,
		[LOGON_SKILL66]             [int] NULL,
		[SK_LEVEL66]                [int] NULL,
		[SK_PERCENT66]              [int] NULL,
		[SK_INTR_TYPE66]            [int] NULL,
		[LOGON_SKILL67]             [int] NULL,
		[SK_LEVEL67]                [int] NULL,
		[SK_PERCENT67]              [int] NULL,
		[SK_INTR_TYPE67]            [int] NULL,
		[LOGON_SKILL68]             [int] NULL,
		[SK_LEVEL68]                [int] NULL,
		[SK_PERCENT68]              [int] NULL,
		[SK_INTR_TYPE68]            [int] NULL,
		[LOGON_SKILL69]             [int] NULL,
		[SK_LEVEL69]                [int] NULL,
		[SK_PERCENT69]              [int] NULL,
		[SK_INTR_TYPE69]            [int] NULL,
		[LOGON_SKILL70]             [int] NULL,
		[SK_LEVEL70]                [int] NULL,
		[SK_PERCENT70]              [int] NULL,
		[SK_INTR_TYPE70]            [int] NULL,
		[LOGON_SKILL71]             [int] NULL,
		[SK_LEVEL71]                [int] NULL,
		[SK_PERCENT71]              [int] NULL,
		[SK_INTR_TYPE71]            [int] NULL,
		[LOGON_SKILL72]             [int] NULL,
		[SK_LEVEL72]                [int] NULL,
		[SK_PERCENT72]              [int] NULL,
		[SK_INTR_TYPE72]            [int] NULL,
		[LOGON_SKILL73]             [int] NULL,
		[SK_LEVEL73]                [int] NULL,
		[SK_PERCENT73]              [int] NULL,
		[SK_INTR_TYPE73]            [int] NULL,
		[LOGON_SKILL74]             [int] NULL,
		[SK_LEVEL74]                [int] NULL,
		[SK_PERCENT74]              [int] NULL,
		[SK_INTR_TYPE74]            [int] NULL,
		[LOGON_SKILL75]             [int] NULL,
		[SK_LEVEL75]                [int] NULL,
		[SK_PERCENT75]              [int] NULL,
		[SK_INTR_TYPE75]            [int] NULL,
		[LOGON_SKILL76]             [int] NULL,
		[SK_LEVEL76]                [int] NULL,
		[SK_PERCENT76]              [int] NULL,
		[SK_INTR_TYPE76]            [int] NULL,
		[LOGON_SKILL77]             [int] NULL,
		[SK_LEVEL77]                [int] NULL,
		[SK_PERCENT77]              [int] NULL,
		[SK_INTR_TYPE77]            [int] NULL,
		[LOGON_SKILL78]             [int] NULL,
		[SK_LEVEL78]                [int] NULL,
		[SK_PERCENT78]              [int] NULL,
		[SK_INTR_TYPE78]            [int] NULL,
		[LOGON_SKILL79]             [int] NULL,
		[SK_LEVEL79]                [int] NULL,
		[SK_PERCENT79]              [int] NULL,
		[SK_INTR_TYPE79]            [int] NULL,
		[LOGON_SKILL80]             [int] NULL,
		[SK_LEVEL80]                [int] NULL,
		[SK_PERCENT80]              [int] NULL,
		[SK_INTR_TYPE80]            [int] NULL,
		[LOGON_SKILL81]             [int] NULL,
		[SK_LEVEL81]                [int] NULL,
		[SK_PERCENT81]              [int] NULL,
		[SK_INTR_TYPE81]            [int] NULL,
		[LOGON_SKILL82]             [int] NULL,
		[SK_LEVEL82]                [int] NULL,
		[SK_PERCENT82]              [int] NULL,
		[SK_INTR_TYPE82]            [int] NULL,
		[LOGON_SKILL83]             [int] NULL,
		[SK_LEVEL83]                [int] NULL,
		[SK_PERCENT83]              [int] NULL,
		[SK_INTR_TYPE83]            [int] NULL,
		[LOGON_SKILL84]             [int] NULL,
		[SK_LEVEL84]                [int] NULL,
		[SK_PERCENT84]              [int] NULL,
		[SK_INTR_TYPE84]            [int] NULL,
		[LOGON_SKILL85]             [int] NULL,
		[SK_LEVEL85]                [int] NULL,
		[SK_PERCENT85]              [int] NULL,
		[SK_INTR_TYPE85]            [int] NULL,
		[LOGON_SKILL86]             [int] NULL,
		[SK_LEVEL86]                [int] NULL,
		[SK_PERCENT86]              [int] NULL,
		[SK_INTR_TYPE86]            [int] NULL,
		[LOGON_SKILL87]             [int] NULL,
		[SK_LEVEL87]                [int] NULL,
		[SK_PERCENT87]              [int] NULL,
		[SK_INTR_TYPE87]            [int] NULL,
		[LOGON_SKILL88]             [int] NULL,
		[SK_LEVEL88]                [int] NULL,
		[SK_PERCENT88]              [int] NULL,
		[SK_INTR_TYPE88]            [int] NULL,
		[LOGON_SKILL89]             [int] NULL,
		[SK_LEVEL89]                [int] NULL,
		[SK_PERCENT89]              [int] NULL,
		[SK_INTR_TYPE89]            [int] NULL,
		[LOGON_SKILL90]             [int] NULL,
		[SK_LEVEL90]                [int] NULL,
		[SK_PERCENT90]              [int] NULL,
		[SK_INTR_TYPE90]            [int] NULL,
		[LOGON_SKILL91]             [int] NULL,
		[SK_LEVEL91]                [int] NULL,
		[SK_PERCENT91]              [int] NULL,
		[SK_INTR_TYPE91]            [int] NULL,
		[LOGON_SKILL92]             [int] NULL,
		[SK_LEVEL92]                [int] NULL,
		[SK_PERCENT92]              [int] NULL,
		[SK_INTR_TYPE92]            [int] NULL,
		[LOGON_SKILL93]             [int] NULL,
		[SK_LEVEL93]                [int] NULL,
		[SK_PERCENT93]              [int] NULL,
		[SK_INTR_TYPE93]            [int] NULL,
		[LOGON_SKILL94]             [int] NULL,
		[SK_LEVEL94]                [int] NULL,
		[SK_PERCENT94]              [int] NULL,
		[SK_INTR_TYPE94]            [int] NULL,
		[LOGON_SKILL95]             [int] NULL,
		[SK_LEVEL95]                [int] NULL,
		[SK_PERCENT95]              [int] NULL,
		[SK_INTR_TYPE95]            [int] NULL,
		[LOGON_SKILL96]             [int] NULL,
		[SK_LEVEL96]                [int] NULL,
		[SK_PERCENT96]              [int] NULL,
		[SK_INTR_TYPE96]            [int] NULL,
		[LOGON_SKILL97]             [int] NULL,
		[SK_LEVEL97]                [int] NULL,
		[SK_PERCENT97]              [int] NULL,
		[SK_INTR_TYPE97]            [int] NULL,
		[LOGON_SKILL98]             [int] NULL,
		[SK_LEVEL98]                [int] NULL,
		[SK_PERCENT98]              [int] NULL,
		[SK_INTR_TYPE98]            [int] NULL,
		[LOGON_SKILL99]             [int] NULL,
		[SK_LEVEL99]                [int] NULL,
		[SK_PERCENT99]              [int] NULL,
		[SK_INTR_TYPE99]            [int] NULL,
		[LOGON_SKILL100]            [int] NULL,
		[SK_LEVEL100]               [int] NULL,
		[SK_PERCENT100]             [int] NULL,
		[SK_INTR_TYPE100]           [int] NULL,
		[LOGON_SKILL101]            [int] NULL,
		[SK_LEVEL101]               [int] NULL,
		[SK_PERCENT101]             [int] NULL,
		[SK_INTR_TYPE101]           [int] NULL,
		[LOGON_SKILL102]            [int] NULL,
		[SK_LEVEL102]               [int] NULL,
		[SK_PERCENT102]             [int] NULL,
		[SK_INTR_TYPE102]           [int] NULL,
		[LOGON_SKILL103]            [int] NULL,
		[SK_LEVEL103]               [int] NULL,
		[SK_PERCENT103]             [int] NULL,
		[SK_INTR_TYPE103]           [int] NULL,
		[LOGON_SKILL104]            [int] NULL,
		[SK_LEVEL104]               [int] NULL,
		[SK_PERCENT104]             [int] NULL,
		[SK_INTR_TYPE104]           [int] NULL,
		[LOGON_SKILL105]            [int] NULL,
		[SK_LEVEL105]               [int] NULL,
		[SK_PERCENT105]             [int] NULL,
		[SK_INTR_TYPE105]           [int] NULL,
		[LOGON_SKILL106]            [int] NULL,
		[SK_LEVEL106]               [int] NULL,
		[SK_PERCENT106]             [int] NULL,
		[SK_INTR_TYPE106]           [int] NULL,
		[LOGON_SKILL107]            [int] NULL,
		[SK_LEVEL107]               [int] NULL,
		[SK_PERCENT107]             [int] NULL,
		[SK_INTR_TYPE107]           [int] NULL,
		[LOGON_SKILL108]            [int] NULL,
		[SK_LEVEL108]               [int] NULL,
		[SK_PERCENT108]             [int] NULL,
		[SK_INTR_TYPE108]           [int] NULL,
		[LOGON_SKILL109]            [int] NULL,
		[SK_LEVEL109]               [int] NULL,
		[SK_PERCENT109]             [int] NULL,
		[SK_INTR_TYPE109]           [int] NULL,
		[LOGON_SKILL110]            [int] NULL,
		[SK_LEVEL110]               [int] NULL,
		[SK_PERCENT110]             [int] NULL,
		[SK_INTR_TYPE110]           [int] NULL,
		[LOGON_SKILL111]            [int] NULL,
		[SK_LEVEL111]               [int] NULL,
		[SK_PERCENT111]             [int] NULL,
		[SK_INTR_TYPE111]           [int] NULL,
		[LOGON_SKILL112]            [int] NULL,
		[SK_LEVEL112]               [int] NULL,
		[SK_PERCENT112]             [int] NULL,
		[SK_INTR_TYPE112]           [int] NULL,
		[LOGON_SKILL113]            [int] NULL,
		[SK_LEVEL113]               [int] NULL,
		[SK_PERCENT113]             [int] NULL,
		[SK_INTR_TYPE113]           [int] NULL,
		[LOGON_SKILL114]            [int] NULL,
		[SK_LEVEL114]               [int] NULL,
		[SK_PERCENT114]             [int] NULL,
		[SK_INTR_TYPE114]           [int] NULL,
		[LOGON_SKILL115]            [int] NULL,
		[SK_LEVEL115]               [int] NULL,
		[SK_PERCENT115]             [int] NULL,
		[SK_INTR_TYPE115]           [int] NULL,
		[LOGON_SKILL116]            [int] NULL,
		[SK_LEVEL116]               [int] NULL,
		[SK_PERCENT116]             [int] NULL,
		[SK_INTR_TYPE116]           [int] NULL,
		[LOGON_SKILL117]            [int] NULL,
		[SK_LEVEL117]               [int] NULL,
		[SK_PERCENT117]             [int] NULL,
		[SK_INTR_TYPE117]           [int] NULL,
		[LOGON_SKILL118]            [int] NULL,
		[SK_LEVEL118]               [int] NULL,
		[SK_PERCENT118]             [int] NULL,
		[SK_INTR_TYPE118]           [int] NULL,
		[LOGON_SKILL119]            [int] NULL,
		[SK_LEVEL119]               [int] NULL,
		[SK_PERCENT119]             [int] NULL,
		[SK_INTR_TYPE119]           [int] NULL,
		[LOGON_SKILL120]            [int] NULL,
		[SK_LEVEL120]               [int] NULL,
		[SK_PERCENT120]             [int] NULL,
		[SK_INTR_TYPE120]           [int] NULL,
		[LOGIN_DATE]                [datetime] NULL,
		[LOGIN_DATE_UTC]            [datetime] NOT NULL,
		[LOGOUT_DATE]               [datetime] NULL,
		[LOGOUT_DATE_UTC]           [datetime] NULL,
		[LOC_ID]                    [int] NULL,
		[LOGIN_DURATION_MINS]       [int] NULL,
		[UTC_TIMEZONE]              [int] NULL,
		[CUSTOM_DIMENSION_0]        [int] NOT NULL,
		[CUSTOM_DIMENSION_1]        [int] NOT NULL,
		[CUSTOM_DIMENSION_2]        [int] NOT NULL,
		[CUSTOM_DIMENSION_3]        [int] NOT NULL,
		[CUSTOM_DIMENSION_4]        [int] NOT NULL,
		[CUSTOM_DIMENSION_5]        [int] NOT NULL,
		[CUSTOM_DIMENSION_6]        [int] NOT NULL,
		[CUSTOM_DIMENSION_7]        [int] NOT NULL,
		[CUSTOM_DIMENSION_8]        [int] NOT NULL,
		[CUSTOM_DIMENSION_9]        [int] NOT NULL,
		[CUSTOM_MEASURE_0]          [int] NULL,
		[CUSTOM_MEASURE_1]          [int] NULL,
		[CUSTOM_MEASURE_2]          [int] NULL,
		[CUSTOM_MEASURE_3]          [int] NULL,
		[CUSTOM_MEASURE_4]          [int] NULL,
		[CUSTOM_MEASURE_5]          [int] NULL,
		[CUSTOM_MEASURE_6]          [int] NULL,
		[CUSTOM_MEASURE_7]          [int] NULL,
		[CUSTOM_MEASURE_8]          [int] NULL,
		[CUSTOM_MEASURE_9]          [int] NULL,
		CONSTRAINT [PK_FCT_CMS_AGENT_LOGOUT]
		PRIMARY KEY
		CLUSTERED
		([PARTITION_URN], [PARTITION_ID])
	ON [FCTCMSGROUP]
) ON [FCTCMSGROUP]
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_ACD_URN]
	ON [dbo].[TB_FCT_CMS_AGENT_LOGOUT] ([ACD_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'INDEX', N'IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_ACD_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_AGENT_URN]
	ON [dbo].[TB_FCT_CMS_AGENT_LOGOUT] ([AGENT_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'INDEX', N'IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_AGENT_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_LOGIN_DATE]
	ON [dbo].[TB_FCT_CMS_AGENT_LOGOUT] ([LOGIN_DATE_UTC_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'INDEX', N'IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_LOGIN_DATE'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_LOGIN_TIME]
	ON [dbo].[TB_FCT_CMS_AGENT_LOGOUT] ([LOGOUT_TIME_UTC_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'INDEX', N'IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_LOGIN_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_LOGOUT_DATE]
	ON [dbo].[TB_FCT_CMS_AGENT_LOGOUT] ([LOGOUT_DATE_UTC_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'INDEX', N'IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_LOGOUT_DATE'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_LOGOUT_TIME]
	ON [dbo].[TB_FCT_CMS_AGENT_LOGOUT] ([LOGIN_TIME_UTC_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'INDEX', N'IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_LOGOUT_TIME'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_PERIHERAL_URN]
	ON [dbo].[TB_FCT_CMS_AGENT_LOGOUT] ([ACD_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'INDEX', N'IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_PERIHERAL_URN'
GO
CREATE NONCLUSTERED INDEX [IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_SKILLGROUP_URN]
	ON [dbo].[TB_FCT_CMS_AGENT_LOGOUT] ([SKILLGROUP_URN])
	ON [FCTCMSIDXGROUP]
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_INDEX_TYPE', N'F', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'INDEX', N'IX_FCT_CMS_AGENT_LOGOUT_INTERVAL_SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the template table for the historical statistics agent logout from CMS systems. This table is created at install time and the partitioning service creates various partition tables with the same schema. These partition tables are prefixed as TB_FCT_CMS_AGENT_LOGOUT_ followed by the partition identifier. The partition identifier is created depending on the partition configuration, for example monthly, weekly etc. All currently active partitions are included VW_PARTITONED_FCT_CMS_AGENT_LOGOUT view. Since the partitioned tables are generated at runtime and that they have the same schema no separate documentations are required for each partition table. In case of a configured Avaya CMS the data in these partition tables are sourced from the  table in cms Database.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_Description', N'Primary Key Identifier for the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'PARTITION_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This column holds a value that uniquely identifies a row across all the partition tables for this partition type.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'PARTITION_GLOBAL_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the number for the current partition table.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'PARTITION_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from the table dbo.TB_CLU_RESOURCE indicating the source of the data..', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CLUSTER_RESOURCE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_AGENT corresponding to an item of type IT_AGENT. This corresponds to the AGENT associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_AGENT', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'AGENT_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_SKILLGROUP corresponding to an item of type IT_SKILLGROUP. This corresponds to the skillgroup associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_SKILLGROUP', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SKILLGROUP_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN from TB_DIM_PERIPHERAL corresponding to an item of type PT_ACD. This corresponds to the ACD associated with the record.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_PERIPHERAL', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'ACD_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the PERIPHERAL_CODE_URN column in VW_DIM_PERIPHERAL_LOGOUT_REASON corresponding to the agents logout reason..', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGOUT_REASONCODE_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the agent logout date associated with the record. This is calculated by the data importer based on the source data time corresponding to the logout of the agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGOUT_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the agent logout time associated with the record. This is calculated by the data importer based on the source data time corresponding to the logout of the agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGOUT_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_DATE corresponding to the agent login date associated with the record. This is calculated by the data importer based on the source data time corresponding to the login of the agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGIN_DATE_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the URN as in TB_DIM_TIME corresponding to the agent login time associated with the record. This is calculated by the data importer based on the source data time corresponding to the login of the agent.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGIN_TIME_UTC_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The unique URN on exony database that is associated with extension number of the station that the agent uses to log in. The URN in this column maps to the HAGLOG.EXTN column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'EXTN_URN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'Sequential row identifier. The data in this column maps to the HAGLOG.SEQNUM column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SEQ_NUM'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The extension number of the station that the agent uses to log in. The data in this column maps to the HAGLOG.EXTN column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'EXTN'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents call handling preference. Valid values for PREFERENCE are blank, LVL (service level), NEED (greatest need), PCNT (percent allocation). The PREFERENCE item is available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.PREFERENCE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'PREFERENCE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL applies to LOGONSKILL. The SKLEVEL item is available with the EAS feature. The data in this column maps to the HAGLOG.SKLEVEL column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL. The SKPERCENT item is available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. This SKLEVEL2 through SKLEVEL20 applies to LOGONSKILL2 through LOGONSKILL20, respectively. The SKLEVEL2 through SKLE. The data in this column maps to the HAGLOG.SKLEVEL2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE2 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. This SKLEVEL2 through SKLEVEL20 applies to LOGONSKILL2 through LOGONSKILL20, respectively. The SKLEVEL2 through SKLE. The data in this column maps to the HAGLOG.SKLEVEL3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE3 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. This SKLEVEL2 through SKLEVEL20 applies to LOGONSKILL2 through LOGONSKILL20, respectively. The SKLEVEL2 through SKLE. The data in this column maps to the HAGLOG.SKLEVEL4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE4 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. This SKLEVEL2 through SKLEVEL20 applies to LOGONSKILL2 through LOGONSKILL20, respectively. The SKLEVEL2 through SKLE. The data in this column maps to the HAGLOG.SKLEVEL5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE5 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL6 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. This SKLEVEL2 through SKLEVEL20 applies to LOGONSKILL2 through LOGONSKILL20, respectively. The SKLEVEL2 through SKLE. The data in this column maps to the HAGLOG.SKLEVEL6 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT6 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE6 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL7 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. This SKLEVEL2 through SKLEVEL20 applies to LOGONSKILL2 through LOGONSKILL20, respectively. The SKLEVEL2 through SKLE. The data in this column maps to the HAGLOG.SKLEVEL7 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT7 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE7 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL8 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. This SKLEVEL2 through SKLEVEL20 applies to LOGONSKILL2 through LOGONSKILL20, respectively. The SKLEVEL2 through SKLE. The data in this column maps to the HAGLOG.SKLEVEL8 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT8 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE8 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL9 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. This SKLEVEL2 through SKLEVEL20 applies to LOGONSKILL2 through LOGONSKILL20, respectively. The SKLEVEL2 through SKLE. The data in this column maps to the HAGLOG.SKLEVEL9 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT9 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE9 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL10 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. This SKLEVEL2 through SKLEVEL20 applies to LOGONSKILL2 through LOGONSKILL20, respectively. The SKLEVEL2 through SKLE. The data in this column maps to the HAGLOG.SKLEVEL10 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT10 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE10 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE10'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL11 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL11'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. This SKLEVEL2 through SKLEVEL20 applies to LOGONSKILL2 through LOGONSKILL20, respectively. The SKLEVEL2 through SKLE. The data in this column maps to the HAGLOG.SKLEVEL11 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL11'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT11 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT11'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE11 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE11'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL12 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL12'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. This SKLEVEL2 through SKLEVEL20 applies to LOGONSKILL2 through LOGONSKILL20, respectively. The SKLEVEL2 through SKLE. The data in this column maps to the HAGLOG.SKLEVEL12 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL12'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT12 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT12'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE12 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE12'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL13 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL13'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. This SKLEVEL2 through SKLEVEL20 applies to LOGONSKILL2 through LOGONSKILL20, respectively. The SKLEVEL2 through SKLE. The data in this column maps to the HAGLOG.SKLEVEL13 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL13'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT13 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT13'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE13 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE13'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL14 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL14'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. This SKLEVEL2 through SKLEVEL20 applies to LOGONSKILL2 through LOGONSKILL20, respectively. The SKLEVEL2 through SKLE. The data in this column maps to the HAGLOG.SKLEVEL14 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL14'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT14 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT14'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE14 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE14'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL15 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL15'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. This SKLEVEL2 through SKLEVEL20 applies to LOGONSKILL2 through LOGONSKILL20, respectively. The SKLEVEL2 through SKLE. The data in this column maps to the HAGLOG.SKLEVEL15 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL15'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT15 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT15'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE15 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE15'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL16 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL16'
GO
EXEC sp_addextendedproperty N'MS_Description', N'An indication of the agents skill level, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. This SKLEVEL2 through SKLEVEL20 applies to LOGONSKILL2 through LOGONSKILL20, respectively. The SKLEVEL2 through SKLE. The data in this column maps to the HAGLOG.SKLEVEL16 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL16'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT16 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT16'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE16 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE16'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL17 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL17'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL17 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL17'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT17 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT17'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE17 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE17'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL18 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL18'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL18 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL18'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT18 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT18'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE18 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE18'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL19 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL19'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL19 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL19'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT19 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT19'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE19 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE19'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The second through twentieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL 2 through LOGONSKILL20 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL20 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL20'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL20 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL20'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT20 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT20'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE20 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE20'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL21 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL21'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL21 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL21'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT21 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT21'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE21 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE21'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL22 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL22'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL22 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL22'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT22 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT22'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE22 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE22'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL23 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL23'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL23 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL23'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT23 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT23'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE23 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE23'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL24 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL24'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL24 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL24'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT24 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT24'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE24 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE24'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL25 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL25'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL25 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL25'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT25 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT25'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE25 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE25'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL26 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL26'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL26 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL26'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT26 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT26'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE26 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE26'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL27 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL27'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL27 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL27'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT27 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT27'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE27 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE27'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL28 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL28'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL28 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL28'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT28 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT28'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE28 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE28'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL29 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL29'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL29 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL29'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT29 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT29'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE29 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE29'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL30 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL30'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL30 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL30'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT30 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT30'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE30 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE30'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL31 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL31'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL31 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL31'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT31 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT31'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE31 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE31'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL32 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL32'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL32 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL32'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT32 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT32'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE32 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE32'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL33 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL33'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL33 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL33'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT33 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT33'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE33 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE33'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL34 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL34'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL34 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL34'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT34 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT34'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE34 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE34'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL35 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL35'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL35 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL35'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT35 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT35'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE35 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE35'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL36 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL36'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL36 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL36'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT36 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT36'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE36 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE36'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL37 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL37'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL37 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL37'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT37 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT37'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE37 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE37'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL38 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL38'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL38 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL38'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT38 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT38'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE38 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE38'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL39 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL39'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL39 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL39'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT39 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT39'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE39 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE39'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL40 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL40'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL40 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL40'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT40 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT40'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE40 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE40'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL41 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL41'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL41 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL41'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT41 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT41'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE41 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE41'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL42 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL42'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL42 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL42'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT42 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT42'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE42 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE42'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL43 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL43'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL43 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL43'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT43 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT43'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE43 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE43'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL44 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL44'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL44 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL44'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT44 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT44'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE44 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE44'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL45 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL45'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL45 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL45'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT45 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT45'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE45 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE45'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL46 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL46'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL46 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL46'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT46 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT46'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE46 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE46'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL47 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL47'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL47 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL47'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT47 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT47'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE47 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE47'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL48 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL48'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL48 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL48'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT48 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT48'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE48 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE48'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL49 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL49'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL49 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL49'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT49 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT49'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE49 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE49'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL50 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL50'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL50 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL50'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT50 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT50'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE50 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE50'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL51 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL51'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL51 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL51'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT51 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT51'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE51 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE51'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL52 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL52'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL52 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL52'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT52 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT52'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE52 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE52'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL53 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL53'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL53 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL53'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT53 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT53'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE53 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE53'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL54 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL54'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL54 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL54'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT54 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT54'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE54 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE54'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL55 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL55'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL55 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL55'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT55 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT55'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE55 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE55'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL56 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL56'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL56 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL56'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT56 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT56'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE56 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE56'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL57 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL57'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL57 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL57'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT57 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT57'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE57 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE57'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL58 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL58'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL58 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL58'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT58 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT58'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE58 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE58'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL59 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL59'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL59 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL59'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT59 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT59'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE59 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE59'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL21 through LOGONSKILL60 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL60 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL60'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL60 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL60'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT60 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT60'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE60 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE60'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL61 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL61'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL61 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL61'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT61 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT61'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE61 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE61'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL62 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL62'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL62 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL62'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT62 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT62'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE62 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE62'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL63 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL63'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL63 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL63'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT63 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT63'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE63 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE63'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL64 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL64'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL64 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL64'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT64 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT64'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE64 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE64'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL65 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL65'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL65 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL65'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT65 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT65'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE65 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE65'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL66 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL66'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL66 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL66'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT66 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT66'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE66 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE66'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL67 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL67'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL67 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL67'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT67 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT67'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE67 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE67'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL68 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL68'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL68 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL68'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT68 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT68'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE68 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE68'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL69 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL69'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL69 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL69'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT69 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT69'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE69 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE69'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL70 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL70'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL70 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL70'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT70 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT70'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE70 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE70'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL71 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL71'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL71 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL71'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT71 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT71'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE71 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE71'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL72 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL72'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL72 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL72'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT72 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT72'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE72 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE72'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL73 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL73'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL73 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL73'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT73 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT73'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE73 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE73'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL74 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL74'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL74 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL74'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT74 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT74'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE74 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE74'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL75 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL75'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL75 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL75'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT75 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT75'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE75 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE75'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL76 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL76'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL76 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL76'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT76 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT76'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE76 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE76'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL77 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL77'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL77 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL77'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT77 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT77'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE77 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE77'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL78 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL78'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL78 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL78'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT78 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT78'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE78 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE78'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL79 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL79'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL79 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL79'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT79 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT79'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE79 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE79'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL80 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL80'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL80 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL80'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT80 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT80'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE80 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE80'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL81 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL81'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL81 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL81'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT81 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT81'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE81 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE81'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL82 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL82'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL82 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL82'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT82 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT82'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE82 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE82'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL83 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL83'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL83 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL83'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT83 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT83'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE83 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE83'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL84 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL84'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL84 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL84'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT84 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT84'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE84 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE84'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL85 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL85'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL85 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL85'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT85 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT85'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE85 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE85'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL86 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL86'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL86 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL86'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT86 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT86'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE86 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE86'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL87 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL87'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL87 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL87'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT87 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT87'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE87 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE87'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL88 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL88'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL88 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL88'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT88 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT88'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE88 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE88'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL89 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL89'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL89 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL89'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT89 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT89'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE89 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE89'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL90 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL90'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL90 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL90'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT90 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT90'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE90 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE90'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL91 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL91'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL91 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL91'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT91 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT91'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE91 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE91'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL92 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL92'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL92 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL92'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT92 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT92'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE92 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE92'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL93 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL93'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL93 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL93'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT93 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT93'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE93 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE93'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL94 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL94'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL94 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL94'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT94 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT94'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE94 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE94'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL95 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL95'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL95 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL95'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT95 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT95'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE95 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE95'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL96 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL96'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL96 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL96'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT96 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT96'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE96 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE96'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL97 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL97'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL97 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL97'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT97 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT97'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE97 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE97'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL98 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL98'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL98 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL98'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT98 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT98'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE98 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE98'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL99 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL99'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL99 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL99'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT99 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT99'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE99 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE99'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL100 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL100'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL100 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL100'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT100 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT100'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE100 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE100'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL101 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL101'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL101 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL101'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT101 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT101'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE101 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE101'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL102 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL102'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL102 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL102'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT102 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT102'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE102 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE102'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL103 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL103'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL103 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL103'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT103 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT103'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE103 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE103'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL104 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL104'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL104 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL104'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT104 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT104'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE104 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE104'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL105 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL105'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL105 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL105'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT105 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT105'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE105 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE105'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL106 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL106'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL106 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL106'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT106 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT106'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE106 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE106'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL107 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL107'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL107 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL107'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT107 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT107'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE107 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE107'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL108 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL108'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL108 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL108'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT108 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT108'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE108 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE108'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL109 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL109'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL109 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL109'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT109 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT109'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE109 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE109'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL110 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL110'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL110 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL110'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT110 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT110'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE110 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE110'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL111 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL111'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL111 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL111'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT111 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT111'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE111 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE111'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL112 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL112'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL112 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL112'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT112 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT112'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE112 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE112'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL113 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL113'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL113 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL113'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT113 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT113'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE113 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE113'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL114 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL114'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL114 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL114'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT114 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT114'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE114 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE114'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL115 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL115'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL115 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL115'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT115 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT115'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE115 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE115'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL116 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL116'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL116 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL116'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT116 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT116'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE116 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE116'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL117 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL117'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL117 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL117'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT117 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT117'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE117 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE117'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL118 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL118'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL118 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL118'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT118 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT118'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE118 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE118'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL119 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL119'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL119 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL119'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT119 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT119'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE119 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE119'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The twenty-first through sixtieth skills to which the agent logged in. The number of skills per agent depends on the type of communication server. The LOGONSKILL61 through LOGONSKILL120 items are available with the EAS feature. The data in this column maps to the HAGLOG.LOGONSKILL120 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGON_SKILL120'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item is an indication of the skill level for an agent, which is 1 through 16 for a normal skill, or reserve level, which is 1 or 2 for a reserve skill. SKLEVEL61 through SKLEVEL99 apply to LOGONSKILL61 through LOGONSKILL99, respectively. These items . The data in this column maps to the HAGLOG.SKLEVEL120 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_LEVEL120'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The percentage of time that is allocated for the agent to spend in LOGONSKILL2 through LOGONSKILL120. The SKPERCENT2 through SKPERCENT120 items are available on Avaya communication servers with the EAS feature. The data in this column maps to the HAGLOG.SKPERCENT120 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_PERCENT120'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This item stores the interrupt type of agent LOGONSKILL and LOGONSKILL2 through LOGONSKILL120.. The data in this column maps to the HAGLOG.SKINTRTYPE120 column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'SK_INTR_TYPE120'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the agent login date associated with the record. This is calculated by the data importer based on the source data time corresponding to the login of the agent. The data in this column maps to the HAGLOG.LOGIN_DATE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGIN_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the agent login UTC date associated with the record. This is calculated by the data importer based on the source data time corresponding to the login of the agent. The data in this column maps to the HAGLOG.LOGIN_DATE_UTC column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGIN_DATE_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the agent logout date associated with the record. This is calculated by the data importer based on the source data time corresponding to the logout of the agent. The data in this column maps to the HAGLOG.LOGOUT_DATE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGOUT_DATE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This corresponds to the agent logout UTC date associated with the record. This is calculated by the data importer based on the source data time corresponding to the logout of the agent. The data in this column maps to the HAGLOG.LOGOUT_DATE_UTC column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGOUT_DATE_UTC'
GO
EXEC sp_addextendedproperty N'MS_Description', N'The equipment location ID that is associated with a particular agent. This is the location ID of the terminal the agent is logged into. It is associated with a port network location ID on the communication server. The data in this column maps to the HAGLOG.LOC_ID column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOC_ID'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is a calculated field to hold the login duration in minutes. The calculation is a date difference against the login and logout dates.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'LOGIN_DURATION_MINS'
GO
EXEC sp_addextendedproperty N'MS_Description', N'This is the offset from UTC corresponding to the record. The data in this column maps to the HAGLOG.UTC_TIMEZONE column in the Avaya CMS database', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'UTC_TIMEZONE'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM0', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM1', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM2', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM3', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM4', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM5', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM6', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM7', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM8', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'XNY_PARTITION_COLUMN_ITEM_TYPE', N'IT_CUSTOM9', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_DIMENSION_9'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_0'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_1'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_2'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_3'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_4'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_5'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_6'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_7'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_8'
GO
EXEC sp_addextendedproperty N'MS_Description', N'For future use.', 'SCHEMA', N'dbo', 'TABLE', N'TB_FCT_CMS_AGENT_LOGOUT', 'COLUMN', N'CUSTOM_MEASURE_9'
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CMS_AGENT_LOGOUT]
	TO [portalapp_role]
GO
GRANT INSERT
	ON [dbo].[TB_FCT_CMS_AGENT_LOGOUT]
	TO [portal_default_mediator_role]
GO
GRANT SELECT
	ON [dbo].[TB_FCT_CMS_AGENT_LOGOUT]
	TO [portal_default_mediator_role]
GO
ALTER TABLE [dbo].[TB_FCT_CMS_AGENT_LOGOUT] SET (LOCK_ESCALATION = TABLE)
GO
