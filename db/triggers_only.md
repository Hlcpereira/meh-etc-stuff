# Triggers

**Total Triggers:** 1

---

## 1. TrUpdatePrintJobsCube

```sql
CREATE TRIGGER [dbo].[TrUpdatePrintJobsCube]
	ON [dbo].[PrintJobs]
	FOR UPDATE, DELETE
	
AS

BEGIN

	IF (NOT EXISTS(SELECT * FROM Deleted))
	BEGIN
		IF (NOT EXISTS(SELECT * FROM Inserted))
		BEGIN
			RETURN 
		END
	END

	DECLARE @TempCube 
		TABLE (	PrintQualityID INT, PrinterQueueID INT, PrinterDeviceID INT, AccountID INT, PaperSizeID INT, 
				JobOriginID SMALLINT,	PrintApplicationID INT, PrintWayID INT, PagesColor INT, PagesMono INT,
				CostColor MONEY, CostMono MONEY, CostAccountID INT, SiteID INT, MachineID INT, DataZero DATETIME, 
				JobTypeID INT, OutTime BIT, TotalJobs INT)

	DECLARE @Temp 
		TABLE (	PrinterQueueID INT, PrinterDeviceID INT, AccountID INT, PaperSizeID INT, 
				JobOriginID SMALLINT,	PrintApplicationID INT, PrintWayID INT, PagesColor INT, PagesMono INT,
				CostColor MONEY, CostMono MONEY, CostAccountID INT, SiteID INT, MachineID INT, DataZero DATETIME, 
				JobTypeID INT, OutTime BIT, TotalJobs INT)

	DECLARE @Core 
		TABLE ( Data	DATETIME, CDFN	INT, CDFV	MONEY, CDCN	INT, CDCV	MONEY, CDIN	INT, CDIV	MONEY, CSFN	INT, CSFV	MONEY, CSCN	INT,
					CSCV	MONEY, CSIN	INT, CSIV	MONEY, PDFN	INT, PDFV	MONEY, PDCN	INT, PDCV	MONEY, PDIN	INT, PDIV	MONEY, PSFN	INT,
					PSFV	MONEY, PSCN	INT , PSCV	MONEY, PSIN	INT , PSIV	MONEY , TotJobs	INT, SN INT, SV MONEY, EN INT, EV MONEY)	

	DECLARE @User 
		TABLE ( Data	DATETIME, AccountID INT, CostAccountID INT, SiteID INT, PrintApplicationID INT, PaperSizeID INT, JobOriginID SMALLINT,
					CDFN	INT, CDFV	MONEY, CDCN	INT, CDCV	MONEY, CDIN	INT, CDIV	MONEY, CSFN	INT, CSFV MONEY, CSCN INT,
					CSCV	MONEY, CSIN	INT, CSIV	MONEY, PDFN	INT, PDFV	MONEY, PDCN	INT, PDCV	MONEY, PDIN	INT, PDIV	MONEY, PSFN	INT,
					PSFV	MONEY, PSCN	INT, PSCV	MONEY, PSIN	INT, PSIV	MONEY, TotJobs	INT, SN INT, SV MONEY, EN INT, EV MONEY)	
	
	DECLARE @Printer 
		TABLE ( Data	DATETIME, PrinterDeviceID INT, CostAccountID INT, SiteID INT, PrintApplicationID INT, PaperSizeID INT, JobOriginID SMALLINT,
					CDFN INT, CDFV	MONEY, CDCN	INT, CDCV	MONEY, CDIN	INT, CDIV	MONEY, CSFN	INT, CSFV MONEY, CSCN INT,
					CSCV	MONEY, CSIN	INT, CSIV	MONEY, PDFN	INT, PDFV	MONEY, PDCN	INT, PDCV	MONEY, PDIN	INT, PDIV	MONEY, PSFN	INT,
					PSFV	MONEY, PSCN	INT, PSCV	MONEY, PSIN	INT, PSIV	MONEY, TotJobs	INT, SN INT, SV MONEY, EN INT, EV MONEY)	

	DECLARE @Queue 
		TABLE ( Data	DATETIME, PrinterQueueID INT, CostAccountID INT, SiteID INT, PrintApplicationID INT, PaperSizeID INT, JobOriginID SMALLINT,
					CDFN INT, CDFV	MONEY, CDCN	INT, CDCV	MONEY, CDIN	INT, CDIV	MONEY, CSFN	INT, CSFV MONEY, CSCN INT,
					CSCV	MONEY, CSIN	INT, CSIV	MONEY, PDFN	INT, PDFV	MONEY, PDCN	INT, PDCV	MONEY, PDIN	INT, PDIV	MONEY, PSFN	INT,
					PSFV	MONEY, PSCN	INT, PSCV	MONEY, PSIN	INT, PSIV	MONEY, TotJobs	INT, SN INT, SV MONEY, EN INT, EV MONEY)	

	DECLARE @Machine 
		TABLE ( Data	DATETIME, MachineID INT, CostAccountID INT, SiteID INT, PrintApplicationID INT, PaperSizeID INT, JobOriginID SMALLINT,
					CDFN INT, CDFV	MONEY, CDCN	INT, CDCV	MONEY, CDIN	INT, CDIV	MONEY, CSFN	INT, CSFV MONEY, CSCN INT,
					CSCV	MONEY, CSIN	INT, CSIV	MONEY, PDFN	INT, PDFV	MONEY, PDCN	INT, PDCV	MONEY, PDIN	INT, PDIV	MONEY, PSFN	INT,
					PSFV	MONEY, PSCN	INT, PSCV	MONEY, PSIN	INT, PSIV	MONEY, TotJobs	INT, SN INT, SV MONEY, EN INT, EV MONEY)	

	DECLARE @CostAccount 
		TABLE ( Data DATETIME, CostAccountID INT, SiteID INT, PrintApplicationID INT, PaperSizeID INT, JobOriginID SMALLINT,
					CDFN INT, CDFV MONEY, CDCN	INT, CDCV	MONEY, CDIN	INT, CDIV	MONEY, CSFN	INT, CSFV MONEY, CSCN INT,
					CSCV MONEY, CSIN INT, CSIV	MONEY, PDFN	INT, PDFV	MONEY, PDCN	INT, PDCV MONEY, PDIN INT, PDIV	MONEY, PSFN INT,
					PSFV MONEY, PSCN INT, PSCV	MONEY, PSIN	INT, PSIV	MONEY, TotJobs	INT, SN INT, SV MONEY, EN INT, EV MONEY)	
	
	DECLARE @Analyze
		TABLE ( Data DATETIME, AccountID INT, CostAccountID INT, A4 INT, NA4 INT, InTime INT, OutTime INT, Local INT, Net INT)

	-- ALTERAÇÃO RELATÓRIO DE CUBO
	DECLARE @CubeCube
		TABLE ( [Date] SMALLDATETIME, Pages INT, Color BIT, Cost DECIMAL (19,6), PrintWayID BIT, PrintApplicationID INT, PrintQualityID INT,
				PaperSizeID SMALLINT, CostAccountID INT, JobOriginID SMALLINT, PrinterDeviceID INT, PrinterQueueID INT, AccountID INT, SiteID INT, JobTypeID INT)


	-- Trava o acesso ""escrita"" aos cubos

	UPDATE
		CubeProcessing
	SET
		ServiceName = 'TRIGGER PrintJob ' + CONVERT(VARCHAR(40), GETDATE(), 121)

	----------------------------------------------------------
	DECLARE @TempVal VARCHAR(5)
	DECLARE @AfternoonBeginHour SMALLINT
	DECLARE @AfternoonBeginMinute SMALLINT
	DECLARE @AfternoonEndHour SMALLINT
	DECLARE @AfternoonEndMinute SMALLINT
	DECLARE @MorningBeginHour SMALLINT
	DECLARE @MorningBeginMinute SMALLINT
	DECLARE @MorningEndHour SMALLINT
	DECLARE @MorningEndMinute SMALLINT

	SELECT @TempVal = ParameterValue FROM [Parameters] WHERE ParameterName = 'TimeWorkAfternoonBegin'

	IF (@TempVal IS NULL)
	BEGIN 
		SET @TempVal = '12:00'
	END

	PRINT 'Horário de entrada verspertino: ' + @TempVal 

	SET @AfternoonBeginHour = CAST(SUBSTRING (@TempVal,1,charindex(':', @TempVal) -1) AS SMALLINT)
	SET @AfternoonBeginMinute = CAST(SUBSTRING (@TempVal,4,charindex(':', @TempVal) -1) AS SMALLINT)

	SET @TempVal = NULL 
	SELECT @TempVal = ParameterValue FROM Parameters WHERE ParameterName = 'TimeWorkAfternoonEnd'

	IF (@TempVal IS NULL)
	BEGIN
		SET @TempVal = '18:00'
	END

	PRINT 'Horário de saída vespertino: ' + @TempVal 

	SET @AfternoonENDHour = CAST(SUBSTRING (@TempVal,1,charindex(':', @TempVal) -1) AS SMALLINT)
	SET @AfternoonENDMinute = CAST(SUBSTRING (@TempVal,4,charindex(':', @TempVal) -1) AS SMALLINT)

	SET @TempVal = NULL 
	SELECT @TempVal = ParameterValue FROM Parameters WHERE ParameterName = 'TimeWorkMorningBegin'

	IF (@TempVal IS NULL)
	BEGIN
		SET @TempVal = '08:00'
	END

	PRINT 'Horário de entrada matinal: ' + @TempVal 

	SET @MorningBeginHour = CAST(SUBSTRING (@TempVal,1,charindex(':', @TempVal) -1) AS SMALLINT)
	SET @MorningBeginMinute = CAST(SUBSTRING (@TempVal,4,charindex(':', @TempVal) -1) AS SMALLINT)

	SET @TempVal = NULL 
	SELECT @TempVal = ParameterValue FROM Parameters WHERE ParameterName = 'TimeWorkMorningEND'

	IF (@TempVal IS NULL)
	BEGIN
		SET @TempVal = '12:00'
	END

	PRINT 'Horário de saída matinal: ' + @TempVal 

	SET @MorningEndHour = CAST(SUBSTRING (@TempVal,1,charindex(':', @TempVal) -1) AS SMALLINT)
	SET @MorningEndMinute = CAST(SUBSTRING (@TempVal,4,charindex(':', @TempVal) -1) AS SMALLINT)
	-------------------------------------------------------------------

	--Carrega os dados a serem excluidos do Cubo
	INSERT INTO
		@TempCube
	SELECT
		PrintQualityID, PrinterQueueID, PrinterDeviceID,AccountID, PaperSizeID, JobOriginID,
		PrintApplicationID, PrintWayID, SUM(PagesColor) AS PagesColor, SUM(PagesMono) AS PagesMono,
		SUM(CostColor) AS CostColor, SUM(CostMono) AS CostMono, CostAccountID, SiteID, MachineID, DataZero,
		JobTypeID, OutTime, COUNT (*) AS TotalJobs
	FROM
		(
			SELECT
				PrintQualityID, 
				ISNULL(PrinterQueueID,-1) AS PrinterQueueID,
				J.PrinterDeviceID, 
				AccountID, 
				PaperSizeID, 
				JobOriginID, 
				PrintApplicationID, 
				PrintWayID, 
				PagesColor, 
				PagesMono, 
				CostColor, 
				CostMono,
				CASE WHEN CostAccountID IS NULL THEN -1 ELSE CostAccountID END AS CostAccountID,
				SiteID,
				ISNULL((SELECT P.MachineID 
						FROM PrintersQueues P
						WHERE P.PrinterQueueID = J.PrinterQueueID),-1) AS MachineID,
				JobTypeID,
				(CAST(DATEPART(yyyy, DatePrinted) AS char(4)) +  RIGHT('0' + CAST(DATEPART(mm, DatePrinted) AS VARCHAR(2)), 2) + 
									RIGHT('0' + CAST(DATEPART(dd, DatePrinted) AS VARCHAR(2)), 2)) AS DataZero, 
				CASE WHEN 
					(((DATEPART(hh,dateprinted) = @MorningBEGINHour AND DATEPART(mi,dateprinted) >= @MorningBEGINMinute) OR DATEPART(hh,dateprinted) >= (@MorningBEGINHour + 1)) AND 
					((DATEPART(hh,dateprinted) = @MorningENDHour AND DATEPART(mi,dateprinted) <= @MorningENDMinute) OR DATEPART(hh,dateprinted) <= (@MorningENDHour-1)))
					OR
					(((DATEPART(hh,dateprinted) = @AfternoonBEGINHour AND DATEPART(mi,dateprinted) >= @AfternoonBEGINMinute) OR DATEPART(hh,dateprinted) >= (@AfternoonBEGINHour+1)) AND 
					((DATEPART(hh,dateprinted) = @AfternoonENDHour AND DATEPART(mi,dateprinted) <= @AfternoonENDMinute) OR DATEPART(hh,dateprinted) <= (@AfternoonENDHour-1)))
				THEN 0 ELSE 1 END AS OutTime--, -- 1 - fora do horario de trabalho, 0 - dentro					
				--CASE WHEN pagesmono > 0 
				--		THEN 1 ELSE 0 END AS Cor
			FROM
				Deleted J
			WHERE
				JobDisabled = 0
		) AS TABLE01
	GROUP BY
		PrintQualityID, PrinterQueueID, PrinterDeviceID,AccountID, PaperSizeID, JobOriginID, 
		PrintApplicationID, PrintWayID, CostAccountID, SiteID, MachineID, JobTypeID, DataZero, OutTime--,Cor

	INSERT INTO
		@CubeCube
	SELECT     
		DataZero AS Date, 
		SUM(PagesMono) AS Pages, 
		0 AS Cor, 
		SUM(CostMono) AS Custo, 
		CAST(PrintWayID AS BIT),  
		PrintApplicationID, 
		PrintQualityID, 
		CAST(PaperSizeID AS SMALLINT), 
		ISNULL(CostAccountID, -1), 
		JobOriginID, 
		PrinterDeviceID, 
		ISNULL(PrinterQueueID,-1), 
		AccountID, 
		SiteID, 
		CAST(JobTypeID AS SMALLINT)
	FROM
		@TempCube
	WHERE
		PagesMono <> 0
	GROUP BY
		DataZero, PrintWayID, PrintApplicationID, PrintQualityID, PaperSizeID, CostAccountID, JobOriginID,
		PrinterQueueID, PrinterDeviceID, AccountID, SiteID, JobTypeID

	UNION ALL

	SELECT     
		DataZero AS Date, 
		SUM(PagesColor) AS Pages, 
		1 AS Cor, 
		SUM(CostColor) AS Custo, 
		CAST(PrintWayID AS BIT),  
		PrintApplicationID, 
		PrintQualityID, 
		CAST(PaperSizeID AS SMALLINT), 
		ISNULL(CostAccountID, -1), 
		JobOriginID, 
		PrinterDeviceID, 
		ISNULL(PrinterQueueID,-1), 
		AccountID, 
		SiteID, 
		CAST(JobTypeID AS SMALLINT)
	FROM
		@TempCube
	WHERE
		PagesColor <> 0
	GROUP BY
		DataZero, PrintWayID, PrintApplicationID, PrintQualityID, PaperSizeID, CostAccountID, JobOriginID,
		PrinterQueueID, PrinterDeviceID, AccountID, SiteID, JobTypeID

	INSERT INTO
		@Temp
	SELECT
		PrinterQueueID, PrinterDeviceID,AccountID, PaperSizeID, JobOriginID, 
		PrintApplicationID, PrintWayID, SUM(PagesColor) AS PagesColor, SUM(PagesMono) AS PagesMono, 
		SUM(CostColor) AS CostColor, SUM(CostMono) AS CostMono, CostAccountID, SiteID, MachineID, DataZero, JobTypeID, OutTime, COUNT (*) AS TotalJobs
	FROM
		@TempCube
	GROUP BY
		PrinterQueueID, PrinterDeviceID,AccountID, PaperSizeID, JobOriginID, 
		PrintApplicationID, PrintWayID, CostAccountID, SiteID, MachineID, JobTypeID, DataZero, OutTime--,Cor

	DELETE FROM @TempCube

	DECLARE @COUNT INT
	SELECT @COUNT = SUM(TotalJobs) FROM @Temp
	PRINT CAST(@COUNT AS VARCHAR) + ' REGISTROS DELETADOS'

	INSERT INTO @Core 
					SELECT	DataZero, 
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDFN,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDFV,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDCN,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDCV,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDIN,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDIV,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSFN,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSFV,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSCN,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSCV,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSIN,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSIV,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDFN,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDFV,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDCN,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDCV,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDIN,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDIV,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSFN,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSFV,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSCN,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSCV,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSIN,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSIV,
							SUM (TotalJobs) AS TotJobs,
							SUM (CASE WHEN JobTypeID = 4 THEN PagesMono ELSE 0 END) AS SN,
							SUM (CASE WHEN JobTypeID = 4 THEN CostMono  ELSE 0 END) AS SV,
							SUM (CASE WHEN JobTypeID = 5 THEN PagesMono ELSE 0 END) AS EN,
							SUM (CASE WHEN JobTypeID = 5 THEN CostMono  ELSE 0 END) AS EV
						FROM  @temp  T
						GROUP BY T.DataZero
			
				IF(@@Error <> 0 )
				BEGIN
					RAISERROR('Erro ao preparar cubos!', 16, 1)
					RETURN
				END			
			
			INSERT INTO @User 
				SELECT	T.DataZero, T.AccountID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSIV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSIV,
						SUM (TotalJobs) AS TotJobs,
						SUM (CASE WHEN JobTypeID = 4 THEN PagesMono ELSE 0 END) AS SN,
						SUM (CASE WHEN JobTypeID = 4 THEN CostMono  ELSE 0 END) AS SV,
						SUM (CASE WHEN JobTypeID = 5 THEN PagesMono ELSE 0 END) AS EN,
						SUM (CASE WHEN JobTypeID = 5 THEN CostMono  ELSE 0 END) AS EV
					FROM @temp  T
					GROUP BY T.DataZero, T.AccountID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID
			
			IF( @@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

			INSERT INTO @Printer 
				SELECT	T.DataZero, T.PrinterDeviceID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSIV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSIV,
						SUM (TotalJobs) AS TotJobs,
						SUM (CASE WHEN JobTypeID = 4 THEN PagesMono ELSE 0 END) AS SN,
						SUM (CASE WHEN JobTypeID = 4 THEN CostMono  ELSE 0 END) AS SV,
						SUM (CASE WHEN JobTypeID = 5 THEN PagesMono ELSE 0 END) AS EN,
						SUM (CASE WHEN JobTypeID = 5 THEN CostMono  ELSE 0 END) AS EV
					FROM  @temp  T
					GROUP BY T.DataZero, T.PrinterDeviceID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END
			
			INSERT INTO @Queue
				SELECT	T.DataZero, T.PrinterQueueID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSIV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSIV,
						SUM (TotalJobs) AS TotJobs,
						SUM (CASE WHEN JobTypeID = 4 THEN PagesMono ELSE 0 END) AS SN,
						SUM (CASE WHEN JobTypeID = 4 THEN CostMono  ELSE 0 END) AS SV,
						SUM (CASE WHEN JobTypeID = 5 THEN PagesMono ELSE 0 END) AS EN,
						SUM (CASE WHEN JobTypeID = 5 THEN CostMono  ELSE 0 END) AS EV
					FROM  @temp  T
					GROUP BY T.DataZero, T.PrinterQueueID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID
			
			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

			INSERT INTO @Machine
				SELECT	T.DataZero, T.MachineID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSIV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSIV,
						SUM (TotalJobs) AS TotJobs,
						SUM (CASE WHEN JobTypeID = 4 THEN PagesMono ELSE 0 END) AS SN,
						SUM (CASE WHEN JobTypeID = 4 THEN CostMono  ELSE 0 END) AS SV,
						SUM (CASE WHEN JobTypeID = 5 THEN PagesMono ELSE 0 END) AS EN,
						SUM (CASE WHEN JobTypeID = 5 THEN CostMono  ELSE 0 END) AS EV
					FROM @temp  T
					GROUP BY T.DataZero, T.MachineID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

			INSERT INTO @CostAccount
				SELECT	T.DataZero, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSIV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSIV,
						SUM (TotalJobs) AS TotJobs,
						SUM (CASE WHEN JobTypeID = 4 THEN PagesMono ELSE 0 END) AS SN,
						SUM (CASE WHEN JobTypeID = 4 THEN CostMono  ELSE 0 END) AS SV,
						SUM (CASE WHEN JobTypeID = 5 THEN PagesMono ELSE 0 END) AS EN,
						SUM (CASE WHEN JobTypeID = 5 THEN CostMono  ELSE 0 END) AS EV
					FROM  @temp  T
					GROUP BY T.DataZero, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID	

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END
			
				INSERT INTO @Analyze
					SELECT	T.DataZero, 
						T.AccountID, 
						T.CostAccountID, 						
						SUM (CASE WHEN PaperSizeId = 9 THEN PagesColor + PagesMono ELSE 0 END) AS A4,
						SUM (CASE WHEN PaperSizeId <> 9 THEN PagesColor + PagesMono ELSE 0 END) AS NA4,
						SUM (CASE WHEN OutTime = 0
							THEN PagesColor + PagesMono ELSE 0 END) AS InTime,
						SUM (CASE WHEN OutTime = 1
							THEN PagesColor + PagesMono ELSE 0 END) AS OutTime,
						SUM (CASE WHEN dbo.ReturnPrinterQueueTypeID( T.PrinterQueueID) = 1
							THEN PagesColor + PagesMono ELSE 0 END) AS Local,
						SUM (CASE WHEN dbo.ReturnPrinterQueueTypeID( T.PrinterQueueID) <> 1
							THEN PagesColor + PagesMono ELSE 0 END) AS Net
					FROM  @temp  T WHERE T.JobTypeID in (1,2,3)
					GROUP BY T.DataZero, T.AccountID, T.CostAccountID

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END
-- Subtrai dos Cubos os valores selecionados

				PRINT 'DELETA DE CUBECUBE'
				UPDATE CubeCube
					SET CubeCube.Pages = CubeCube.Pages - C.Pages, CubeCube.Cost = CubeCube.Cost - C.Cost 
					FROM @CubeCube C
					WHERE CubeCube.Date = C.Date AND CubeCube.Color = C.Color AND CubeCube.PrintWayID = C.PrintWayID AND CubeCube.PrintApplicationID = C.PrintApplicationID AND
						CubeCube.PrintQualityID = C.PrintQualityID AND  CubeCube.PaperSizeID = C.PaperSizeID AND CubeCube.CostAccountID = C.CostAccountID AND CubeCube.JobOriginID = C.JobOriginID AND
						CubeCube.PrinterDeviceID = C.PrinterDeviceID AND CubeCube.PrinterQueueID = C.PrinterQueueID AND CubeCube.AccountID = C.AccountID AND 
						CubeCube.SiteID = C.SiteID AND CubeCube.JobTypeID = C.JobTypeID



				PRINT 'DELETA DE CUBECORE'
				UPDATE CubeCore
					SET CubeCore.CDFN = CubeCore.CDFN - C.CDFN, CubeCore.CDFV = CubeCore.CDFV - C.CDFV, CubeCore.CDCN = CubeCore.CDCN - C.CDCN,
						CubeCore.CDCV = CubeCore.CDCV - C.CDCV, CubeCore.CDIN = CubeCore.CDIN - C.CDIN,	CubeCore.CDIV = CubeCore.CDIV - C.CDIV,
						CubeCore.CSFN = CubeCore.CSFN - C.CSFN, CubeCore.CSFV = CubeCore.CSFV - C.CSFV,	CubeCore.CSCN = CubeCore.CSCN - C.CSCN,
						CubeCore.CSCV = CubeCore.CSCV - C.CSCV,	CubeCore.CSIN = CubeCore.CSIN - C.CSIN, CubeCore.CSIV = CubeCore.CSIV - C.CSIV, 
						CubeCore.PDFN = CubeCore.PDFN - C.PDFN, CubeCore.PDFV = CubeCore.PDFV - C.PDFV, CubeCore.PDCN = CubeCore.PDCN - C.PDCN, 
						CubeCore.PDCV = CubeCore.PDCV - C.PDCV, CubeCore.PDIN = CubeCore.PDIN - C.PDIN,	CubeCore.PDIV = CubeCore.PDIV - C.PDIV,
						CubeCore.PSFN = CubeCore.PSFN - C.PSFN, CubeCore.PSFV = CubeCore.PSFV - C.PSFV,	CubeCore.PSCN = CubeCore.PSCN - C.PSCN, 
						CubeCore.PSCV = CubeCore.PSCV - C.PSCV,	CubeCore.PSIN = CubeCore.PSIN - C.PSIN, CubeCore.PSIV = CubeCore.PSIV - C.PSIV,
						CubeCore.TotJobs = CubeCore.TotJobs - C.TotJobs,
						CubeCore.SN = CubeCore.SN - C.SN, CubeCore.SV = CubeCore.SV - C.SV,
						CubeCore.EN = CubeCore.EN - C.EN, CubeCore.EV = CubeCore.EV - C.EV
					FROM @Core C
					WHERE CubeCore.Data = C.Data
				
				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END		

				PRINT 'DELETA DE CUBEUSER'
				UPDATE CubeUser			
					SET CubeUser.CDFN = CubeUser.CDFN - C.CDFN, CubeUser.CDFV = CubeUser.CDFV - C.CDFV, CubeUser.CDCN = CubeUser.CDCN - C.CDCN,
						CubeUser.CDCV = CubeUser.CDCV - C.CDCV, CubeUser.CDIN = CubeUser.CDIN - C.CDIN,	CubeUser.CDIV = CubeUser.CDIV - C.CDIV,
						CubeUser.CSFN = CubeUser.CSFN - C.CSFN, CubeUser.CSFV = CubeUser.CSFV - C.CSFV,	CubeUser.CSCN = CubeUser.CSCN - C.CSCN,
						CubeUser.CSCV = CubeUser.CSCV - C.CSCV,	CubeUser.CSIN = CubeUser.CSIN - C.CSIN, CubeUser.CSIV = CubeUser.CSIV - C.CSIV, 
						CubeUser.PDFN = CubeUser.PDFN - C.PDFN, CubeUser.PDFV = CubeUser.PDFV - C.PDFV, CubeUser.PDCN = CubeUser.PDCN - C.PDCN, 
						CubeUser.PDCV = CubeUser.PDCV - C.PDCV, CubeUser.PDIN = CubeUser.PDIN - C.PDIN,	CubeUser.PDIV = CubeUser.PDIV - C.PDIV,
						CubeUser.PSFN = CubeUser.PSFN - C.PSFN, CubeUser.PSFV = CubeUser.PSFV - C.PSFV,	CubeUser.PSCN = CubeUser.PSCN - C.PSCN, 
						CubeUser.PSCV = CubeUser.PSCV - C.PSCV,	CubeUser.PSIN = CubeUser.PSIN - C.PSIN, CubeUser.PSIV = CubeUser.PSIV - C.PSIV,
						CubeUser.TotJobs = CubeUser.TotJobs - C.TotJobs,
						CubeUser.SN = CubeUser.SN - C.SN, CubeUser.SV = CubeUser.SV - C.SV,
						CubeUser.EN = CubeUser.EN - C.EN, CubeUser.EV = CubeUser.EV - C.EV
					FROM @User C
					WHERE	CubeUser.Data = C.Data AND CubeUser.AccountID = C.AccountID AND CubeUser.CostAccountID = C.CostAccountID AND 
							CubeUser.SiteID = C.SiteID AND CubeUser.PrintApplicationID = C.PrintApplicationID AND 
							CubeUser.PaperSizeID = C.PaperSizeID AND CubeUser.JobOriginID = C.JobOriginID

				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END	

				PRINT 'DELETA DE CUBEPRINTER'
				UPDATE CubePrinter			
					SET CubePrinter.CDFN = CubePrinter.CDFN - C.CDFN, CubePrinter.CDFV = CubePrinter.CDFV - C.CDFV, CubePrinter.CDCN = CubePrinter.CDCN - C.CDCN,
						CubePrinter.CDCV = CubePrinter.CDCV - C.CDCV, CubePrinter.CDIN = CubePrinter.CDIN - C.CDIN,	CubePrinter.CDIV = CubePrinter.CDIV - C.CDIV,
						CubePrinter.CSFN = CubePrinter.CSFN - C.CSFN, CubePrinter.CSFV = CubePrinter.CSFV - C.CSFV,	CubePrinter.CSCN = CubePrinter.CSCN - C.CSCN,
						CubePrinter.CSCV = CubePrinter.CSCV - C.CSCV,	CubePrinter.CSIN = CubePrinter.CSIN - C.CSIN, CubePrinter.CSIV = CubePrinter.CSIV - C.CSIV, 
						CubePrinter.PDFN = CubePrinter.PDFN - C.PDFN, CubePrinter.PDFV = CubePrinter.PDFV - C.PDFV, CubePrinter.PDCN = CubePrinter.PDCN - C.PDCN, 
						CubePrinter.PDCV = CubePrinter.PDCV - C.PDCV, CubePrinter.PDIN = CubePrinter.PDIN - C.PDIN,	CubePrinter.PDIV = CubePrinter.PDIV - C.PDIV,
						CubePrinter.PSFN = CubePrinter.PSFN - C.PSFN, CubePrinter.PSFV = CubePrinter.PSFV - C.PSFV,	CubePrinter.PSCN = CubePrinter.PSCN - C.PSCN, 
						CubePrinter.PSCV = CubePrinter.PSCV - C.PSCV,	CubePrinter.PSIN = CubePrinter.PSIN - C.PSIN, CubePrinter.PSIV = CubePrinter.PSIV - C.PSIV,
						CubePrinter.TotJobs = CubePrinter.TotJobs - C.TotJobs,
						CubePrinter.SN = CubePrinter.SN - C.SN, CubePrinter.SV = CubePrinter.SV - C.SV,
						CubePrinter.EN = CubePrinter.EN - C.EN, CubePrinter.EV = CubePrinter.EV - C.EV
					FROM @Printer C
					WHERE	CubePrinter.Data = C.Data AND CubePrinter.PrinterDeviceID = C.PrinterDeviceID AND 
							CubePrinter.CostAccountID = C.CostAccountID AND CubePrinter.SiteID = C.SiteID AND	
							CubePrinter.PrintApplicationID = C.PrintApplicationID AND CubePrinter.PaperSizeID = C.PaperSizeID AND
							CubePrinter.JobOriginID = C.JobOriginID
				
				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END	

				PRINT 'DELETA DE CUBEQUEUE'
				UPDATE CubeQueue			
					SET CubeQueue.CDFN = CubeQueue.CDFN - C.CDFN, CubeQueue.CDFV = CubeQueue.CDFV - C.CDFV, CubeQueue.CDCN = CubeQueue.CDCN - C.CDCN,
						CubeQueue.CDCV = CubeQueue.CDCV - C.CDCV, CubeQueue.CDIN = CubeQueue.CDIN - C.CDIN,	CubeQueue.CDIV = CubeQueue.CDIV - C.CDIV,
						CubeQueue.CSFN = CubeQueue.CSFN - C.CSFN, CubeQueue.CSFV = CubeQueue.CSFV - C.CSFV,	CubeQueue.CSCN = CubeQueue.CSCN - C.CSCN,
						CubeQueue.CSCV = CubeQueue.CSCV - C.CSCV, CubeQueue.CSIN = CubeQueue.CSIN - C.CSIN, CubeQueue.CSIV = CubeQueue.CSIV - C.CSIV, 
						CubeQueue.PDFN = CubeQueue.PDFN - C.PDFN, CubeQueue.PDFV = CubeQueue.PDFV - C.PDFV, CubeQueue.PDCN = CubeQueue.PDCN - C.PDCN, 
						CubeQueue.PDCV = CubeQueue.PDCV - C.PDCV, CubeQueue.PDIN = CubeQueue.PDIN - C.PDIN,	CubeQueue.PDIV = CubeQueue.PDIV - C.PDIV,
						CubeQueue.PSFN = CubeQueue.PSFN - C.PSFN, CubeQueue.PSFV = CubeQueue.PSFV - C.PSFV,	CubeQueue.PSCN = CubeQueue.PSCN - C.PSCN, 
						CubeQueue.PSCV = CubeQueue.PSCV - C.PSCV, CubeQueue.PSIN = CubeQueue.PSIN - C.PSIN, CubeQueue.PSIV = CubeQueue.PSIV - C.PSIV,
						CubeQueue.TotJobs = CubeQueue.TotJobs - C.TotJobs,
						CubeQueue.SN = CubeQueue.SN - C.SN, CubeQueue.SV = CubeQueue.SV - C.SV,
						CubeQueue.EN = CubeQueue.EN - C.EN, CubeQueue.EV = CubeQueue.EV - C.EV
					FROM @Queue C
					WHERE	CubeQueue.Data = C.Data AND CubeQueue.PrinterQueueID = C.PrinterQueueID AND CubeQueue.CostAccountID = C.CostAccountID AND
							CubeQueue.SiteID = C.SiteID AND CubeQueue.PrintApplicationID = C.PrintApplicationID AND 
							CubeQueue.PaperSizeID = C.PaperSizeID AND CubeQueue.JobOriginID = C.JobOriginID				
				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END	

				PRINT 'DELETA DE CUBEMACHINE'
				UPDATE CubeMachine
					SET CubeMachine.CDFN = CubeMachine.CDFN - C.CDFN, CubeMachine.CDFV = CubeMachine.CDFV - C.CDFV, CubeMachine.CDCN = CubeMachine.CDCN - C.CDCN,
						CubeMachine.CDCV = CubeMachine.CDCV - C.CDCV, CubeMachine.CDIN = CubeMachine.CDIN - C.CDIN,	CubeMachine.CDIV = CubeMachine.CDIV - C.CDIV,
						CubeMachine.CSFN = CubeMachine.CSFN - C.CSFN, CubeMachine.CSFV = CubeMachine.CSFV - C.CSFV,	CubeMachine.CSCN = CubeMachine.CSCN - C.CSCN,
						CubeMachine.CSCV = CubeMachine.CSCV - C.CSCV, CubeMachine.CSIN = CubeMachine.CSIN - C.CSIN, CubeMachine.CSIV = CubeMachine.CSIV - C.CSIV, 
						CubeMachine.PDFN = CubeMachine.PDFN - C.PDFN, CubeMachine.PDFV = CubeMachine.PDFV - C.PDFV, CubeMachine.PDCN = CubeMachine.PDCN - C.PDCN, 
						CubeMachine.PDCV = CubeMachine.PDCV - C.PDCV, CubeMachine.PDIN = CubeMachine.PDIN - C.PDIN,	CubeMachine.PDIV = CubeMachine.PDIV - C.PDIV,
						CubeMachine.PSFN = CubeMachine.PSFN - C.PSFN, CubeMachine.PSFV = CubeMachine.PSFV - C.PSFV,	CubeMachine.PSCN = CubeMachine.PSCN - C.PSCN, 
						CubeMachine.PSCV = CubeMachine.PSCV - C.PSCV, CubeMachine.PSIN = CubeMachine.PSIN - C.PSIN, CubeMachine.PSIV = CubeMachine.PSIV - C.PSIV,
						CubeMachine.TotJobs = CubeMachine.TotJobs - C.TotJobs,
						CubeMachine.SN = CubeMachine.SN - C.SN, CubeMachine.SV = CubeMachine.SV - C.SV,
						CubeMachine.EN = CubeMachine.EN - C.EN, CubeMachine.EV = CubeMachine.EV - C.EV
					FROM @Machine C
					WHERE	CubeMachine.Data = C.Data AND CubeMachine.MachineID = C.MachineID AND CubeMachine.CostAccountID = C.CostAccountID AND 
							CubeMachine.SiteID = C.SiteID AND CubeMachine.PrintApplicationID = C.PrintApplicationID AND 
							CubeMachine.PaperSizeID = C.PaperSizeID AND CubeMachine.JobOriginID = C.JobOriginID
				
				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END	

				PRINT 'DELETA DE CUBECOSTACCOUNT'
				UPDATE CubeCostAccount
					SET CubeCostAccount.CDFN = CubeCostAccount.CDFN - C.CDFN, CubeCostAccount.CDFV = CubeCostAccount.CDFV - C.CDFV, CubeCostAccount.CDCN = CubeCostAccount.CDCN - C.CDCN,
						CubeCostAccount.CDCV = CubeCostAccount.CDCV - C.CDCV, CubeCostAccount.CDIN = CubeCostAccount.CDIN - C.CDIN,	CubeCostAccount.CDIV = CubeCostAccount.CDIV - C.CDIV,
						CubeCostAccount.CSFN = CubeCostAccount.CSFN - C.CSFN, CubeCostAccount.CSFV = CubeCostAccount.CSFV - C.CSFV,	CubeCostAccount.CSCN = CubeCostAccount.CSCN - C.CSCN,
						CubeCostAccount.CSCV = CubeCostAccount.CSCV - C.CSCV,	CubeCostAccount.CSIN = CubeCostAccount.CSIN - C.CSIN, CubeCostAccount.CSIV = CubeCostAccount.CSIV - C.CSIV, 
						CubeCostAccount.PDFN = CubeCostAccount.PDFN - C.PDFN, CubeCostAccount.PDFV = CubeCostAccount.PDFV - C.PDFV, CubeCostAccount.PDCN = CubeCostAccount.PDCN - C.PDCN, 
						CubeCostAccount.PDCV = CubeCostAccount.PDCV - C.PDCV, CubeCostAccount.PDIN = CubeCostAccount.PDIN - C.PDIN,	CubeCostAccount.PDIV = CubeCostAccount.PDIV - C.PDIV,
						CubeCostAccount.PSFN = CubeCostAccount.PSFN - C.PSFN, CubeCostAccount.PSFV = CubeCostAccount.PSFV - C.PSFV,	CubeCostAccount.PSCN = CubeCostAccount.PSCN - C.PSCN, 
						CubeCostAccount.PSCV = CubeCostAccount.PSCV - C.PSCV,	CubeCostAccount.PSIN = CubeCostAccount.PSIN - C.PSIN, CubeCostAccount.PSIV = CubeCostAccount.PSIV - C.PSIV,
						CubeCostAccount.TotJobs = CubeCostAccount.TotJobs - C.TotJobs,
						CubeCostAccount.SN = CubeCostAccount.SN - C.SN, CubeCostAccount.SV = CubeCostAccount.SV - C.SV,
						CubeCostAccount.EN = CubeCostAccount.EN - C.EN, CubeCostAccount.EV = CubeCostAccount.EV - C.EV
					FROM @CostAccount C
					WHERE	CubeCostAccount.Data = C.Data AND CubeCostAccount.CostAccountID = C.CostAccountID AND CubeCostAccount.SiteID = C.SiteID AND
							CubeCostAccount.PrintApplicationID = C.PrintApplicationID AND CubeCostAccount.PaperSizeID = C.PaperSizeID AND
							CubeCostAccount.JobOriginID = C.JobOriginID
				
				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END					

				PRINT 'DELETA DE CUBEANALIZE'
				UPDATE CubeAnalyze
					SET CubeAnalyze.A4 = CubeAnalyze.A4- C.A4, CubeAnalyze.NA4 = CubeAnalyze.NA4  - C.NA4, CubeAnalyze.InTime = CubeAnalyze.InTime  - C.InTime, CubeAnalyze.OutTime = CubeAnalyze.OutTime - C.OutTime, 
						CubeAnalyze.[Local] = CubeAnalyze.[Local] - C.[Local], CubeAnalyze.Net = CubeAnalyze.Net - C.Net
					FROM @Analyze C
					WHERE CubeAnalyze.Data = C.Data AND CubeAnalyze.AccountID = C.AccountID AND CubeAnalyze.CostAccountID = C.CostAccountID 
				
				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END	

				-- Atualiza os valores correspondentes nos cubos de sumarização ampla (chave específica)			

				PRINT 'DELETA DE CUBEUSERACCOUNT'
				UPDATE CubeUserAccount			
					SET CubeUserAccount.CDFN = CubeUserAccount.CDFN - C.CDFN, CubeUserAccount.CDFV = CubeUserAccount.CDFV - C.CDFV, CubeUserAccount.CDCN = CubeUserAccount.CDCN - C.CDCN,
						CubeUserAccount.CDCV = CubeUserAccount.CDCV - C.CDCV, CubeUserAccount.CDIN = CubeUserAccount.CDIN - C.CDIN,	CubeUserAccount.CDIV = CubeUserAccount.CDIV - C.CDIV,
						CubeUserAccount.CSFN = CubeUserAccount.CSFN - C.CSFN, CubeUserAccount.CSFV = CubeUserAccount.CSFV - C.CSFV,	CubeUserAccount.CSCN = CubeUserAccount.CSCN - C.CSCN,
						CubeUserAccount.CSCV = CubeUserAccount.CSCV - C.CSCV, CubeUserAccount.CSIN = CubeUserAccount.CSIN - C.CSIN, CubeUserAccount.CSIV = CubeUserAccount.CSIV - C.CSIV, 
						CubeUserAccount.PDFN = CubeUserAccount.PDFN - C.PDFN, CubeUserAccount.PDFV = CubeUserAccount.PDFV - C.PDFV, CubeUserAccount.PDCN = CubeUserAccount.PDCN - C.PDCN, 
						CubeUserAccount.PDCV = CubeUserAccount.PDCV - C.PDCV, CubeUserAccount.PDIN = CubeUserAccount.PDIN - C.PDIN,	CubeUserAccount.PDIV = CubeUserAccount.PDIV - C.PDIV,
						CubeUserAccount.PSFN = CubeUserAccount.PSFN - C.PSFN, CubeUserAccount.PSFV = CubeUserAccount.PSFV - C.PSFV,	CubeUserAccount.PSCN = CubeUserAccount.PSCN - C.PSCN, 
						CubeUserAccount.PSCV = CubeUserAccount.PSCV - C.PSCV, CubeUserAccount.PSIN = CubeUserAccount.PSIN - C.PSIN, CubeUserAccount.PSIV = CubeUserAccount.PSIV - C.PSIV,
						CubeUserAccount.TotJobs = CubeUserAccount.TotJobs - C.TotJobs,
						CubeUserAccount.SN = CubeUserAccount.SN - C.SN, CubeUserAccount.SV = CubeUserAccount.SV - C.SV,
						CubeUserAccount.EN = CubeUserAccount.EN - C.EN, CubeUserAccount.EV = CubeUserAccount.EV - C.EV
					FROM (SELECT	Data, AccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV
							FROM @User 
							GROUP BY Data, AccountID) AS C
					WHERE CubeUserAccount.Data = C.Data AND CubeUserAccount.AccountID = C.AccountID 

				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END	

				PRINT 'DELETA DE CUBEPRINTERDEVICE'
				UPDATE CubePrinterDevice			
					SET CubePrinterDevice.CDFN = CubePrinterDevice.CDFN - C.CDFN, CubePrinterDevice.CDFV = CubePrinterDevice.CDFV - C.CDFV, CubePrinterDevice.CDCN = CubePrinterDevice.CDCN - C.CDCN,
						CubePrinterDevice.CDCV = CubePrinterDevice.CDCV - C.CDCV, CubePrinterDevice.CDIN = CubePrinterDevice.CDIN - C.CDIN,	CubePrinterDevice.CDIV = CubePrinterDevice.CDIV - C.CDIV,
						CubePrinterDevice.CSFN = CubePrinterDevice.CSFN - C.CSFN, CubePrinterDevice.CSFV = CubePrinterDevice.CSFV - C.CSFV,	CubePrinterDevice.CSCN = CubePrinterDevice.CSCN - C.CSCN,
						CubePrinterDevice.CSCV = CubePrinterDevice.CSCV - C.CSCV, CubePrinterDevice.CSIN = CubePrinterDevice.CSIN - C.CSIN, CubePrinterDevice.CSIV = CubePrinterDevice.CSIV - C.CSIV, 
						CubePrinterDevice.PDFN = CubePrinterDevice.PDFN - C.PDFN, CubePrinterDevice.PDFV = CubePrinterDevice.PDFV - C.PDFV, CubePrinterDevice.PDCN = CubePrinterDevice.PDCN - C.PDCN, 
						CubePrinterDevice.PDCV = CubePrinterDevice.PDCV - C.PDCV, CubePrinterDevice.PDIN = CubePrinterDevice.PDIN - C.PDIN,	CubePrinterDevice.PDIV = CubePrinterDevice.PDIV - C.PDIV,
						CubePrinterDevice.PSFN = CubePrinterDevice.PSFN - C.PSFN, CubePrinterDevice.PSFV = CubePrinterDevice.PSFV - C.PSFV,	CubePrinterDevice.PSCN = CubePrinterDevice.PSCN - C.PSCN, 
						CubePrinterDevice.PSCV = CubePrinterDevice.PSCV - C.PSCV, CubePrinterDevice.PSIN = CubePrinterDevice.PSIN - C.PSIN, CubePrinterDevice.PSIV = CubePrinterDevice.PSIV - C.PSIV,
						CubePrinterDevice.TotJobs = CubePrinterDevice.TotJobs - C.TotJobs,
						CubePrinterDevice.SN = CubePrinterDevice.SN - C.SN, CubePrinterDevice.SV = CubePrinterDevice.SV - C.SV,
						CubePrinterDevice.EN = CubePrinterDevice.EN - C.EN, CubePrinterDevice.EV = CubePrinterDevice.EV - C.EV
					FROM (SELECT	Data, PrinterDeviceID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV
							FROM @Printer 
							GROUP BY Data, PrinterDeviceID) AS C
					WHERE	CubePrinterDevice.Data = C.Data AND CubePrinterDevice.PrinterDeviceID = C.PrinterDeviceID 
				
				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END	

				PRINT 'DELETA DE CUBEQUEUEPRINTER'
				UPDATE CubeQueuePrinter			
					SET CubeQueuePrinter.CDFN = CubeQueuePrinter.CDFN - C.CDFN, CubeQueuePrinter.CDFV = CubeQueuePrinter.CDFV - C.CDFV, CubeQueuePrinter.CDCN = CubeQueuePrinter.CDCN - C.CDCN,
						CubeQueuePrinter.CDCV = CubeQueuePrinter.CDCV - C.CDCV, CubeQueuePrinter.CDIN = CubeQueuePrinter.CDIN - C.CDIN,	CubeQueuePrinter.CDIV = CubeQueuePrinter.CDIV - C.CDIV,
						CubeQueuePrinter.CSFN = CubeQueuePrinter.CSFN - C.CSFN, CubeQueuePrinter.CSFV = CubeQueuePrinter.CSFV - C.CSFV,	CubeQueuePrinter.CSCN = CubeQueuePrinter.CSCN - C.CSCN,
						CubeQueuePrinter.CSCV = CubeQueuePrinter.CSCV - C.CSCV, CubeQueuePrinter.CSIN = CubeQueuePrinter.CSIN - C.CSIN, CubeQueuePrinter.CSIV = CubeQueuePrinter.CSIV - C.CSIV, 
						CubeQueuePrinter.PDFN = CubeQueuePrinter.PDFN - C.PDFN, CubeQueuePrinter.PDFV = CubeQueuePrinter.PDFV - C.PDFV, CubeQueuePrinter.PDCN = CubeQueuePrinter.PDCN - C.PDCN, 
						CubeQueuePrinter.PDCV = CubeQueuePrinter.PDCV - C.PDCV, CubeQueuePrinter.PDIN = CubeQueuePrinter.PDIN - C.PDIN,	CubeQueuePrinter.PDIV = CubeQueuePrinter.PDIV - C.PDIV,
						CubeQueuePrinter.PSFN = CubeQueuePrinter.PSFN - C.PSFN, CubeQueuePrinter.PSFV = CubeQueuePrinter.PSFV - C.PSFV,	CubeQueuePrinter.PSCN = CubeQueuePrinter.PSCN - C.PSCN, 
						CubeQueuePrinter.PSCV = CubeQueuePrinter.PSCV - C.PSCV, CubeQueuePrinter.PSIN = CubeQueuePrinter.PSIN - C.PSIN, CubeQueuePrinter.PSIV = CubeQueuePrinter.PSIV - C.PSIV,
						CubeQueuePrinter.TotJobs = CubeQueuePrinter.TotJobs - C.TotJobs,
						CubeQueuePrinter.SN = CubeQueuePrinter.SN - C.SN, CubeQueuePrinter.SV = CubeQueuePrinter.SV - C.SV,
						CubeQueuePrinter.EN = CubeQueuePrinter.EN - C.EN, CubeQueuePrinter.EV = CubeQueuePrinter.EV - C.EV
					FROM ( SELECT	Data, PrinterQueueID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV
								FROM @Queue 
								GROUP BY Data, PrinterQueueID) AS C
					WHERE	CubeQueuePrinter.Data = C.Data AND CubeQueuePrinter.PrinterQueueID = C.PrinterQueueID
				
				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END	

				PRINT 'DELETA DE CUBEMACHINEID'	
				UPDATE CubeMachineID
					SET CubeMachineID.CDFN = CubeMachineID.CDFN - C.CDFN, CubeMachineID.CDFV = CubeMachineID.CDFV - C.CDFV, CubeMachineID.CDCN = CubeMachineID.CDCN - C.CDCN,
						CubeMachineID.CDCV = CubeMachineID.CDCV - C.CDCV, CubeMachineID.CDIN = CubeMachineID.CDIN - C.CDIN,	CubeMachineID.CDIV = CubeMachineID.CDIV - C.CDIV,
						CubeMachineID.CSFN = CubeMachineID.CSFN - C.CSFN, CubeMachineID.CSFV = CubeMachineID.CSFV - C.CSFV,	CubeMachineID.CSCN = CubeMachineID.CSCN - C.CSCN,
						CubeMachineID.CSCV = CubeMachineID.CSCV - C.CSCV, CubeMachineID.CSIN = CubeMachineID.CSIN - C.CSIN, CubeMachineID.CSIV = CubeMachineID.CSIV - C.CSIV, 
						CubeMachineID.PDFN = CubeMachineID.PDFN - C.PDFN, CubeMachineID.PDFV = CubeMachineID.PDFV - C.PDFV, CubeMachineID.PDCN = CubeMachineID.PDCN - C.PDCN, 
						CubeMachineID.PDCV = CubeMachineID.PDCV - C.PDCV, CubeMachineID.PDIN = CubeMachineID.PDIN - C.PDIN,	CubeMachineID.PDIV = CubeMachineID.PDIV - C.PDIV,
						CubeMachineID.PSFN = CubeMachineID.PSFN - C.PSFN, CubeMachineID.PSFV = CubeMachineID.PSFV - C.PSFV,	CubeMachineID.PSCN = CubeMachineID.PSCN - C.PSCN, 
						CubeMachineID.PSCV = CubeMachineID.PSCV - C.PSCV, CubeMachineID.PSIN = CubeMachineID.PSIN - C.PSIN, CubeMachineID.PSIV = CubeMachineID.PSIV - C.PSIV,
						CubeMachineID.TotJobs = CubeMachineID.TotJobs - C.TotJobs,
						CubeMachineID.SN = CubeMachineID.SN - C.SN, CubeMachineID.SV = CubeMachineID.SV - C.SV,
						CubeMachineID.EN = CubeMachineID.EN - C.EN, CubeMachineID.EV = CubeMachineID.EV - C.EV
					FROM ( SELECT	Data, MachineID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV,
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN,
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV,
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN,
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV
								FROM @Machine 
								GROUP BY Data, MachineID) AS C
					WHERE	CubeMachineID.Data = C.Data AND CubeMachineID.MachineID = C.MachineID
				
				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END	

				PRINT 'DELETA DE CUBECOSTACCOUNTID'
				UPDATE CubeCostAccountID
					SET CubeCostAccountID.CDFN = CubeCostAccountID.CDFN - C.CDFN, CubeCostAccountID.CDFV = CubeCostAccountID.CDFV - C.CDFV, CubeCostAccountID.CDCN = CubeCostAccountID.CDCN - C.CDCN,
						CubeCostAccountID.CDCV = CubeCostAccountID.CDCV - C.CDCV, CubeCostAccountID.CDIN = CubeCostAccountID.CDIN - C.CDIN,	CubeCostAccountID.CDIV = CubeCostAccountID.CDIV - C.CDIV,
						CubeCostAccountID.CSFN = CubeCostAccountID.CSFN - C.CSFN, CubeCostAccountID.CSFV = CubeCostAccountID.CSFV - C.CSFV,	CubeCostAccountID.CSCN = CubeCostAccountID.CSCN - C.CSCN,
						CubeCostAccountID.CSCV = CubeCostAccountID.CSCV - C.CSCV,	CubeCostAccountID.CSIN = CubeCostAccountID.CSIN - C.CSIN, CubeCostAccountID.CSIV = CubeCostAccountID.CSIV - C.CSIV, 
						CubeCostAccountID.PDFN = CubeCostAccountID.PDFN - C.PDFN, CubeCostAccountID.PDFV = CubeCostAccountID.PDFV - C.PDFV, CubeCostAccountID.PDCN = CubeCostAccountID.PDCN - C.PDCN, 
						CubeCostAccountID.PDCV = CubeCostAccountID.PDCV - C.PDCV, CubeCostAccountID.PDIN = CubeCostAccountID.PDIN - C.PDIN,	CubeCostAccountID.PDIV = CubeCostAccountID.PDIV - C.PDIV,
						CubeCostAccountID.PSFN = CubeCostAccountID.PSFN - C.PSFN, CubeCostAccountID.PSFV = CubeCostAccountID.PSFV - C.PSFV,	CubeCostAccountID.PSCN = CubeCostAccountID.PSCN - C.PSCN, 
						CubeCostAccountID.PSCV = CubeCostAccountID.PSCV - C.PSCV,	CubeCostAccountID.PSIN = CubeCostAccountID.PSIN - C.PSIN, CubeCostAccountID.PSIV = CubeCostAccountID.PSIV - C.PSIV,
						CubeCostAccountID.TotJobs = CubeCostAccountID.TotJobs - C.TotJobs,
						CubeCostAccountID.SN = CubeCostAccountID.SN - C.SN, CubeCostAccountID.SV = CubeCostAccountID.SV - C.SV,
						CubeCostAccountID.EN = CubeCostAccountID.EN - C.EN, CubeCostAccountID.EV = CubeCostAccountID.EV - C.EV
					FROM ( SELECT	Data, CostAccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV,
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV
								FROM @CostAccount 
								GROUP BY Data, CostAccountID) AS C
					WHERE	CubeCostAccountID.Data = C.Data AND CubeCostAccountID.CostAccountID = C.CostAccountID

				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END					

				-- Atualiza os valores correspondentes nos cubos Week/MONTH

				PRINT 'DELETA DE CUBEUSERACCOUNTWEEK'
				UPDATE CubeUserAccountWeek			
					SET CubeUserAccountWeek.CDFN = CubeUserAccountWeek.CDFN - C.CDFN, CubeUserAccountWeek.CDFV = CubeUserAccountWeek.CDFV - C.CDFV, CubeUserAccountWeek.CDCN = CubeUserAccountWeek.CDCN - C.CDCN,
						CubeUserAccountWeek.CDCV = CubeUserAccountWeek.CDCV - C.CDCV, CubeUserAccountWeek.CDIN = CubeUserAccountWeek.CDIN - C.CDIN,	CubeUserAccountWeek.CDIV = CubeUserAccountWeek.CDIV - C.CDIV,
						CubeUserAccountWeek.CSFN = CubeUserAccountWeek.CSFN - C.CSFN, CubeUserAccountWeek.CSFV = CubeUserAccountWeek.CSFV - C.CSFV,	CubeUserAccountWeek.CSCN = CubeUserAccountWeek.CSCN - C.CSCN,
						CubeUserAccountWeek.CSCV = CubeUserAccountWeek.CSCV - C.CSCV, CubeUserAccountWeek.CSIN = CubeUserAccountWeek.CSIN - C.CSIN, CubeUserAccountWeek.CSIV = CubeUserAccountWeek.CSIV - C.CSIV, 
						CubeUserAccountWeek.PDFN = CubeUserAccountWeek.PDFN - C.PDFN, CubeUserAccountWeek.PDFV = CubeUserAccountWeek.PDFV - C.PDFV, CubeUserAccountWeek.PDCN = CubeUserAccountWeek.PDCN - C.PDCN, 
						CubeUserAccountWeek.PDCV = CubeUserAccountWeek.PDCV - C.PDCV, CubeUserAccountWeek.PDIN = CubeUserAccountWeek.PDIN - C.PDIN,	CubeUserAccountWeek.PDIV = CubeUserAccountWeek.PDIV - C.PDIV,
						CubeUserAccountWeek.PSFN = CubeUserAccountWeek.PSFN - C.PSFN, CubeUserAccountWeek.PSFV = CubeUserAccountWeek.PSFV - C.PSFV,	CubeUserAccountWeek.PSCN = CubeUserAccountWeek.PSCN - C.PSCN, 
						CubeUserAccountWeek.PSCV = CubeUserAccountWeek.PSCV - C.PSCV, CubeUserAccountWeek.PSIN = CubeUserAccountWeek.PSIN - C.PSIN, CubeUserAccountWeek.PSIV = CubeUserAccountWeek.PSIV - C.PSIV,
						CubeUserAccountWeek.TotJobs = CubeUserAccountWeek.TotJobs - C.TotJobs,
						CubeUserAccountWeek.SN = CubeUserAccountWeek.SN - C.SN, CubeUserAccountWeek.SV = CubeUserAccountWeek.SV - C.SV,
						CubeUserAccountWeek.EN = CubeUserAccountWeek.EN - C.EN, CubeUserAccountWeek.EV = CubeUserAccountWeek.EV - C.EV
					FROM (SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, AccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, AccountID, SUM (CDFN) AS CDFN, SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 
											CASE WHEN DAY(Data) < 8 THEN 1 
												 WHEN DAY(Data) < 15 AND DAY(Data) > 7 THEN 8
												 WHEN DAY(Data) < 22 AND DAY(Data) > 14 THEN 15
												 WHEN DAY(Data) > 21 THEN 22 END AS dia
										FROM @User 
										GROUP BY Data, AccountID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , AccountID
				UNION ALL
						SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, AccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, AccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 28 AS dia
										FROM @User 
										GROUP BY Data, AccountID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , AccountID) AS C
					WHERE CubeUserAccountWeek.yearw = C.Ano  AND  
						CubeUserAccountWeek.monthw = C.Mes AND 
						CubeUserAccountWeek.dayw = C.Dia  AND
						CubeUserAccountWeek.AccountID = C.AccountID 

				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END	

				PRINT 'DELETA DE CUBEPRINTERDEVICEWEEK'
				UPDATE CubePrinterDeviceWeek			
					SET CubePrinterDeviceWeek.CDFN = CubePrinterDeviceWeek.CDFN - C.CDFN, CubePrinterDeviceWeek.CDFV = CubePrinterDeviceWeek.CDFV - C.CDFV, CubePrinterDeviceWeek.CDCN = CubePrinterDeviceWeek.CDCN - C.CDCN,
						CubePrinterDeviceWeek.CDCV = CubePrinterDeviceWeek.CDCV - C.CDCV, CubePrinterDeviceWeek.CDIN = CubePrinterDeviceWeek.CDIN - C.CDIN,	CubePrinterDeviceWeek.CDIV = CubePrinterDeviceWeek.CDIV - C.CDIV,
						CubePrinterDeviceWeek.CSFN = CubePrinterDeviceWeek.CSFN - C.CSFN, CubePrinterDeviceWeek.CSFV = CubePrinterDeviceWeek.CSFV - C.CSFV,	CubePrinterDeviceWeek.CSCN = CubePrinterDeviceWeek.CSCN - C.CSCN,
						CubePrinterDeviceWeek.CSCV = CubePrinterDeviceWeek.CSCV - C.CSCV, CubePrinterDeviceWeek.CSIN = CubePrinterDeviceWeek.CSIN - C.CSIN, CubePrinterDeviceWeek.CSIV = CubePrinterDeviceWeek.CSIV - C.CSIV, 
						CubePrinterDeviceWeek.PDFN = CubePrinterDeviceWeek.PDFN - C.PDFN, CubePrinterDeviceWeek.PDFV = CubePrinterDeviceWeek.PDFV - C.PDFV, CubePrinterDeviceWeek.PDCN = CubePrinterDeviceWeek.PDCN - C.PDCN, 
						CubePrinterDeviceWeek.PDCV = CubePrinterDeviceWeek.PDCV - C.PDCV, CubePrinterDeviceWeek.PDIN = CubePrinterDeviceWeek.PDIN - C.PDIN,	CubePrinterDeviceWeek.PDIV = CubePrinterDeviceWeek.PDIV - C.PDIV,
						CubePrinterDeviceWeek.PSFN = CubePrinterDeviceWeek.PSFN - C.PSFN, CubePrinterDeviceWeek.PSFV = CubePrinterDeviceWeek.PSFV - C.PSFV,	CubePrinterDeviceWeek.PSCN = CubePrinterDeviceWeek.PSCN - C.PSCN, 
						CubePrinterDeviceWeek.PSCV = CubePrinterDeviceWeek.PSCV - C.PSCV, CubePrinterDeviceWeek.PSIN = CubePrinterDeviceWeek.PSIN - C.PSIN, CubePrinterDeviceWeek.PSIV = CubePrinterDeviceWeek.PSIV - C.PSIV,
						CubePrinterDeviceWeek.TotJobs = CubePrinterDeviceWeek.TotJobs - C.TotJobs,
						CubePrinterDeviceWeek.SN = CubePrinterDeviceWeek.SN - C.SN, CubePrinterDeviceWeek.SV = CubePrinterDeviceWeek.SV - C.SV,
						CubePrinterDeviceWeek.EN = CubePrinterDeviceWeek.EN - C.EN, CubePrinterDeviceWeek.EV = CubePrinterDeviceWeek.EV - C.EV
					FROM (SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, PrinterDeviceID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, PrinterDeviceID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 
											CASE WHEN DAY(Data) < 8 THEN 1 
												 WHEN DAY(Data) < 15 AND DAY(Data) > 7 THEN 8
												 WHEN DAY(Data) < 22 AND DAY(Data) > 14 THEN 15
												 WHEN DAY(Data) > 21 THEN 22 END AS dia
										FROM @Printer
										GROUP BY Data, PrinterDeviceID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , PrinterDeviceID
				UNION ALL
						SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, PrinterDeviceID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, PrinterDeviceID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 28 AS dia
										FROM @Printer
										GROUP BY Data, PrinterDeviceID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , PrinterDeviceID) AS C
					WHERE	CubePrinterDeviceWeek.yearw = C.Ano  AND  
							CubePrinterDeviceWeek.monthw = C.Mes AND 
							CubePrinterDeviceWeek.dayw = C.Dia  AND
							CubePrinterDeviceWeek.PrinterDeviceID = C.PrinterDeviceID 
				
				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END	

				PRINT 'DELETA DE CUBEQUEUEPRINTERWEEK'
				UPDATE CubeQueuePrinterWeek			
					SET CubeQueuePrinterWeek.CDFN = CubeQueuePrinterWeek.CDFN - C.CDFN, CubeQueuePrinterWeek.CDFV = CubeQueuePrinterWeek.CDFV - C.CDFV, CubeQueuePrinterWeek.CDCN = CubeQueuePrinterWeek.CDCN - C.CDCN,
						CubeQueuePrinterWeek.CDCV = CubeQueuePrinterWeek.CDCV - C.CDCV, CubeQueuePrinterWeek.CDIN = CubeQueuePrinterWeek.CDIN - C.CDIN,	CubeQueuePrinterWeek.CDIV = CubeQueuePrinterWeek.CDIV - C.CDIV,
						CubeQueuePrinterWeek.CSFN = CubeQueuePrinterWeek.CSFN - C.CSFN, CubeQueuePrinterWeek.CSFV = CubeQueuePrinterWeek.CSFV - C.CSFV,	CubeQueuePrinterWeek.CSCN = CubeQueuePrinterWeek.CSCN - C.CSCN,
						CubeQueuePrinterWeek.CSCV = CubeQueuePrinterWeek.CSCV - C.CSCV, CubeQueuePrinterWeek.CSIN = CubeQueuePrinterWeek.CSIN - C.CSIN, CubeQueuePrinterWeek.CSIV = CubeQueuePrinterWeek.CSIV - C.CSIV, 
						CubeQueuePrinterWeek.PDFN = CubeQueuePrinterWeek.PDFN - C.PDFN, CubeQueuePrinterWeek.PDFV = CubeQueuePrinterWeek.PDFV - C.PDFV, CubeQueuePrinterWeek.PDCN = CubeQueuePrinterWeek.PDCN - C.PDCN, 
						CubeQueuePrinterWeek.PDCV = CubeQueuePrinterWeek.PDCV - C.PDCV, CubeQueuePrinterWeek.PDIN = CubeQueuePrinterWeek.PDIN - C.PDIN,	CubeQueuePrinterWeek.PDIV = CubeQueuePrinterWeek.PDIV - C.PDIV,
						CubeQueuePrinterWeek.PSFN = CubeQueuePrinterWeek.PSFN - C.PSFN, CubeQueuePrinterWeek.PSFV = CubeQueuePrinterWeek.PSFV - C.PSFV,	CubeQueuePrinterWeek.PSCN = CubeQueuePrinterWeek.PSCN - C.PSCN, 
						CubeQueuePrinterWeek.PSCV = CubeQueuePrinterWeek.PSCV - C.PSCV, CubeQueuePrinterWeek.PSIN = CubeQueuePrinterWeek.PSIN - C.PSIN, CubeQueuePrinterWeek.PSIV = CubeQueuePrinterWeek.PSIV - C.PSIV,
						CubeQueuePrinterWeek.TotJobs = CubeQueuePrinterWeek.TotJobs - C.TotJobs,
						CubeQueuePrinterWeek.SN = CubeQueuePrinterWeek.SN - C.SN, CubeQueuePrinterWeek.SV = CubeQueuePrinterWeek.SV - C.SV,
						CubeQueuePrinterWeek.EN = CubeQueuePrinterWeek.EN - C.EN, CubeQueuePrinterWeek.EV = CubeQueuePrinterWeek.EV - C.EV
					FROM ( SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, PrinterQueueID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, PrinterQueueID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 
											CASE WHEN DAY(Data) < 8 THEN 1 
												 WHEN DAY(Data) < 15 AND DAY(Data) > 7 THEN 8
												 WHEN DAY(Data) < 22 AND DAY(Data) > 14 THEN 15
												 WHEN DAY(Data) > 21 THEN 22 END AS dia
										FROM @Queue
										GROUP BY Data, PrinterQueueID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , PrinterQueueID
				UNION ALL
						SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, PrinterQueueID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, PrinterQueueID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 28 AS dia
										FROM @Queue
										GROUP BY Data, PrinterQueueID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , PrinterQueueID) AS C
					WHERE	CubeQueuePrinterWeek.yearw = C.Ano  AND  
							CubeQueuePrinterWeek.monthw = C.Mes AND 
							CubeQueuePrinterWeek.dayw = C.Dia  AND
							CubeQueuePrinterWeek.PrinterQueueID = C.PrinterQueueID
				
				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END	

				PRINT 'DELETA DE CUBEMACHINEIDWEEK'
				UPDATE CubeMachineIDWeek
					SET CubeMachineIDWeek.CDFN = CubeMachineIDWeek.CDFN - C.CDFN, CubeMachineIDWeek.CDFV = CubeMachineIDWeek.CDFV - C.CDFV, CubeMachineIDWeek.CDCN = CubeMachineIDWeek.CDCN - C.CDCN,
						CubeMachineIDWeek.CDCV = CubeMachineIDWeek.CDCV - C.CDCV, CubeMachineIDWeek.CDIN = CubeMachineIDWeek.CDIN - C.CDIN,	CubeMachineIDWeek.CDIV = CubeMachineIDWeek.CDIV - C.CDIV,
						CubeMachineIDWeek.CSFN = CubeMachineIDWeek.CSFN - C.CSFN, CubeMachineIDWeek.CSFV = CubeMachineIDWeek.CSFV - C.CSFV,	CubeMachineIDWeek.CSCN = CubeMachineIDWeek.CSCN - C.CSCN,
						CubeMachineIDWeek.CSCV = CubeMachineIDWeek.CSCV - C.CSCV, CubeMachineIDWeek.CSIN = CubeMachineIDWeek.CSIN - C.CSIN, CubeMachineIDWeek.CSIV = CubeMachineIDWeek.CSIV - C.CSIV, 
						CubeMachineIDWeek.PDFN = CubeMachineIDWeek.PDFN - C.PDFN, CubeMachineIDWeek.PDFV = CubeMachineIDWeek.PDFV - C.PDFV, CubeMachineIDWeek.PDCN = CubeMachineIDWeek.PDCN - C.PDCN, 
						CubeMachineIDWeek.PDCV = CubeMachineIDWeek.PDCV - C.PDCV, CubeMachineIDWeek.PDIN = CubeMachineIDWeek.PDIN - C.PDIN,	CubeMachineIDWeek.PDIV = CubeMachineIDWeek.PDIV - C.PDIV,
						CubeMachineIDWeek.PSFN = CubeMachineIDWeek.PSFN - C.PSFN, CubeMachineIDWeek.PSFV = CubeMachineIDWeek.PSFV - C.PSFV,	CubeMachineIDWeek.PSCN = CubeMachineIDWeek.PSCN - C.PSCN, 
						CubeMachineIDWeek.PSCV = CubeMachineIDWeek.PSCV - C.PSCV, CubeMachineIDWeek.PSIN = CubeMachineIDWeek.PSIN - C.PSIN, CubeMachineIDWeek.PSIV = CubeMachineIDWeek.PSIV - C.PSIV,
						CubeMachineIDWeek.TotJobs = CubeMachineIDWeek.TotJobs - C.TotJobs,
						CubeMachineIDWeek.SN = CubeMachineIDWeek.SN - C.SN, CubeMachineIDWeek.SV = CubeMachineIDWeek.SV - C.SV,
						CubeMachineIDWeek.EN = CubeMachineIDWeek.EN - C.EN, CubeMachineIDWeek.EV = CubeMachineIDWeek.EV - C.EV
					FROM ( SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, MachineID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, MachineID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 
											CASE WHEN DAY(Data) < 8 THEN 1 
												 WHEN DAY(Data) < 15 AND DAY(Data) > 7 THEN 8
												 WHEN DAY(Data) < 22 AND DAY(Data) > 14 THEN 15
												 WHEN DAY(Data) > 21 THEN 22 END AS dia
										FROM @Machine
										GROUP BY Data, MachineID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , MachineID
				UNION ALL
						SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, MachineID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, MachineID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 28 AS dia
										FROM @Machine
										GROUP BY Data, MachineID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , MachineID) AS C
					WHERE	CubeMachineIDWeek.yearw = C.Ano  AND  
							CubeMachineIDWeek.monthw = C.Mes AND 
							CubeMachineIDWeek.dayw = C.Dia  AND
							CubeMachineIDWeek.MachineID = C.MachineID
				
				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
					ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END	

				PRINT 'DELETA DE CUBECOSTACCOUNTIDWEEK'
				UPDATE CubeCostAccountIDWeek
					SET CubeCostAccountIDWeek.CDFN = CubeCostAccountIDWeek.CDFN - C.CDFN, CubeCostAccountIDWeek.CDFV = CubeCostAccountIDWeek.CDFV - C.CDFV, CubeCostAccountIDWeek.CDCN = CubeCostAccountIDWeek.CDCN - C.CDCN,
						CubeCostAccountIDWeek.CDCV = CubeCostAccountIDWeek.CDCV - C.CDCV, CubeCostAccountIDWeek.CDIN = CubeCostAccountIDWeek.CDIN - C.CDIN,	CubeCostAccountIDWeek.CDIV = CubeCostAccountIDWeek.CDIV - C.CDIV,
						CubeCostAccountIDWeek.CSFN = CubeCostAccountIDWeek.CSFN - C.CSFN, CubeCostAccountIDWeek.CSFV = CubeCostAccountIDWeek.CSFV - C.CSFV,	CubeCostAccountIDWeek.CSCN = CubeCostAccountIDWeek.CSCN - C.CSCN,
						CubeCostAccountIDWeek.CSCV = CubeCostAccountIDWeek.CSCV - C.CSCV,	CubeCostAccountIDWeek.CSIN = CubeCostAccountIDWeek.CSIN - C.CSIN, CubeCostAccountIDWeek.CSIV = CubeCostAccountIDWeek.CSIV - C.CSIV, 
						CubeCostAccountIDWeek.PDFN = CubeCostAccountIDWeek.PDFN - C.PDFN, CubeCostAccountIDWeek.PDFV = CubeCostAccountIDWeek.PDFV - C.PDFV, CubeCostAccountIDWeek.PDCN = CubeCostAccountIDWeek.PDCN - C.PDCN, 
						CubeCostAccountIDWeek.PDCV = CubeCostAccountIDWeek.PDCV - C.PDCV, CubeCostAccountIDWeek.PDIN = CubeCostAccountIDWeek.PDIN - C.PDIN,	CubeCostAccountIDWeek.PDIV = CubeCostAccountIDWeek.PDIV - C.PDIV,
						CubeCostAccountIDWeek.PSFN = CubeCostAccountIDWeek.PSFN - C.PSFN, CubeCostAccountIDWeek.PSFV = CubeCostAccountIDWeek.PSFV - C.PSFV,	CubeCostAccountIDWeek.PSCN = CubeCostAccountIDWeek.PSCN - C.PSCN, 
						CubeCostAccountIDWeek.PSCV = CubeCostAccountIDWeek.PSCV - C.PSCV,	CubeCostAccountIDWeek.PSIN = CubeCostAccountIDWeek.PSIN - C.PSIN, CubeCostAccountIDWeek.PSIV = CubeCostAccountIDWeek.PSIV - C.PSIV,
						CubeCostAccountIDWeek.TotJobs = CubeCostAccountIDWeek.TotJobs - C.TotJobs,
						CubeCostAccountIDWeek.SN = CubeCostAccountIDWeek.SN - C.SN, CubeCostAccountIDWeek.SV = CubeCostAccountIDWeek.SV - C.SV,
						CubeCostAccountIDWeek.EN = CubeCostAccountIDWeek.EN - C.EN, CubeCostAccountIDWeek.EV = CubeCostAccountIDWeek.EV - C.EV
					FROM ( SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, CostAccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, CostAccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 
											CASE WHEN DAY(Data) < 8 THEN 1 
												 WHEN DAY(Data) < 15 AND DAY(Data) > 7 THEN 8
												 WHEN DAY(Data) < 22 AND DAY(Data) > 14 THEN 15
												 WHEN DAY(Data) > 21 THEN 22 END AS dia
										FROM @CostAccount
										GROUP BY Data, CostAccountID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , CostAccountID
				UNION ALL
						SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, CostAccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, CostAccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 28 AS dia
										FROM @CostAccount
										GROUP BY Data, CostAccountID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , CostAccountID) AS C
					WHERE   CubeCostAccountIDWeek.yearw = C.Ano  AND  
							CubeCostAccountIDWeek.monthw = C.Mes AND 
							CubeCostAccountIDWeek.dayw = C.Dia  AND
							CubeCostAccountIDWeek.CostAccountID = C.CostAccountID

				IF(@@Error <> 0) --OR @@RowCount = 0) caso não tenha o valor do cubo não da erro dai
				BEGIN
						ROLLBACK
					RAISERROR('Erro ao atualizar Cubos!', 16, 1)
					RETURN
				END		


	-- Recarrega os Cubos com os novos valores
		DELETE FROM	@temp
		IF(@@Error <> 0 )
		BEGIN
			RAISERROR('Erro ao preparar cubos!', 16, 1)
			RETURN
		END		
		DELETE FROM	@Core 
		IF(@@Error <> 0 )
		BEGIN
			RAISERROR('Erro ao preparar cubos!', 16, 1)
			RETURN
		END		
		DELETE FROM	@User 
		IF(@@Error <> 0 )
		BEGIN
			RAISERROR('Erro ao preparar cubos!', 16, 1)
			RETURN
		END		
		DELETE FROM	@Printer 
		IF(@@Error <> 0 )
		BEGIN
			RAISERROR('Erro ao preparar cubos!', 16, 1)
			RETURN
		END		
		DELETE FROM	@Queue 
		IF(@@Error <> 0 )
		BEGIN
			RAISERROR('Erro ao preparar cubos!', 16, 1)
			RETURN
		END		
		DELETE FROM	@Machine 
		IF(@@Error <> 0 )
		BEGIN
			RAISERROR('Erro ao preparar cubos!', 16, 1)
			RETURN
		END		
		DELETE FROM	@CostAccount
		IF(@@Error <> 0 )
		BEGIN
			RAISERROR('Erro ao preparar cubos!', 16, 1)
			RETURN
		END		
		DELETE FROM	@Analyze
		IF(@@Error <> 0 )
		BEGIN
			RAISERROR('Erro ao preparar cubos!', 16, 1)
			RETURN
		END		
			

	INSERT INTO @TempCube	

		SELECT PrintQualityID, PrinterQueueID, PrinterDeviceID,AccountID, PaperSizeID, JobOriginID, 
				PrintApplicationID, PrintWayID, SUM(PagesColor) AS PagesColor, SUM(PagesMono) AS PagesMono, 
			SUM(CostColor) AS CostColor, SUM(CostMono) AS CostMono, CostAccountID, SiteID, MachineID, DataZero, JobTypeID, OutTime, COUNT (*) AS TotalJobs FROM
		(

		SELECT	
			PrintQualityID,
			ISNULL(PrinterQueueID,-1) AS PrinterQueueID,
			J.PrinterDeviceID, 
			AccountID, 
			PaperSizeID, 
			JobOriginID, 
			PrintApplicationID, 
			PrintWayID, 
			PagesColor, 
			PagesMono, 
			CostColor, 
			CostMono,
			CASE WHEN CostAccountID IS NULL THEN -1 ELSE CostAccountID END AS CostAccountID,
			SiteID,
			ISNULL((SELECT P.MachineID 
					FROM PrintersQueues P
					WHERE P.PrinterQueueID = J.PrinterQueueID),-1) AS MachineID,
			JobTypeID,
			(CAST(DATEPART(yyyy, DatePrinted) AS char(4)) +  RIGHT('0' + CAST(DATEPART(mm, DatePrinted) AS VARCHAR(2)), 2) + 
								RIGHT('0' + CAST(DATEPART(dd, DatePrinted) AS VARCHAR(2)), 2)) AS DataZero, 
			CASE WHEN 
				(((DATEPART(hh,dateprinted) = @MorningBEGINHour AND DATEPART(mi,dateprinted) >= @MorningBEGINMinute) OR DATEPART(hh,dateprinted) >= (@MorningBEGINHour + 1)) AND 
				((DATEPART(hh,dateprinted) = @MorningENDHour AND DATEPART(mi,dateprinted) <= @MorningENDMinute) OR DATEPART(hh,dateprinted) <= (@MorningENDHour-1)))
				OR
				(((DATEPART(hh,dateprinted) = @AfternoonBEGINHour AND DATEPART(mi,dateprinted) >= @AfternoonBEGINMinute) OR DATEPART(hh,dateprinted) >= (@AfternoonBEGINHour+1)) AND 
				((DATEPART(hh,dateprinted) = @AfternoonENDHour AND DATEPART(mi,dateprinted) <= @AfternoonENDMinute) OR DATEPART(hh,dateprinted) <= (@AfternoonENDHour-1)))
			THEN 0 ELSE 1 END AS OutTime--, -- 1 - fora do horario de trabalho, 0 - dentro					
			--CASE WHEN pagesmono > 0 THEN 1 ELSE 0 END AS Cor

			FROM Inserted J
			WHERE JobDisabled = 0
		)AS TABLE01
		GROUP BY PrintQualityID, PrinterQueueID, PrinterDeviceID,AccountID, PaperSizeID, JobOriginID, 
				PrintApplicationID, PrintWayID, CostAccountID, SiteID, MachineID, JobTypeID, DataZero, OutTime--,Cor
		

				IF(@@Error <> 0 )
				BEGIN
					RAISERROR('Erro ao preparar cubos!', 16, 1)
					RETURN
				END		



			DELETE FROM @CubeCube

			INSERT INTO @CubeCube
				SELECT     
				DataZero AS Date, 
				SUM(PagesMono) AS Pages, 
				0 AS Cor, 
				SUM(CostMono) AS Custo, 
				CAST(PrintWayID AS BIT),  
				PrintApplicationID, 
				PrintQualityID, 
				CAST(PaperSizeID AS SMALLINT), 
				ISNULL(CostAccountID,-1), 
				JobOriginID, 
				PrinterDeviceID, 
				ISNULL(PrinterQueueID,-1), 
				AccountID, 
				SiteID, 
				CAST(JobTypeID AS SMALLINT)
				FROM @TempCube
				WHERE      (PagesMono <> 0) 
				GROUP BY DataZero, PrintWayID, PrintApplicationID, PrintQualityID, PaperSizeID, CostAccountID, JobOriginID, 
						 PrinterQueueID, PrinterDeviceID, AccountID, SiteID, JobTypeID

				UNION ALL

				SELECT     
				DataZero AS Date, 
				SUM(PagesColor) AS Pages, 
				1 AS Cor, 
				SUM(CostColor) AS Custo, 
				CAST(PrintWayID AS BIT),  
				PrintApplicationID, 
				PrintQualityID, 
				CAST(PaperSizeID AS SMALLINT), 
				ISNULL(CostAccountID,-1), 
				JobOriginID, 
				PrinterDeviceID, 
				ISNULL(PrinterQueueID,-1), 
				AccountID, 
				SiteID, 
				CAST(JobTypeID AS SMALLINT)
				FROM @TempCube
				WHERE     (PagesColor <> 0)
				GROUP BY DataZero, PrintWayID, PrintApplicationID, PrintQualityID, PaperSizeID, CostAccountID, JobOriginID, 
						 PrinterQueueID, PrinterDeviceID, AccountID, SiteID, JobTypeID

				IF(@@Error <> 0 )
				BEGIN
					RAISERROR('Erro ao preparar cubos!', 16, 1)
					RETURN
				END		



	INSERT INTO @Temp

		SELECT PrinterQueueID, PrinterDeviceID,AccountID, PaperSizeID, JobOriginID, 
				PrintApplicationID, PrintWayID, SUM(PagesColor) AS PagesColor, SUM(PagesMono) AS PagesMono, 
			SUM(CostColor) AS CostColor, SUM(CostMono) AS CostMono, CostAccountID, SiteID, MachineID, DataZero, JobTypeID, OutTime, COUNT (*) AS TotalJobs FROM
		@Tempcube
		GROUP BY  PrinterQueueID, PrinterDeviceID,AccountID, PaperSizeID, JobOriginID, 
				PrintApplicationID, PrintWayID, CostAccountID, SiteID, MachineID, JobTypeID, DataZero, OutTime--,Cor

		IF(@@Error <> 0 )
		BEGIN
			RAISERROR('Erro ao preparar cubos!', 16, 1)
			RETURN
		END	

	DELETE FROM @Tempcube

	SELECT @COUNT = SUM(TOTALJOBS) FROM @TEMP
	PRINT CAST(@COUNT AS VARCHAR) + ' REGISTROS INSERIDOS'



				INSERT INTO @Core 
					SELECT	DataZero, 
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDFN,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDFV,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDCN,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDCV,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDIN,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDIV,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSFN,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSFV,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSCN,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSCV,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSIN,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSIV,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDFN,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDFV,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDCN,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDCV,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDIN,
							SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDIV,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSFN,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSFV,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSCN,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSCV,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSIN,
							SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSIV,
							SUM (TotalJobs) AS TotJobs,
							SUM (CASE WHEN JobTypeID = 4 THEN PagesMono ELSE 0 END) AS SN,
							SUM (CASE WHEN JobTypeID = 4 THEN CostMono  ELSE 0 END) AS SV,
							SUM (CASE WHEN JobTypeID = 5 THEN PagesMono ELSE 0 END) AS EN,
							SUM (CASE WHEN JobTypeID = 5 THEN CostMono  ELSE 0 END) AS EV
						FROM  @temp  T
						GROUP BY T.DataZero
			
				IF(@@Error <> 0 )
				BEGIN
					RAISERROR('Erro ao preparar cubos!', 16, 1)
					RETURN
				END			
			
			INSERT INTO @User 
				SELECT	T.DataZero, T.AccountID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSIV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSIV,
						SUM (TotalJobs) AS TotJobs,
						SUM (CASE WHEN JobTypeID = 4 THEN PagesMono ELSE 0 END) AS SN,
						SUM (CASE WHEN JobTypeID = 4 THEN CostMono  ELSE 0 END) AS SV,
						SUM (CASE WHEN JobTypeID = 5 THEN PagesMono ELSE 0 END) AS EN,
						SUM (CASE WHEN JobTypeID = 5 THEN CostMono  ELSE 0 END) AS EV
					FROM @temp  T
					GROUP BY T.DataZero, T.AccountID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID
			
			IF( @@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

			INSERT INTO @Printer 
				SELECT	T.DataZero, T.PrinterDeviceID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSIV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSIV,
						SUM (TotalJobs) AS TotJobs,
						SUM (CASE WHEN JobTypeID = 4 THEN PagesMono ELSE 0 END) AS SN,
						SUM (CASE WHEN JobTypeID = 4 THEN CostMono  ELSE 0 END) AS SV,
						SUM (CASE WHEN JobTypeID = 5 THEN PagesMono ELSE 0 END) AS EN,
						SUM (CASE WHEN JobTypeID = 5 THEN CostMono  ELSE 0 END) AS EV
					FROM  @temp  T
					GROUP BY T.DataZero, T.PrinterDeviceID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END
			
			INSERT INTO @Queue
				SELECT	T.DataZero, T.PrinterQueueID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSIV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSIV,
						SUM (TotalJobs) AS TotJobs,
						SUM (CASE WHEN JobTypeID = 4 THEN PagesMono ELSE 0 END) AS SN,
						SUM (CASE WHEN JobTypeID = 4 THEN CostMono  ELSE 0 END) AS SV,
						SUM (CASE WHEN JobTypeID = 5 THEN PagesMono ELSE 0 END) AS EN,
						SUM (CASE WHEN JobTypeID = 5 THEN CostMono  ELSE 0 END) AS EV
					FROM  @temp  T
					GROUP BY T.DataZero, T.PrinterQueueID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID
			
			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

			INSERT INTO @Machine
				SELECT	T.DataZero, T.MachineID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSIV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSIV,
						SUM (TotalJobs) AS TotJobs,
						SUM (CASE WHEN JobTypeID = 4 THEN PagesMono ELSE 0 END) AS SN,
						SUM (CASE WHEN JobTypeID = 4 THEN CostMono  ELSE 0 END) AS SV,
						SUM (CASE WHEN JobTypeID = 5 THEN PagesMono ELSE 0 END) AS EN,
						SUM (CASE WHEN JobTypeID = 5 THEN CostMono  ELSE 0 END) AS EV
					FROM @temp  T
					GROUP BY T.DataZero, T.MachineID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

			INSERT INTO @CostAccount
				SELECT	T.DataZero, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN PagesColor ELSE 0 END) AS CSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesColor > 0 THEN CostColor ELSE 0 END) AS CSIV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDFN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDFV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDCN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDCV,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PDIN,
						SUM (CASE WHEN PrintWayID = 1 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PDIV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSFN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 3 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSFV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSCN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 2 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSCV,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN PagesMono ELSE 0 END) AS PSIN,
						SUM (CASE WHEN PrintWayID = 0 AND JobTypeID = 1 AND PagesMono > 0 THEN CostMono ELSE 0 END) AS PSIV,
						SUM (TotalJobs) AS TotJobs,
						SUM (CASE WHEN JobTypeID = 4 THEN PagesMono ELSE 0 END) AS SN,
						SUM (CASE WHEN JobTypeID = 4 THEN CostMono  ELSE 0 END) AS SV,
						SUM (CASE WHEN JobTypeID = 5 THEN PagesMono ELSE 0 END) AS EN,
						SUM (CASE WHEN JobTypeID = 5 THEN CostMono  ELSE 0 END) AS EV
					FROM  @temp  T
					GROUP BY T.DataZero, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID	

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END
			
				INSERT INTO @Analyze
					SELECT	T.DataZero, 
						T.AccountID, 
						T.CostAccountID, 						
						SUM (CASE WHEN PaperSizeId = 9 THEN PagesColor + PagesMono ELSE 0 END) AS A4,
						SUM (CASE WHEN PaperSizeId <> 9 THEN PagesColor + PagesMono ELSE 0 END) AS NA4,
						SUM (CASE WHEN OutTime = 0
							THEN PagesColor + PagesMono ELSE 0 END) AS InTime,
						SUM (CASE WHEN OutTime = 1
							THEN PagesColor + PagesMono ELSE 0 END) AS OutTime,
						SUM (CASE WHEN dbo.ReturnPrinterQueueTypeID( T.PrinterQueueID) = 1
							THEN PagesColor + PagesMono ELSE 0 END) AS Local,
						SUM (CASE WHEN dbo.ReturnPrinterQueueTypeID( T.PrinterQueueID) <> 1
							THEN PagesColor + PagesMono ELSE 0 END) AS Net
					FROM  @temp  T WHERE T.JobTypeID IN (1,2,3)
					GROUP BY T.DataZero, T.AccountID, T.CostAccountID

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

-- Insere os registros com os valores zerados para ser possivel atualizá-los com AS dados.

		INSERT INTO CubeCube
			SELECT T.Date, 0, T.Color, 0, T.PrintWayID, T.PrintApplicationID, T.PrintQualityID, T.PaperSizeID, T.CostAccountID, T.JobOriginID, T.PrinterDeviceID, T.PrinterQueueID, 
					T.AccountID, T.SiteID, T.JobTypeID
			FROM @CubeCube T
			WHERE NOT EXISTS (SELECT 1 FROM CubeCube WHERE Date = T.Date AND Color = T.Color AND PrintWayID = T.PrintWayID AND PrintApplicationID = T.PrintApplicationID AND
								PrintQualityID = T.PrintQualityID AND  PaperSizeID = T.PaperSizeID AND CostAccountID = T.CostAccountID AND JobOriginID = T.JobOriginID AND
								PrinterDeviceID = T.PrinterDeviceID AND PrinterQueueID = T.PrinterQueueID AND AccountID = T.AccountID AND 
								SiteID = T.SiteID AND JobTypeID = T.JobTypeID )

			IF (@@Error <> 0)
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END


			PRINT 'INSERE REGISTROS ZERADOS NOS CUBOS'
			INSERT INTO CubeCore 
				SELECT DISTINCT T.DataZero, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeCore WHERE Data = T.DataZero)

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

			INSERT INTO CubeUser
				SELECT DISTINCT T.DataZero, T.AccountID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID,
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeUser 	
										WHERE	Data = T.DataZero AND AccountID = T.AccountID AND CostAccountID = T.CostAccountID AND 
												SiteID = T.SiteID AND PrintApplicationID = T.PrintApplicationID AND PaperSizeID = T.PaperSizeID AND
												JobOriginID = T.JobOriginID)

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

			INSERT INTO CubePrinter
				SELECT DISTINCT T.DataZero, T.PrinterDeviceID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID,
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubePrinter 
										WHERE	Data = T.DataZero AND PrinterDeviceID = T.PrinterDeviceID AND CostAccountID = T.CostAccountID AND 
												SiteID = T.SiteID AND PrintApplicationID = T.PrintApplicationID AND PaperSizeID = T.PaperSizeID AND
												JobOriginID = T.JobOriginID)

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

			INSERT INTO CubeQueue
				SELECT DISTINCT T.DataZero, T.PrinterQueueID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID,
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeQueue 
										WHERE	Data = T.DataZero AND PrinterQueueID = T.PrinterQueueID AND CostAccountID = T.CostAccountID AND 
												SiteID = T.SiteID AND PrintApplicationID = T.PrintApplicationID AND PaperSizeID = T.PaperSizeID AND
												JobOriginID = T.JobOriginID)

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END
			
			INSERT INTO CubeMachine
				SELECT DISTINCT T.DataZero, T.MachineID, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID,
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeMachine 
										WHERE	Data = T.DataZero AND MachineID = T.MachineID AND CostAccountID = T.CostAccountID AND 
												SiteID = T.SiteID AND PrintApplicationID = T.PrintApplicationID AND PaperSizeID = T.PaperSizeID AND
												JobOriginID = T.JobOriginID)

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

			INSERT INTO CubeCostAccount
				SELECT DISTINCT T.DataZero, T.CostAccountID, T.SiteID, T.PrintApplicationID, T.PaperSizeID, T.JobOriginID,
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeCostAccount WHERE Data = T.DataZero AND CostAccountID = T.CostAccountID AND SiteID = T.SiteID AND 
												PrintApplicationID = T.PrintApplicationID AND PaperSizeID = T.PaperSizeID AND
												JobOriginID = T.JobOriginID)

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END
			
			INSERT INTO CubeAnalyze
				SELECT DISTINCT T.DataZero,T.AccountID, T.CostAccountID, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeAnalyze 
										WHERE	Data = T.DataZero AND 
												AccountID = T.AccountID AND
												CostAccountID = T.CostAccountID)


			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

			-- inicializacao dos cubos de sumarização ampla (chave específica)
			
			INSERT INTO CubeUserAccount
				SELECT DISTINCT T.DataZero, T.AccountID, 
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeUserAccount 
										WHERE	Data = T.DataZero AND AccountID = T.AccountID)

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END
			
			INSERT INTO CubePrinterDevice
				SELECT DISTINCT T.DataZero, T.PrinterDeviceID, 
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubePrinterDevice 
										WHERE	Data = T.DataZero AND PrinterDeviceID = T.PrinterDeviceID)

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

			INSERT INTO CubeQueuePrinter
				SELECT DISTINCT T.DataZero, T.PrinterQueueID, 
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeQueuePrinter 
										WHERE	Data = T.DataZero AND PrinterQueueID = T.PrinterQueueID)

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END
			
			INSERT INTO CubeMachineID
				SELECT DISTINCT T.DataZero, T.MachineID, 
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeMachineID 
										WHERE	Data = T.DataZero AND MachineID = T.MachineID)

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

			INSERT INTO CubeCostAccountID
				SELECT DISTINCT T.DataZero, T.CostAccountID, 
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeCostAccountID 
										WHERE	Data = T.DataZero AND CostAccountID = T.CostAccountID)


			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END
			
			-- inicializacao dos cubos Week/MONTH

			INSERT INTO CubeUserAccountWeek
				SELECT DISTINCT YEAR(T.DataZero), MONTH(T.DataZero), 
								CASE WHEN DAY(T.DataZero) < 8 THEN 1 
									 WHEN DAY(T.DataZero) < 15 AND DAY(T.DataZero) > 7 THEN 8
									 WHEN DAY(T.DataZero) < 22 AND DAY(T.DataZero) > 14 THEN 15
									 WHEN DAY(T.DataZero) > 21 THEN 22 END, T.AccountID, 
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeUserAccountWeek
										WHERE	YEAR(T.DataZero) = yearw AND MONTH(T.DataZero) = monthw AND
												(CASE	WHEN DAY(DataZero) < 8 THEN 1 
														WHEN DAY(DataZero) < 15 AND DAY(DataZero) > 7 THEN 8
														WHEN DAY(DataZero) < 22 AND DAY(DataZero) > 14 THEN 15
														WHEN DAY(DataZero) > 21 THEN 22 END) = dayw AND 
												AccountID = T.AccountID)
			UNION All
				SELECT DISTINCT YEAR(T.DataZero), MONTH(T.DataZero), 28, T.AccountID, 
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeUserAccountWeek
										WHERE	YEAR(T.DataZero) = yearw AND MONTH(T.DataZero) = monthw AND
												CubeUserAccountWeek.dayw = 28 AND AccountID = T.AccountID)
	

			
			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END
			
			INSERT INTO CubePrinterDeviceWeek
				SELECT DISTINCT YEAR(T.DataZero), MONTH(T.DataZero), 
								CASE WHEN DAY(T.DataZero) < 8 THEN 1 
									 WHEN DAY(T.DataZero) < 15 AND DAY(T.DataZero) > 7 THEN 8
									 WHEN DAY(T.DataZero) < 22 AND DAY(T.DataZero) > 14 THEN 15
									 WHEN DAY(T.DataZero) > 21 THEN 22 END, T.PrinterDeviceID, 
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubePrinterDeviceWeek 
										WHERE	YEAR(T.DataZero) = yearw AND MONTH(T.DataZero) = monthw AND
												(CASE	WHEN DAY(DataZero) < 8 THEN 1 
														WHEN DAY(DataZero) < 15 AND DAY(DataZero) > 7 THEN 8
														WHEN DAY(DataZero) < 22 AND DAY(DataZero) > 14 THEN 15
														WHEN DAY(DataZero) > 21 THEN 22 END) = dayw AND 
												PrinterDeviceID = T.PrinterDeviceID)
			UNION All
				SELECT DISTINCT YEAR(T.DataZero), MONTH(T.DataZero), 28, T.PrinterDeviceID, 
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubePrinterDeviceWeek
										WHERE	YEAR(T.DataZero) = yearw AND MONTH(T.DataZero) = monthw AND
												CubePrinterDeviceWeek.dayw = 28 AND PrinterDeviceID = T.PrinterDeviceID)
			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

			INSERT INTO CubeQueuePrinterWeek
				SELECT DISTINCT YEAR(T.DataZero), MONTH(T.DataZero), 
								CASE WHEN DAY(T.DataZero) < 8 THEN 1 
									 WHEN DAY(T.DataZero) < 15 AND DAY(T.DataZero) > 7 THEN 8
									 WHEN DAY(T.DataZero) < 22 AND DAY(T.DataZero) > 14 THEN 15
									 WHEN DAY(T.DataZero) > 21 THEN 22 END, T.PrinterQueueID, 
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeQueuePrinterWeek 
										WHERE	YEAR(T.DataZero) = yearw AND MONTH(T.DataZero) = monthw AND
												(CASE	WHEN DAY(DataZero) < 8 THEN 1 
														WHEN DAY(DataZero) < 15 AND DAY(DataZero) > 7 THEN 8
														WHEN DAY(DataZero) < 22 AND DAY(DataZero) > 14 THEN 15
														WHEN DAY(DataZero) > 21 THEN 22 END) = dayw AND
												PrinterQueueID = T.PrinterQueueID)
			UNION All
				SELECT DISTINCT YEAR(T.DataZero), MONTH(T.DataZero), 28, T.PrinterQueueID, 
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeQueuePrinterWeek
										WHERE	YEAR(T.DataZero) = yearw AND MONTH(T.DataZero) = monthw AND
												CubeQueuePrinterWeek.dayw = 28 AND PrinterQueueID = T.PrinterQueueID)
			
			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END
			
			INSERT INTO CubeMachineIDWeek
				SELECT DISTINCT YEAR(T.DataZero), MONTH(T.DataZero), 
								CASE WHEN DAY(T.DataZero) < 8 THEN 1 
									 WHEN DAY(T.DataZero) < 15 AND DAY(T.DataZero) > 7 THEN 8
									 WHEN DAY(T.DataZero) < 22 AND DAY(T.DataZero) > 14 THEN 15
									 WHEN DAY(T.DataZero) > 21 THEN 22 END, T.MachineID, 
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeMachineIDWeek 
										WHERE	YEAR(T.DataZero) = yearw AND MONTH(T.DataZero) = monthw AND
												(CASE	WHEN DAY(DataZero) < 8 THEN 1 
														WHEN DAY(DataZero) < 15 AND DAY(DataZero) > 7 THEN 8
														WHEN DAY(DataZero) < 22 AND DAY(DataZero) > 14 THEN 15
														WHEN DAY(DataZero) > 21 THEN 22 END) = dayw AND
												MachineID = T.MachineID)
			UNION All
				SELECT DISTINCT YEAR(T.DataZero), MONTH(T.DataZero), 28, T.MachineID, 
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeMachineIDWeek
										WHERE	YEAR(T.DataZero) = yearw AND MONTH(T.DataZero) = monthw AND
												CubeMachineIDWeek.dayw = 28 AND MachineID = T.MachineID)
			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

			INSERT INTO CubeCostAccountIDWeek
				SELECT DISTINCT YEAR(T.DataZero), MONTH(T.DataZero), 
								CASE WHEN DAY(T.DataZero) < 8 THEN 1 
									 WHEN DAY(T.DataZero) < 15 AND DAY(T.DataZero) > 7 THEN 8
									 WHEN DAY(T.DataZero) < 22 AND DAY(T.DataZero) > 14 THEN 15
									 WHEN DAY(T.DataZero) > 21 THEN 22 END, T.CostAccountID, 
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeCostAccountIDWeek 
										WHERE	YEAR(T.DataZero) = yearw AND MONTH(T.DataZero) = monthw AND
												(CASE	WHEN DAY(DataZero) < 8 THEN 1 
														WHEN DAY(DataZero) < 15 AND DAY(DataZero) > 7 THEN 8
														WHEN DAY(DataZero) < 22 AND DAY(DataZero) > 14 THEN 15
														WHEN DAY(DataZero) > 21 THEN 22 END) = dayw AND
												CostAccountID = T.CostAccountID)
			UNION All
				SELECT DISTINCT YEAR(T.DataZero), MONTH(T.DataZero), 28, T.CostAccountID, 
								0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
					FROM @Temp T
					WHERE NOT EXISTS (SELECT 1 FROM CubeCostAccountIDWeek
										WHERE	YEAR(T.DataZero) = yearw AND MONTH(T.DataZero) = monthw AND
												CubeCostAccountIDWeek.dayw = 28 AND CostAccountID = T.CostAccountID)

			IF(@@Error <> 0 )
			BEGIN
				RAISERROR('Erro ao preparar cubos!', 16, 1)
				RETURN
			END

PRINT 'INSERE EM CUBECUBE'
	UPDATE CubeCube
		SET CubeCube.Pages = CubeCube.Pages + C.Pages, CubeCube.Cost = CubeCube.Cost + C.Cost 
		FROM @CubeCube C
		WHERE CubeCube.Date = C.Date AND CubeCube.Color = C.Color AND CubeCube.PrintWayID = C.PrintWayID AND CubeCube.PrintApplicationID = C.PrintApplicationID AND
			CubeCube.PrintQualityID = C.PrintQualityID AND  CubeCube.PaperSizeID = C.PaperSizeID AND CubeCube.CostAccountID = C.CostAccountID AND CubeCube.JobOriginID = C.JobOriginID AND
			CubeCube.PrinterDeviceID = C.PrinterDeviceID AND CubeCube.PrinterQueueID = C.PrinterQueueID AND CubeCube.AccountID = C.AccountID AND 
			CubeCube.SiteID = C.SiteID AND CubeCube.JobTypeID = C.JobTypeID

			IF(@@Error <> 0)-- OR @@RowCount = 0)
			BEGIN
				ROLLBACK					
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END		



		-- Adiciona os novos Valores nos cubos do Job atualizado.
		PRINT 'INSERE EM CUBECORE'
		UPDATE CubeCore
				SET CubeCore.CDFN = CubeCore.CDFN + C.CDFN, CubeCore.CDFV = CubeCore.CDFV + C.CDFV, CubeCore.CDCN = CubeCore.CDCN + C.CDCN,
					CubeCore.CDCV = CubeCore.CDCV + C.CDCV, CubeCore.CDIN = CubeCore.CDIN + C.CDIN,	CubeCore.CDIV = CubeCore.CDIV + C.CDIV,
					CubeCore.CSFN = CubeCore.CSFN + C.CSFN, CubeCore.CSFV = CubeCore.CSFV + C.CSFV,	CubeCore.CSCN = CubeCore.CSCN + C.CSCN,
					CubeCore.CSCV = CubeCore.CSCV + C.CSCV,	CubeCore.CSIN = CubeCore.CSIN + C.CSIN, CubeCore.CSIV = CubeCore.CSIV + C.CSIV, 
					CubeCore.PDFN = CubeCore.PDFN + C.PDFN, CubeCore.PDFV = CubeCore.PDFV + C.PDFV, CubeCore.PDCN = CubeCore.PDCN + C.PDCN, 
					CubeCore.PDCV = CubeCore.PDCV + C.PDCV, CubeCore.PDIN = CubeCore.PDIN + C.PDIN,	CubeCore.PDIV = CubeCore.PDIV + C.PDIV,
					CubeCore.PSFN = CubeCore.PSFN + C.PSFN, CubeCore.PSFV = CubeCore.PSFV + C.PSFV,	CubeCore.PSCN = CubeCore.PSCN + C.PSCN, 
					CubeCore.PSCV = CubeCore.PSCV + C.PSCV,	CubeCore.PSIN = CubeCore.PSIN + C.PSIN, CubeCore.PSIV = CubeCore.PSIV + C.PSIV,
					CubeCore.TotJobs = CubeCore.TotJobs + C.TotJobs,
					CubeCore.SN = CubeCore.SN + C.SN, CubeCore.SV = CubeCore.SV + C.SV,
					CubeCore.EN = CubeCore.EN + C.EN, CubeCore.EV = CubeCore.EV + C.EV
				FROM @Core C
				WHERE CubeCore.Data = C.Data
			
			IF(@@Error <> 0)-- OR @@RowCount = 0)
			BEGIN
				ROLLBACK					
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END		

			PRINT 'INSERE EM CUBEUSER'
			UPDATE CubeUser			
				SET CubeUser.CDFN = CubeUser.CDFN + C.CDFN, CubeUser.CDFV = CubeUser.CDFV + C.CDFV, CubeUser.CDCN = CubeUser.CDCN + C.CDCN,
					CubeUser.CDCV = CubeUser.CDCV + C.CDCV, CubeUser.CDIN = CubeUser.CDIN + C.CDIN,	CubeUser.CDIV = CubeUser.CDIV + C.CDIV,
					CubeUser.CSFN = CubeUser.CSFN + C.CSFN, CubeUser.CSFV = CubeUser.CSFV + C.CSFV,	CubeUser.CSCN = CubeUser.CSCN + C.CSCN,
					CubeUser.CSCV = CubeUser.CSCV + C.CSCV,	CubeUser.CSIN = CubeUser.CSIN + C.CSIN, CubeUser.CSIV = CubeUser.CSIV + C.CSIV, 
					CubeUser.PDFN = CubeUser.PDFN + C.PDFN, CubeUser.PDFV = CubeUser.PDFV + C.PDFV, CubeUser.PDCN = CubeUser.PDCN + C.PDCN, 
					CubeUser.PDCV = CubeUser.PDCV + C.PDCV, CubeUser.PDIN = CubeUser.PDIN + C.PDIN,	CubeUser.PDIV = CubeUser.PDIV + C.PDIV,
					CubeUser.PSFN = CubeUser.PSFN + C.PSFN, CubeUser.PSFV = CubeUser.PSFV + C.PSFV,	CubeUser.PSCN = CubeUser.PSCN + C.PSCN, 
					CubeUser.PSCV = CubeUser.PSCV + C.PSCV,	CubeUser.PSIN = CubeUser.PSIN + C.PSIN, CubeUser.PSIV = CubeUser.PSIV + C.PSIV,
					CubeUser.TotJobs = CubeUser.TotJobs + C.TotJobs,
					CubeUser.SN = CubeUser.SN + C.SN, CubeUser.SV = CubeUser.SV + C.SV,
					CubeUser.EN = CubeUser.EN + C.EN, CubeUser.EV = CubeUser.EV + C.EV
				FROM @User C
				WHERE	CubeUser.Data = C.Data AND CubeUser.AccountID = C.AccountID AND CubeUser.CostAccountID = C.CostAccountID AND 						CubeUser.SiteID = C.SiteID AND CubeUser.PrintApplicationID = C.PrintApplicationID AND 
						CubeUser.PaperSizeID = C.PaperSizeID AND CubeUser.JobOriginID = C.JobOriginID

			IF(@@Error <> 0)-- OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END	

			PRINT 'INSERE EM CUBEPRINTER'
			UPDATE CubePrinter			
				SET CubePrinter.CDFN = CubePrinter.CDFN + C.CDFN, CubePrinter.CDFV = CubePrinter.CDFV + C.CDFV, CubePrinter.CDCN = CubePrinter.CDCN + C.CDCN,
					CubePrinter.CDCV = CubePrinter.CDCV + C.CDCV, CubePrinter.CDIN = CubePrinter.CDIN + C.CDIN,	CubePrinter.CDIV = CubePrinter.CDIV + C.CDIV,
					CubePrinter.CSFN = CubePrinter.CSFN + C.CSFN, CubePrinter.CSFV = CubePrinter.CSFV + C.CSFV,	CubePrinter.CSCN = CubePrinter.CSCN + C.CSCN,
					CubePrinter.CSCV = CubePrinter.CSCV + C.CSCV,	CubePrinter.CSIN = CubePrinter.CSIN + C.CSIN, CubePrinter.CSIV = CubePrinter.CSIV + C.CSIV, 
					CubePrinter.PDFN = CubePrinter.PDFN + C.PDFN, CubePrinter.PDFV = CubePrinter.PDFV + C.PDFV, CubePrinter.PDCN = CubePrinter.PDCN + C.PDCN, 
					CubePrinter.PDCV = CubePrinter.PDCV + C.PDCV, CubePrinter.PDIN = CubePrinter.PDIN + C.PDIN,	CubePrinter.PDIV = CubePrinter.PDIV + C.PDIV,
					CubePrinter.PSFN = CubePrinter.PSFN + C.PSFN, CubePrinter.PSFV = CubePrinter.PSFV + C.PSFV,	CubePrinter.PSCN = CubePrinter.PSCN + C.PSCN, 
					CubePrinter.PSCV = CubePrinter.PSCV + C.PSCV,	CubePrinter.PSIN = CubePrinter.PSIN + C.PSIN, CubePrinter.PSIV = CubePrinter.PSIV + C.PSIV,
					CubePrinter.TotJobs = CubePrinter.TotJobs + C.TotJobs,
					CubePrinter.SN = CubePrinter.SN + C.SN, CubePrinter.SV = CubePrinter.SV + C.SV,
					CubePrinter.EN = CubePrinter.EN + C.EN, CubePrinter.EV = CubePrinter.EV + C.EV
				FROM @Printer C
				WHERE	CubePrinter.Data = C.Data AND CubePrinter.PrinterDeviceID = C.PrinterDeviceID AND 
						CubePrinter.CostAccountID = C.CostAccountID AND CubePrinter.SiteID = C.SiteID AND	
						CubePrinter.PrintApplicationID = C.PrintApplicationID AND CubePrinter.PaperSizeID = C.PaperSizeID AND
						CubePrinter.JobOriginID = C.JobOriginID
			
			IF(@@Error <> 0 )--OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END	

			PRINT 'INSERE EM CUBEQUEUE'
			UPDATE CubeQueue			
				SET CubeQueue.CDFN = CubeQueue.CDFN + C.CDFN, CubeQueue.CDFV = CubeQueue.CDFV + C.CDFV, CubeQueue.CDCN = CubeQueue.CDCN + C.CDCN,
					CubeQueue.CDCV = CubeQueue.CDCV + C.CDCV, CubeQueue.CDIN = CubeQueue.CDIN + C.CDIN,	CubeQueue.CDIV = CubeQueue.CDIV + C.CDIV,
					CubeQueue.CSFN = CubeQueue.CSFN + C.CSFN, CubeQueue.CSFV = CubeQueue.CSFV + C.CSFV,	CubeQueue.CSCN = CubeQueue.CSCN + C.CSCN,
					CubeQueue.CSCV = CubeQueue.CSCV + C.CSCV, CubeQueue.CSIN = CubeQueue.CSIN + C.CSIN, CubeQueue.CSIV = CubeQueue.CSIV + C.CSIV, 
					CubeQueue.PDFN = CubeQueue.PDFN + C.PDFN, CubeQueue.PDFV = CubeQueue.PDFV + C.PDFV, CubeQueue.PDCN = CubeQueue.PDCN + C.PDCN, 
					CubeQueue.PDCV = CubeQueue.PDCV + C.PDCV, CubeQueue.PDIN = CubeQueue.PDIN + C.PDIN,	CubeQueue.PDIV = CubeQueue.PDIV + C.PDIV,
					CubeQueue.PSFN = CubeQueue.PSFN + C.PSFN, CubeQueue.PSFV = CubeQueue.PSFV + C.PSFV,	CubeQueue.PSCN = CubeQueue.PSCN + C.PSCN, 
					CubeQueue.PSCV = CubeQueue.PSCV + C.PSCV, CubeQueue.PSIN = CubeQueue.PSIN + C.PSIN, CubeQueue.PSIV = CubeQueue.PSIV + C.PSIV,
					CubeQueue.TotJobs = CubeQueue.TotJobs + C.TotJobs,
					CubeQueue.SN = CubeQueue.SN + C.SN, CubeQueue.SV = CubeQueue.SV + C.SV,
					CubeQueue.EN = CubeQueue.EN + C.EN, CubeQueue.EV = CubeQueue.EV + C.EV
				FROM @Queue C
				WHERE	CubeQueue.Data = C.Data AND CubeQueue.PrinterQueueID = C.PrinterQueueID AND CubeQueue.CostAccountID = C.CostAccountID AND
						CubeQueue.SiteID = C.SiteID AND CubeQueue.PrintApplicationID = C.PrintApplicationID AND 
						CubeQueue.PaperSizeID = C.PaperSizeID AND CubeQueue.JobOriginID = C.JobOriginID
			
			IF(@@Error <> 0 )--OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END	

			PRINT 'INSERE EM CUBEMACHINE'
			UPDATE CubeMachine
				SET CubeMachine.CDFN = CubeMachine.CDFN + C.CDFN, CubeMachine.CDFV = CubeMachine.CDFV + C.CDFV, CubeMachine.CDCN = CubeMachine.CDCN + C.CDCN,
					CubeMachine.CDCV = CubeMachine.CDCV + C.CDCV, CubeMachine.CDIN = CubeMachine.CDIN + C.CDIN,	CubeMachine.CDIV = CubeMachine.CDIV + C.CDIV,
					CubeMachine.CSFN = CubeMachine.CSFN + C.CSFN, CubeMachine.CSFV = CubeMachine.CSFV + C.CSFV,	CubeMachine.CSCN = CubeMachine.CSCN + C.CSCN,
					CubeMachine.CSCV = CubeMachine.CSCV + C.CSCV, CubeMachine.CSIN = CubeMachine.CSIN + C.CSIN, CubeMachine.CSIV = CubeMachine.CSIV + C.CSIV, 
					CubeMachine.PDFN = CubeMachine.PDFN + C.PDFN, CubeMachine.PDFV = CubeMachine.PDFV + C.PDFV, CubeMachine.PDCN = CubeMachine.PDCN + C.PDCN, 
					CubeMachine.PDCV = CubeMachine.PDCV + C.PDCV, CubeMachine.PDIN = CubeMachine.PDIN + C.PDIN,	CubeMachine.PDIV = CubeMachine.PDIV + C.PDIV,
					CubeMachine.PSFN = CubeMachine.PSFN + C.PSFN, CubeMachine.PSFV = CubeMachine.PSFV + C.PSFV,	CubeMachine.PSCN = CubeMachine.PSCN + C.PSCN, 
					CubeMachine.PSCV = CubeMachine.PSCV + C.PSCV, CubeMachine.PSIN = CubeMachine.PSIN + C.PSIN, CubeMachine.PSIV = CubeMachine.PSIV + C.PSIV,
					CubeMachine.TotJobs = CubeMachine.TotJobs + C.TotJobs,
					CubeMachine.SN = CubeMachine.SN + C.SN, CubeMachine.SV = CubeMachine.SV + C.SV,
					CubeMachine.EN = CubeMachine.EN + C.EN, CubeMachine.EV = CubeMachine.EV + C.EV
				FROM @Machine C
				WHERE	CubeMachine.Data = C.Data AND CubeMachine.MachineID = C.MachineID AND CubeMachine.CostAccountID = C.CostAccountID AND 
						CubeMachine.SiteID = C.SiteID AND CubeMachine.PrintApplicationID = C.PrintApplicationID AND 
						CubeMachine.PaperSizeID = C.PaperSizeID AND CubeMachine.JobOriginID = C.JobOriginID
			
			IF(@@Error <> 0 )--OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END	

			PRINT 'INSERE EM CUBECOSTACCOUNT'
			UPDATE CubeCostAccount
				SET CubeCostAccount.CDFN = CubeCostAccount.CDFN + C.CDFN, CubeCostAccount.CDFV = CubeCostAccount.CDFV + C.CDFV, CubeCostAccount.CDCN = CubeCostAccount.CDCN + C.CDCN,
					CubeCostAccount.CDCV = CubeCostAccount.CDCV + C.CDCV, CubeCostAccount.CDIN = CubeCostAccount.CDIN + C.CDIN,	CubeCostAccount.CDIV = CubeCostAccount.CDIV + C.CDIV,
					CubeCostAccount.CSFN = CubeCostAccount.CSFN + C.CSFN, CubeCostAccount.CSFV = CubeCostAccount.CSFV + C.CSFV,	CubeCostAccount.CSCN = CubeCostAccount.CSCN + C.CSCN,
					CubeCostAccount.CSCV = CubeCostAccount.CSCV + C.CSCV,	CubeCostAccount.CSIN = CubeCostAccount.CSIN + C.CSIN, CubeCostAccount.CSIV = CubeCostAccount.CSIV + C.CSIV, 
					CubeCostAccount.PDFN = CubeCostAccount.PDFN + C.PDFN, CubeCostAccount.PDFV = CubeCostAccount.PDFV + C.PDFV, CubeCostAccount.PDCN = CubeCostAccount.PDCN + C.PDCN, 
					CubeCostAccount.PDCV = CubeCostAccount.PDCV + C.PDCV, CubeCostAccount.PDIN = CubeCostAccount.PDIN + C.PDIN,	CubeCostAccount.PDIV = CubeCostAccount.PDIV + C.PDIV,
					CubeCostAccount.PSFN = CubeCostAccount.PSFN + C.PSFN, CubeCostAccount.PSFV = CubeCostAccount.PSFV + C.PSFV,	CubeCostAccount.PSCN = CubeCostAccount.PSCN + C.PSCN, 
					CubeCostAccount.PSCV = CubeCostAccount.PSCV + C.PSCV,	CubeCostAccount.PSIN = CubeCostAccount.PSIN + C.PSIN, CubeCostAccount.PSIV = CubeCostAccount.PSIV + C.PSIV,
					CubeCostAccount.TotJobs = CubeCostAccount.TotJobs + C.TotJobs,
					CubeCostAccount.SN = CubeCostAccount.SN + C.SN, CubeCostAccount.SV = CubeCostAccount.SV + C.SV,
					CubeCostAccount.EN = CubeCostAccount.EN + C.EN, CubeCostAccount.EV = CubeCostAccount.EV + C.EV
				FROM @CostAccount C
				WHERE	CubeCostAccount.Data = C.Data AND CubeCostAccount.CostAccountID = C.CostAccountID AND CubeCostAccount.SiteID = C.SiteID AND
						CubeCostAccount.PrintApplicationID = C.PrintApplicationID AND CubeCostAccount.PaperSizeID = C.PaperSizeID AND
						CubeCostAccount.JobOriginID = C.JobOriginID
			
			IF (@@Error <> 0 )--OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END					

			PRINT 'INSERE EM CUBEANALYZE'
			UPDATE CubeAnalyze
				SET CubeAnalyze.A4 =  CubeAnalyze.A4+ C.A4, CubeAnalyze.NA4 = CubeAnalyze.NA4  + C.NA4, CubeAnalyze.InTime = CubeAnalyze.InTime  + C.InTime, 
					CubeAnalyze.OutTime = CubeAnalyze.OutTime + C.OutTime, CubeAnalyze.Local = CubeAnalyze.Local + C.Local, CubeAnalyze.Net = CubeAnalyze.Net + C.Net
				FROM @Analyze C
				WHERE CubeAnalyze.Data = C.Data AND CubeAnalyze.AccountID = C.AccountID AND CubeAnalyze.CostAccountID = C.CostAccountID 
			
			IF(@@Error <> 0)-- OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END	

			-- Atualiza os valores correspondentes nos cubos de sumarização ampla (chave específica)			
			PRINT 'INSERE EM CUBEUSERACCOUNT'
			UPDATE CubeUserAccount			
				SET CubeUserAccount.CDFN = CubeUserAccount.CDFN + C.CDFN, CubeUserAccount.CDFV = CubeUserAccount.CDFV + C.CDFV, CubeUserAccount.CDCN = CubeUserAccount.CDCN + C.CDCN,
					CubeUserAccount.CDCV = CubeUserAccount.CDCV + C.CDCV, CubeUserAccount.CDIN = CubeUserAccount.CDIN + C.CDIN,	CubeUserAccount.CDIV = CubeUserAccount.CDIV + C.CDIV,
					CubeUserAccount.CSFN = CubeUserAccount.CSFN + C.CSFN, CubeUserAccount.CSFV = CubeUserAccount.CSFV + C.CSFV,	CubeUserAccount.CSCN = CubeUserAccount.CSCN + C.CSCN,
					CubeUserAccount.CSCV = CubeUserAccount.CSCV + C.CSCV, CubeUserAccount.CSIN = CubeUserAccount.CSIN + C.CSIN, CubeUserAccount.CSIV = CubeUserAccount.CSIV + C.CSIV, 
					CubeUserAccount.PDFN = CubeUserAccount.PDFN + C.PDFN, CubeUserAccount.PDFV = CubeUserAccount.PDFV + C.PDFV, CubeUserAccount.PDCN = CubeUserAccount.PDCN + C.PDCN, 
					CubeUserAccount.PDCV = CubeUserAccount.PDCV + C.PDCV, CubeUserAccount.PDIN = CubeUserAccount.PDIN + C.PDIN,	CubeUserAccount.PDIV = CubeUserAccount.PDIV + C.PDIV,
					CubeUserAccount.PSFN = CubeUserAccount.PSFN + C.PSFN, CubeUserAccount.PSFV = CubeUserAccount.PSFV + C.PSFV,	CubeUserAccount.PSCN = CubeUserAccount.PSCN + C.PSCN, 
					CubeUserAccount.PSCV = CubeUserAccount.PSCV + C.PSCV, CubeUserAccount.PSIN = CubeUserAccount.PSIN + C.PSIN, CubeUserAccount.PSIV = CubeUserAccount.PSIV + C.PSIV,
					CubeUserAccount.TotJobs = CubeUserAccount.TotJobs + C.TotJobs,
					CubeUserAccount.SN = CubeUserAccount.SN + C.SN, CubeUserAccount.SV = CubeUserAccount.SV + C.SV,
					CubeUserAccount.EN = CubeUserAccount.EN + C.EN, CubeUserAccount.EV = CubeUserAccount.EV + C.EV
				FROM (SELECT	Data, AccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
								SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
								SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
								SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
								SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
								SUM (TotJobs) AS TotJobs,
								SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV
						FROM @User 
						GROUP BY Data, AccountID) AS C
				WHERE CubeUserAccount.Data = C.Data AND CubeUserAccount.AccountID = C.AccountID 

			IF(@@Error <> 0)-- OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END	

			PRINT 'INSERE EM CUBEPRINTERDEVICE'
			UPDATE CubePrinterDevice			
				SET CubePrinterDevice.CDFN = CubePrinterDevice.CDFN + C.CDFN, CubePrinterDevice.CDFV = CubePrinterDevice.CDFV + C.CDFV, CubePrinterDevice.CDCN = CubePrinterDevice.CDCN + C.CDCN,
					CubePrinterDevice.CDCV = CubePrinterDevice.CDCV + C.CDCV, CubePrinterDevice.CDIN = CubePrinterDevice.CDIN + C.CDIN,	CubePrinterDevice.CDIV = CubePrinterDevice.CDIV + C.CDIV,
					CubePrinterDevice.CSFN = CubePrinterDevice.CSFN + C.CSFN, CubePrinterDevice.CSFV = CubePrinterDevice.CSFV + C.CSFV,	CubePrinterDevice.CSCN = CubePrinterDevice.CSCN + C.CSCN,
					CubePrinterDevice.CSCV = CubePrinterDevice.CSCV + C.CSCV, CubePrinterDevice.CSIN = CubePrinterDevice.CSIN + C.CSIN, CubePrinterDevice.CSIV = CubePrinterDevice.CSIV + C.CSIV, 
					CubePrinterDevice.PDFN = CubePrinterDevice.PDFN + C.PDFN, CubePrinterDevice.PDFV = CubePrinterDevice.PDFV + C.PDFV, CubePrinterDevice.PDCN = CubePrinterDevice.PDCN + C.PDCN, 
					CubePrinterDevice.PDCV = CubePrinterDevice.PDCV + C.PDCV, CubePrinterDevice.PDIN = CubePrinterDevice.PDIN + C.PDIN,	CubePrinterDevice.PDIV = CubePrinterDevice.PDIV + C.PDIV,
					CubePrinterDevice.PSFN = CubePrinterDevice.PSFN + C.PSFN, CubePrinterDevice.PSFV = CubePrinterDevice.PSFV + C.PSFV,	CubePrinterDevice.PSCN = CubePrinterDevice.PSCN + C.PSCN, 
					CubePrinterDevice.PSCV = CubePrinterDevice.PSCV + C.PSCV, CubePrinterDevice.PSIN = CubePrinterDevice.PSIN + C.PSIN, CubePrinterDevice.PSIV = CubePrinterDevice.PSIV + C.PSIV,
					CubePrinterDevice.TotJobs = CubePrinterDevice.TotJobs + C.TotJobs,
					CubePrinterDevice.SN = CubePrinterDevice.SN + C.SN, CubePrinterDevice.SV = CubePrinterDevice.SV + C.SV,
					CubePrinterDevice.EN = CubePrinterDevice.EN + C.EN, CubePrinterDevice.EV = CubePrinterDevice.EV + C.EV
				FROM (SELECT	Data, PrinterDeviceID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
								SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
								SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
								SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
								SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
								SUM (TotJobs) AS TotJobs,
								SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV
						FROM @Printer 
						GROUP BY Data, PrinterDeviceID) AS C
				WHERE	CubePrinterDevice.Data = C.Data AND CubePrinterDevice.PrinterDeviceID = C.PrinterDeviceID 
			
			IF(@@Error <> 0 )--OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END	

			PRINT 'INSERE EM CUBEQUEUEPRINTER'
			UPDATE CubeQueuePrinter			
				SET CubeQueuePrinter.CDFN = CubeQueuePrinter.CDFN + C.CDFN, CubeQueuePrinter.CDFV = CubeQueuePrinter.CDFV + C.CDFV, CubeQueuePrinter.CDCN = CubeQueuePrinter.CDCN + C.CDCN,
					CubeQueuePrinter.CDCV = CubeQueuePrinter.CDCV + C.CDCV, CubeQueuePrinter.CDIN = CubeQueuePrinter.CDIN + C.CDIN,	CubeQueuePrinter.CDIV = CubeQueuePrinter.CDIV + C.CDIV,
					CubeQueuePrinter.CSFN = CubeQueuePrinter.CSFN + C.CSFN, CubeQueuePrinter.CSFV = CubeQueuePrinter.CSFV + C.CSFV,	CubeQueuePrinter.CSCN = CubeQueuePrinter.CSCN + C.CSCN,
					CubeQueuePrinter.CSCV = CubeQueuePrinter.CSCV + C.CSCV, CubeQueuePrinter.CSIN = CubeQueuePrinter.CSIN + C.CSIN, CubeQueuePrinter.CSIV = CubeQueuePrinter.CSIV + C.CSIV, 
					CubeQueuePrinter.PDFN = CubeQueuePrinter.PDFN + C.PDFN, CubeQueuePrinter.PDFV = CubeQueuePrinter.PDFV + C.PDFV, CubeQueuePrinter.PDCN = CubeQueuePrinter.PDCN + C.PDCN, 
					CubeQueuePrinter.PDCV = CubeQueuePrinter.PDCV + C.PDCV, CubeQueuePrinter.PDIN = CubeQueuePrinter.PDIN + C.PDIN,	CubeQueuePrinter.PDIV = CubeQueuePrinter.PDIV + C.PDIV,
					CubeQueuePrinter.PSFN = CubeQueuePrinter.PSFN + C.PSFN, CubeQueuePrinter.PSFV = CubeQueuePrinter.PSFV + C.PSFV,	CubeQueuePrinter.PSCN = CubeQueuePrinter.PSCN + C.PSCN, 
					CubeQueuePrinter.PSCV = CubeQueuePrinter.PSCV + C.PSCV, CubeQueuePrinter.PSIN = CubeQueuePrinter.PSIN + C.PSIN, CubeQueuePrinter.PSIV = CubeQueuePrinter.PSIV + C.PSIV,
					CubeQueuePrinter.TotJobs = CubeQueuePrinter.TotJobs + C.TotJobs,
					CubeQueuePrinter.SN = CubeQueuePrinter.SN + C.SN, CubeQueuePrinter.SV = CubeQueuePrinter.SV + C.SV,
					CubeQueuePrinter.EN = CubeQueuePrinter.EN + C.EN, CubeQueuePrinter.EV = CubeQueuePrinter.EV + C.EV
				FROM ( SELECT	Data, PrinterQueueID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
								SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
								SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
								SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
								SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
								SUM (TotJobs) AS TotJobs,
								SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV
							FROM @Queue 
							GROUP BY Data, PrinterQueueID) AS C
				WHERE	CubeQueuePrinter.Data = C.Data AND CubeQueuePrinter.PrinterQueueID = C.PrinterQueueID
			
			IF(@@Error <> 0)-- OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END	

			PRINT 'INSERE EM CUBEMACHINEID'
			UPDATE CubeMachineID
				SET CubeMachineID.CDFN = CubeMachineID.CDFN + C.CDFN, CubeMachineID.CDFV = CubeMachineID.CDFV + C.CDFV, CubeMachineID.CDCN = CubeMachineID.CDCN + C.CDCN,
					CubeMachineID.CDCV = CubeMachineID.CDCV + C.CDCV, CubeMachineID.CDIN = CubeMachineID.CDIN + C.CDIN,	CubeMachineID.CDIV = CubeMachineID.CDIV + C.CDIV,
					CubeMachineID.CSFN = CubeMachineID.CSFN + C.CSFN, CubeMachineID.CSFV = CubeMachineID.CSFV + C.CSFV,	CubeMachineID.CSCN = CubeMachineID.CSCN + C.CSCN,
					CubeMachineID.CSCV = CubeMachineID.CSCV + C.CSCV, CubeMachineID.CSIN = CubeMachineID.CSIN + C.CSIN, CubeMachineID.CSIV = CubeMachineID.CSIV + C.CSIV, 
					CubeMachineID.PDFN = CubeMachineID.PDFN + C.PDFN, CubeMachineID.PDFV = CubeMachineID.PDFV + C.PDFV, CubeMachineID.PDCN = CubeMachineID.PDCN + C.PDCN, 
					CubeMachineID.PDCV = CubeMachineID.PDCV + C.PDCV, CubeMachineID.PDIN = CubeMachineID.PDIN + C.PDIN,	CubeMachineID.PDIV = CubeMachineID.PDIV + C.PDIV,
					CubeMachineID.PSFN = CubeMachineID.PSFN + C.PSFN, CubeMachineID.PSFV = CubeMachineID.PSFV + C.PSFV,	CubeMachineID.PSCN = CubeMachineID.PSCN + C.PSCN, 
					CubeMachineID.PSCV = CubeMachineID.PSCV + C.PSCV, CubeMachineID.PSIN = CubeMachineID.PSIN + C.PSIN, CubeMachineID.PSIV = CubeMachineID.PSIV + C.PSIV,
					CubeMachineID.TotJobs = CubeMachineID.TotJobs + C.TotJobs,
					CubeMachineID.SN = CubeMachineID.SN + C.SN, CubeMachineID.SV = CubeMachineID.SV + C.SV,
					CubeMachineID.EN = CubeMachineID.EN + C.EN, CubeMachineID.EV = CubeMachineID.EV + C.EV
				FROM ( SELECT	Data, MachineID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV,
								SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN,
								SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV,
								SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN,
								SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
								SUM (TotJobs) AS TotJobs,
								SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV
							FROM @Machine 
							GROUP BY Data, MachineID) AS C
				WHERE	CubeMachineID.Data = C.Data AND CubeMachineID.MachineID = C.MachineID
			
			IF(@@Error <> 0)-- OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END	

			PRINT 'INSERE EM CUBECOSTACCOUNTID'
			UPDATE CubeCostAccountID
				SET CubeCostAccountID.CDFN = CubeCostAccountID.CDFN + C.CDFN, CubeCostAccountID.CDFV = CubeCostAccountID.CDFV + C.CDFV, CubeCostAccountID.CDCN = CubeCostAccountID.CDCN + C.CDCN,
					CubeCostAccountID.CDCV = CubeCostAccountID.CDCV + C.CDCV, CubeCostAccountID.CDIN = CubeCostAccountID.CDIN + C.CDIN,	CubeCostAccountID.CDIV = CubeCostAccountID.CDIV + C.CDIV,
					CubeCostAccountID.CSFN = CubeCostAccountID.CSFN + C.CSFN, CubeCostAccountID.CSFV = CubeCostAccountID.CSFV + C.CSFV,	CubeCostAccountID.CSCN = CubeCostAccountID.CSCN + C.CSCN,
					CubeCostAccountID.CSCV = CubeCostAccountID.CSCV + C.CSCV,	CubeCostAccountID.CSIN = CubeCostAccountID.CSIN + C.CSIN, CubeCostAccountID.CSIV = CubeCostAccountID.CSIV + C.CSIV, 
					CubeCostAccountID.PDFN = CubeCostAccountID.PDFN + C.PDFN, CubeCostAccountID.PDFV = CubeCostAccountID.PDFV + C.PDFV, CubeCostAccountID.PDCN = CubeCostAccountID.PDCN + C.PDCN, 
					CubeCostAccountID.PDCV = CubeCostAccountID.PDCV + C.PDCV, CubeCostAccountID.PDIN = CubeCostAccountID.PDIN + C.PDIN,	CubeCostAccountID.PDIV = CubeCostAccountID.PDIV + C.PDIV,
					CubeCostAccountID.PSFN = CubeCostAccountID.PSFN + C.PSFN, CubeCostAccountID.PSFV = CubeCostAccountID.PSFV + C.PSFV,	CubeCostAccountID.PSCN = CubeCostAccountID.PSCN + C.PSCN, 
					CubeCostAccountID.PSCV = CubeCostAccountID.PSCV + C.PSCV,	CubeCostAccountID.PSIN = CubeCostAccountID.PSIN + C.PSIN, CubeCostAccountID.PSIV = CubeCostAccountID.PSIV + C.PSIV,
					CubeCostAccountID.TotJobs = CubeCostAccountID.TotJobs + C.TotJobs,
					CubeCostAccountID.SN = CubeCostAccountID.SN + C.SN, CubeCostAccountID.SV = CubeCostAccountID.SV + C.SV,
					CubeCostAccountID.EN = CubeCostAccountID.EN + C.EN, CubeCostAccountID.EV = CubeCostAccountID.EV + C.EV
				FROM ( SELECT	Data, CostAccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
								SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
								SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
								SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
								SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV,
								SUM (TotJobs) AS TotJobs,
								SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV
							FROM @CostAccount 
							GROUP BY Data, CostAccountID) AS C
				WHERE	CubeCostAccountID.Data = C.Data AND CubeCostAccountID.CostAccountID = C.CostAccountID

			IF (@@Error <> 0 )--OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END					

			-- Atualiza os valores correspondentes nos cubos Week/MONTH
			PRINT 'INSERE EM CUBEUSERACCOUNTWEEK'
			UPDATE CubeUserAccountWeek			
				SET CubeUserAccountWeek.CDFN = CubeUserAccountWeek.CDFN + C.CDFN, CubeUserAccountWeek.CDFV = CubeUserAccountWeek.CDFV + C.CDFV, CubeUserAccountWeek.CDCN = CubeUserAccountWeek.CDCN + C.CDCN,
					CubeUserAccountWeek.CDCV = CubeUserAccountWeek.CDCV + C.CDCV, CubeUserAccountWeek.CDIN = CubeUserAccountWeek.CDIN + C.CDIN,	CubeUserAccountWeek.CDIV = CubeUserAccountWeek.CDIV + C.CDIV,
					CubeUserAccountWeek.CSFN = CubeUserAccountWeek.CSFN + C.CSFN, CubeUserAccountWeek.CSFV = CubeUserAccountWeek.CSFV + C.CSFV,	CubeUserAccountWeek.CSCN = CubeUserAccountWeek.CSCN + C.CSCN,
					CubeUserAccountWeek.CSCV = CubeUserAccountWeek.CSCV + C.CSCV, CubeUserAccountWeek.CSIN = CubeUserAccountWeek.CSIN + C.CSIN, CubeUserAccountWeek.CSIV = CubeUserAccountWeek.CSIV + C.CSIV, 
					CubeUserAccountWeek.PDFN = CubeUserAccountWeek.PDFN + C.PDFN, CubeUserAccountWeek.PDFV = CubeUserAccountWeek.PDFV + C.PDFV, CubeUserAccountWeek.PDCN = CubeUserAccountWeek.PDCN + C.PDCN, 
					CubeUserAccountWeek.PDCV = CubeUserAccountWeek.PDCV + C.PDCV, CubeUserAccountWeek.PDIN = CubeUserAccountWeek.PDIN + C.PDIN,	CubeUserAccountWeek.PDIV = CubeUserAccountWeek.PDIV + C.PDIV,
					CubeUserAccountWeek.PSFN = CubeUserAccountWeek.PSFN + C.PSFN, CubeUserAccountWeek.PSFV = CubeUserAccountWeek.PSFV + C.PSFV,	CubeUserAccountWeek.PSCN = CubeUserAccountWeek.PSCN + C.PSCN, 
					CubeUserAccountWeek.PSCV = CubeUserAccountWeek.PSCV + C.PSCV, CubeUserAccountWeek.PSIN = CubeUserAccountWeek.PSIN + C.PSIN, CubeUserAccountWeek.PSIV = CubeUserAccountWeek.PSIV + C.PSIV,
					CubeUserAccountWeek.TotJobs = CubeUserAccountWeek.TotJobs + C.TotJobs,
					CubeUserAccountWeek.SN = CubeUserAccountWeek.SN + C.SN, CubeUserAccountWeek.SV = CubeUserAccountWeek.SV + C.SV,
					CubeUserAccountWeek.EN = CubeUserAccountWeek.EN + C.EN, CubeUserAccountWeek.EV = CubeUserAccountWeek.EV + C.EV
				FROM (SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, AccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, AccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 
											CASE WHEN DAY(Data) < 8 THEN 1 
												 WHEN DAY(Data) < 15 AND DAY(Data) > 7 THEN 8
												 WHEN DAY(Data) < 22 AND DAY(Data) > 14 THEN 15
												 WHEN DAY(Data) > 21 THEN 22 END AS dia
										FROM @User 
										GROUP BY Data, AccountID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , AccountID
				UNION ALL
						SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, AccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, AccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 28 AS dia
										FROM @User 
										GROUP BY Data, AccountID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , AccountID) AS C
				WHERE CubeUserAccountWeek.yearw = C.Ano  AND  
						CubeUserAccountWeek.monthw = C.Mes AND 
						CubeUserAccountWeek.dayw = C.Dia  AND
						CubeUserAccountWeek.AccountID = C.AccountID 

			IF(@@Error <> 0 )--OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END	

			PRINT 'INSERE EM CUBEPRINTERDEVICEWEEK'
			UPDATE CubePrinterDeviceWeek			
				SET CubePrinterDeviceWeek.CDFN = CubePrinterDeviceWeek.CDFN + C.CDFN, CubePrinterDeviceWeek.CDFV = CubePrinterDeviceWeek.CDFV + C.CDFV, CubePrinterDeviceWeek.CDCN = CubePrinterDeviceWeek.CDCN + C.CDCN,
					CubePrinterDeviceWeek.CDCV = CubePrinterDeviceWeek.CDCV + C.CDCV, CubePrinterDeviceWeek.CDIN = CubePrinterDeviceWeek.CDIN + C.CDIN,	CubePrinterDeviceWeek.CDIV = CubePrinterDeviceWeek.CDIV + C.CDIV,
					CubePrinterDeviceWeek.CSFN = CubePrinterDeviceWeek.CSFN + C.CSFN, CubePrinterDeviceWeek.CSFV = CubePrinterDeviceWeek.CSFV + C.CSFV,	CubePrinterDeviceWeek.CSCN = CubePrinterDeviceWeek.CSCN + C.CSCN,
					CubePrinterDeviceWeek.CSCV = CubePrinterDeviceWeek.CSCV + C.CSCV, CubePrinterDeviceWeek.CSIN = CubePrinterDeviceWeek.CSIN + C.CSIN, CubePrinterDeviceWeek.CSIV = CubePrinterDeviceWeek.CSIV + C.CSIV, 
					CubePrinterDeviceWeek.PDFN = CubePrinterDeviceWeek.PDFN + C.PDFN, CubePrinterDeviceWeek.PDFV = CubePrinterDeviceWeek.PDFV + C.PDFV, CubePrinterDeviceWeek.PDCN = CubePrinterDeviceWeek.PDCN + C.PDCN, 
					CubePrinterDeviceWeek.PDCV = CubePrinterDeviceWeek.PDCV + C.PDCV, CubePrinterDeviceWeek.PDIN = CubePrinterDeviceWeek.PDIN + C.PDIN,	CubePrinterDeviceWeek.PDIV = CubePrinterDeviceWeek.PDIV + C.PDIV,
					CubePrinterDeviceWeek.PSFN = CubePrinterDeviceWeek.PSFN + C.PSFN, CubePrinterDeviceWeek.PSFV = CubePrinterDeviceWeek.PSFV + C.PSFV,	CubePrinterDeviceWeek.PSCN = CubePrinterDeviceWeek.PSCN + C.PSCN, 
					CubePrinterDeviceWeek.PSCV = CubePrinterDeviceWeek.PSCV + C.PSCV, CubePrinterDeviceWeek.PSIN = CubePrinterDeviceWeek.PSIN + C.PSIN, CubePrinterDeviceWeek.PSIV = CubePrinterDeviceWeek.PSIV + C.PSIV,
					CubePrinterDeviceWeek.TotJobs = CubePrinterDeviceWeek.TotJobs + C.TotJobs,
					CubePrinterDeviceWeek.SN = CubePrinterDeviceWeek.SN + C.SN, CubePrinterDeviceWeek.SV = CubePrinterDeviceWeek.SV + C.SV,
					CubePrinterDeviceWeek.EN = CubePrinterDeviceWeek.EN + C.EN, CubePrinterDeviceWeek.EV = CubePrinterDeviceWeek.EV + C.EV
				FROM (SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, PrinterDeviceID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, PrinterDeviceID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 
											CASE WHEN DAY(Data) < 8 THEN 1 
												 WHEN DAY(Data) < 15 AND DAY(Data) > 7 THEN 8
												 WHEN DAY(Data) < 22 AND DAY(Data) > 14 THEN 15
												 WHEN DAY(Data) > 21 THEN 22 END AS dia
										FROM @Printer
										GROUP BY Data, PrinterDeviceID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , PrinterDeviceID
				UNION ALL
						SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, PrinterDeviceID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, PrinterDeviceID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 28 AS dia
										FROM @Printer
										GROUP BY Data, PrinterDeviceID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , PrinterDeviceID) AS C
					WHERE	CubePrinterDeviceWeek.yearw = C.Ano  AND  
							CubePrinterDeviceWeek.monthw = C.Mes AND 
							CubePrinterDeviceWeek.dayw = C.Dia  AND
							CubePrinterDeviceWeek.PrinterDeviceID = C.PrinterDeviceID 
			
			IF(@@Error <> 0)-- OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END	

			PRINT 'INSERE EM CUBEQUEUEPRINTERWEEK'
			UPDATE CubeQueuePrinterWeek			
				SET CubeQueuePrinterWeek.CDFN = CubeQueuePrinterWeek.CDFN + C.CDFN, CubeQueuePrinterWeek.CDFV = CubeQueuePrinterWeek.CDFV + C.CDFV, CubeQueuePrinterWeek.CDCN = CubeQueuePrinterWeek.CDCN + C.CDCN,
					CubeQueuePrinterWeek.CDCV = CubeQueuePrinterWeek.CDCV + C.CDCV, CubeQueuePrinterWeek.CDIN = CubeQueuePrinterWeek.CDIN + C.CDIN,	CubeQueuePrinterWeek.CDIV = CubeQueuePrinterWeek.CDIV + C.CDIV,
					CubeQueuePrinterWeek.CSFN = CubeQueuePrinterWeek.CSFN + C.CSFN, CubeQueuePrinterWeek.CSFV = CubeQueuePrinterWeek.CSFV + C.CSFV,	CubeQueuePrinterWeek.CSCN = CubeQueuePrinterWeek.CSCN + C.CSCN,
					CubeQueuePrinterWeek.CSCV = CubeQueuePrinterWeek.CSCV + C.CSCV, CubeQueuePrinterWeek.CSIN = CubeQueuePrinterWeek.CSIN + C.CSIN, CubeQueuePrinterWeek.CSIV = CubeQueuePrinterWeek.CSIV + C.CSIV, 
					CubeQueuePrinterWeek.PDFN = CubeQueuePrinterWeek.PDFN + C.PDFN, CubeQueuePrinterWeek.PDFV = CubeQueuePrinterWeek.PDFV + C.PDFV, CubeQueuePrinterWeek.PDCN = CubeQueuePrinterWeek.PDCN + C.PDCN, 
					CubeQueuePrinterWeek.PDCV = CubeQueuePrinterWeek.PDCV + C.PDCV, CubeQueuePrinterWeek.PDIN = CubeQueuePrinterWeek.PDIN + C.PDIN,	CubeQueuePrinterWeek.PDIV = CubeQueuePrinterWeek.PDIV + C.PDIV,
					CubeQueuePrinterWeek.PSFN = CubeQueuePrinterWeek.PSFN + C.PSFN, CubeQueuePrinterWeek.PSFV = CubeQueuePrinterWeek.PSFV + C.PSFV,	CubeQueuePrinterWeek.PSCN = CubeQueuePrinterWeek.PSCN + C.PSCN, 
					CubeQueuePrinterWeek.PSCV = CubeQueuePrinterWeek.PSCV + C.PSCV, CubeQueuePrinterWeek.PSIN = CubeQueuePrinterWeek.PSIN + C.PSIN, CubeQueuePrinterWeek.PSIV = CubeQueuePrinterWeek.PSIV + C.PSIV,
					CubeQueuePrinterWeek.TotJobs = CubeQueuePrinterWeek.TotJobs + C.TotJobs,
					CubeQueuePrinterWeek.SN = CubeQueuePrinterWeek.SN + C.SN, CubeQueuePrinterWeek.SV = CubeQueuePrinterWeek.SV + C.SV,
					CubeQueuePrinterWeek.EN = CubeQueuePrinterWeek.EN + C.EN, CubeQueuePrinterWeek.EV = CubeQueuePrinterWeek.EV + C.EV
				FROM ( SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, PrinterQueueID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, PrinterQueueID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 
											CASE WHEN DAY(Data) < 8 THEN 1 
												 WHEN DAY(Data) < 15 AND DAY(Data) > 7 THEN 8
												 WHEN DAY(Data) < 22 AND DAY(Data) > 14 THEN 15
												 WHEN DAY(Data) > 21 THEN 22 END AS dia
										FROM @Queue
										GROUP BY Data, PrinterQueueID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , PrinterQueueID
				UNION ALL
						SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, PrinterQueueID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, PrinterQueueID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 28 AS dia
										FROM @Queue
										GROUP BY Data, PrinterQueueID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , PrinterQueueID) AS C
					WHERE	CubeQueuePrinterWeek.yearw = C.Ano  AND  
							CubeQueuePrinterWeek.monthw = C.Mes AND 
							CubeQueuePrinterWeek.dayw = C.Dia  AND
							CubeQueuePrinterWeek.PrinterQueueID = C.PrinterQueueID
			
			IF(@@Error <> 0)-- OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END	

			PRINT 'INSERE EM CUBEMACHINEIDWEEK'
			UPDATE CubeMachineIDWeek
				SET CubeMachineIDWeek.CDFN = CubeMachineIDWeek.CDFN + C.CDFN, CubeMachineIDWeek.CDFV = CubeMachineIDWeek.CDFV + C.CDFV, CubeMachineIDWeek.CDCN = CubeMachineIDWeek.CDCN + C.CDCN,
					CubeMachineIDWeek.CDCV = CubeMachineIDWeek.CDCV + C.CDCV, CubeMachineIDWeek.CDIN = CubeMachineIDWeek.CDIN + C.CDIN,	CubeMachineIDWeek.CDIV = CubeMachineIDWeek.CDIV + C.CDIV,
					CubeMachineIDWeek.CSFN = CubeMachineIDWeek.CSFN + C.CSFN, CubeMachineIDWeek.CSFV = CubeMachineIDWeek.CSFV + C.CSFV,	CubeMachineIDWeek.CSCN = CubeMachineIDWeek.CSCN + C.CSCN,
					CubeMachineIDWeek.CSCV = CubeMachineIDWeek.CSCV + C.CSCV, CubeMachineIDWeek.CSIN = CubeMachineIDWeek.CSIN + C.CSIN, CubeMachineIDWeek.CSIV = CubeMachineIDWeek.CSIV + C.CSIV, 
					CubeMachineIDWeek.PDFN = CubeMachineIDWeek.PDFN + C.PDFN, CubeMachineIDWeek.PDFV = CubeMachineIDWeek.PDFV + C.PDFV, CubeMachineIDWeek.PDCN = CubeMachineIDWeek.PDCN + C.PDCN, 
					CubeMachineIDWeek.PDCV = CubeMachineIDWeek.PDCV + C.PDCV, CubeMachineIDWeek.PDIN = CubeMachineIDWeek.PDIN + C.PDIN,	CubeMachineIDWeek.PDIV = CubeMachineIDWeek.PDIV + C.PDIV,
					CubeMachineIDWeek.PSFN = CubeMachineIDWeek.PSFN + C.PSFN, CubeMachineIDWeek.PSFV = CubeMachineIDWeek.PSFV + C.PSFV,	CubeMachineIDWeek.PSCN = CubeMachineIDWeek.PSCN + C.PSCN, 
					CubeMachineIDWeek.PSCV = CubeMachineIDWeek.PSCV + C.PSCV, CubeMachineIDWeek.PSIN = CubeMachineIDWeek.PSIN + C.PSIN, CubeMachineIDWeek.PSIV = CubeMachineIDWeek.PSIV + C.PSIV,
					CubeMachineIDWeek.TotJobs = CubeMachineIDWeek.TotJobs + C.TotJobs,
					CubeMachineIDWeek.SN = CubeMachineIDWeek.SN + C.SN, CubeMachineIDWeek.SV = CubeMachineIDWeek.SV + C.SV,
					CubeMachineIDWeek.EN = CubeMachineIDWeek.EN + C.EN, CubeMachineIDWeek.EV = CubeMachineIDWeek.EV + C.EV
				FROM ( SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, MachineID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, MachineID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 
											CASE WHEN DAY(Data) < 8 THEN 1 
												 WHEN DAY(Data) < 15 AND DAY(Data) > 7 THEN 8
												 WHEN DAY(Data) < 22 AND DAY(Data) > 14 THEN 15
												 WHEN DAY(Data) > 21 THEN 22 END AS dia
										FROM @Machine
										GROUP BY Data, MachineID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , MachineID
				UNION ALL
						SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, MachineID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, MachineID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 28 AS dia
										FROM @Machine
										GROUP BY Data, MachineID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , MachineID) AS C
					WHERE	CubeMachineIDWeek.yearw = C.Ano  AND  
							CubeMachineIDWeek.monthw = C.Mes AND 
							CubeMachineIDWeek.dayw = C.Dia  AND
							CubeMachineIDWeek.MachineID = C.MachineID
			
			IF(@@Error <> 0) --OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END	

			PRINT 'INSERE EM CUBECOSTACCOUNTIDWEEK'
			UPDATE CubeCostAccountIDWeek
				SET CubeCostAccountIDWeek.CDFN = CubeCostAccountIDWeek.CDFN + C.CDFN, CubeCostAccountIDWeek.CDFV = CubeCostAccountIDWeek.CDFV + C.CDFV, CubeCostAccountIDWeek.CDCN = CubeCostAccountIDWeek.CDCN + C.CDCN,
					CubeCostAccountIDWeek.CDCV = CubeCostAccountIDWeek.CDCV + C.CDCV, CubeCostAccountIDWeek.CDIN = CubeCostAccountIDWeek.CDIN + C.CDIN,	CubeCostAccountIDWeek.CDIV = CubeCostAccountIDWeek.CDIV + C.CDIV,
					CubeCostAccountIDWeek.CSFN = CubeCostAccountIDWeek.CSFN + C.CSFN, CubeCostAccountIDWeek.CSFV = CubeCostAccountIDWeek.CSFV + C.CSFV,	CubeCostAccountIDWeek.CSCN = CubeCostAccountIDWeek.CSCN + C.CSCN,
					CubeCostAccountIDWeek.CSCV = CubeCostAccountIDWeek.CSCV + C.CSCV,	CubeCostAccountIDWeek.CSIN = CubeCostAccountIDWeek.CSIN + C.CSIN, CubeCostAccountIDWeek.CSIV = CubeCostAccountIDWeek.CSIV + C.CSIV, 
					CubeCostAccountIDWeek.PDFN = CubeCostAccountIDWeek.PDFN + C.PDFN, CubeCostAccountIDWeek.PDFV = CubeCostAccountIDWeek.PDFV + C.PDFV, CubeCostAccountIDWeek.PDCN = CubeCostAccountIDWeek.PDCN + C.PDCN, 
					CubeCostAccountIDWeek.PDCV = CubeCostAccountIDWeek.PDCV + C.PDCV, CubeCostAccountIDWeek.PDIN = CubeCostAccountIDWeek.PDIN + C.PDIN,	CubeCostAccountIDWeek.PDIV = CubeCostAccountIDWeek.PDIV + C.PDIV,
					CubeCostAccountIDWeek.PSFN = CubeCostAccountIDWeek.PSFN + C.PSFN, CubeCostAccountIDWeek.PSFV = CubeCostAccountIDWeek.PSFV + C.PSFV,	CubeCostAccountIDWeek.PSCN = CubeCostAccountIDWeek.PSCN + C.PSCN, 
					CubeCostAccountIDWeek.PSCV = CubeCostAccountIDWeek.PSCV + C.PSCV,	CubeCostAccountIDWeek.PSIN = CubeCostAccountIDWeek.PSIN + C.PSIN, CubeCostAccountIDWeek.PSIV = CubeCostAccountIDWeek.PSIV + C.PSIV,
					CubeCostAccountIDWeek.TotJobs = CubeCostAccountIDWeek.TotJobs + C.TotJobs,
					CubeCostAccountIDWeek.SN = CubeCostAccountIDWeek.SN + C.SN, CubeCostAccountIDWeek.SV = CubeCostAccountIDWeek.SV + C.SV,
					CubeCostAccountIDWeek.EN = CubeCostAccountIDWeek.EN + C.EN, CubeCostAccountIDWeek.EV = CubeCostAccountIDWeek.EV + C.EV
				FROM ( SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, CostAccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, CostAccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 
											CASE WHEN DAY(Data) < 8 THEN 1 
												 WHEN DAY(Data) < 15 AND DAY(Data) > 7 THEN 8
												 WHEN DAY(Data) < 22 AND DAY(Data) > 14 THEN 15
												 WHEN DAY(Data) > 21 THEN 22 END AS dia
										FROM @CostAccount
										GROUP BY Data, CostAccountID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , CostAccountID
				UNION ALL
						SELECT	YEAR(Data) AS ano, MONTH(data) AS mes, CostAccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
									SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
									SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
									SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
									SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
									SUM (TotJobs) AS TotJobs,
									SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, dia
							FROM ( SELECT	Data, CostAccountID, SUM (CDFN) AS CDFN,  SUM (CDFV) AS CDFV, SUM (CDCN) AS CDCN, SUM (CDCV) AS CDCV, 
											SUM (CDIN) AS CDIN, SUM (CDIV) AS CDIV, SUM (CSFN) AS CSFN, SUM (CSFV) AS CSFV, SUM (CSCN) AS CSCN, 
											SUM (CSCV) AS CSCV, SUM (CSIN) AS CSIN, SUM (CSIV) AS CSIV, SUM (PDFN) AS PDFN,  SUM (PDFV) AS PDFV, 
											SUM (PDCN) AS PDCN, SUM (PDCV) AS PDCV, SUM (PDIN) AS PDIN, SUM (PDIV) AS PDIV, SUM (PSFN) AS PSFN, 
											SUM (PSFV) AS PSFV, SUM (PSCN) AS PSCN, SUM (PSCV) AS PSCV, SUM (PSIN) AS PSIN, SUM (PSIV) AS PSIV, 
											SUM (TotJobs) AS TotJobs,
											SUM (SN) AS SN, SUM (SV) AS SV, SUM (EN) AS EN, SUM (EV) AS EV, 28 AS dia
										FROM @CostAccount
										GROUP BY Data, CostAccountID) AS Te
							GROUP BY YEAR(Data), MONTH(data), dia , CostAccountID) AS C
					WHERE   CubeCostAccountIDWeek.yearw = C.Ano  AND  
							CubeCostAccountIDWeek.monthw = C.Mes AND 
							CubeCostAccountIDWeek.dayw = C.Dia  AND
							CubeCostAccountIDWeek.CostAccountID = C.CostAccountID

			IF (@@Error <> 0 )--OR @@RowCount = 0)
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar Cubos!', 16, 1)
				RETURN
			END

			UPDATE 
				PrintJobsSaveToner
			SET
				PrinterQueueID = I.PrinterQueueID,
				PrinterDeviceID = I.PrinterDeviceID,
				AccountID = I.AccountID,
				JobTypeID = I.JobTypeID,
				SpoolSize = I.SpoolSize,
				Title = I.Title,
				DatePrinted = I.DatePrinted,
				DateInclude = I.DateInclude,
				PagesColor = I.PagesColor,
				PagesMono = I.PagesMono
			FROM
				Inserted I
				INNER JOIN PrintJobsSaveToner PJST ON I.PrintJobID = PJST.PrintJobID

			IF (@@Error <> 0 )
			BEGIN
				ROLLBACK
				RAISERROR('Erro ao atualizar a PrintJobsSaveToner!', 16, 1)
				RETURN
			END

END
```

---

