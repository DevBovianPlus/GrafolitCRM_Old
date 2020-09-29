alter table Stranka add AKTIVNOST int;

alter table Dogodek alter column Opis varchar(max);
alter table Dogodek add Priloge varchar(max);
alter table DogodekSestanek alter column Opis varchar(max);
alter table KontaktneOsebe add RojstniDatum datetime;
alter table Stranka add LastStatusID int; 

ALTER TABLE Stranka WITH CHECK ADD  CONSTRAINT FK_StatusDogodek_Stranka FOREIGN KEY(LastStatusID)
REFERENCES StatusDogodek (idStatusDogodek)
GO


CREATE TABLE OpombaStranka(
	idOpombaStranka int IDENTITY(1,1) NOT NULL,
	idStranka int NULL,	
	Opomba varchar(max) NULL,
	ts datetime NULL,
	tsIDOsebe int NULL,
 CONSTRAINT PK_OpombaStranka PRIMARY KEY CLUSTERED 
(
	idOpombaStranka ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE OpombaStranka WITH CHECK ADD  CONSTRAINT FK_OpombaStranka_Stranka FOREIGN KEY(idStranka)
REFERENCES Stranka (idStranka)
GO

ALTER TABLE OpombaStranka CHECK CONSTRAINT FK_OpombaStranka_Stranka
GO

