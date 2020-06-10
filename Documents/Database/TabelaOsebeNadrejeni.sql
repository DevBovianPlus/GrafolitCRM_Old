USE [AnalizaProdajeTest]
GO

/****** Object:  Table [dbo].[OsebeNadrejeni]    Script Date: 20. 11. 2017 13:03:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[OsebeNadrejeni](
	[OsebeNadrejeniID] [int] IDENTITY(1,1) NOT NULL,
	[idOseba] [int] NOT NULL,
	[idNadrejeni] [int] NOT NULL,
	[Opomba] [varchar](200) NULL,
	[ts] [datetime] NULL CONSTRAINT [DF_OsebeNadrejeni_ts]  DEFAULT (getdate()),
	[tsIDosebe] [int] NULL,
 CONSTRAINT [PK_OsebeNadrejeni] PRIMARY KEY CLUSTERED 
(
	[OsebeNadrejeniID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[OsebeNadrejeni]  WITH CHECK ADD  CONSTRAINT [FK_OsebeNadrejeni_Osebe] FOREIGN KEY([idOseba])
REFERENCES [dbo].[Osebe] ([idOsebe])
GO

ALTER TABLE [dbo].[OsebeNadrejeni] CHECK CONSTRAINT [FK_OsebeNadrejeni_Osebe]
GO

ALTER TABLE [dbo].[OsebeNadrejeni]  WITH CHECK ADD  CONSTRAINT [FK_OsebeNadrejeni_Osebe1] FOREIGN KEY([idNadrejeni])
REFERENCES [dbo].[Osebe] ([idOsebe])
GO

ALTER TABLE [dbo].[OsebeNadrejeni] CHECK CONSTRAINT [FK_OsebeNadrejeni_Osebe1]
GO

/*****DELETE ALL EVENTS FROM TABLE*****/
DELETE FROM [dbo].[Dogodek]
GO
