# User-Defined Functions

**Total Functions:** 75

---

## 1. AccountHasAliases

```sql
CREATE FUNCTION [dbo].[AccountHasAliases](@AccountID INT) RETURNS BIT
BEGIN 
 
	DECLARE @EXISTS BIT
	SET @EXISTS = 0
 
	IF EXISTS(SELECT 1 FROM AccountsAliases WHERE AccountID = @AccountID)
	BEGIN
		SET @EXISTS = 1
	END

	RETURN @EXISTS 
 
END
```

---

## 2. GetAccountPermission

```sql
CREATE FUNCTION [dbo].[GetAccountPermission](@AccountID INT, @PermissionControlID SMALLINT) RETURNS SMALLINT
BEGIN 

	DECLARE @PermissionAccessID SMALLINT
	--SET @PermissionAccessID = -1
	
	SELECT
		@PermissionAccessID = AP.PermissionAccessID
	FROM
		Accounts AC
		LEFT JOIN AccountsPermissions AP ON AP.AccountID = AC.AccountID
	WHERE
		AC.AccountID = @AccountID
		AND AP.PermissionControlID = @PermissionControlID
 
	RETURN @PermissionAccessID
	
END
```

---

## 3. GetCostAccountExists

```sql
CREATE FUNCTION [dbo].[GetCostAccountExists](@CostAccountID INT) RETURNS INT

BEGIN 
	
	IF EXISTS(SELECT 1 FROM CostAccounts WHERE CostAccountID = @CostAccountID)
	BEGIN
		RETURN @CostAccountID
	END
	
	RETURN -1

END
```

---

## 4. GetCostAccountHierarchy

```sql
CREATE FUNCTION [dbo].[GetCostAccountHierarchy](@CostAccountID INT) 
	RETURNS NVARCHAR(4000)

BEGIN 

	--***********************************************************************************************************
	-- Função que busca o caminho completo de uma conta.
	--
	-- Héber Savedra, 2016-03-28
	--***********************************************************************************************************

	DECLARE @Path NVARCHAR(4000) 
	
	;WITH CostAccountHierarchy(CostAccountID, CostAccountParentID, [Level]) AS
	(
		SELECT
			CostAccountID, 
			CostAccountParentID, 
			1 AS [Level] 
		FROM 
			CostAccounts 
		WHERE
			CostAccountID = @CostAccountID

		UNION ALL

		SELECT
			CA.CostAccountID,
			CA.CostAccountParentID,
			[Level] + 1
		FROM 
			CostAccounts CA
			INNER JOIN CostAccountHierarchy CAH ON CAH.CostAccountParentID = CA.CostAccountID
	)

	SELECT
		@Path = COALESCE(@Path + '/', '') + CA.CostAccountName
	FROM 
		CostAccountHierarchy CAH
		INNER JOIN CostAccounts CA ON CA.CostAccountID = CAH.CostAccountID
	ORDER BY
		[Level] DESC

	IF(LEN(@Path) >= 4000)
	BEGIN
		RETURN '...' + RIGHT(@Path, 3997)
	END

	RETURN @Path

END
```

---

## 5. GetCostAccountHierarchyIds

```sql
CREATE FUNCTION [dbo].[GetCostAccountHierarchyIds](@CostAccountID INT) 
	RETURNS NVARCHAR(4000)

BEGIN 

	--***********************************************************************************************************
	-- Função que busca os ids da hierarquia de uma conta.
	--
	-- Akauam Westphal - 17/08/2017
	--***********************************************************************************************************

	DECLARE @Path NVARCHAR(4000) 
	
	;WITH CostAccountHierarchy(CostAccountID, CostAccountParentID, [Level]) AS
	(
		SELECT
			CostAccountID, 
			CostAccountParentID, 
			1 AS [Level] 
		FROM 
			CostAccounts 
		WHERE
			CostAccountID = @CostAccountID

		UNION ALL

		SELECT
			CA.CostAccountID,
			CA.CostAccountParentID,
			[Level] + 1
		FROM 
			CostAccounts CA
			INNER JOIN CostAccountHierarchy CAH ON CAH.CostAccountParentID = CA.CostAccountID
	)

	SELECT
		@Path = COALESCE(@Path + ',', '') + CONVERT(NVARCHAR,CA.CostAccountID)
	FROM 
		CostAccountHierarchy CAH
		INNER JOIN CostAccounts CA ON CA.CostAccountID = CAH.CostAccountID
	ORDER BY
		[Level] DESC	

	RETURN @Path

END
```

---

## 6. GetCostAccountIDWithPeriod

```sql
CREATE FUNCTION [dbo].[GetCostAccountIDWithPeriod](@AccountID INT, @PrinterDeviceID INT, @Date DATETIME) RETURNS INT

BEGIN 
	
	DECLARE @ID INT
	DECLARE @ObjectID INT
	DECLARE @ObjectIsPrinterDevice BIT

	IF ((SELECT CAST(ParameterValue AS INT) FROM Parameters WHERE ParameterName = 'CostAccountsType') = 2) --Tipo de conta
	BEGIN
		SET @ObjectIsPrinterDevice = 1
		SET @ObjectID = @PrinterDeviceID
	END
	ELSE
	BEGIN
		SET @ObjectIsPrinterDevice = 0
		SET @ObjectID = @AccountID
	END

	IF EXISTS (SELECT 1 FROM CostAccountsHistorics WHERE ObjectID =  @ObjectID)
	BEGIN
		--Existe histórico, então busca dele
		SELECT
			@ID = CostAccountID
		FROM
			CostAccountsHistorics 
		WHERE
			ObjectID = @ObjectID
			AND StartDate <= @Date 
		ORDER BY
			StartDate
	END
	ELSE
	BEGIN
		--Não existe histórico, então pega da tabela mesmo 
		IF (@ObjectIsPrinterDevice = 1)
		BEGIN
			SELECT
				@ID  = CostAccountID
			FROM 
				PrintersDevices 
			WHERE 
				PrinterDeviceID = @ObjectID
		END
		ELSE
		BEGIN
			SELECT
				@ID  = CostAccountID
			FROM 
				Accounts 
			WHERE 
				AccountID = @ObjectID
		END
	END

	RETURN ISNULL(@ID, -1)

END
```

---

## 7. GetCostAccountName

```sql
CREATE FUNCTION [dbo].[GetCostAccountName](@CostAccountID INT) RETURNS NVARCHAR(358)
BEGIN 
 
	DECLARE @Parameter NVARCHAR(1)

	SELECT @Parameter = ParameterValue FROM [Parameters] WHERE ParameterName = 'CostAccountsShowCode'

	DECLARE @Name NVARCHAR(255)
	DECLARE @Code NVARCHAR(100)
	
	DECLARE @ReturnName NVARCHAR(255)

	SELECT 
		@Name = CostAccountName,
		@Code = CostAccountCode
	FROM
		CostAccounts 
	WHERE
		CostAccountID = @CostAccountID

	IF (@Parameter = '1')
	BEGIN
		IF (@Code IS NULL)
		BEGIN
			SET @ReturnName =  @Name
		END
		ELSE
		BEGIN
			IF (LTRIM(@Code) = '')
			BEGIN
				SET @ReturnName =  @Name
			END
			ELSE
			BEGIN
				SET @ReturnName =  @Name + ' (' + @Code + ')'
			END
		END
	END
	ELSE
	BEGIN
		SET @ReturnName =  @Name
	END
	
	RETURN(@ReturnName); 
 
END
```

---

## 8. GetDateBeforeFirst

```sql
CREATE FUNCTION [dbo].[GetDateBeforeFirst](@PrinterDeviceID BIGINT, @StartDate DATETIME, @CounterTypeID INT)
RETURNS DATETIME

BEGIN 

	--********************************************************************************************
	-- Maicon Pereira 21/08/2015
	-- Retorna o último contador (sem limite de data) para esta impressora e tipo de contador
	-- Se não achar retorna a data inicial passada
	
	--********************************************************************************************

	DECLARE @StartDateTimeBeforeFirst DATETIME
    
	--Aqui pega o registro imediatamente anterior ao da data passada
	SELECT 
		TOP 1 @StartDateTimeBeforeFirst = DateTimeRead 
	FROM 
		CountersReadings
	INNER JOIN 
		Counters ON Counters.CounterReadingID = CountersReadings.CounterReadingID
	WHERE 
		(DateTimeRead <  @StartDate) AND
		(PrinterDeviceID = @PrinterDeviceID) AND 
		CounterTypeID = @CounterTypeID AND
		Removed = 0
	ORDER BY  
		DateTimeRead DESC
	
	IF (@StartDateTimeBeforeFirst IS NULL)
	BEGIN
		SET @StartDateTimeBeforeFirst = @StartDate
	END
          	
    RETURN (@StartDateTimeBeforeFirst)

END
```

---

## 9. GetDefaultPrinterName1

```sql
CREATE FUNCTION [dbo].[GetDefaultPrinterName1](@IDDevice BIGINT) RETURNS NVARCHAR(200)
BEGIN 
 
	DECLARE @Name NVARCHAR(100)
	DECLARE @Model NVARCHAR(100)
	DECLARE @BrandName NVARCHAR(100)
	DECLARE @Address NVARCHAR(100)
	DECLARE @Type NVARCHAR(100)
	
	DECLARE @ReturnName NVARCHAR(200)

	SELECT 
		@Name  = PrinterDeviceName,		
		@Model = PM.PrinterModelName,
		@Address = AddressName,
		@Type = CASE WHEN IsLocal = 1 THEN 'Local' ELSE 'Network' END,		
		@BrandName = B.BrandName
	FROM
		PrintersDevices PD
		INNER JOIN PrintersModels PM ON PM.PrinterModelID = PD.PrinterModelID
		INNER JOIN Brands B ON PM.BrandID = B.BrandID
	WHERE
		PrinterDeviceID = @IDDevice

	IF (@BrandName <> '')
	BEGIN
		SET @Model =  @BrandName + ' ' + @Model
	END

	IF (@Name = @Model) 
	BEGIN
		SET @ReturnName = @Name + ' - ' + @Address +' ('+ @Type +')'
	END
	ELSE
	BEGIN
		SET @ReturnName = @Name +' ('+ @Model +') - ' + @Address +' ('+ @Type +')'
	END
	 
	 RETURN(@ReturnName); 
 
END
```

---

## 10. GetDefaultPrinterName2

```sql
CREATE FUNCTION [dbo].[GetDefaultPrinterName2](@IDDevice BIGINT) RETURNS NVARCHAR(200)
BEGIN 
 
	DECLARE @Name NVARCHAR(100)
	DECLARE @Model NVARCHAR(100)
	DECLARE @BrandName NVARCHAR(100)
	
	DECLARE @ReturnName  NVARCHAR(200)

	SELECT 
		@Name  = PrinterDeviceName,		
		@Model = PM.PrinterModelName,		
		@BrandName = B.BrandName
	FROM 
		PrintersDevices PD
		INNER JOIN PrintersModels PM ON PM.PrinterModelID = PD.PrinterModelID
		INNER JOIN Brands B ON PM.BrandID = B.BrandID
	WHERE
		PrinterDeviceID = @IDDevice
		
	IF(@BrandName <> '')
	BEGIN
		SET @Model = @BrandName + ' ' + @Model
	END

	IF (@Name = @Model) 
	BEGIN
		SET @ReturnName = @Name
	END
	ELSE
	BEGIN
		SET @ReturnName = @Name +' ('+ @Model +')'
	END
	 
	RETURN(@ReturnName); 
 
END
```

---

## 11. GetDefaultPrinterName3

```sql
CREATE FUNCTION [dbo].[GetDefaultPrinterName3](@IDDevice BIGINT) RETURNS NVARCHAR(200)
BEGIN 
	 
	--essa tem o SN tmb
	DECLARE @Name NVARCHAR(100)
	DECLARE @Model NVARCHAR(100)
	DECLARE @BrandName NVARCHAR(100)
	DECLARE @Address NVARCHAR(100)
	DECLARE @SerialNumber NVARCHAR(100)
	DECLARE @Type NVARCHAR(100)
	DECLARE @ReturnName  NVARCHAR(200)

	SELECT 
		@Name  = PrinterDeviceName,		
		@Model = PM.PrinterModelName,
		@Address = AddressName,
		@Type = CASE WHEN IsLocal = 1 THEN 'Local' ELSE 'Network' END,		
		@BrandName = B.BrandName,
		@SerialNumber= SerialNumber
	FROM 
		PrintersDevices PD
		INNER JOIN PrintersModels PM ON PM.PrinterModelID = PD.PrinterModelID
		INNER JOIN Brands B ON PM.BrandID = B.BrandID
	WHERE 
		PrinterDeviceID = @IDDevice


	IF (@BrandName <> '')
	BEGIN
		SET @Model =  @BrandName + ' ' + @Model
	END

	IF (@Name = @Model) 
	BEGIN
		SET @ReturnName = @Name + ' - ' + @Address +' ('+ @Type +')'
	END
	ELSE
	BEGIN
		SET @ReturnName = @Name +' ('+ @Model +') - ' + @Address +' ('+ @Type +')'
	END

	IF (@SerialNumber <> '')
	BEGIN
		SET @ReturnName = @ReturnName  + ' - SN: ' + @SerialNumber
	END

	RETURN(@ReturnName)
	 
END
```

---

## 12. GetDefaultPrinterName4

```sql
CREATE FUNCTION [dbo].[GetDefaultPrinterName4](@PrinterDeviceID BIGINT) RETURNS NVARCHAR(250)
BEGIN 

	------------------------------------------------------------------------------------------------------
	--Função que busca o texto exibido para identificar a impressora no relatório de análise geral.
	
	--Quando o parâmetro GeneralAnalysisPrinterName:
	--	Não exite ou igual 0: Endereço (Modelo)
	--	Igual 1: Endereço (Nome da impressora)
	------------------------------------------------------------------------------------------------------
 
 	DECLARE @GeneralAnalysisPrinterName NVARCHAR(1)
 	SET @GeneralAnalysisPrinterName = 0
 	
 	SELECT
 		@GeneralAnalysisPrinterName = ParameterValue
 	FROM
 		[Parameters]
 	WHERE
 		ParameterName = 'GeneralAnalysisPrinterName'
	
 	DECLARE @AddressName NVARCHAR(50)
	DECLARE @ModelName NVARCHAR(100)
	DECLARE @BrandName NVARCHAR(100)
	DECLARE @PrinterDeviceName NVARCHAR(100)
	
	DECLARE @ReturnName  NVARCHAR(200)

	SELECT 
		@AddressName  = AddressName,		
		@ModelName = PM.PrinterModelName,		
		@BrandName = B.BrandName,
		@PrinterDeviceName = PD.PrinterDeviceName
	FROM 
		PrintersDevices PD
		INNER JOIN PrintersModels PM ON PM.PrinterModelID = PD.PrinterModelID
		INNER JOIN Brands B ON PM.BrandID = B.BrandID
	WHERE
		PrinterDeviceID = @PrinterDeviceID
		
	IF (@GeneralAnalysisPrinterName = 1)
	BEGIN
		SET @ReturnName = @AddressName +' ('+ @PrinterDeviceName +')'
	END
	ELSE
	BEGIN
		IF(@BrandName <> '')
		BEGIN
			SET @ModelName = @BrandName + ' ' + @ModelName
		END

		SET @ReturnName = @AddressName +' ('+ @ModelName +')'
	END
	 
	RETURN(@ReturnName); 
 
END
```

---

## 13. GetDefaultPrinterType2

```sql
CREATE FUNCTION [dbo].[GetDefaultPrinterType2](@IDDevice BIGINT) RETURNS NVARCHAR(200)
BEGIN 

	DECLARE @Address NVARCHAR(100)
	DECLARE @Type NVARCHAR(100)
	
	DECLARE @ReturnName  NVARCHAR(200)

	SELECT
		@Address = AddressName,
		@Type = CASE WHEN IsLocal = 1 THEN 'Local' ELSE 'Network' END
	FROM
		PrintersDevices 
	WHERE
		PrinterDeviceID = @IDDevice

	SET @ReturnName = @Address + ' (' + @Type + ')'

	RETURN(@ReturnName); 
 
END
```

---

## 14. GetIP

```sql
CREATE FUNCTION [dbo].[GetIP](@MachineID NVARCHAR(18)) RETURNS NVARCHAR(18)
BEGIN 
 
 DECLARE @IP NVARCHAR(18);  
 DECLARE @ReturnIP NVARCHAR(18);
 
 SELECT TOP 1  @IP = mna.IP 
 FROM Machines m
 LEFT JOIN MachinesNetworkAddress mna on m.MachineID = mna.MachineID
 WHERE m.MachineID= @MAchineID
 

 SET @ReturnIP = @IP
 RETURN(@ReturnIP); 
 
END
```

---

## 15. GetLastCounter

```sql
CREATE FUNCTION [dbo].[GetLastCounter](@PrinterDeviceID INT, @CounterTypeID INT) RETURNS BIGINT
BEGIN 

	--***********************************************************************************************************
	-- Maicon Pereira 21/08/2015
	-- Função para pegar o valor do último contador total dessa impressora e desse tipo de contador
	--***********************************************************************************************************
	DECLARE @CounterNumber BIGINT
	
	SELECT 
		TOP 1 @CounterNumber = CounterTotal 
	FROM 
		CountersReadings
	INNER JOIN 
		Counters ON Counters.CounterReadingID = CountersReadings.CounterReadingID
	WHERE 
		PrinterDeviceID = @PrinterDeviceID AND 
		CounterTypeID = @CounterTypeID AND
		Removed = 0
	ORDER BY  
		DateTimeRead DESC

	RETURN(@CounterNumber)

END
```

---

## 16. GetLastDateTimeReadCounter

```sql
CREATE FUNCTION [dbo].[GetLastDateTimeReadCounter](@PrinterDeviceID INT, @CounterTypeID INT) RETURNS DATETIME
BEGIN 

	--***********************************************************************************************************
	-- Maicon Pereira 21/08/2015
	-- Função para pegar a data do último contador total dessa impressora e desse tipo de contador
	--***********************************************************************************************************

	DECLARE @CounterDateTime DATETIME
	
	SELECT 
		TOP 1 @CounterDateTime = MAX (DateTimeRead)	
	FROM 
		CountersReadings
	INNER JOIN 
		Counters ON Counters.CounterReadingID = CountersReadings.CounterReadingID
	WHERE 
		PrinterDeviceID = @PrinterDeviceID AND 
		CounterTypeID = @CounterTypeID AND
		Removed = 0
	
	RETURN(@CounterDateTime)
END
```

---

## 17. GetMachineIP

```sql
CREATE FUNCTION [dbo].[GetMachineIP](@MachineID INT) RETURNS NVARCHAR(18)
BEGIN 
	
	DECLARE @IP NVARCHAR(18)

	SELECT 
		@IP = MNA.IP
	FROM
		MachinesNetworkAddress MNA
	WHERE
		MNA.MachineID = @MachineID
	
	RETURN(@IP); 

END
```

---

## 18. GetMaxIntValue

```sql
CREATE FUNCTION [dbo].[GetMaxIntValue]()

RETURNS INT

AS
BEGIN

	----------------------------------------------------------------------------------------
	-- Diego 08/03/2017
	-- Retorna o valor máximo de um INT
	----------------------------------------------------------------------------------------

    RETURN 2147483647

END
```

---

## 19. GetOperationSystem

```sql
CREATE  FUNCTION [dbo].[GetOperationSystem](@ID BIGINT) RETURNS NVARCHAR(100)
BEGIN 
 
DECLARE @Value NVARCHAR(100);

	SELECT @Value = OperationSystems.OperationSystemName
	FROM    Machines     
	INNER JOIN OperationSystems ON Machines.OperationSystemID = OperationSystems.OperationSystemID 
	WHERE MAchineID = @ID	

 
 RETURN(@Value); 
 
END
```

---

## 20. GetPoliciesBehaviorName

```sql
CREATE FUNCTION [dbo].[GetPoliciesBehaviorName](@PolicyID INT) RETURNS NVARCHAR(100)
BEGIN 
	
	--------------------------------------------------------------------------------------------------------------------------------
	-- Função que retorma a ResourceString com o nome do comportamento da política de impressão, considerando os parâmetros
	-- de comportamento da política de impressão parametrizada na função.
	-- Marco Cevey, 2014-06-25
	-- Alterado o retorno da opção de notificar, Douglas, 2014-10-27
	--------------------------------------------------------------------------------------------------------------------------------

	DECLARE @ResourceString NVARCHAR(200)
	DECLARE @PolicyBehaviorID INT 
	DECLARE @PolicyBehaviorValue INT

	-- Obtém o parâmetro de comportamento e o seu valor, da política de impressão, ignorando os parâmetros de comportamento 6, 7, 12 e 13,
	-- que indicam apenas se o usuario será ou não notificado na aplicação da política de impressão.
	SELECT 
		@PolicyBehaviorID = PolicyBehaviorID,
		@PolicyBehaviorValue = PolicyBehaviorValue
	FROM 
		PoliciesBehaviorsParameters
	WHERE
		PolicyID = @PolicyID 
		AND PolicyBehaviorID NOT IN (6, 7, 12, 13)
	
	SET @ResourceString = 
		CASE @PolicyBehaviorID
			WHEN 1 THEN '@@Allow'
			WHEN 2 THEN '@@AllowOnly'
			WHEN 3 THEN '@@NotifyStation'
			WHEN 4 THEN '@@ToAlert'
			WHEN 5 THEN '@@DontAllow'
			WHEN 8 THEN 
				CASE @PolicyBehaviorValue
					WHEN 0 THEN '@@DoNotConvertToMono'
					WHEN 1 THEN '@@ConvertToMono'
					WHEN 2 THEN '@@SuggestConvertToMono'
				END
			WHEN 9 THEN
				CASE @PolicyBehaviorValue
					WHEN 0 THEN '@@DoNotConvertToDuplex'
					WHEN 1 THEN '@@ConvertToDuplex'
					WHEN 2 THEN '@@SuggestConvertToDuplex'
				END
			WHEN 10 THEN 
				CASE @PolicyBehaviorValue 
					WHEN 0 THEN '@@DoNotStampLogon'
					WHEN 1 THEN '@@StampLogon'
				END
			WHEN 11 THEN 
				CASE @PolicyBehaviorValue
					WHEN 0 THEN '@@DoNotAudit'
					WHEN 1 THEN '@@Audit'
				END
			ELSE ''
		END

	RETURN @ResourceString
	
END
```

---

## 21. GetPoliciesFeaturesMembers

```sql
CREATE FUNCTION [dbo].[GetPoliciesFeaturesMembers](@PolicyID INT, @ReturnType BIT) --0:Feature, 1:Member
	RETURNS NVARCHAR(2000)
	
BEGIN 

	DECLARE @ReturnString NVARCHAR(max)
	DECLARE @CharacterBegin NVARCHAR(1)

	IF (@ReturnType = 0)
	BEGIN
		SET @ReturnString = 'ReturnString'
	
		SELECT 
			@ReturnString = @ReturnString + ', ' + PF.PolicyFeatureName
		FROM
			PoliciesFeaturesParameters PFP
			INNER JOIN PoliciesFeatures PF ON PF.PolicyFeatureID = PFP.PolicyFeatureID
		WHERE
			PolicyID = @PolicyID
		GROUP BY
			PF.PolicyFeatureName,PF.PolicyFeatureID
		ORDER BY
			PF.PolicyFeatureID
			
		SET @ReturnString = REPLACE(@ReturnString, 'ReturnString, ', '') --Caso encontre algo
		RETURN REPLACE(@ReturnString, 'ReturnString', '') --Caso não encontre
	END
	ELSE IF (@ReturnType = 1)
	BEGIN
		SET @ReturnString = ''
	
		DECLARE @CountMembers INT
		
		SELECT @CountMembers = COUNT(1) FROM PoliciesMembers WHERE PolicyID = @PolicyID
		
		IF (@CountMembers = 1)
		BEGIN
			SELECT @ReturnString =
				CASE PM.PolicyMemberType
					WHEN 1 THEN 
						(
					    -- Quando for -2, significa que é todos os usuários.
						CASE PM.ObjectID
							WHEN -2 THEN '@@AllUsers'
							ELSE dbo.GetUserNameDefault(D.DomainName, AC.LogonName, AC.FullName)
						END
						)
					WHEN 2 THEN AG.AccountGroupName
					WHEN 3 THEN 
						(
						-- Quando for -2, significa que é todas AS impressoras.
						CASE PM.ObjectID
							WHEN -2 THEN '@@AllPrinters'
							ELSE dbo.GetDefaultPrinterName1(PD.PrinterDeviceID)
						END
						)
					WHEN 4 THEN PDG.CostGroupName
					WHEN 5 THEN '@@AccountOnPrinterDevice,''' + dbo.GetUserNameDefault(D.DomainName, AC.LogonName, AC.FullName) + ''','''+ dbo.GetDefaultPrinterName1(PD2.PrinterDeviceID) + ''''
				END 
			FROM
				PoliciesMembers PM
				LEFT JOIN Accounts AC ON AC.AccountID = PM.ObjectID AND PM.PolicyMemberType IN (1, 5)
				LEFT JOIN [Domains] D ON D.DomainID = AC.DomainID AND PM.PolicyMemberType IN (1, 5)
				LEFT JOIN AccountsGroups AG ON AG.AccountGroupID = PM.ObjectID  AND PM.PolicyMemberType = 2
				LEFT JOIN PrintersDevices PD ON PD.PrinterDeviceID = PM.ObjectID  AND PM.PolicyMemberType = 3
				LEFT JOIN PrintersDevices PD2 ON PD2.PrinterDeviceID = PM.PrinterDeviceID  AND PM.PolicyMemberType = 5
				LEFT JOIN CostGroups PDG ON PDG.CostGroupID = PM.ObjectID  AND PM.PolicyMemberType = 4
			WHERE
				PolicyID = @PolicyID
				
			RETURN @ReturnString
		END
		ELSE
		BEGIN
			DECLARE @CountUsers INT, @CountPrinters INT, @CountGroups INT
			SET @CountUsers = 0
			SET @CountPrinters = 0
			SET @CountGroups = 0
			
			SELECT @CountUsers = COUNT(1) FROM PoliciesMembers PM WHERE PolicyID = @PolicyID AND PM.PolicyMemberType IN (1, 5)
			SELECT @CountGroups = COUNT(1) FROM PoliciesMembers PM WHERE PolicyID = @PolicyID AND PM.PolicyMemberType IN (2, 4)
			SELECT @CountPrinters = COUNT(1) FROM PoliciesMembers PM WHERE PolicyID = @PolicyID AND PM.PolicyMemberType = 3
				
			SET @CharacterBegin = '';
			IF (@CountUsers = 1)
			BEGIN
				-- Se existe um membro do tipo ususário com id -2, significa que é todos os usuários. 
				IF( EXISTS( SELECT PolicyMemberID FROM PoliciesMembers PM WHERE PM.PolicyID = @PolicyID AND PM.PolicyMemberType = 1 AND PM.ObjectID = -2 ))
				BEGIN
					SET @ReturnString = 'AllUsers'
				END
				ELSE
				BEGIN
					SET @ReturnString = '''' + CAST(@CountUsers AS NVARCHAR) + ' ''+User.ShortName'
				END
				SET @CharacterBegin = '|';
			END
			ELSE IF (@CountUsers > 1)
			BEGIN
				SET @ReturnString = '''' + CAST(@CountUsers AS NVARCHAR) + ' ''+User.ShortNamePlural'
				SET @CharacterBegin = '|';
			END
			
			IF (@CountPrinters = 1)
			BEGIN
				-- Se existe um membro do tipo impressora com id -2, significa que é todos os usuários. 
				IF( EXISTS( SELECT PolicyMemberID FROM PoliciesMembers PM WHERE PM.PolicyID = @PolicyID AND PM.PolicyMemberType = 3 AND PM.ObjectID = -2 ))
				BEGIN
					SET @ReturnString = @ReturnString + @CharacterBegin + '@@AllPrinters'
				END
				ELSE
				BEGIN
					SET @ReturnString =  @ReturnString + @CharacterBegin + '@@''' +  CAST(@CountPrinters AS NVARCHAR) + ' ''+Printer.ShortName'
				END				
				SET @CharacterBegin = '|';
			END
			ELSE IF (@CountPrinters > 1)
			BEGIN
			    SET @ReturnString =  @ReturnString + @CharacterBegin + '@@''' +  CAST(@CountPrinters AS NVARCHAR) + ' ''+Printer.ShortNamePlural'
				SET @CharacterBegin = '|';
			END
			
			IF (@CountGroups = 1)
			BEGIN
				SET @ReturnString =  @ReturnString + @CharacterBegin + '@@''' + CAST(@CountGroups AS NVARCHAR) + ' ''+GROUP.ShortName'
			END
			ELSE IF (@CountGroups > 1)
			BEGIN
				SET @ReturnString =  @ReturnString + @CharacterBegin + '@@''' +  CAST(@CountGroups AS NVARCHAR) + ' ''+GROUP.ShortNamePlural'
			END
			
			RETURN SUBSTRING('@@' + @ReturnString, 0, LEN(@ReturnString)+3)
			
		END
	END

	RETURN ''
	
END
```

---

## 22. GetPoliciesMemberType

```sql
CREATE FUNCTION [dbo].[GetPoliciesMemberType](@PolicyID INT, @ReturnType TINYINT) --0:IsAccount, 1:IsPrinter, 2:IsGroup, 3:IsAccountPrinter
	RETURNS BIT
	
BEGIN 

	DECLARE @RETURN BIT
	SET @RETURN = 0

	IF (@ReturnType = 0)
	BEGIN
		SELECT @RETURN = 1 FROM PoliciesMembers PM WHERE PolicyID = @PolicyID AND PM.PolicyMemberType = 1 GROUP BY PM.PolicyMemberType
	END
	ELSE IF (@ReturnType = 1)
	BEGIN
		SELECT @RETURN = 1 FROM PoliciesMembers PM WHERE PolicyID = @PolicyID AND PM.PolicyMemberType = 3 GROUP BY PM.PolicyMemberType
	END
	ELSE IF (@ReturnType = 2)
	BEGIN
		SELECT @RETURN = 1 FROM PoliciesMembers PM WHERE PolicyID = @PolicyID AND PM.PolicyMemberType IN (2, 4) GROUP BY PM.PolicyMemberType
	END	
	ELSE IF (@ReturnType = 3)
	BEGIN
		SELECT @RETURN = 1 FROM PoliciesMembers PM WHERE PolicyID = @PolicyID AND PM.PolicyMemberType = 5 GROUP BY PM.PolicyMemberType
	END			

	RETURN @RETURN
	
END
```

---

## 23. GetPrinterDeviceConsolidationBillingStatus

```sql
CREATE FUNCTION [dbo].[GetPrinterDeviceConsolidationBillingStatus](@PrinterDeviceID INT) RETURNS BIT
BEGIN

	DECLARE @PDIDMain INT
	SET @PDIDMain = -1
	
	DECLARE @BillingStatus BIT
	
	SELECT
		@PDIDMain = PrinterDeviceMainID
	FROM
		PrintersDevicesConsolidation
	WHERE
		PrinterDeviceConsolidatedID = @PrinterDeviceID
		
	SELECT
		@BillingStatus = CASE
							 WHEN EnabledBillingStatus IN (1, 3) THEN 1
							 ELSE 0
						 END
	FROM
		PrintersDevices
	WHERE
		(@PDIDMain > 0 AND PrinterDeviceID = @PDIDMain)
		OR (@PDIDMain <= 0 AND PrinterDeviceID = @PrinterDeviceID)

	RETURN @BillingStatus
	
END
```

---

## 24. GetPrinterDeviceID

```sql
CREATE FUNCTION [dbo].[GetPrinterDeviceID]
(
	@PrinterDeviceID INT,
	@AddressName NVARCHAR(50),
	@AddressPort NVARCHAR(200),
	@PrinterModelID INT,
	@SerialNumber NVARCHAR(50),
	@AddressMAC NVARCHAR(50)
) RETURNS INT

BEGIN

	--*************************************************************************************************
	--** Alterado para 5.0
	--** Regras continuam AS mesmas. Só mudei para esperar o modelid e nao só o modelname. 
	--** Robson 18/02/2013
	--** Devido as issues: #3801 e #5398,
	--** Foi criado um parâmetro na tabela Parameters GetPrinterDeviceIDDisableConditionalCheck1 para desabilitar determinado condicional.
	--** Assim definindo que a impressora não foi encontrada e que uma nova impressora deve ser criada.
	--** Rafael Machado, 06/06/2017
	--*************************************************************************************************


	DECLARE @PrinterDeviceIDFound INT 

	IF (@PrinterDeviceID = -1)
	BEGIN
	
		--********************************************************************
		-- LIMPEZA DE SERIAL TERÁ QUE SAIR DAQUI. ROBSON.
		
		--Verifica se o SN tem mais do que 3 caracters
		IF(LEN(@SerialNumber) <= 3)
		BEGIN
			SET @SerialNumber = ''
		END
		ELSE IF (REPLACE(@SerialNumber, SUBSTRING(@SerialNumber, 1, 1), '') = '')--Verifica se o SN é composto por caracteres todos iguais
		BEGIN
			SET @SerialNumber = ''
		END
			
			
			
			
		IF (@SerialNumber <> '')
		BEGIN
			--A IMPRESSORA NOVA TEM SERIAL NUMBER
			--PROCURA NO BANCO POR UMA IMPRESSORA COM O MESMO SERIAL
			SELECT
				@PrinterDeviceIDFound = PrinterDeviceID
			FROM 
				PrintersDevices 
			WHERE
				SerialNumber = @SerialNumber

			IF (@PrinterDeviceIDFound IS NULL)		
			BEGIN 			
				-- NÃO ACHOU NO BANCO NENHUMA IMPRESSORA COM ESSE SERIAL	
				IF ( @AddressMAC = '')
				BEGIN
					--O MAC DA IMPRESSORA NOVA NÃO É CONHECIDO
					--PROCURA POR UMA IMPRESSORA NO BANCO COM MESMO IP, MODELO E PORTA, E COM SERIAL NUMBER EM BRANCO,
					SELECT
						@PrinterDeviceIDFound = PD.PrinterDeviceID
					FROM 
						PrintersDevices PD						
					WHERE
						(PD.AddressName = @AddressName) 
						AND (PD.AddressPort = @AddressPort) 
						AND (Pd.PrinterModelID = @PrinterModelID) 
						AND (PD.SerialNumber = '' OR PD.SerialNumber IS NULL)

					IF (@PrinterDeviceIDFound IS NULL)		
					BEGIN 		

						--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
						--PROCURA POR UMA IMPRESSORA NO BANCO COM MESMO IP, PORTA, E COM SERIAL NUMBER EM BRANCO,
						SELECT
							@PrinterDeviceIDFound = PrinterDeviceID
						FROM 
							PrintersDevices 
						WHERE
							(AddressName = @AddressName) 
							AND (AddressPort = @AddressPort) 
							AND (SerialNumber = '' OR SerialNumber IS NULL)

						IF (@PrinterDeviceIDFound IS NULL)		
						BEGIN 		
							--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
							--ENTÃO TEM QUE CRIAR UM NOVO REGISTRO NO BANCO PARA ESTA IMPRESSORA 
							--RETORNA 0 PARA O BUSINESS FAZER ISSO
							SET @PrinterDeviceIDFound = 0
						END
						ELSE
						BEGIN
							--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
							--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
							--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
							--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
							SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
						END
					END
					ELSE
					BEGIN
						--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
						--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
						--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
						--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
						SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
					END

				END
				ELSE
				BEGIN
					-- A IMPRESSORA NOVA TEM UM MAC 
					--PROCURA NO BANCO POR UMA IMPRESSORA COM ESSE MAC E SEM SERIAL NUMBER
					SELECT 
						@PrinterDeviceIDFound = PrinterDeviceID
					FROM
						PrintersDevices 
					WHERE 
						(AddressMAC = @AddressMAC) 
						AND (SerialNumber = '' OR SerialNumber IS NULL)
				
					IF (@PrinterDeviceIDFound IS NULL)			
					BEGIN 	
						-- NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍSTICAS
						--PROCURA POR UMA IMPRESSORA NO BANCO COM MESMO IP, MODELO E PORTA, E COM SERIAL NUMBER EM BRANCO,
						SELECT
							@PrinterDeviceIDFound = PD.PrinterDeviceID
						FROM 
							PrintersDevices PD							
						WHERE 
							(PD.AddressName = @AddressName) 
							AND (PD.AddressPort = @AddressPort) 
							AND (PD.PrinterModelID = @PrinterModelID) 
							AND (PD.SerialNumber = '' OR PD.SerialNumber IS NULL)
	
						IF (@PrinterDeviceIDFound IS NULL )
						BEGIN 		

							--Criamos esse parâmetro (GetPrinterDeviceIDDisableConditionalCheck1) para desabilitar essa verificação.
							--Assim definindo que a impressora não foi encontrada e que uma nova impressora deve ser criada.
							--Issues relacionadas a essa alteração: #3801 e #5398.
							IF EXISTS (SELECT * FROM Parameters WHERE ParameterName = 'GetPrinterDeviceIDDisableConditionalCheck1' AND ParameterValue = '1')
							BEGIN
								SET @PrinterDeviceIDFound = 0
							END
							ELSE
							BEGIN
								--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
								--PROCURA POR UMA IMPRESSORA NO BANCO COM MESMO IP, PORTA, E COM SERIAL NUMBER EM BRANCO,
								SELECT
									@PrinterDeviceIDFound = PrinterDeviceID
								FROM 
									PrintersDevices 
								WHERE 
									(AddressName = @AddressName) 
									AND (AddressPort = @AddressPort) 
									AND (SerialNumber = '' OR SerialNumber IS NULL)

								IF (@PrinterDeviceIDFound IS NULL)		
								BEGIN 		

									--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
									--ENTÃO TEM QUE CRIAR UM NOVO REGISTRO NO BANCO PARA ESTA IMPRESSORA 
									--RETORNA 0 PARA O BUSINESS FAZER ISSO
									SET @PrinterDeviceIDFound = 0
								END
								ELSE
								BEGIN
									--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
									--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
									--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
									--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
									SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
								END
							END
						END
						ELSE
						BEGIN
							--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
							--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
							--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
							--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
							SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
						END

					END
					ELSE
					BEGIN
						--ACHOU NO BANCO A IMPRESSORA COM ESTE MAC E SEM SERIAL NUMBER
						--ATUALIZA OS OUTROS DADOS, INCLUSIVE O SERIAL NUMBER, JÁ QUE NÃO TINHA
						--AQUI NÃO FAZ NADA, NO FINAL DA SP QUE OS DADOS DA IMPRESSORA SERÃO RETORNADOS
						SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
					END
				END		
			END
			ELSE
			BEGIN
				--ACHOU A IMPRESSORA NO BANCO QUE TEM ESSE MESMO SERIAL
				--NÃO FAZ NADA AQUI. RETORNA NO FINAL DA SP OS DADOS DA IMPRESSORA
				SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
			END

		END
		ELSE
		BEGIN
			--O SERIAL NUMBER DA IMPRESSORA NOVA É DESCONHECIDO
			IF (@AddressMAC = '')
			BEGIN
				--O MAC DA IMPRESSORA NOVA NÃO É CONHECIDO
				-- PROCURA POR UMA IMPRESSORA COM O MESMO IP, PORTA E MODELO (E QUALQUER MAC E SERIAL)
				SELECT
					@PrinterDeviceIDFound = PD.PrinterDeviceID
				FROM 
					PrintersDevices PD					
				WHERE
					(PD.AddressName = @AddressName) 
					AND (PD.AddressPort = @AddressPort) 
					AND (PD.PrinterModelID = @PrinterModelID)
			
				IF (@PrinterDeviceIDFound IS NULL)		
				BEGIN 		

					--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
					--PROCURA POR UMA IMPRESSORA NO BANCO COM MESMO IP E PORTA
					SELECT
						@PrinterDeviceIDFound = PrinterDeviceID
					FROM 
						PrintersDevices 
					WHERE
						(AddressName = @AddressName) 
						AND (AddressPort = @AddressPort) 

					IF (@PrinterDeviceIDFound IS NULL)		
					BEGIN 		
						--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
						--ENTÃO TEM QUE CRIAR UM NOVO REGISTRO NO BANCO PARA ESTA IMPRESSORA 
						--RETORNA 0 PARA O BUSINESS FAZER ISSO
						SET @PrinterDeviceIDFound = 0
					END
					ELSE
					BEGIN
						--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
						--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
						--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
						--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
						SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
					END
				END
				ELSE
				BEGIN
					--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
					--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
					--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
					--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
					SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
				END
			END
			ELSE
			BEGIN
				--O MAC DA IMPRESSORA É CONHECIDO
				-- PROCURA POR UMA IMPRESSORA COM ESSE MAC E QUALQUER SERIAL NUMBER
				SELECT 
					@PrinterDeviceIDFound = PrinterDeviceID
				FROM
					PrintersDevices
				WHERE 
					AddressMAC = @AddressMAC

				IF (@PrinterDeviceIDFound  IS NULL)
				BEGIN
					-- NÃO ACHOU A IMPRESSORA COM ESSE MAC
					-- PROCURA POR UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SEM MAC
					SELECT
						@PrinterDeviceIDFound = PD.PrinterDeviceID
					FROM 
						PrintersDevices PD						
					WHERE
						(PD.AddressName = @AddressName) 
						AND (PD.AddressPort = @AddressPort) 
						AND (PD.PrinterModelID = @PrinterModelID)
						AND (PD.AddressMAC = '' OR PD.AddressMAC IS NULL)

					IF (@PrinterDeviceIDFound IS NULL)		
					BEGIN 		
						--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
						--PROCURA POR UMA IMPRESSORA NO BANCO COM MESMO IP E PORTA E SEM MAC
						SELECT
							@PrinterDeviceIDFound = PrinterDeviceID
						FROM 
							PrintersDevices 
						WHERE 
							(AddressName = @AddressName) 
							AND (AddressPort = @AddressPort)  
							AND (AddressMAC = '' OR AddressMAC IS NULL)
	
						IF (@PrinterDeviceIDFound IS NULL)		
						BEGIN 		
							--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
							--ENTÃO TEM QUE CRIAR UM NOVO REGISTRO NO BANCO PARA ESTA IMPRESSORA 
							--RETORNA 0 PARA O BUSINESS FAZER ISSO
							SET @PrinterDeviceIDFound = 0
						END
						ELSE
						BEGIN
							--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
							--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
							--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
							--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
							SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
						END
					END
				ELSE
				BEGIN
					--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
					--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
					--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
					--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
					SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
				END
				END	
				ELSE
				BEGIN
					--ACHOU UMA IMPRESSORA COM ESSE MAC, COM OU SEM SERIAL
					--ATUALIZA OS DADOS DESSA IMPRESSORA, MENOS O SERIAL, PORQUE SE JÁ TIVER UM NO BANCO
					--CONTINUA CERTO. AQUI NÃO FAZ NADA, NO FIM DA SP QUE SERÁ FEITO
					SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
				END			
			END
		END
	END
	ELSE
	BEGIN
		SET @PrinterDeviceIDFound = @PrinterDeviceID
	END

	RETURN (@PrinterDeviceIDFound);

END
```

---

## 25. GetPriorityProductID

```sql
CREATE FUNCTION [dbo].[GetPriorityProductID](@MachineID INT) RETURNS SMALLINT
BEGIN 

	DECLARE @ID SMALLINT;  
	DECLARE @FeatureID SMALLINT;  

	SET @FeatureID = 0;
	
	SELECT 
		@FeatureID = Products.ProductID
	FROM
		Products
		INNER JOIN InstalledProducts ON Products.ProductID = InstalledProducts.ProductID
	WHERE
		MachineID = @MachineID 
		AND ProductName = 'n-Client'

	IF (@FeatureID = 0)
	BEGIN
		SELECT
			@FeatureID = Products.ProductID 
		FROM
			Products
			INNER JOIN InstalledProducts ON Products.ProductID = InstalledProducts.ProductID
		WHERE 
			MachineID = @MachineID 
			AND ProductName = 'n-Track'
			
		IF (@FeatureID = 0)
		BEGIN
			SELECT
				@FeatureID = Products.ProductID 
			FROM
				Products
				INNER JOIN InstalledProducts ON Products.ProductID = InstalledProducts.ProductID
			WHERE 
				MachineID = @MachineID 
				AND ProductName = 'n-Control'
		
			IF (@FeatureID = 0)
			BEGIN
				SELECT TOP 1 
					@FeatureID = Products.ProductID 
				FROM 
					Products
					INNER JOIN InstalledProducts ON Products.ProductID = InstalledProducts.ProductID
				WHERE 
					MachineID = @MachineID 
			END
		END
	END

	SET @ID = @FeatureID
	
	RETURN(@ID); 

END
```

---

## 26. GetProcessQueuePeriod

```sql
CREATE FUNCTION [dbo].[GetProcessQueuePeriod] (@dt DATETIME, @QueueType INT, @ObjectQueueID INT) RETURNS CHAR  

BEGIN 

	--***********************************************************************************************************
	-- Alterado para verificar também na PrintJobsCanceled.
	--
	-- Héber Savedra, 2012-07-27
	--***********************************************************************************************************
	
	DECLARE @AVGLast10Days INT
	
	IF ((@QueueType = 7) OR (@QueueType = 8) OR (@QueueType = 9) OR (@QueueType = 10) OR (@QueueType = 11))--PrinterDevice
	BEGIN
		SELECT
			@AVGLast10Days = AVG(TJ)
		FROM
			(
				SELECT TOP 10 TotJobs AS TJ 
				FROM CubePrinterDevice 
				WHERE PrinterDeviceID = @ObjectQueueID AND Data <= @dt
				ORDER BY Data DESC
			) AS TABLE1

		IF (@AVGLast10Days > 30000) --mais que 30000 jobs por dia atualiza cubos por dia
		BEGIN
			RETURN 'd'
		END
		ELSE IF (@AVGLast10Days > 10000) --mais que 10000 atualiza por semana
		BEGIN
			RETURN 's'
		END
		--senão atualiza por mês
		RETURN 'm'
	END
	ELSE IF ((@QueueType = 5) OR (@QueueType = 4)) --Contas 
	BEGIN
		DECLARE @CostAccountsType INT --1: Usuários, 2: Impressoras e 3: Contas selecionáveis
		SELECT @CostAccountsType = ParameterValue FROM [Parameters] WHERE ParameterName = 'CostAccountsType'

		IF (@CostAccountsType = 2)
		BEGIN
			IF (NOT EXISTS(SELECT TOP 1 PrinterDeviceID FROM PrintJobs WHERE PrinterDeviceID = @ObjectQueueID))
				AND (NOT EXISTS(SELECT TOP 1 PrinterDeviceID FROM PrintJobsCanceled WHERE PrinterDeviceID = @ObjectQueueID))
			BEGIN
				RETURN 'n'	 --diz que nao tem jobs entao nem cria a fila
			END

			SELECT
				@AVGLast10Days = AVG(TJ)
			FROM
				(
					SELECT TOP 10 TotJobs AS TJ
					FROM CubePrinterDevice 
					WHERE PrinterDeviceID = @ObjectQueueID AND Data <= @dt
					ORDER BY Data DESC
				) AS TABLE1
				
			IF (@AVGLast10Days > 30000) --mais que 30000 jobs por dia atualiza cubos por dia
			BEGIN
				RETURN 'd'
			END
			ELSE IF (@AVGLast10Days > 10000) --mais que 10000 atualiza por semana
			BEGIN
				RETURN 's'
			END
			--senão atualiza por mês
			RETURN 'm'
		END
		ELSE
		BEGIN
			IF (NOT EXISTS(SELECT TOP 1 AccountID FROM PrintJobs WHERE AccountID = @ObjectQueueID))
				AND (NOT EXISTS(SELECT TOP 1 AccountID FROM PrintJobsCanceled WHERE AccountID = @ObjectQueueID))
			BEGIN
				RETURN 'n'	 --diz que nao tem jobs entao nem cria a fila
			END

			SELECT
				@AVGLast10Days = AVG(TJ)
			FROM
				(
					SELECT TOP 10 TotJobs AS TJ
					FROM CubeUserAccount 
					WHERE AccountID = @ObjectQueueID AND Data <= @dt
					ORDER BY Data DESC
				) AS TABLE1
				
			IF (@AVGLast10Days > 30000) --mais que 30000 jobs por dia atualiza cubos por dia
			BEGIN
				RETURN 'd'
			END
			ELSE IF (@AVGLast10Days > 10000) --mais que 10000 atualiza por semana
			BEGIN
				RETURN 's'
			END
			--senão atualiza por mês
			RETURN 'm'
		END
	END
	ELSE IF ((@QueueType = 14)) --Account Aliases
	BEGIN
		IF (NOT EXISTS(SELECT TOP 1 AccountID FROM PrintJobs WHERE AccountID = @ObjectQueueID))
			AND (NOT EXISTS(SELECT TOP 1 AccountID FROM PrintJobsCanceled WHERE AccountID = @ObjectQueueID))
		BEGIN
			RETURN 'n'	 --diz que nao tem jobs entao nem cria a fila
		END

		SELECT
			@AVGLast10Days = AVG(TJ)
		FROM
			(
				SELECT TOP 10 TotJobs AS TJ
				FROM CubeUserAccount 
				WHERE AccountID = @ObjectQueueID AND Data <= @dt
				ORDER BY Data DESC
			) AS TABLE1
			
		IF (@AVGLast10Days > 30000) --mais que 30000 jobs por dia atualiza cubos por dia
		BEGIN
			RETURN 'd'
		END
		ELSE IF (@AVGLast10Days > 10000) --mais que 10000 atualiza por semana
		BEGIN
			RETURN 's'
		END
		--senão atualiza por mês
		RETURN 'm'
	END
	ELSE IF((@QueueType = 1) OR (@QueueType = 2))
	BEGIN
		SELECT
			@AVGLast10Days = AVG(TJ)
		FROM
			(
				SELECT TOP 10 TotJobs AS TJ 
				FROM CubeCore 
				WHERE Data <= @dt 
				ORDER BY Data DESC
			) AS TABLE1
			
		IF (@AVGLast10Days > 30000) --mais que 30000 jobs por dia atualiza cubos por dia
		BEGIN
 			RETURN 'd'
		END
		ELSE IF (@AVGLast10Days > 10000) --mais que 10000 atualiza por semana
		BEGIN
			RETURN 's'
		END
		--senão atualiza por mês
		RETURN 'm'
	END 
	--senão atualiza por mês
	RETURN 'm'
	
END
```

---

## 27. GetQuotaPrepaidCardBatchIsExpired

```sql
CREATE FUNCTION [dbo].[GetQuotaPrepaidCardBatchIsExpired](@BatchID INT) RETURNS BIT
BEGIN 
 
  	-- ***************************************************************************************
	-- Rafael, 2014-05-26
	-- Função criada para verificar se um lote está expirado.
	-- ***************************************************************************************
 
	DECLARE @IsExpired BIT
 	 
 	DECLARE @DateTimeNow DATETIME
	SET @DateTimeNow = GETDATE()
 	
	SELECT
		@IsExpired = CASE WHEN QPCB.ExpirationDate < @DateTimeNow THEN 1 ELSE 0 END 
	FROM 
		QuotasPrepaidCardsBatches QPCB
		LEFT JOIN QuotasPrepaidCardsCodes QPCC ON QPCB.BatchID = QPCC.BatchID
	WHERE
		QPCB.BatchID = @BatchID
		
 	RETURN @IsExpired
 
END
```

---

## 28. GetQuotasAccounts_RetrieveAllBalances

```sql
CREATE FUNCTION [dbo].[GetQuotasAccounts_RetrieveAllBalances]()
RETURNS 
@TBBalances TABLE
		(
			AccountID INT,
			CostAccountID INT,
			TotalPages INT,
			PagesMono INT,
			PagesColor INT,
			MoneyValue DECIMAL (19, 6),
			UnlimitedQuotas BIT,
			IsCorporative BIT
		)

AS

BEGIN
	
	-- =============================================
	-- Author:		Rodrigo Scopel
	-- Change date: 28/11/2019
	-- Description:	Removido processo de apagar balanços de usuários com cotas ilimitadas substituindo por joins que não buscam esses usuários
	-- =============================================
	
	--Busca os balanços dos créditos
	INSERT INTO
		@TBBalances
	SELECT
		ISNULL(QC.AccountID, -1) AS AccountID,
		ISNULL(QC.CostAccountID, -1) AS CostAccountID,
		(SUM(QC.TotalPages) - SUM(QC.ExpenseTotalPages)) AS TotalPages,
		(SUM(QC.PagesMono)  - SUM(QC.ExpensePagesMono))  AS PagesMono,
		(SUM(QC.PagesColor) - SUM(QC.ExpensePagesColor)) AS PagesColor,
		(SUM(QC.MoneyValue) - SUM(QC.ExpenseMoneyValue)) AS MoneyValue,
		0, --UnlimitedQuotas
		IsCorporative
	FROM
		QuotasCredits QC
		LEFT JOIN QuotasUnlimited QU ON QC.AccountID = QU.AccountID
	WHERE
		[Enabled] = 1 AND QU.AccountID IS NULL
	GROUP BY
		QC.AccountID,
		QC.CostAccountID,
		QC.IsCorporative

	--Busca os balanços dos créditos expirados
	INSERT INTO
		@TBBalances		
	SELECT
		ISNULL(QC.AccountID, -1) AS AccountID,
		ISNULL(QC.CostAccountID, -1) AS CostAccountID,
		(SUM(QC.TotalPages) - (SUM(QC.ExpenseTotalPages) + SUM(ISNULL(QE.ExpenseTotalPages, 0)))) AS TotalPages,
		(SUM(QC.PagesMono)  - (SUM(QC.ExpensePagesMono)  + SUM(ISNULL(QE.ExpensePagesMono, 0))))  AS PagesMono,
		(SUM(QC.PagesColor) - (SUM(QC.ExpensePagesColor) + SUM(ISNULL(QE.ExpensePagesColor, 0)))) AS PagesColor,
		(SUM(QC.MoneyValue) - (SUM(QC.ExpenseMoneyValue) + SUM(ISNULL(QE.ExpenseMoneyValue, 0)))) AS MoneyValue,
		0, --UnlimitedQuotas
		IsCorporative
	FROM
		QuotasExpires QE
		INNER JOIN QuotasCredits QC ON QC.QuotaCreditID = QE.QuotaCreditID
		LEFT JOIN QuotasUnlimited QU ON QC.AccountID = QU.AccountID
	WHERE
		[Enabled] = 0 AND QU.AccountID IS NULL
		--AND (
		--		ISNULL(QC.AccountID, -1) NOT IN (SELECT AccountID FROM @TBBalances)
		--		OR ISNULL(QC.CostAccountID,-1) NOT IN (SELECT CostAccountID FROM @TBBalances)
		--	)
	GROUP BY
		QC.AccountID,
		QC.CostAccountID,
		QC.IsCorporative
		
		
	--Insere no balanço os usuários que tiveram débito, mas não tem mais créditos, isso quer dizer q estão zerados
	--Deve inserir do tipo corporativo e particular
	INSERT INTO
		@TBBalances
	SELECT DISTINCT
		ISNULL(QD.AccountID, -1) AS AccountID,
		ISNULL(QD.CostAccountID, -1) AS CostAccountID,
		0, 0, 0, 0,
		0, --UnlimitedQuotas
		0 -- IsCorporative
	FROM
		QuotasDebits QD
		LEFT JOIN QuotasUnlimited QU ON QD.AccountID = QU.AccountID
	WHERE
		QU.AccountID IS NULL
	--WHERE
	--	ISNULL(QD.AccountID, -1) NOT IN (SELECT AccountID FROM @TBBalances WHERE IsCorporative = 0)
	--	OR ISNULL(QD.CostAccountID,-1) NOT IN (SELECT CostAccountID FROM @TBBalances WHERE IsCorporative = 0)

	INSERT INTO
		@TBBalances
	SELECT DISTINCT
		ISNULL(QD.AccountID, -1) AS AccountID,
		ISNULL(QD.CostAccountID, -1) AS CostAccountID,
		0, 0, 0, 0,
		0, --UnlimitedQuotas
		1 --IsCorporative
	FROM
		QuotasDebits QD
		LEFT JOIN QuotasUnlimited QU ON QD.AccountID = QU.AccountID
	WHERE
		QU.AccountID IS NULL
	--WHERE
	--	ISNULL(QD.AccountID, -1) NOT IN (SELECT AccountID FROM @TBBalances WHERE IsCorporative = 1)
	--	OR ISNULL(QD.CostAccountID, -1) NOT IN (SELECT CostAccountID FROM @TBBalances WHERE IsCorporative = 1)
		
	--Insere os usuários que tem cotas ilimitadas
	INSERT INTO
		@TBBalances
	SELECT
		AccountID,
		-1, --CostAccountID
		0, 0, 0, 0,
		1, --UnlimitedQuotas
		1 --IsCorporative
	FROM
		QuotasUnlimited
	
	RETURN
END
```

---

## 29. GetQuotasFirstNextDate

```sql
CREATE FUNCTION [dbo].[GetQuotasFirstNextDate](@PeriodType INT, @StartDay INT)
	RETURNS DATETIME
	
BEGIN 

	DECLARE @ReturnDate DATETIME
	
	DECLARE @DateTimeNow DATETIME
	SET @DateTimeNow = DATEADD(DAY, 0, FLOOR(CONVERT(FLOAT, GETDATE())))
	
	IF (@PeriodType = 1) --Weekly = 1
	BEGIN
		--Busca qual a segunda-feira dessa semana
		SET @ReturnDate = DATEADD(WK, DATEDIFF(WK, 0, @DateTimeNow), -1)
		
		--Adiciona os dias necessários
		SET @ReturnDate = DATEADD(DAY, @StartDay - 1, @ReturnDate) 
		
		--Caso seja menor que a data atual, adiciona uma semana
		IF (@ReturnDate < @DateTimeNow)
		BEGIN
			SET @ReturnDate = DATEADD(WEEK, 1, @ReturnDate)
		END
	END
	ELSE IF (@PeriodType = 2) --Monthly = 2
	BEGIN
		DECLARE @LastDayOfMonth INT
	
		--Verifica se esse dia já passou nesse mês
		IF (DATEPART(DAY, @DateTimeNow) > @StartDay)
		BEGIN
			--Adiciona um mês
			SET @ReturnDate = DATEADD(MONTH, 1, @DateTimeNow)
		
			--Busca o último dia do mês		
			SET @LastDayOfMonth = DATEPART(DAY, DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@ReturnDate)+1,0)))
		
			--Compara se o dia indicado está dentro desse mês, se nao estiver diminui para ficar no último dia do mês
			IF (@LastDayOfMonth > @StartDay)
			BEGIN			
				--Retorna a data do próximo mês com o dia especificado
				SET @ReturnDate = CAST(CAST(YEAR(@ReturnDate) AS CHAR(4)) +
								  RIGHT('0' + CAST(MONTH(@ReturnDate) AS NVARCHAR(2)), 2) +
								  RIGHT('0' + CAST(@StartDay AS NVARCHAR(2)), 2) AS DATETIME)
			END
			ELSE
			BEGIN
				SET @ReturnDate = CAST(CAST(YEAR(@ReturnDate) AS CHAR(4)) +
								  RIGHT('0' + CAST(MONTH(@ReturnDate) AS NVARCHAR(2)), 2) +
								  RIGHT('0' + CAST(@LastDayOfMonth AS NVARCHAR(2)), 2) AS DATETIME)
			END
		END
		ELSE
		BEGIN
			--Busca o último dia do mês		
			SET @LastDayOfMonth = DATEPART(DAY, DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,@DateTimeNow)+1,0)))
			
			--Compara se o dia indicado está dentro desse mês, se nao estiver diminui para ficar no último dia do mês
			IF (@LastDayOfMonth > @StartDay)
			BEGIN			
				SET @ReturnDate = CAST(CAST(YEAR(@DateTimeNow) AS CHAR(4)) +
								  RIGHT('0' + CAST(MONTH(@DateTimeNow) AS NVARCHAR(2)), 2) +
								  RIGHT('0' + CAST(@StartDay AS NVARCHAR(2)), 2) AS DATETIME)
			END
			ELSE
			BEGIN
				SET @ReturnDate = CAST(CAST(YEAR(@DateTimeNow) AS CHAR(4)) +
								  RIGHT('0' + CAST(MONTH(@DateTimeNow) AS NVARCHAR(2)), 2) +
								  RIGHT('0' + CAST(@LastDayOfMonth AS NVARCHAR(2)), 2) AS DATETIME)
			END			
		END
	END
	ELSE IF (@PeriodType = 3) --Annual = 3
	BEGIN
		SET @ReturnDate = '1-1-1'
	END	

	RETURN @ReturnDate
	
END
```

---

## 30. GetQuotasNextDate

```sql
CREATE FUNCTION [dbo].[GetQuotasNextDate](@PeriodType INT, @PeriodQuantity INT, @StartDay INT, @NextDate DATETIME)
	RETURNS DATETIME
	
BEGIN 

	DECLARE @ReturnDate DATETIME
	
	IF (@PeriodType = 0) --Daily = 0
	BEGIN
		--Adiciona a quantidade de dias definidos na regra
		SET @ReturnDate = DATEADD(DAY, @PeriodQuantity, @NextDate)
	END
	ELSE IF (@PeriodType = 1) --Weekly = 1
	BEGIN
		--Adiciona a quantidade de semanas definidas na regra
		SET @ReturnDate = DATEADD(WEEK, @PeriodQuantity, @NextDate)
	END
	ELSE IF (@PeriodType = 2) --Monthly = 2
	BEGIN
		DECLARE @LastDayOfMonth INT
	
		--Adiciona a quantidade de meses definidos na regra
		SET @ReturnDate = DATEADD(MONTH, @PeriodQuantity, @NextDate)
	
		--Busca o último dia do mês	atualizado	
		SET @LastDayOfMonth = DATEPART(DAY, DATEADD(s, -1, DATEADD(mm, DATEDIFF(m, 0, @ReturnDate) + 1, 0)))
	
		--Compara se o dia indicado está dentro desse mês, se nao estiver diminui para ficar no último dia do mês
		IF (@LastDayOfMonth > @StartDay)
		BEGIN			
			--Retorna a data do próximo mês com o dia especificado
			SET @ReturnDate = CAST(CAST(YEAR(@ReturnDate) AS CHAR(4)) +
							  RIGHT('0' + CAST(MONTH(@ReturnDate) AS NVARCHAR(2)), 2) +
							  RIGHT('0' + CAST(@StartDay AS NVARCHAR(2)), 2) AS DATETIME)
		END
		ELSE
		BEGIN
			SET @ReturnDate = CAST(CAST(YEAR(@ReturnDate) AS CHAR(4)) +
							  RIGHT('0' + CAST(MONTH(@ReturnDate) AS NVARCHAR(2)), 2) +
							  RIGHT('0' + CAST(@LastDayOfMonth AS NVARCHAR(2)), 2) AS DATETIME)
		END
		
	END
	ELSE IF (@PeriodType = 3) --Annual = 3
	BEGIN
		SET @ReturnDate = '1-1-1'
	END	

	RETURN @ReturnDate
	
END
```

---

## 31. GetReferenceCounters

```sql
CREATE FUNCTION [dbo].[GetReferenceCounters]
	(@PlainCounters PlainCounters READONLY)
RETURNS 
	@ReferenceCounters TABLE (ReferenceMono INT, ReferenceColor INT)

BEGIN

	--*******************************************************************************
	--** Robson, 14/08/2015
	--** Versão contratos
	--** Recebe a lista de contadores e monta os contadores de referencia
	--*******************************************************************************

	DECLARE @REFERENCE_COLOR AS INT
	SET @REFERENCE_COLOR = 0
	DECLARE @REFERENCE_MONO AS INT	
	SET @REFERENCE_MONO = 0
	
	SELECT 
	  @REFERENCE_COLOR = PC.CounterColor
	FROM 
		@PlainCounters AS PC 
		INNER JOIN CounterTypes AS CT ON PC.CounterTypeID = CT.CounterTypeID 
	WHERE 
		CT.CounterTypeName = 'Total'
				
	IF((@REFERENCE_COLOR IS NULL) OR (@REFERENCE_COLOR = 0))
	BEGIN 			
	
		SELECT 
			@REFERENCE_COLOR = SUM(PC.CounterColor)
		FROM 
			@PlainCounters AS PC 
			INNER JOIN CounterTypes AS CT ON PC.CounterTypeID = CT.CounterTypeID
		WHERE 
			CT.CounterGroupID = 2 							
	END		
		
	IF((@REFERENCE_COLOR IS NULL) OR @REFERENCE_COLOR = 0)
	BEGIN	
			
		SELECT 
			@REFERENCE_COLOR = PC.CounterColor
		FROM 
			@PlainCounters AS PC 
		WHERE 
			CounterTypeID = 1
	END		
	
	IF (@REFERENCE_COLOR IS NULL OR @REFERENCE_COLOR < 0)
	BEGIN
		SET @REFERENCE_COLOR = 0
	END
	
	SELECT 
		@REFERENCE_MONO = (PC.CounterTotal - @REFERENCE_COLOR)
	FROM 
		@PlainCounters AS PC 
		--INNER JOIN CounterTypes AS CT ON PC.CounterTypeID = CT.CounterTypeID
	WHERE 
		CounterTypeID = 1 
	
	IF(@REFERENCE_MONO < 0 )
		SET @REFERENCE_MONO = 0	
	
	INSERT INTO @ReferenceCounters (ReferenceMono, ReferenceColor)
	VALUES	(@REFERENCE_MONO, @REFERENCE_COLOR)
	
	RETURN 
END
```

---

## 32. GetReferenceCountersFromProduction

```sql
CREATE FUNCTION [dbo].[GetReferenceCountersFromProduction]
	(@PrinterDeviceID INT, @PlainCounters PlainCounters READONLY)
		
RETURNS 
	@ReferenceCounters TABLE (ReferenceMono INT, ReferenceColor INT)

BEGIN

	--*******************************************************************************
	--** Robson, 14/08/2015
	--** Versão contratos
	--** Recebe a lista de contadores e monta os contadores de referencia

	--** Robson, 21/12/2016	
	--** Usar regras dos contadores de produção para definir o contador de referência
	--*******************************************************************************
	
	--**********************************************************************************************************
	--*DESCRIÇÃO
	--*
	--* @LifeAdjustType  --Ajuste do contador de vida
	--*			0 - Sem ajuste
	--*			1 - mono = total – color
	--*			2 - Total = color + mono
	--*
	--* @ProductionAdjustType --Ajuste do contador de produção (mesmo ajuste que o de vida)
	--* 
	--* @ProductionComplementType --Complemento do contador de produção (mesmo complemento que o de vida)
	--*			0 - Sem complemento
	--*			1 - Pegar o contador mono e color da soma dos de impressão quando os contadores mono e color forem ambos zerados
	--*			2 - Pegar o contador mono e color da soma dos de impressão sempre
	--*			3 - Pegar o contador color da soma dos de impressão quando o contador color for zerado
    --*			4 - Pegar o contador color da soma dos de impressão sempre
	--*
	--* @ProductionIsLife  --Indica se o contador de produção usa o de vida (1) ou a soma dos de impressão (0)
	--*
	--**********************************************************************************************************


	DECLARE @LifeAdjustType TINYINT                  --Ajuste do contador de vida	
	DECLARE @ProductionAdjustType TINYINT      --Ajuste do contador de produção
	DECLARE @ProductionComplementType TINYINT  --Complemento do contador de produção
	DECLARE @ProductionIsLife BIT                     --Indica se o contador de produção usa o de vida (1) ou a soma dos de impressão (0)

	DECLARE @PrinterDeviceIDs IntTable
	INSERT INTO @PrinterDeviceIDs VALUES (@PrinterDeviceID)

	-- PEGAR O COMPORTAMENTO DA IMPRESSORA
	SELECT 
		@LifeAdjustType = LifeAdjustType,	--SERA USADO APENAS SE FOR PRA USAR OS CONTADORES DE PRODUÇÃO E NÃO TIVER OS CONTADORES (QUE DAI VAI USAR O DE VIDA)	
		@ProductionAdjustType = ProductionAdjustType,
		@ProductionComplementType = ProductionComplementType,
		@ProductionIsLife = ProductionIsLife
	FROM
		[dbo].[getPrintersAndCountersBehaviorsRetrocompToReference](@PrinterDeviceIDs)


	DECLARE @REFERENCE_COLOR INT = 0	
	DECLARE @REFERENCE_MONO INT	= 0
	DECLARE @REFERENCE_TOTAL INT = 0
	
	DECLARE @PrintCounters TABLE (CounterTypeID INT)	
	INSERT INTO @PrintCounters SELECT CounterTypeID FROM CounterTypes WHERE CounterGroupID = 2 
	

	--- PEGAR A SOMA DOS DE IMPRESSÃO, QUANDO ESTIVER CONFIGURADO PARA TAL
	IF (@ProductionIsLife = 0)
	BEGIN

		SELECT 
			@REFERENCE_COLOR = ISNULL(SUM(PC.CounterColor),0),
			@REFERENCE_MONO = ISNULL(SUM(PC.CounterMono),0),
			@REFERENCE_TOTAL = ISNULL(SUM(PC.CounterTotal),0)
		FROM 
			@PlainCounters AS PC 
			INNER JOIN @PrintCounters AS CT ON PC.CounterTypeID = CT.CounterTypeID		

		IF (@REFERENCE_COLOR + @REFERENCE_MONO + @REFERENCE_TOTAL = 0) --caso era pra usar os de impressão e nao tem vou usar o de vida ali embaio, e tmb usar a config do de vida
		BEGIN
			SET @ProductionAdjustType = @LifeAdjustType --forçando o ajuste de produção ser igual ao ajuste de vida
			SET @ProductionComplementType = 0 --nao tem o que complementar nesse caso
		END

	END		

	--PEGAR O DE VIDA QUANDO ESTIVER CONFIGURADO PARA PEGAR O DE VIDA, OU SE ESTAVA CONFIGURADO PRA PEGAR OS DE IMPRESSÃO MAS NAO TINHA NENHUM (FICOU COM 0 nos 3)
	IF (@ProductionIsLife = 1 OR (@REFERENCE_COLOR + @REFERENCE_MONO + @REFERENCE_TOTAL = 0))
	BEGIN

		SELECT 
			@REFERENCE_COLOR = PC.CounterColor,
			@REFERENCE_MONO = PC.CounterMono,
			@REFERENCE_TOTAL = PC.CounterTotal
		FROM 
			@PlainCounters AS PC 		
		WHERE 
			CounterTypeID = 1 


		--Complementar valores Coloridos
		IF ((@ProductionComplementType = 1 AND @REFERENCE_COLOR = 0 AND @REFERENCE_MONO = 0) OR  -- Complemento 1 atualiza mono e cor se ambos forem 0 (aqui ta atualizando só cor)
             (@ProductionComplementType = 2) OR                                                   -- Complemento 2 atualiza mono e cor sempre (aqui ta atualizando só cor)
             (@ProductionComplementType = 3 AND @REFERENCE_COLOR = 0) OR                          -- Complemento 3 atualiza cor se cor for 0
             (@ProductionComplementType = 4))													  -- Complemento 4 atualiza cor sempre			
		BEGIN
			SELECT 
				@REFERENCE_COLOR = ISNULL(SUM(PC.CounterColor),0)
			FROM 
				@PlainCounters AS PC 
				INNER JOIN @PrintCounters AS CT ON PC.CounterTypeID = CT.CounterTypeID
		END

		--Complementar valores Mono
		IF ((@ProductionComplementType = 1 AND @REFERENCE_MONO = 0) OR  -- Complemento 1 atualiza mono e cor se ambos forem 0 (aqui ta atualizando só mono)
             (@ProductionComplementType = 2))                             -- Complemento 2 atualiza mono e cor sempre (aqui ta atualizando só mono)
		BEGIN
			SELECT 
				@REFERENCE_MONO = ISNULL(SUM(PC.CounterMono),0)
			FROM 
				@PlainCounters AS PC 
				INNER JOIN @PrintCounters AS CT ON PC.CounterTypeID = CT.CounterTypeID 
		END

	END


	--Agora ajustar. Ajustar precisa para ambos
	IF (@ProductionAdjustType = 1 OR (@REFERENCE_MONO = 0))--só vai ajustar quando nao era pra ajustar (0) ou era ajuste do total (2) E se o mono for 0
	BEGIN

		SET @REFERENCE_MONO = @REFERENCE_TOTAL - @REFERENCE_COLOR

	END
	
	INSERT INTO @ReferenceCounters (ReferenceMono, ReferenceColor)
	VALUES	(@REFERENCE_MONO, @REFERENCE_COLOR)
	
	RETURN 

END
```

---

## 33. GetStartDateBeforeFirstOfficial

```sql
CREATE FUNCTION   [dbo].[GetStartDateBeforeFirstOfficial](@PrinterDeviceID BIGINT, @StartDate DATETIME, @CounterTypeID INT, @MaxLimitDaysEarlier INT)
RETURNS DATETIME

BEGIN 


       --***********************************************************************************************************
       -- Maicon 24/08/2015
       -- Pega a primeira data anterior a data passada
       --***********************************************************************************************************

	IF(@MaxLimitDaysEarlier < 0)
	BEGIN
		SET @MaxLimitDaysEarlier = @MaxLimitDaysEarlier * -1
	END

	DECLARE @StartDateTimeBeforeFirst DATETIME;
	DECLARE @ReturnDate DATETIME;
                    
	--Aqui pega o registro imediatamente anterior ao da data passada
	SELECT  
		TOP 1 @StartDateTimeBeforeFirst = DateTimeRead 
	FROM Counters C
		INNER JOIN CountersReadings CR on C.CounterReadingID = CR.CounterReadingID
	WHERE 
		(CR.DateTimeRead <  @StartDate) AND
		(CR.PrinterDeviceID = @PrinterDeviceID) AND 
		(C.CounterTypeID = @CounterTypeID)AND
		 CR.Removed = 0

	IF (@StartDateTimeBeforeFirst IS NULL OR (DATEDIFF(hh,@StartDateTimeBeforeFirst, @StartDate) > @MaxLimitDaysEarlier * 24 ))
	BEGIN

		--se não encontrou nenhum registro antes da data
		-- ou se encontrou mas era mais velho que o permitido
		--procura pelo primeiro registro após a data
		SELECT  
			TOP 1 @StartDateTimeBeforeFirst = DateTimeRead 
		FROM Counters C
			INNER JOIN CountersReadings CR on C.CounterReadingID = CR.CounterReadingID
		WHERE 
			(CR.DateTimeRead <  @StartDate) AND
			(CR.PrinterDeviceID = @PrinterDeviceID) AND 
			(C.CounterTypeID = @CounterTypeID)AND
			 CR.Removed = 0
	END
          	
	SET @ReturnDate = ISNULL(@StartDateTimeBeforeFirst, @StartDate);
    RETURN (@ReturnDate);

END
```

---

## 34. GetString

```sql
CREATE FUNCTION [dbo].[GetString](@ID1 BIGINT) RETURNS NVARCHAR(100)
BEGIN 
 
 DECLARE @VAlue NVARCHAR(100);
 IF (@ID1 = 1)
  SET @Value = '-';
 ELSE IF(@ID1 = 2)
  SET @Value = 'Simplex';
 ELSE IF(@ID1 = 3)
  SET @Value = 'Duplex';
 ELSE IF(@ID1 = 4)
  SET @Value = 'Mono';
 ELSE IF(@ID1 = 5)
  SET @Value = 'Cor';
 ELSE IF(@ID1 = 6)
  SET @Value = 'Local';
 ELSE IF(@ID1 = 7)
  SET @Value = 'Rede';
 
 

 
 RETURN(@Value); 
 
END
```

---

## 35. GetTransactionStatusName

```sql
CREATE FUNCTION [dbo].[GetTransactionStatusName] (@TransactionStatus SMALLINT)
RETURNS NVARCHAR(20)
AS
BEGIN

	DECLARE @TransactionStatusName NVARCHAR(20)

	SELECT @TransactionStatusName = CASE @TransactionStatus
										WHEN 0 THEN '@@Initiated'
										WHEN 1 THEN '@@WaitingPayment'
										WHEN 2 THEN '@@InAnalysis'
										WHEN 3 THEN '@@Paid'
										WHEN 4 THEN '@@Available'
										WHEN 5 THEN '@@InDispute'
										WHEN 6 THEN '@@Refunded'
										WHEN 7 THEN '@@Cancelled'
									END
 
	RETURN @TransactionStatusName
	
END
```

---

## 36. GetUserEmailExists

```sql
CREATE FUNCTION [dbo].[GetUserEmailExists](@AccountID INT, @Email NVARCHAR(255)) RETURNS BIT
BEGIN 
 
	DECLARE @ReturnValue BIT
	
	SELECT
		@ReturnValue = COUNT(1)
	FROM
		Accounts AC
	WHERE
		(@AccountID = 0 OR AC.AccountID <> @AccountID)
		AND AC.Email = @Email
		AND AC.Removed = 0

	RETURN @ReturnValue
 
END
```

---

## 37. GetUserNameDefault

```sql
CREATE FUNCTION [dbo].[GetUserNameDefault]
(@DomainName NVARCHAR(255), @LogonName NVARCHAR(255), @FullName NVARCHAR(255))
RETURNS NVARCHAR(560)

BEGIN

	DECLARE @UserName NVARCHAR(560)

	SELECT @UserName = CASE @FullName
							WHEN '' THEN @DomainName + '\' + @LogonName
							WHEN @LogonName THEN @DomainName + '\' + @LogonName
							ELSE @FullName + ' (' + @DomainName + '\' + @LogonName + ')'
						END
 
	RETURN @UserName
	
END
```

---

## 38. GetUserNameDefaultShort

```sql
CREATE FUNCTION [dbo].[GetUserNameDefaultShort]
(@DomainName NVARCHAR(255), @LogonName NVARCHAR(255))
RETURNS NVARCHAR(560)

BEGIN

	DECLARE @UserName NVARCHAR(560)

	IF(@DomainName IS NOT NULL AND @LogonName IS NOT NULL)
	BEGIN
		SET @UserName = @DomainName + '\' + @LogonName
	END
	ELSE
	BEGIN
		SET @UserName = '-'
	END
	
	RETURN @UserName
	
END
```

---

## 39. HasJobsOutsideCCsManaged

```sql
CREATE FUNCTION [dbo].[HasJobsOutsideCCsManaged]
(
      @AccountID int,
      @StartDate datetime,
      @EndDate datetime
)
RETURNS bit
AS
BEGIN

      --Verifica se o usuário imprimiu alguma coisa fora das contas que ele é gerente dentro do período selecionado

      --pega os dias cheios

      Declare @SD smallDatetime
      Declare @ED smallDatetime

      SET @SD  = cast( cast(year(@StartDate) as NVARCHAR) + '-' +cast(month(@StartDate) as NVARCHAR) + '-' + cast( day(@StartDate) as NVARCHAR) as smalldatetime)
      SET @ED  = cast( cast(year(@EndDate) as NVARCHAR) + '-' +cast(month(@EndDate) as NVARCHAR) + '-' + cast( day(@EndDate) as NVARCHAR) as smalldatetime)

      --pega a lista de IDs de conta que ele imprimiu
      DECLARE @PrintedCCs table (CostAccountID int)
      INSERT INTO @PrintedCCs 
            SELECT DISTINCT CostAccountID FROM CubeUser WHERE AccountID = @AccountID AND Data BETWEEN @SD AND @ED AND TotJobs > 0

      --pega a lista com todos os IDs que ele gerencia
      Declare @CCIDList table (CostCenterID int) 
      INSERT INTO @CCIDList 
            SELECT DISTINCT costAccountID FROM dbo.[getCostAccountManaged](@AccountID)  --traz a lista das contas gerenciados por esse usuario       

      Declare @CountPrintedCCs int
      Declare @FoundPrintedCCs int

      SELECT @CountPrintedCCs = COUNT(*) FROM @PrintedCCs --quantas contas ele imprimiu no período (incluindo null)
      SELECT @FoundPrintedCCs = COUNT(*) FROM @CCIDList WHERE CostCenterID IN (SELECT CostAccountID FROM @PrintedCCs) --quantas contas que ele imprimiu foram encontrados na lista dos gerenciados


      DECLARE @Exists bit
      IF (@CountPrintedCCs <> @FoundPrintedCCs )
      BEGIN

            -- é diferente, indica que ele imprimiu em alguma conta que não estava na lista de gerenciados
            SET @Exists  =1

      END
      ELSE
      BEGIN

            -- é igual, indica que todos as contas impressos estao na lista de gerenciados
            SET @Exists  = 0

      END

      RETURN @Exists 

END
```

---

## 40. IsConsolidated

```sql
CREATE FUNCTION [dbo].[IsConsolidated](@DeviceID INT) RETURNS BIT

BEGIN 
 
	DECLARE @EXISTS BIT
	SET @EXISTS = 0
 
	IF EXISTS(SELECT 1 FROM PrintersDevicesConsolidation WHERE PrinterDeviceConsolidatedID = @DeviceID)
	BEGIN
		SET @EXISTS = 1
	END

	RETURN @EXISTS
 
END
```

---

## 41. IsCostAccountManagedByAccount

```sql
CREATE FUNCTION [dbo].[IsCostAccountManagedByAccount]
(
      @CostAccountID int,
      @AccountID int    
)
RETURNS bit
AS
BEGIN


      DECLARE @caID int;
      DECLARE @caParentID int;
      DECLARE @Exists bit;

      SET @Exists = 0

      SELECT @caID = CostAccountID FROM CostAccountsManagers WHERE AccountID = @AccountID AND CostAccountID= @CostAccountID

      IF(@caID IS NOT NULL)
      BEGIN

            -- Significa que ele é gerente do CA. Retorna 1.
            SET @Exists = 1

      END
      ELSE
      BEGIN

            SELECT @caParentID = ISNULL(CostAccountParentID,-1) FROM CostAccounts WHERE CostAccountID = @CostAccountID

            WHILE(@caParentID <> -1)
            BEGIN

                  SELECT @caID = CostAccountID FROM CostAccountsManagers WHERE AccountID = @AccountID AND CostAccountID = @caParentID

                  IF(@caID IS NOT NULL)
                  BEGIN

                        -- Significa que ele é gerente do CA. Retorna 1.
                        SET @Exists = 1
                        BREAK

                  END
                  ELSE
                  BEGIN

                        SELECT @caParentID = ISNULL(CostAccountParentID,-1) FROM CostAccounts WHERE CostAccountID = @caParentID

                  END

            END

      END

      RETURN @Exists

END
```

---

## 42. IsMainAliaseOrNotInAliase

```sql
CREATE FUNCTION [dbo].[IsMainAliaseOrNotInAliase](@AccountID INT) RETURNS BIT

BEGIN 
 
	--Essa função traz se o usuário é o aliase principal ou se não é utilizado nos aliases, excluindo apenas os usuários aliases de outros
	--1 Usuário aliase principal ou não utiliza aliases
	--0 Utiliza aliases mas não é o usuário principal
	DECLARE @EXISTS BIT
	SET @EXISTS = 0
 
	--Verifica se existe referencia deste usuário nos aliases
	IF EXISTS(SELECT 1 FROM AccountsAliases WHERE AccountID = @AccountID)
	BEGIN
		 --Se sim verifica se ele é o aliase principal
		 IF EXISTS(SELECT 1 FROM AccountsAliases WHERE AccountID = @AccountID AND AccountIDMain = @AccountID)
			BEGIN
			 -- Se sim retorna true	
			 SET @EXISTS = 1
			 END
	END
	ELSE
	BEGIN 
	--Se não retorna true
	 SET @EXISTS = 1
	END
	
	RETURN @EXISTS
 
END
```

---

## 43. IsMainConsolidate

```sql
CREATE    FUNCTION [dbo].[IsMainConsolidate](@DeviceID INT) RETURNS BIT
BEGIN 
 
 DECLARE @EXISTS BIT;  
 DECLARE @ReturnExists NVARCHAR(18);
 
SET @EXISTS = (SELECT COUNT(1) FROM PrintersDevicesConsolidation WHERE PrinterDeviceMainID = @DeviceID)

	IF( @EXISTS > 1  )
		SET @EXISTS  = 1


 SET @ReturnExists = @EXISTS
 RETURN(@ReturnExists); 
 
END
```

---

## 44. IsManagerOfHimself

```sql
CREATE FUNCTION [dbo].[IsManagerOfHimself](@AccountIDOwner int) RETURNS bit
BEGIN 
	DECLARE @ccID int;
	DECLARE @ccParentID int;
	DECLARE @Exists bit;

	SET @Exists = 0

	--Retorna o CC do usuário
	SELECT @ccID = ISNULL(CostAccountID,-1) FROM Accounts WHERE AccountID = @AccountIDOwner

	IF (@ccID <> -1)--Se não tem conta, então muito menos será gerente dele mesmo
	BEGIN
	
		--Verifica se o usuário é gerente de sua conta
		IF(EXISTS(SELECT CostAccountID FROM CostAccountsManagers WHERE CostAccountID = @ccID AND AccountID = @AccountIDOwner))
		BEGIN
			--É gerente da sua conta
			SET @Exists = 1
		END
		ELSE
		BEGIN
			--Testa se ele é gerente de uma das contas pai dele
			SELECT @ccParentID = ISNULL(CostAccountParentID,-1) FROM CostAccounts WHERE CostAccountID = @ccID
			
			WHILE(@ccParentID <> -1)
			BEGIN
				IF(EXISTS(SELECT CostAccountID FROM CostAccountsManagers WHERE CostAccountID = @ccParentID AND AccountID = @AccountIDOwner))
				BEGIN
					SET @Exists = 1
					BREAK
				END
				ELSE
				BEGIN
					SELECT @ccParentID = ISNULL(CostAccountParentID,-1) FROM CostAccounts WHERE CostAccountID = @ccParentID
				END
			END
		END
	END


	RETURN @Exists
END
```

---

## 45. ReturnPrinterQueueTypeID

```sql
CREATE FUNCTION [dbo].[ReturnPrinterQueueTypeID] (@PrinterQueueID INT)
RETURNS INT
AS 
BEGIN
	RETURN (SELECT PrinterQueueTypeID FROM PrintersQueues WHERE PrinterQueueID = @PrinterQueueID)
END
```

---

## 46. TotalBureauWithResourcesJobs

```sql
CREATE FUNCTION [dbo].[TotalBureauWithResourcesJobs](@StartDate DATETIME, @EndDate DATETIME, @CostAccountID INT, @AccountIDOwner INT) RETURNS BIGINT
BEGIN 

	--////////////////////////////////////////////////
	--A partir da versão 4.2
	-- * Verificação das permissões do usuário de visualização do usuário dentro das SPs.
	--////////////////////////////////////////////////
	--/// início

	DECLARE @CCIDList TABLE (CostAccountID INT) -- tabela que contém a lista de centros de custo que serão pesquisados dependendo  do filtro e da permissão do usuário
	DECLARE @Parameters TABLE(AccountID INT, CostAccountID INT, UseORMethod BIT, BuildListType INT) --TABELA COM OS PARAMETROS DAS PERMISSOES

	INSERT INTO @Parameters
		SELECT * FROM [dbo].[getParametersForReports](@CostAccountID, @AccountIDOwner, @StartDate, @EndDate)

	--EXTRAIR OS PARAMETROS DA TABELA
	DECLARE @UseORMethod BIT -- 0: indica que será usado o operador E na consulta (maioria dos cacos) 1: indica o operador OU (para os casos que tem que trazer dados dos CCs E do usuário)
	DECLARE @BuildListType INT -- 0: lista vazia; 1: lista de filhos dos ccs; 2: lista de ccs gerenciados do usuario
	DECLARE @AccountID INT --vai vir com valor se precisar pegar os dados do usuario

	SELECT @AccountID = AccountID, @CostAccountID = CostAccountID, @UseORMethod = UseORMethod, @BuildListType = BuildListType FROM @Parameters --*****************

	--preenche a lista de Centros de custo que serão usados nessa consulta
	IF (@BuildListType = 1)
	BEGIN
		INSERT INTO @CCIDList 
			SELECT CostAccountID FROM dbo.[getCostAccountChildrenTable](@CostAccountID) --Lista recebe os filhos do CC procurado
	END
	ELSE
	BEGIN
		IF (@BuildListType = 2)
		BEGIN
			INSERT INTO @CCIDList 
				SELECT DISTINCT CostAccountID FROM dbo.[getCostAccountManaged](@AccountIDOwner)  --traz a lista dos ccs gerenciados por esse usuario		
		END
	END

	--/// fim das alterações da 4.2 

	DECLARE @TotalJobs BIGINT
	DECLARE @Total BIGINT

	SELECT 
		@Total = COUNT(1)
	FROM 
		BureauResourcesJobs 
	WHERE 
		PrintJobID IN 
		(
			SELECT   
				PrintJobID
			FROM  
				PrintJobs
				INNER JOIN PrintersDevices ON PrintJobs.PrinterDeviceID = PrintersDevices.PrinterDeviceID
			WHERE
				PrintJobs.JobOriginID = 7
				AND (PrintJobs.DatePrinted BETWEEN @StartDate AND @EndDate) AND (PrintersDevices.EnabledBillingStatus IN (1, 3)) 
				AND
					--//alteração [4.2]
					--//testa com o operador E qnd é jobs do usuário no CC ou operador OU qnd é jobs do usuário + jobs do cc
					((
						@UseORMethod= 0 
						AND
						(
							(@AccountID = -1			OR		PrintJobs.AccountID				= @AccountID)			AND 
							(@CostAccountID = -1 OR		PrintJobs.CostAccountID IN (SELECT CostAccountID FROM @CCIDList))
						)
					)
					OR
					(
						@UseORMethod= 1 
						AND
						(
							(@AccountID = -1			OR		PrintJobs.AccountID				= @AccountID)			OR
							(@CostAccountID = -1 OR		PrintJobs.CostAccountID IN (SELECT CostAccountID FROM @CCIDList))
						)

					))
		) 

	SET @TotalJobs = @Total
	RETURN(@TotalJobs)
	
END
```

---

## 47. TotalCostCalcColor

```sql
CREATE FUNCTION [dbo].[TotalCostCalcColor](@PrinterDeviceID BIGINT, @IsDuplex BIT, @PaperSizeID INT, @PagesColor INT, @PagesMono INT, @WasLastPageColor BIT, @JobTypeID SMALLINT)
	RETURNS DECIMAL(19,6)
BEGIN 

	DECLARE @ShowPaper SMALLINT
	DECLARE @CostColor DECIMAL (19,6)
	DECLARE @CostGroupID INT

	--se não tem páginas color, não é necessário calcular o valor
	IF (@PagesColor <= 0)
	BEGIN
		RETURN 0
	END
	ELSE IF (@PagesColor > 0 AND @PagesMono = 0) --se tem somente páginas color, calcular a última página como color, ignorando o que está no banco
	BEGIN	
		SET @WasLastPageColor = 1
	END

	--Pega o ID do custo
	IF (@PrinterDeviceID IS NOT NULL)
	BEGIN
		SELECT @CostGroupID = CostGroupID FROM PrintersDevices WHERE PrintersDevices.PrinterDeviceID = @PrinterDeviceID
	END
	ELSE
	BEGIN
		SELECT @CostGroupID = CostGroupID FROM CostGroups WHERE IsDefault = 1
	END

    --Verifica se é Scan
	IF(@JobTypeID = 4)
	BEGIN
		SELECT @CostColor = @PagesColor * CostScan FROM CostGroups WHERE CostGroupID = @CostGroupID
	END
	ELSE --Verifica se é SentFax
	IF(@JobTypeID = 5) 
	BEGIN
		SELECT @CostColor = @PagesColor * CostSentFax FROM CostGroups WHERE CostGroupID = @CostGroupID
	END
	ELSE --Outros tipos...
	BEGIN
		-- Verifica se existe o custo no papel
		SELECT @ShowPaper = 1 FROM PrintersDevicesGroupsPapersSize WHERE CostGroupID = @CostGroupID AND PaperSizeID = @PaperSizeID
		
		IF(@ShowPaper IS NOT NULL)
		BEGIN
			--Pega o custo do papel
			IF(@IsDuplex  = 1)
			BEGIN
				IF ((@PagesColor + @PagesMono) % 2 = 0)
				BEGIN 
					-- se o total de páginas é par signIFica que todas AS páginas são duplex
					SELECT @CostColor = (@PagesColor * CostDuplexColor) FROM PrintersDevicesGroupsPapersSize WHERE CostGroupID = @CostGroupID AND PaperSizeID = @PaperSizeID
				END
				ELSE
				BEGIN
					--se o total de páginas for impar
					IF (@WasLastPageColor = 0)
					BEGIN
						-- e a última página é mono
						SELECT @CostColor =  (@PagesColor * CostDuplexColor) FROM PrintersDevicesGroupsPapersSize WHERE CostGroupID = @CostGroupID AND PaperSizeID = @PaperSizeID
					END
					ELSE
					BEGIN
						-- e a última página é color
						SELECT @CostColor = (((@PagesColor - 1) * CostDuplexColor) + CostColor) FROM PrintersDevicesGroupsPapersSize WHERE CostGroupID = @CostGroupID AND PaperSizeID = @PaperSizeID
					END 
				END
			END
			ELSE
			BEGIN
				SELECT @CostColor = (@PagesColor * CostColor) FROM PrintersDevicesGroupsPapersSize WHERE CostGroupID = @CostGroupID AND PaperSizeID = @PaperSizeID
			END
		END	
		ELSE
		BEGIN
			--Pega o custo padrão do custo				
			IF(@IsDuplex = 1)
			BEGIN
				IF ((@PagesColor + @PagesMono) % 2 = 0)
				BEGIN 
					-- se o total de páginas é par sigbIFica que todas AS páginas são duplex
					SELECT @CostColor = (@PagesColor * CostDuplexColor) FROM CostGroups WHERE CostGroupID = @CostGroupID
				END
				ELSE
				BEGIN
					--se o total de páginas for impar
					IF (@WasLastPageColor = 0)
					BEGIN
						-- e a última página é mono
						SELECT @CostColor =  (@PagesColor * CostDuplexColor) FROM CostGroups WHERE CostGroupID = @CostGroupID
					END
					ELSE
					BEGIN
						-- e a última página é color
						SELECT @CostColor = (((@PagesColor - 1) * CostDuplexColor) + CostColor) FROM CostGroups WHERE CostGroupID = @CostGroupID
					END 
				END
			END	
			ELSE		
			BEGIN
				SELECT @CostColor =  (@PagesColor * CostColor) FROM CostGroups WHERE CostGroupID = @CostGroupID 
			END
		END
	END
	
	RETURN @CostColor
END
```

---

## 48. TotalCostCalcMono

```sql
CREATE FUNCTION [dbo].[TotalCostCalcMono](@PrinterDeviceID BIGINT, @IsDuplex BIT, @PaperSizeID INT, @PagesColor INT, @PagesMono INT, @WasLastPageColor BIT, @JobTypeID SMALLINT)
	RETURNS DECIMAL(19,6)
BEGIN 

	DECLARE @ShowPaper SMALLINT
	DECLARE @CostMono DECIMAL(19,6)
	DECLARE @CostGroupID INT

	--se não tem páginas mono, não é necessário calcular o valor
	IF (@PagesMono <= 0)	
	BEGIN
		RETURN 0
	END
	ELSE IF (@PagesMono > 0 AND @PagesColor = 0) --se tem somente páginas mono, calcular a última página como mono, ignorando o que está no banco
	BEGIN
		SET @WasLastPageColor = 0
	END

	--Pega o ID do custo
	IF (@PrinterDeviceID IS NOT NULL)
	BEGIN
		SELECT @CostGroupID = CostGroupID FROM PrintersDevices WHERE PrinterDeviceID = @PrinterDeviceID
	END
	ELSE
	BEGIN
		SELECT @CostGroupID = CostGroupID FROM CostGroups WHERE IsDefault = 1
	END

	--Verifica se é Scan
	IF(@JobTypeID = 4)
	BEGIN
		SELECT @CostMono = @PagesMono * CostScan FROM CostGroups WHERE CostGroupID = @CostGroupID
	END
	ELSE --Verifica se é SentFax
	IF(@JobTypeID = 5) 
	BEGIN
		SELECT @CostMono = @PagesMono * CostSentFax FROM CostGroups WHERE CostGroupID = @CostGroupID
	END
	ELSE --Outros tipos...
	BEGIN
		-- Verifica se existe o custo no papel
		SELECT @ShowPaper = 1 FROM PrintersDevicesGroupsPapersSize WHERE CostGroupID = @CostGroupID AND PaperSizeID = @PaperSizeID

		IF(@ShowPaper IS NOT NULL)
		BEGIN
			--Pega o custo do papel
			IF(@IsDuplex  = 1)
			BEGIN
				IF((@PagesColor + @PagesMono) % 2 = 0)
				BEGIN 
					-- se o total de páginas é par signIFica que todas AS páginas são duplex
					SELECT @CostMono = (@PagesMono * CostDuplexMono) FROM PrintersDevicesGroupsPapersSize WHERE CostGroupID = @CostGroupID AND PaperSizeID = @PaperSizeID
				END
				ELSE
				BEGIN
					--se o total de páginas for impar
					IF (@WasLastPageColor = 0)
					BEGIN
						-- e a última página é mono
						SELECT @CostMono = (((@PagesMono - 1) * CostDuplexMono) + CostMono) FROM PrintersDevicesGroupsPapersSize WHERE CostGroupID = @CostGroupID AND PaperSizeID = @PaperSizeID
					END
					ELSE
					BEGIN
						-- e a última página é color
						SELECT @CostMono = (@PagesMono * CostDuplexMono) FROM PrintersDevicesGroupsPapersSize WHERE CostGroupID = @CostGroupID AND PaperSizeID = @PaperSizeID
					END 
				END
			END
			ELSE
			BEGIN
				SELECT @CostMono = (@PagesMono * CostMono) FROM PrintersDevicesGroupsPapersSize WHERE CostGroupID = @CostGroupID AND PaperSizeID = @PaperSizeID
			END
		END	
		ELSE
		BEGIN
			--Pega o custo padrão do custo				
			IF(@IsDuplex = 1)
			BEGIN
				IF ((@PagesColor + @PagesMono) % 2 = 0)
				BEGIN 
					-- se o total de páginas é par sigbIFica que todas AS páginas são duplex
					SELECT @CostMono =  (@PagesMono * CostDuplexMono) FROM CostGroups WHERE CostGroupID = @CostGroupID
				END
				ELSE
				BEGIN
					--se o total de páginas for impar
					IF (@WasLastPageColor = 0)
					BEGIN
						-- e a última página é mono
						SELECT @CostMono = (((@PagesMono - 1) * CostDuplexMono) + CostMono) FROM CostGroups WHERE CostGroupID = @CostGroupID
					END
					ELSE
					BEGIN
						-- e a última página é color
						SELECT @CostMono = (@PagesMono * CostDuplexMono) FROM CostGroups WHERE CostGroupID = @CostGroupID
					END 
				END
			END	
			ELSE		
			BEGIN
				SELECT @CostMono = (@PagesMono * CostMono) FROM CostGroups WHERE CostGroupID = @CostGroupID 
			END
		END
	END
	 
	RETURN @CostMono
END
```

---

## 49. TotalPages

```sql
CREATE FUNCTION [dbo].[TotalPages](@StartDate DATETIME, @EndDate DATETIME, @CostAccountID INT, @AccountIDOwner INT) RETURNS BIGINT
BEGIN 

	--////////////////////////////////////////////////
	--A partir da versão 4.2
	-- * Verificação das permissões do usuário de visualização do usuário dentro das SPs.
	--////////////////////////////////////////////////
	--/// início

	DECLARE @CCIDList TABLE (CostAccountID INT) -- tabela que contém a lista de centros de custo que serão pesquisados dependendo  do filtro e da permissão do usuário
	DECLARE @Parameters TABLE(AccountID INT, CostAccountID INT, UseORMethod BIT, BuildListType INT) --TABELA COM OS PARAMETROS DAS PERMISSOES

	INSERT INTO @Parameters
		SELECT * FROM [dbo].[getParametersForReports](@CostAccountID, @AccountIDOwner, @StartDate, @EndDate)

	--EXTRAIR OS PARAMETROS DA TABELA
	DECLARE @UseORMethod BIT -- 0: indica que será usado o operador E na consulta (maioria dos cacos) 1: indica o operador OU (para os casos que tem que trazer dados dos CCs E do usuário)
	DECLARE @BuildListType INT -- 0: lista vazia; 1: lista de filhos dos ccs; 2: lista de ccs gerenciados do usuario
	DECLARE @AccountID INT --vai vir com valor se precisar pegar os dados do usuario

	SELECT @AccountID = AccountID, @CostAccountID = CostAccountID, @UseORMethod = UseORMethod, @BuildListType = BuildListType FROM @Parameters --*****************

	--preenche a lista de Centros de custo que serão usados nessa consulta
	IF (@BuildListType = 1)
	BEGIN
		INSERT INTO @CCIDList 
			SELECT CostAccountID FROM dbo.[getCostAccountChildrenTable](@CostAccountID) --Lista recebe os filhos do CC procurado
	END
	ELSE
	BEGIN
		IF (@BuildListType = 2)
		BEGIN
			INSERT INTO @CCIDList 
				SELECT DISTINCT CostAccountID FROM dbo.[getCostAccountManaged](@AccountIDOwner)  --traz a lista dos ccs gerenciados por esse usuario		
		END
	END

	--/// fim das alterações da 4.2
 
	DECLARE @TotalPages BIGINT
	DECLARE @Total BIGINT
 
	SELECT   
		@Total = COUNT(PagesColor + PagesMono) 
	FROM  
		PrintJobs
		INNER JOIN PrintersDevices ON PrintJobs.PrinterDeviceID = PrintersDevices.PrinterDeviceID
	WHERE
		(PrintJobs.DatePrinted BETWEEN @StartDate AND @EndDate) AND (PrintersDevices.EnabledBillingStatus IN (1, 3)) 
		AND PrintJobs.JobTypeID in (1,2,3)
		AND
		--//alteração [4.2]
		--//testa com o operador E qnd é jobs do usuário no CC ou operador OU qnd é jobs do usuário + jobs do cc
		((
			@UseORMethod= 0 
			AND
			(
				(@AccountID = -1			OR		PrintJobs.AccountID				= @AccountID)			AND 
				(@CostAccountID = -1 OR		PrintJobs.CostAccountID IN (SELECT CostAccountID FROM @CCIDList))
			)
		)
		OR
		(
			@UseORMethod= 1 
			AND
			(
				(@AccountID = -1			OR		PrintJobs.AccountID				= @AccountID)			OR
				(@CostAccountID = -1 OR		PrintJobs.CostAccountID IN (SELECT CostAccountID FROM @CCIDList))
			)

		))
	
	SET @TotalPages = @Total
	RETURN(@TotalPages)
	
END
```

---

## 50. TotalPagesCounter

```sql
CREATE FUNCTION [dbo].[TotalPagesCounter](@StartDateTime DATETIME, @EndDateTime DATETIME, @PrinterDeviceID INT) RETURNS BIGINT
BEGIN 

       --***********************************************************************************************************
       -- Stored Procedure usada para somar o total de páginas bilhetadas em um período de uma impressora
       --***********************************************************************************************************
       
       -- Se impressora esta desabilitada (contabilização) trazer 0.
       IF (EXISTS(SELECT 1 FROM PrintersDevices WHERE PrinterDeviceID = @PrinterDeviceID AND EnabledBillingStatus IN (0, 2)))
       BEGIN
             RETURN 0     
       END

       DECLARE @Day DATETIME
       DECLARE @Month SMALLINT
       
       DECLARE @Initial BIT, @Total INT
       DECLARE @TopDay SMALLINT, @TopMonth SMALLINT, @TopYear SMALLINT
       
       DECLARE @TotalPages BIGINT 
       DECLARE @TBDays TABLE ([Year] SMALLINT, [Month] SMALLINT, [Day] SMALLINT)
       DECLARE @TBWeeks TABLE ([Year] SMALLINT, [Month] SMALLINT, [Day] SMALLINT)
       DECLARE @StartTime DATETIME, @EndTime DATETIME

       SELECT  @StartTime = @StartDateTime, @EndTime = @EndDateTime

       --Tira as horas das datas
       SELECT @StartDateTime = DATEADD(DAY, 0, FLOOR(CONVERT(FLOAT, @StartDateTime)))
       SELECT @EndDateTime   = DATEADD(DAY, 0, FLOOR(CONVERT(FLOAT, @EndDateTime)))

       -- Data inicial pega o dia seguinte, porque a atual nao pode pegar dos cubos
       IF ((DATEPART(hh, @StartTime) +   DATEPART(mi, @StartTime)  + DATEPART(ss, @StartTime)) > 0)
       BEGIN
             SET @StartDateTime = @StartDateTime + 1
       END
             
       --Data final tira um dia, porque a atual não da de pegar dos cubos
       --IF ((DATEPART(hh, @EndTime) +   DATEPART(mi, @EndTime)  + DATEPART(ss, @EndTime)) > 0)
       --BEGIN
       
       --robson, 21/12/2016: Tem que tirar um dia sempre... pq se tem horas na data ja tem que tirar mesmo pra pegar do dia cheio anterior, e se nao tem horas
       -- a query acha que é pra pegar desse dia cheio e nao é, é pra pegar só do segundo 0
       SET @EndDateTime = @EndDateTime - 1
       --END

       SELECT @Day = @StartDateTime, @Month = MONTH(@StartDateTime)

       WHILE (DAY(@Day) NOT IN (1, 8, 15, 22) AND @Day <= @EndDateTime)
       BEGIN
             IF (@Month = MONTH(@Day))
             BEGIN
                    INSERT INTO @TBDays 
                    VALUES (YEAR(@Day), MONTH(@Day), DAY(@Day))
             END
             
             SET @Day = @Day + 1
       END

       SELECT @Initial = 0, @Month = 0

       WHILE (CAST(@EndDateTime - @Day AS INT) >= 6)
       BEGIN
             IF (DAY(@Day) = 1)
             BEGIN
                    SET @Initial = 1
                    
                    SET @Month = MONTH(@Day)
             END
             
             IF (DAY(@Day) IN (1, 8, 15) OR (DAY(@Day) = 22 AND (MONTH(@Day) <> MONTH(@EndDateTime)) OR (YEAR(@Day) < YEAR(@EndDateTime))))  
             BEGIN
                    INSERT INTO @TBWeeks
                    VALUES (YEAR(@Day), MONTH(@Day), DAY(@Day))
             END
             ELSE
             BEGIN
                    BREAK
             END    

             SET @Day = @Day + 1

             WHILE (DAY(@Day) NOT IN (1, 8, 15, 22))
             BEGIN                      
                    SET @Day = @Day + 1
             END

             IF(@Initial = 1 AND DAY(@Day) = 1 AND MONTH(@Day) <> @Month)
             BEGIN
                    DELETE FROM
                           @TBWeeks 
                    WHERE
                           [Year] = YEAR(@Day - 1)
                           AND [Month] = @Month
                           AND [Day] IN (1, 8, 15, 22) 

                    INSERT INTO @TBWeeks
                    VALUES (YEAR(@Day - 1), @Month, 28)     

                    SELECT @Initial = 0, @Month = 0   
             END
       END

       WHILE (@Day <= (@EndDateTime))
       BEGIN
             INSERT INTO @TBDays 
             VALUES (YEAR(@Day), MONTH(@Day), DAY(@Day))
             
             SET @Day = @Day + 1
       END

       SET @TotalPages = 0

       -- Uma vez tendo todos os ponteiro para os banco vamos aos processamentos              
       SET @Total = (SELECT COUNT(1) FROM @TBDays)

       IF (@Total > 0)
       BEGIN
             SET @Total = (SELECT COUNT(1) FROM @TBDays)

             WHILE (@Total > 0)
             BEGIN
                    SET @Total = @Total - 1 
                    
                    SELECT TOP 1
                           @TopYear = [Year],
                           @TopMonth = [Month],
                           @TopDay = [Day]
                    FROM
                           @TBDays
                    
                    DELETE FROM
                           @TBDays 
                    WHERE
                           @TopYear = [Year] 
                           AND @TopMonth = [Month] 
                           AND @TopDay = [Day]
                           
                    DECLARE @ConcatDateCube DATETIME
                    SELECT @ConcatDateCube = CONVERT(DATETIME, CAST(@TopYear AS NVARCHAR) + '/' + CAST(@TopMonth AS NVARCHAR) + '/' + CAST(@TopDay AS NVARCHAR), 111)
                    
                    SELECT
                           @TotalPages = @TotalPages + ISNULL(CDFN + CDCN + CDIN + CSFN + CSCN + CSIN + PDFN + PDCN + PDIN + PSFN + PSCN + PSIN, 0)
                    FROM 
                           CubePrinterDevice C 
                    WHERE
                           C.Data = @ConcatDateCube
                           AND C.PrinterDeviceID = @PrinterDeviceID
             END

             -- Processamento das Week/Month
             SET @Total = (SELECT COUNT(1) FROM @TBWeeks)

             WHILE (@Total > 0)
             BEGIN
                    SET @Total = @Total - 1 
                    
                    SELECT TOP 1
                           @TopYear = [Year],
                           @TopMonth = [Month],
                           @TopDay = [Day]
                    FROM
                           @TBWeeks
                    
                    DELETE FROM
                           @TBWeeks 
                    WHERE  
                           @TopYear = [Year]
                           AND @TopMonth = [Month]
                           AND @TopDay = [Day]

                    SELECT
                           @TotalPages = @TotalPages + ISNULL(CDFN + CDCN + CDIN + CSFN + CSCN + CSIN + PDFN + PDCN + PDIN + PSFN + PSCN + PSIN,0) 
                    FROM
                           CubePrinterDeviceWeek C 
                    WHERE
                           dayw = @TopDay
                           AND monthw = @TopMonth
                           AND yearw = @TopYear
                           AND C.Printerdeviceid = @PrinterDeviceID
             END
             -- Fim processamento ponteiros.

             SELECT 
                    @TotalPages = @TotalPages + ISNULL(SUM(P.PagesColor + P.PagesMono), 0)
             FROM 
                    PrintJobs P
             WHERE
                    (
                           ((@StartTime <> @StartDateTime) AND P.DatePrinted BETWEEN @StartTime AND @StartDateTime ) --só busca se as variaveis forem diferentes, porque se forem iguais é no segundo 0, e se tiver um job nesse instante vai somar de novo
                           OR 
                           (P.DatePrinted BETWEEN (@EndDateTime + 1) AND @EndTime) --aqui se for segundo 0 eu quero o registro pq nao foi pego dos cubos o valor
                    )
                    AND P.PrinterDeviceID = @PrinterDeviceID
                    AND P.JobTypeID IN (1, 2, 3)
                    AND P.JobDisabled = 0
       END
       ELSE
       BEGIN
             SELECT 
                    @TotalPages = ISNULL(SUM(P.PagesColor + P.PagesMono), 0)
             FROM 
                    PrintJobs P
             WHERE  
                    P.DatePrinted BETWEEN @StartTime AND @EndTime
                    AND P.PrinterDeviceID = @PrinterDeviceID 
                    AND P.JobTypeID IN (1, 2, 3)
                    AND P.JobDisabled = 0
       END

       RETURN @TotalPages

END
```

---

## 51. TryConvertUniqueidentifier

```sql
CREATE FUNCTION [dbo].[TryConvertUniqueidentifier]
(
  @Value NVARCHAR(4000)
)
RETURNS [UNIQUEIDENTIFIER]

AS

BEGIN

  RETURN (
	SELECT CONVERT(uniqueidentifier,
		CASE WHEN LEN(@Value) = 36 THEN
		CASE WHEN @Value LIKE
		   '[A-F0-9][A-F0-9][A-F0-9][A-F0-9]'
		+  '[A-F0-9][A-F0-9][A-F0-9][A-F0-9]'
		+ '-[A-F0-9][A-F0-9][A-F0-9][A-F0-9]'
		+ '-[A-F0-9][A-F0-9][A-F0-9][A-F0-9]'
		+ '-[A-F0-9][A-F0-9][A-F0-9][A-F0-9]'
		+ '-[A-F0-9][A-F0-9][A-F0-9][A-F0-9]'
		+  '[A-F0-9][A-F0-9][A-F0-9][A-F0-9]'
		+  '[A-F0-9][A-F0-9][A-F0-9][A-F0-9]'
    THEN @Value END
    END))

END
```

---

## 52. TypePrint

```sql
CREATE FUNCTION [dbo].[TypePrint](@ID1 BIGINT, @ID2 BIGINT) RETURNS BIGINT 
BEGIN 
 
DECLARE @Value BIGINT;

	IF (@ID1 = -1 OR @ID1 = 4)
	BEGIN
		IF (@ID2 = 1) 
			SET @Value =4; 
		ELSE   
			SET @Value = 5;
	END
	ELSE IF(@ID1 = 1)
 		SET @Value = 10;
 
 	RETURN(@Value); 
 
END
```

---

## 53. fn_360_GetAllPrintersFromCostAccounts

```sql
CREATE FUNCTION [dbo].[fn_360_GetAllPrintersFromCostAccounts](@CostAccountID INT) RETURNS 
@PrintersList TABLE (PrinterDeviceID INT)

AS

BEGIN

	IF (@CostAccountID IN (-1, 0, NULL))
	BEGIN
		RETURN
	END

	DECLARE @CCTempList TABLE (CostAccountID INT, Updated BIT)
	
	INSERT INTO
		@CCTempList
	SELECT 
		CostAccountID, 0
	FROM 
		CostAccounts
	WHERE 
		CostAccountParentID = @CostAccountID

	DECLARE @CAID INT
	SET @CAID = NULL

	SELECT @CAID = CostAccountID FROM @CCTempList WHERE Updated = 0

	WHILE @CAID IS NOT NULL
	BEGIN
		INSERT INTO @PrintersList
			SELECT PrinterDeviceID FROM dbo.[fn_360_GetAllPrintersFromCostAccounts](@CAID)
		
		UPDATE @CCTempList SET updated = 1 WHERE CostAccountID = @CAID 
		
		SET @CAID = NULL
		
		SELECT @CAID = CostAccountID FROM @CCTempList WHERE updated = 0

	END

	INSERT INTO
		@PrintersList
	SELECT 
		PrinterDeviceID
	FROM 
		PrintersDevices
	WHERE 
		CostAccountID = @CostAccountID

	RETURN

END
```

---

## 54. fn_360_GetCostAccountManaged

```sql
CREATE FUNCTION [dbo].[fn_360_GetCostAccountManaged] (@UserManagerID INT)
RETURNS 
@AccountList TABLE (AccountID INT)

AS

BEGIN

	DECLARE @AccountsTempList TABLE (AccountID INT, Updated BIT)
	
	INSERT INTO
		@AccountsTempList
	SELECT 
		CostAccountID, 0
	FROM
		CostAccountsManagers 
	WHERE 
		AccountID = @UserManagerID

	DECLARE @CAID INT
	SET @CAID = NULL

	SELECT
		@CAID = AccountID
	FROM 
		@AccountsTempList
	WHERE 
		Updated = 0

	WHILE (@CAID IS NOT NULL)
	BEGIN
		INSERT INTO
			@AccountList
		SELECT 
			CostAccountID 
		FROM 
			dbo.[getCostAccountChildrenTable](@CAID)
		
		UPDATE
			@AccountsTempList 
		SET 
			Updated = 1
		WHERE 
			AccountID = @CAID 
			
		SET @CAID = NULL
		
		SELECT 
			@CAID = AccountID 
		FROM 
			@AccountsTempList 
		WHERE 
			Updated = 0

	END

	RETURN

END
```

---

## 55. fn_360_GetQuotasPrinters_RetrieveAllBalances

```sql
CREATE FUNCTION [dbo].[fn_360_GetQuotasPrinters_RetrieveAllBalances]()
RETURNS 
@TBPrintersBalances TABLE
		(
			PrinterDeviceID INT,
			TotalPages INT,
			PagesMono INT,
			PagesColor INT,
			MoneyValue DECIMAL (19, 6),
			UnlimitedQuotas BIT
		)

AS

BEGIN
	
	--Busca os balanços dos créditos
	INSERT INTO
		@TBPrintersBalances
	SELECT
		ISNULL(QPC.PrinterDeviceID, -1) AS PrinterDeviceID,
		(SUM(QPC.TotalPages) - SUM(QPC.ExpenseTotalPages)) AS TotalPages,
		(SUM(QPC.PagesMono)  - SUM(QPC.ExpensePagesMono))  AS PagesMono,
		(SUM(QPC.PagesColor) - SUM(QPC.ExpensePagesColor)) AS PagesColor,
		(SUM(QPC.MoneyValue) - SUM(QPC.ExpenseMoneyValue)) AS MoneyValue,
		0 --UnlimitedQuotas
	FROM
		QuotasPrintersCredits QPC
	WHERE
		[Enabled] = 1
	GROUP BY
		QPC.PrinterDeviceID

	--Busca os balanços dos créditos expirados
	INSERT INTO
		@TBPrintersBalances		
	SELECT
		ISNULL(QPC.PrinterDeviceID, -1) AS AccountID,
		(SUM(QPC.TotalPages) - (SUM(QPC.ExpenseTotalPages) + SUM(ISNULL(QPE.ExpenseTotalPages, 0)))) AS TotalPages,
		(SUM(QPC.PagesMono)  - (SUM(QPC.ExpensePagesMono)  + SUM(ISNULL(QPE.ExpensePagesMono, 0))))  AS PagesMono,
		(SUM(QPC.PagesColor) - (SUM(QPC.ExpensePagesColor) + SUM(ISNULL(QPE.ExpensePagesColor, 0)))) AS PagesColor,
		(SUM(QPC.MoneyValue) - (SUM(QPC.ExpenseMoneyValue) + SUM(ISNULL(QPE.ExpenseMoneyValue, 0)))) AS MoneyValue,
		0 --UnlimitedQuotas
	FROM
		QuotasPrintersExpires QPE
		INNER JOIN QuotasPrintersCredits QPC ON QPC.QuotaPrinterCreditID = QPE.QuotaPrinterCreditID
	WHERE
		[Enabled] = 0
	GROUP BY
		QPC.PrinterDeviceID
		
	--Insere no balanço as Impressoras que tiveram débito, mas não tem mais créditos, isso quer dizer que estão zerados
	INSERT INTO
		@TBPrintersBalances
	SELECT DISTINCT
		ISNULL(QPD.PrinterDeviceID, -1) AS PrinterDeviceID,
		0, 0, 0, 0,
		0 --UnlimitedQuotas
	FROM
		QuotasPrintersDebits QPD
	
	INSERT INTO
		@TBPrintersBalances
	SELECT DISTINCT
		ISNULL(QPD.PrinterDeviceID, -1) AS PrinterDeviceID,
		0, 0, 0, 0,
		0 --UnlimitedQuotas
	FROM
		QuotasPrintersDebits QPD
		
	--Insere as Impressoras que tem cotas ilimitadas
	INSERT INTO
		@TBPrintersBalances
	SELECT
		PrinterDeviceID,
		0, 0, 0, 0,
		1 --UnlimitedQuotas
	FROM
		QuotasPrintersUnlimited
	
	--Remove qualquer tipo de balanço que tenha gerado para as impressoras com cotas ilimitadas
	DELETE FROM
		@TBPrintersBalances
	WHERE
		PrinterDeviceID IN (SELECT PrinterDeviceID FROM QuotasPrintersUnlimited)
		AND UnlimitedQuotas = 0
	
	RETURN
	
END
```

---

## 56. fn_360_Integration_PrintJobs_RetrieveAll

```sql
CREATE FUNCTION [dbo].[fn_360_Integration_PrintJobs_RetrieveAll]
(@BeginDate DATETIME, @EndDate DATETIME)
RETURNS 
	@PrintJobs TABLE
		(DomainName NVARCHAR(255),
		LogonName NVARCHAR(255),
		SerialNumber NVARCHAR(50),
		PrinterModel NVARCHAR(100),
		PrinterName NVARCHAR(200),
		Manufacturer NVARCHAR(100),
		IPAddress NVARCHAR(50),
		SiteName NVARCHAR(255),
		AccountID INT,
		PagesMono INT,
		PagesColor INT,
		BillingFirstDate DATETIME,
		BillingLastDate DATETIME,
		JobType INT) AS
BEGIN
	INSERT INTO
		@PrintJobs
	SELECT
		D.DomainName,
		A.LogonName,
		P.SerialNumber,
		PM.PrinterModelName AS PrinterModel,
		P.PrinterDeviceName AS PrinterName,
		B.BrandName AS Manufacturer,
		P.AddressName AS IPAddress,
		S.SiteName,
		PJ.AccountID,
		SUM(PJ.PagesMono) AS PagesMono,
		SUM(PJ.PagesColor) AS PagesColor,
		MIN(PJ.[Date]) AS BillingFirstDate,
		MAX(PJ.[Date]) AS BillingLastDate,
		PJ.JobTypeID
	FROM
		(SELECT
			AccountID AS UserID,
			CostAccountID AS AccountID,
			PrinterDeviceID,
			[Date],
			CASE
				WHEN Color = 0
				THEN SUM(Pages)
				ELSE 0
			END AS PagesMono,
			CASE
				WHEN Color = 1
				THEN SUM(Pages)
				ELSE 0
			END AS PagesColor,
			JobTypeID
		FROM
			CubeCube
		WHERE
			[Date] BETWEEN @BeginDate AND @EndDate
			AND Pages > 0
		GROUP BY
			AccountID,
			CostAccountID,
			PrinterDeviceID,
			[Date],
			Color,
			JobTypeID) AS PJ
	LEFT JOIN
		CostAccounts CA ON PJ.AccountID = CA.CostAccountID
	INNER JOIN
		Accounts A ON PJ.UserID = A.AccountID
	INNER JOIN
		[Domains] D ON A.DomainID = D.DomainID
	INNER JOIN
		PrintersDevices P ON PJ.PrinterDeviceID = P.PrinterDeviceID
	INNER JOIN
		PrintersModels PM ON P.PrinterModelID = PM.PrinterModelID
	INNER JOIN
		Brands B ON PM.BrandID = B.BrandID
	INNER JOIN
		Sites S ON P.SiteID = S.SiteID
	GROUP BY
		D.DomainName,
		A.LogonName,
		P.SerialNumber,
		PM.PrinterModelName,
		P.PrinterDeviceName,
		B.BrandName,
		P.AddressName,
		S.SiteName,
		PJ.AccountID,
		PJ.JobTypeID

	RETURN
END
```

---

## 57. fn_360_Reports_ReferenceCounter_Retrieve

```sql
CREATE FUNCTION [dbo].[fn_360_Reports_ReferenceCounter_Retrieve](@StartDateTime DATETIME, @EndDateTime DATETIME,@PrinterDeviceID INT) RETURNS INT
BEGIN

	DECLARE @LastCounters TABLE 
	(
		PrinterDeviceID INT,
		CounterReadingID INT,
		DateTimeRead DATETIME,
		ReferenceMono BIGINT,
		ReferenceColor BIGINT,
		IsUpdated BIT
	)
	
INSERT INTO @LastCounters 
	SELECT 
		CR.PrinterDeviceID, 
		CR.CounterReadingID, 
		CR.DateTimeRead, 
		CR.ReferenceMono, 
		CR.ReferenceColor, 
		CR.IsUpdated
	FROM 
		CountersReadings CR
	RIGHT OUTER JOIN
		(
			SELECT 
				CR.PrinterDeviceID,  
				MAX(DateTimeRead) AS DateTimeRead 
			FROM 
				CountersReadings CR
				INNER JOIN PrintersDevices PD ON PD.PrinterDeviceID = CR.PrinterDeviceID
			WHERE 
				DateTimeRead BETWEEN @StartDateTime AND @EndDateTime
				AND CR.Removed = 0
				AND CR.PrinterDeviceID = @PrinterDeviceID
			GROUP BY 
				CR.PrinterDeviceID
		) AS TableAux
	ON 
		CR.DateTimeRead = TableAux.DateTimeRead 
		AND CR.PrinterDeviceID = TableAux.PrinterDeviceID 
		AND CR.Removed = 0 
	WHERE 
		CR.PrinterDeviceID = @PrinterDeviceID

	DECLARE @FirstCounters TABLE 
	(
		PrinterDeviceID INT,
		CounterReadingID INT,
		DateTimeRead DATETIME,
		ReferenceMono BIGINT,
		ReferenceColor BIGINT,
		IsUpdated BIT
	)

INSERT INTO @FirstCounters 
	SELECT 
		CR.PrinterDeviceID,
		CR.CounterReadingID,
		CR.DateTimeRead, 
		CR.ReferenceMono, 
		CR.ReferenceColor, 
		CR.IsUpdated 
	FROM 
		CountersReadings CR
	RIGHT OUTER JOIN
		(
			SELECT 
				PD1.PrinterDeviceID,  
				MIN(DateTimeRead) AS DateTimeRead 
			FROM 
				CountersReadings CR
				INNER JOIN PrintersDevices PD1 ON PD1.PrinterDeviceID =  CR.PrinterDeviceID
			WHERE 
				DateTimeRead BETWEEN @StartDateTime AND @EndDateTime 
				AND CR.Removed = 0 
				AND PD1.PrinterDeviceID = @PrinterDeviceID
			GROUP BY 
				PD1.PrinterDeviceID
		) AS TableAux
	ON	
		CR.DateTimeRead = TableAux.DateTimeRead 
		AND CR.PrinterDeviceID = TableAux.PrinterDeviceID  
		AND CR.Removed = 0  
	WHERE 
		CR.PrinterDeviceID = @PrinterDeviceID

	DECLARE @Count INT

	SELECT
		@Count = (LCR.ReferenceMono + LCR.ReferenceColor) - (FCR.ReferenceColor + FCR.ReferenceMono)
	FROM 
		@LastCounters LCR	
		LEFT JOIN @FirstCounters FCR on LCR.PrinterDeviceID = FCR.PrinterDeviceID

	RETURN @Count
END
```

---

## 58. getAllAccountsFromCC

```sql
CREATE FUNCTION [dbo].[getAllAccountsFromCC](@CostAccountID INT) RETURNS 
@AccountsList TABLE (AccountID INT)

AS

BEGIN

	IF (@CostAccountID IN (-1, 0, NULL))
	BEGIN
		RETURN
	END

	DECLARE @CCTempList TABLE (CostAccountID INT, Updated BIT)
	
	INSERT INTO
		@CCTempList
	SELECT 
		CostAccountID, 0
	FROM 
		CostAccounts
	WHERE 
		CostAccountParentID = @CostAccountID

	DECLARE @CAID INT
	SET @CAID = NULL

	SELECT @CAID = CostAccountID FROM @CCTempList WHERE Updated = 0

	WHILE @CAID IS NOT NULL
	BEGIN
		INSERT INTO @AccountsList
			SELECT AccountID FROM dbo.[getAllAccountsFromCC](@CAID)
		
		UPDATE @CCTempList SET updated = 1 WHERE CostAccountID = @CAID 
		
		SET @CAID = NULL
		
		SELECT @CAID = CostAccountID FROM @CCTempList WHERE updated = 0

	END

	INSERT INTO
		@AccountsList
	SELECT 
		AccountID
	FROM 
		Accounts
	WHERE 
		CostAccountID = @CostAccountID

	RETURN

END
```

---

## 59. getCostAccountChildrenTable

```sql
CREATE FUNCTION [dbo].[getCostAccountChildrenTable] (@CostAccountID INT)
RETURNS @CostAccountList TABLE (CostAccountID INT)

AS

BEGIN

	IF (@CostAccountID IN (-1, 0, NULL))
	BEGIN
		RETURN
	END

	DECLARE @CCTempList TABLE (CostAccountID INT, Updated BIT)
	
	INSERT INTO
		@CCTempList
	SELECT 
		CostAccountID, 0
	FROM 
		CostAccounts 
	WHERE 
		CostAccountParentID = @CostAccountID

	DECLARE @CCID INT
	SET @CCID = NULL

	SELECT
		@CCID = CostAccountID
	FROM 
		@CCTempList 
	WHERE 
		Updated = 0

	WHILE (@CCID IS NOT NULL)
	BEGIN
		INSERT INTO
			@CostAccountList
		SELECT 
			CostAccountID 
		FROM 
			dbo.[getCostAccountChildrenTable](@CCID)
		
		UPDATE
			@CCTempList
		SET 
			Updated = 1
		WHERE 
			CostAccountID = @CCID 
		
		SET @CCID = NULL
		
		SELECT 
			@CCID = CostAccountID
		FROM 
			@CCTempList 
		WHERE 
			Updated = 0
	END

	INSERT INTO
		@CostAccountList 
	VALUES 
		(@CostAccountID)

	RETURN

END
```

---

## 60. getCostAccountManaged

```sql
CREATE FUNCTION [dbo].[getCostAccountManaged] (@AccountID INT)
RETURNS 
@CostAccountList TABLE (CostAccountID INT)

AS

BEGIN

	DECLARE @CCTempList TABLE (CostAccountID INT, Updated BIT)
	
	INSERT INTO
		@CCTempList
	SELECT 
		CostAccountID, 0
	FROM
		CostAccountsManagers 
	WHERE 
		AccountID = @AccountID

	DECLARE @CCID INT
	SET @CCID = NULL

	SELECT
		@CCID = CostAccountID
	FROM 
		@CCTempList
	WHERE 
		Updated = 0

	WHILE (@CCID IS NOT NULL)
	BEGIN
		INSERT INTO
			@CostAccountList
		SELECT 
			CostAccountID 
		FROM 
			dbo.[getCostAccountChildrenTable](@CCID)
		
		UPDATE
			@CCTempList 
		SET 
			Updated = 1
		WHERE 
			CostAccountID = @CCID 
			
		SET @CCID = NULL
		
		SELECT 
			@CCID = CostAccountID 
		FROM 
			@CCTempList 
		WHERE 
			Updated = 0

	END

	RETURN

END
```

---

## 61. getCountersDifRetrocomp

```sql
CREATE FUNCTION [dbo].[getCountersDifRetrocomp] (@Day DATE, @PDID INT)
RETURNS @CountersDifs TABLE (CounterReadingID INT, DateTimeRead DATETIME, CounterTypeID INT, CounterNumberDif INT, CounterColorNumberDif INT, CounterBlackNumberDif INT)

AS

BEGIN

	--**************************************************************************************************************
	--** Robson, 03/05/2016	
	--** FUNÇÃO QUE SIMULA OS DIFS DOS CONTADORES QUE TINHA NA VERSÃO 5.4 E ANTERIORES PARA SIMULAR O CONTADOR DE PRODUÇÃO NA 5.5
	--**************************************************************************************************************
	
	DECLARE @CounterReadingID INT = NULL
	DECLARE @CounterTypeID INT 
	DECLARE @DateTimeRead DATETIME 
	DECLARE @CounterNumber BIGINT
	DECLARE @CounterColorNumber BIGINT
	DECLARE @CounterBlackNumber BIGINT


	DECLARE @PrevCounterTypeID INT 
	--DECLARE @PrevDateTimeRead DATETIME
	DECLARE @PrevCounterNumber BIGINT
	DECLARE @PrevCounterColorNumber BIGINT
	DECLARE @PrevCounterBlackNumber BIGINT

	SET @PrevCounterTypeID = -1
	
	DECLARE @CounterNumberDif INT
	DECLARE @CounterColorNumberDif INT
	DECLARE @CounterBlackNumberDif INT


	--para teste quando é o primeiro registro de cada tipo
	DECLARE @PrevCounterReadingID INT 
	DECLARE @PrevCN BIGINT
	DECLARE @PrevCCN BIGINT
	DECLARE @PrevCBN BIGINT				
	DECLARE @PrevCNDif BIGINT
	DECLARE @PrevCCNDif BIGINT
	DECLARE @PrevCBNDif BIGINT

	DECLARE @FakeCounters TABLE (CounterReadingID INT, CounterTypeID INT, DateTimeRead DATETIME, CounterTotal INT, CounterColor INT, CounterMono INT, CounterNumberDif INT, CounterColorNumberDif INT, CounterBlackNumberDif INT, Updated BIT)

	INSERT INTO @FakeCounters
		SELECT
			C.CounterReadingID,			
			C.CounterTypeID,
			CR.DateTimeRead,
			C.CounterTotal,
			C.CounterColor,
			C.CounterMono,
			0,0,0,0
		FROM
			Counters C
			INNER JOIN CountersReadings CR ON C.CounterReadingID = CR.CounterReadingID
		WHERE
			CR.Removed = 0 AND
			CR.DateTimeRead >= @Day AND
			CR.DateTimeRead < DATEADD(DAY, 1, @Day) AND
			CR.PrinterDeviceID = @PDID/* AND
			(
				C.CounterTypeID = 1 OR --contador geral
				C.CounterTypeID IN (SELECT CounterTypeID FROM CounterTypes WHERE CounterGroupID = 2) OR --contadores de produção
				C.CounterTypeID IN (SELECT CounterTypeID FROM CounterTypes WHERE CounterTypeName IN ('A3','A3AndBiggerSizes','Duplex','Scan','FaxSent')) --contadores do relatório de fechamento
			)*/
		
	SELECT TOP 1
		@CounterReadingID =CounterReadingID,
		@CounterTypeID = CounterTypeID,
		@DateTimeRead=DateTimeRead,
		@CounterNumber=CounterTotal,
		@CounterColorNumber=CounterColor,
		@CounterBlackNumber=CounterMono
	FROM
		@FakeCounters 
	ORDER BY			
		CounterTypeID ASC,
		DateTimeRead ASC
		

	WHILE (@CounterReadingID IS NOT NULL)
	BEGIN 

		IF (@PrevCounterTypeID = @CounterTypeID)
		BEGIN
			SET @CounterNumberDif = @CounterNumber - @PrevCounterNumber
			IF (@CounterNumberDif < 0) --evita que fique negativo (atual menor que o anterior)
				SET @CounterNumberDif = 0
				
			--**Código comentado: se o anterior era 0, antes eu buscava outro anterior que não fosse. Só que isso bagunça a 
			--**informação da última leitura, que vai ficar furada porque o total mono e color são de datas diferentes.
			IF (@PrevCounterBlackNumber = 0 AND @CounterBlackNumber <> 0)
			BEGIN
				SET @PrevCounterBlackNumber  = @CounterBlackNumber --pro diff ficar 0

			END

			SET @CounterBlackNumberDif = @CounterBlackNumber - @PrevCounterBlackNumber
			IF (@CounterBlackNumberDif < 0)--evita que fique negativo (atual menor que o anterior)
				SET @CounterBlackNumberDif = 0

			--**Código comentado: se o anterior era 0, antes eu buscava outro anterior que não fosse. Só que isso bagunça a 
			--**informação da última leitura, que vai ficar furada porque o total mono e color são de datas diferentes.
			IF (@PrevCounterColorNumber = 0 AND @CounterColorNumber <> 0)
			BEGIN
				SET @PrevCounterColorNumber  = @CounterColorNumber --pro diff ficar 0
					
			END
			
			SET @CounterColorNumberDif = @CounterColorNumber - @PrevCounterColorNumber
			IF (@CounterColorNumberDif < 0)--evita que fique negativo (atual menor que o anterior)
				SET @CounterColorNumberDif = 0
			
			--Faz os updates
			UPDATE 
				@FakeCounters 
			SET 
				CounterNumberDif = @CounterNumberDif,
				CounterColorNumberDif = @CounterColorNumberDif,				
				CounterBlackNumberDif = @CounterBlackNumberDif
			WHERE 
				CounterReadingID = @CounterReadingID AND CounterTypeID = @CounterTypeID  

			
			--ALTEREI	
			SET	@PrevCounterNumber = @CounterNumber
			SET @PrevCounterColorNumber  = @CounterColorNumber
			SET	@PrevCounterBlackNumber = @CounterBlackNumber
			--ALTEREI
				
		END
		ELSE
		BEGIN

			--MUDOU DE CONTADOR, entao esse registro também tem que ser atualizado.

			-- tem que limpar AS variaveis pq senao fica com o resultado anterior
			SET @PrevCounterReadingID = NULL
			SET @PrevCN = NULL
			SET @PrevCCN = NULL
			SET @PrevCBN = NULL
			SET @PrevCNDif  = NULL
			SET @PrevCCNDif = NULL
			SET @PrevCBNDif = NULL
			--ALTEREI
			SET @PrevCounterTypeID = NULL
			--ALTEREI
						
			SELECT TOP 1 --busca do banco o ultimo contador (porque esta fora da minha memoria daqui da SP)
				@PrevCounterReadingID = C.CounterReadingID ,
				@PrevCN = C.CounterTotal,
				@PrevCCN = C.CounterColor,
				@PrevCBN = C.CounterMono,
				@PrevCounterTypeID = C.CounterTypeID --ALTEREI
			FROM
				Counters C
				INNER JOIN CountersReadings CR ON C.CounterReadingID = CR.CounterReadingID
			WHERE
				CR.Removed = 0 AND
				CR.PrinterDeviceID = @PDID
				AND CounterTypeID = @CounterTypeID
				AND DateTimeRead < @DateTimeRead
			ORDER BY			
				DateTimeRead DESC

			IF(@PrevCounterReadingID IS NOT NULL)
			BEGIN
			
				--Tem um contador antes desse. Calcula os Diffs desse primeiro registro.
				
				SET @PrevCNDif = @CounterNumber - @PrevCN
				IF (@PrevCNDif < 0) --evita que fique negativo (atual menor que o anterior)
					SET @PrevCNDif = 0

				--**Código comentado: se o anterior era 0, antes eu buscava outro anterior que não fosse. Só que isso bagunça a 
				--**informação da última leitura, que vai ficar furada porque o total mono e color são de datas diferentes.									
				IF (@PrevCBN = 0 AND @CounterBlackNumber <> 0)
				BEGIN
					SET @PrevCBN = @CounterBlackNumber 
						
				END

				SET @PrevCBNDif = @CounterBlackNumber - @PrevCBN
				IF (@PrevCBNDif < 0)--evita que fique negativo (atual menor que o anterior)
					SET @PrevCBNDif = 0

				--**Código comentado: se o anterior era 0, antes eu buscava outro anterior que não fosse. Só que isso bagunça a 
				--**informação da última leitura, que vai ficar furada porque o total mono e color são de datas diferentes.									
				IF (@PrevCCN = 0 AND @CounterColorNumber <> 0)
				BEGIN
					SET @PrevCCN = @CounterColorNumber 
						
				END
				
				SET @PrevCCNDif = @CounterColorNumber - @PrevCCN
				IF (@PrevCCNDif < 0)--evita que fique negativo (atual menor que o anterior)
					SET @PrevCCNDif = 0
				
				--Faz os updates
				UPDATE 
					@FakeCounters 
				SET 
					CounterNumberDif	  = @PrevCNDif,
					CounterColorNumberDif = @PrevCCNDif,				
					CounterBlackNumberDif = @PrevCBNDif
				WHERE 
					CounterReadingID = @CounterReadingID AND CounterTypeID = @CounterTypeID  
				
				--ALTEREI	
				SET @PrevCounterNumber = @CounterNumber 
				SET @PrevCounterBlackNumber = @CounterBlackNumber
				SET @PrevCounterColorNumber = @CounterColorNumber
				--ALTEREI
				
			END
			
		END			
	
		UPDATE @FakeCounters SET Updated = 1 WHERE CounterReadingID = @CounterReadingID and CounterTypeID = @CounterTypeID
		
		SET @CounterReadingID = NULL
		
		SELECT TOP 1
			@CounterReadingID =CounterReadingID,
			@CounterTypeID = CounterTypeID,
			@DateTimeRead=DateTimeRead,
			@CounterNumber=CounterTotal,
			@CounterColorNumber=CounterColor,
			@CounterBlackNumber=CounterMono
		FROM
			@FakeCounters
		WHERE 
			Updated = 0
		ORDER BY			
			CounterTypeID ASC,
			DateTimeRead ASC
	
	
	END
	
	INSERT INTO 
		@CountersDifs 
		SELECT 			
			CounterReadingID, DateTimeRead , CounterTypeID , CounterNumberDif , CounterColorNumberDif , CounterBlackNumberDif 
		FROM 
			@FakeCounters
		ORDER BY
			CounterTypeID DESC,
			DateTimeRead DESC		
	
	RETURN

END
```

---

## 62. getCubeTable

```sql
CREATE FUNCTION [dbo].[getCubeTable](@StartDateTime DATETIME, @EndDateTime DATETIME, @AccountIDOwner INT)
RETURNS
@CubeTable TABLE
(
	DomainName NVARCHAR(100),
	FullName NVARCHAR(255),
	SiteName NVARCHAR(255),
	PrinterDeviceName NVARCHAR(255),
	DateYear INT,
	DateMonth INT,
	DateDay INT,
	DateQuarter INT,
	Duplex NVARCHAR(7),
	PrintApplicationName NVARCHAR(100),
	PrintQualityName NVARCHAR(50),
	PaperSizeName NVARCHAR(100),
	JobOrigin NVARCHAR(16),
	Color NVARCHAR(5),
	CostAccountName NVARCHAR(255),
	CostAccountCode NVARCHAR(200),
	PrintServerName NVARCHAR(255),
	SerialNumber NVARCHAR(50),
	PrinterQueueName NVARCHAR(255),
	JobType NVARCHAR(11),
	SiteDivisionName NVARCHAR(255),
	Pages INT,
	Cost DECIMAL(19,6)
)

AS

BEGIN

	--////////////////////////////////////////////////
	--A partir da versão 4.2
	-- * Verificação das permissões do usuário de visualização do usuário dentro das SPs.
	--////////////////////////////////////////////////
	--/// início

	DECLARE @CCIDList TABLE (CostAccountID INT) -- tabela que contém a lista de centros de custo que serão pesquisados dependendo  do filtro e da permissão do usuário
	DECLARE @Parameters TABLE(accountID INT, CostAccountID INT, useORMethod BIT, buildListType INT) --TABELA COM OS PARAMETROS DAS PERMISSOES

	INSERT INTO @Parameters
		SELECT * FROM [dbo].[getParametersForReports](-1,@AccountIDOwner,@StartDateTime, @EndDateTime)

	--EXTRAIR OS PARAMETROS DA TABELA
	DECLARE @UseORMethod BIT -- 0: indica que será usado o operador E na consulta (maioria dos cacos) 1: indica o operador OU (para os casos que tem que trazer dados dos CCs E do usuário)
	DECLARE @buildListType INT -- 0: lista vazia; 1: lista de filhos dos ccs; 2: lista de ccs gerenciados do usuario
	DECLARE @AccountID INT --vai vir com valor se precisar pegar os dados do usuario
	DECLARE @CostAccountID INT

	SELECT @AccountID = AccountID, @CostAccountID = CostAccountID, @UseORMethod = UseORMethod, @buildListType = buildListType FROM @Parameters --*****************
	
	--preenche a lista de Centros de custo que serão usados nessa consulta
	IF (@buildListType = 1)
	BEGIN
		INSERT INTO @CCIDList 
			SELECT CostAccountID FROM [getCostAccountChildrenTable](@CostAccountID) --Lista recebe os filhos do CC procurado
	END
	ELSE
	BEGIN
		IF (@buildListType = 2)
		BEGIN
			INSERT INTO @CCIDList 
				SELECT DISTINCT CostAccountID FROM [getCostAccountManaged](@AccountIDOwner)  --traz a lista dos ccs gerenciados por esse usuario		
		END
	END
	--/// fim das alterações da 4.2


	DECLARE @GetCosts BIT
	--primeiro verifica se o usuário é admin
	IF (EXISTS(SELECT 1 FROM AccountsPermissions WHERE AccountID = @AccountIDOwner AND PermissionControlID = 1 AND PermissionAccessID = 9))
	BEGIN	
		-- Significa que o usuário pode ver todos os CCs e os custos dos jobs
		SET @GetCosts = 1
	END
	ELSE
	BEGIN	
		-- Significa que o usuário só pode ver os seus dados e/ou seus CCs
		-- Verifica se ele é gerente de algum CC
		IF((SELECT COUNT(1) FROM CostAccountsManagers WHERE AccountID = @AccountIDOwner) > 0)
		BEGIN
			-- o usuário é gerente. Ve se gerentes podem ver custo
			DECLARE @ShowCostsReportsToManagers BIT
			SELECT @ShowCostsReportsToManagers = CAST(ParameterValue AS BIT) FROM Parameters WHERE ParameterName = 'ShowCostsReportsToManagers'

			IF(@ShowCostsReportsToManagers = 0)
			BEGIN
				SET @GetCosts = 0
			END
			ELSE
			BEGIN
				SET @GetCosts = 1
			END
		END
		ELSE
		BEGIN
			--não é admion nem gerente. ve se usuários podem ver custos.
			DECLARE @ShowCostsReportsToAccounts BIT
			SELECT @ShowCostsReportsToAccounts = CAST(ParameterValue AS BIT) FROM Parameters WHERE ParameterName = 'ShowCostsReportsToAccounts'

			IF(@ShowCostsReportsToAccounts = 0)
			BEGIN
				SET @GetCosts = 0
			END
			ELSE
			BEGIN
				SET @GetCosts = 1
			END
		END
	END

	INSERT INTO 
		@CubeTable
	SELECT     
		D.DomainName,
		AC.FullName,
		S.SiteName,
		dbo.GetDefaultPrinterName1(PD.PrinterDeviceID) AS PrinterDeviceName, 
		DATEPART(YEAR,    [Date]) AS DateYear,
		DATEPART(MONTH,   [Date]) AS DateMonth,
		DATEPART(DAY,     [Date]) AS DateDay,
		DATEPART(QUARTER, [Date]) AS DateQuarter,
		CASE CB.PrintWayID WHEN 0 THEN 'Simplex' ELSE 'Duplex' END AS Duplex, 
		PA.PrintApplicationName,
		PQL.PrintQualityName,
		PS.PaperSizeName,
		CASE CB.JobOriginID 
			WHEN 1 THEN 'IMPRESSÃO DIRETA'  
			WHEN 2 THEN 'DPS'
			WHEN 3 THEN 'FORMS'
			WHEN 4 THEN 'Cópia Lexmark'
			WHEN 5 THEN 'Fax Lexmark'
			WHEN 6 THEN 'Xerox MF'
			WHEN 7 THEN 'BUREAU'
		END AS JobOrigin,
		CASE Color WHEN 0 THEN 'Mono' ELSE 'Color' END AS Color, 
		CASE CB.CostAccountID   WHEN -1 THEN 'No Cost Account'   ELSE CC.CostAccountName END AS CostAccountName,
		ISNULL(CC.CostAccountCode, '') AS CostAccountCode, 
		CASE CB.PrinterQueueID WHEN -1 THEN 'No Print Server'  ELSE M.MachineName END AS PrintServerName, 
		PD.SerialNumber,
		CASE CB.PrinterQueueID WHEN -1 THEN 'No Printer Queue' ELSE PQ.PrinterQueueName END AS PrinterQueueName, 
		CASE CB.JobTypeID
			WHEN 1 THEN 'Printing' 
			WHEN 2 THEN 'Copy' 
			WHEN 3 THEN 'FaxReceived' 
			WHEN 4 THEN 'Scan' 
			WHEN 5 THEN 'FaxSent' 
		END AS JobType,
		ISNULL(SD.SiteDivisionName, 'No Department')	AS SiteDivisionName,
		Pages,
		CASE @GetCosts WHEN 1 THEN Cost ELSE 0 END AS Cost
	FROM       
		CubeCube CB
		INNER JOIN PrintersDevices PD ON PD.PrinterDeviceID = CB.PrinterDeviceID 
		LEFT  JOIN SitesDivisions SD ON SD.SiteDivisionID = PD.SiteDivisionID 
		INNER JOIN PrintApplications PA ON PA.PrintApplicationID = CB.PrintApplicationID 
		INNER JOIN PrintQualities PQL ON PQL.PrintQualityID = CB.PrintQualityID 
		INNER JOIN PapersSize PS ON PS.PaperSizeID = CB.PaperSizeID 
		INNER JOIN Accounts AC ON AC.AccountID = CB.AccountID
		LEFT  JOIN PrintersQueues PQ ON PQ.PrinterQueueID = CB.PrinterQueueID 
		LEFT  JOIN Machines M ON M.MachineID = PQ.MachineID 
		INNER JOIN [Domains] D ON D.DomainID = AC.DomainID 
		INNER JOIN Sites S ON S.SiteID = CB.SiteID
		LEFT  JOIN CostAccounts CC ON CC.CostAccountID = CB.CostAccountID
	WHERE
		(CB.[Date] BETWEEN @StartDateTime AND @EndDateTime)
		AND Pages > 0 
		AND
		--//alteração [4.2]
		--//testa com o operador E qnd é jobs do usuário no CC ou operador OU qnd é jobs do usuário + jobs do cc
		((
			@UseORMethod= 0 
			AND
			(
				(@AccountID = -1 OR CB.AccountID = @AccountID)
				AND
				(@CostAccountID = -1 OR CB.CostAccountID IN (SELECT CostAccountID FROM @CCIDList))
			)
		)
		OR
		(
			@UseORMethod= 1 
			AND
			(
				(@AccountID = -1 OR CB.AccountID = @AccountID)
				OR
				(@CostAccountID = -1 OR CB.CostAccountID IN (SELECT CostAccountID FROM @CCIDList))
			)
		))

	RETURN

END
```

---

## 63. getFilterCostAccountHierarchy

```sql
CREATE FUNCTION [dbo].[getFilterCostAccountHierarchy] (@Filter NVARCHAR(255))
RETURNS @CostAccountList TABLE (ID INT, AccountName NVARCHAR(255),AccountCode NVARCHAR(100), ParentId INT)

AS

BEGIN


	--***********************************************************************************************************
	-- Função filtra contas pelo nome e código e retorna sua hierarquia junto.
	--
	-- Akauam Westphal - 18/08/2017
	--***********************************************************************************************************
	
	DECLARE @ParentIdsTable TABLE (CostAccountID INT)
	DECLARE @OriginalFilteredTable TABLE (CostAccountID INT)
	DECLARE @FilterText NVARCHAR(257)
	SET @FilterText = '%'+ @Filter +'%'

	INSERT INTO @OriginalFilteredTable
	SELECT CostAccountID 
	FROM   CostAccounts
	WHERE CostAccountName like @FilterText OR CostAccountCode like @FilterText

	DECLARE @Id INT

	WHILE EXISTS(SELECT * FROM @OriginalFilteredTable)
	BEGIN

		SELECT TOP 1 @Id = CostAccountId From @OriginalFilteredTable

		insert into @ParentIdsTable
		select ObjectID from [dbo].[getTableIDs] (dbo.GetCostAccountHierarchyIds(@Id)) 
		--Do some processing here

		Delete @OriginalFilteredTable Where CostAccountId = @Id

	End
	INSERT INTO @CostAccountList
	SELECT DISTINCT(ta.CostAccountID),ca.CostAccountName, ca.CostAccountCode, Ca.CostAccountParentID FROM @ParentIdsTable  ta
	INNER JOIN CostAccounts ca on ca.CostAccountID = ta.CostAccountID


	RETURN
END
```

---

## 64. getMainPrinterData

```sql
CREATE FUNCTION [dbo].[getMainPrinterData](@PrinterDeviceID BIGINT, @Field NVARCHAR(100)) RETURNS NVARCHAR(100)

BEGIN 

	DECLARE @ID DECIMAL(19, 6);
	DECLARE @strValueAux NVARCHAR(100);
	DECLARE @strValue NVARCHAR(100);
	 
	SELECT @ID = PrinterDeviceMainID FROM PrintersDevicesConsolidation WHERE PrinterDeviceConsolidatedID = @PrinterDeviceID
	
	IF (dbo.IsConsolidated(@PrinterDeviceID) = 1)
	BEGIN
		IF(@Field = 'PrinterDeviceID')
			SELECT @strValueAux = cast(PrinterDeviceID AS NVARCHAR(20)) FROM PrintersDevices WHERE PrinterDeviceID = @ID
		ELSE IF(@Field = 'PrinterDeviceName')
			SELECT @strValueAux = PrinterDeviceName FROM PrintersDevices WHERE PrinterDeviceID = @ID
		ELSE IF(@Field = 'TypePrinterID')
			SELECT @strValueAux = CASE WHEN IsLocal = 1 THEN '@@Local' ELSE '@@Network' END FROM PrintersDevices WHERE PrinterDeviceID = @ID
		ELSE IF(@Field = 'AddressName')
			SELECT @strValueAux = AddressName FROM PrintersDevices WHERE PrinterDeviceID = @ID
		ELSE IF(@Field = 'AddressPort')
			SELECT @strValueAux = AddressPort FROM PrintersDevices WHERE PrinterDeviceID = @ID
		ELSE IF(@Field = 'Model')
			SELECT @strValueAux = PM.PrinterModelName FROM PrintersDevices PD INNER JOIN PrintersModels PM ON PM.PrinterModelID = PD.PrinterModelID WHERE PD.PrinterDeviceID = @ID
		ELSE IF(@Field = 'Location')
			SELECT @strValueAux = Location FROM PrintersDevices WHERE PrinterDeviceID = @ID
		ELSE IF(@Field = 'EnabledBillingStatus')
			SELECT @strValueAux = EnabledBillingStatus FROM PrintersDevices WHERE PrinterDeviceID = @ID
		ELSE IF(@Field = 'EnabledCounterStatus')
			SELECT @strValueAux = EnabledCounterStatus FROM PrintersDevices WHERE PrinterDeviceID = @ID
		ELSE IF(@Field = 'SerialNumber')
			SELECT @strValueAux = SerialNumber FROM PrintersDevices WHERE PrinterDeviceID = @ID
	END
	ELSE
	BEGIN		
		SET @strValueAux = NULL;
	END

	SET @strValue = @strValueAux;

	RETURN(@strValue); 
	 
	END
```

---

## 65. getParametersForAccountsReports

```sql
CREATE FUNCTION [dbo].[getParametersForAccountsReports]
(
	@AccountIDPAR INT,
	@CostAccountIDPAR INT,
	@AccountIDOwner INT,
	@StartDateTime DATETIME, --data inicial, solicitada no relatório (o dia todo será considerado)
	@EndDateTime DATETIME --data final do relatório (o dia todo será considerado)

)
RETURNS 
@Parameters TABLE
(
	AccountID INT, --indica o ID do usuário que será usado nas queries
	CostAccountID INT, --indica o ID do centro de custo que será usado nas queries
	UseORMethod BIT, -- 0: indica que será usado o operado E na consulta (maioria dos cacos) 1: indica o operador OU (para os casos que tem que trazer dados dos CCs E do usuário)
	BuildListType INT -- 0: lista vazia; 1: lista de filhos dos ccs; 2: lista de ccs gerenciados do usuario
)

AS
BEGIN

	DECLARE @AccountID INT
	DECLARE @CostAccountID INT
	DECLARE @UseORMethod BIT
	DECLARE @BuildListType INT
	DECLARE @HasJobsOutsideCCsManaged BIT

	SET @AccountID = @AccountIDPAR
	SET @CostAccountID =@CostAccountIDPAR
	SET @UseORMethod = 0
	SET @BuildListType = 0

	--////////////////////////////////////////////////
	--A partir da versão 4.2
	-- * Verificação das permissões do usuário de visualização do usuário dentro das SPs.
	--////////////////////////////////////////////////
	--/// início

	DECLARE @Permission BIT -- 0: Permissão FULL (Vê todos os CCs) , 1: Permissão limitada (Vê apenas os seus dados e/ou de seus centros de custo)
	DECLARE @IsManager BIT -- 0: Indica que o usuário não é gerente de ninguém , 1: Indica que o usuário é gerente de algum CC
	DECLARE @IsManagerOfHimSelf BIT -- 0: Indica que o usuário não é gerente do CC que ele está, 1: Indica que o usuário é gerente do seu CC
	DECLARE @IsManagerOFCostCenter BIT  -- 0: indica que o usuário gerencia o CC que ele está filtrando. 1: indica que nao gerencia o CC que está sendo filtrado

	SET @IsManagerOfHimSelf = 0--apenas inicializa


	IF (@AccountIDOwner = -1)
	BEGIN 
	
		-- Owner = -1 indica que é usuarios de parceiro: pode ver tudo de todos
		SET @Permission = 0

	END
	ELSE
	BEGIN

		IF (EXISTS(SELECT * FROM AccountsPermissions WHERE AccountID = @AccountIDOwner AND PermissionControlID = 1 AND PermissionAccessID = 9))
		BEGIN	
			-- Significa que o usuário pode ver todos os CCs
			SET @Permission = 0
		END
		ELSE
		BEGIN	
			-- Significa que o usuário só pode ver os seus dados e/ou seus CCs
			SET @Permission = 1
		END

		DECLARE @MyCostAccountID INT

		SELECT @MyCostAccountID = ISNULL(CostAccountID, -1) FROM Accounts WHERE AccountID = @AccountIDOwner

		IF (EXISTS (SELECT * FROM CostAccountsManagers WHERE AccountID = @AccountIDOwner))
		BEGIN
			--Significa que ele tem alguma gerência
			SET @IsManager = 1

			--Testar se ele é gerente dele mesmo
			IF (@MyCostAccountID <> -1)
			BEGIN
				SET @IsManagerOfHimSelf = dbo.[IsManagerOfHimself](@AccountIDOwner)
			END
			
		END
		ELSE
		BEGIN
			--Significa que ele não é gerente de ninguém
			SET @IsManager = 0
		END
	END
	
	IF (@Permission = 1) --permissão limitada
	BEGIN
		IF (@IsManager = 0)
		BEGIN
			
			IF (@AccountID = -1 OR @AccountID = @AccountIDOwner) --se o filtro é ele mesmo ou não foi passado
			BEGIN

				IF (@CostAccountID = -1) --se não foi passado filtro de CC
				BEGIN	
			
					--/////////////////////////
					--/////CASO	C.4////////////
					--/////////////////////////

					SET @AccountID = @AccountIDOwner
					--Centro de Custo permanece o mesmo (-1)
					--Lista de CCs continua vazia				
			

				END
				ELSE
				BEGIN
				
					--foi passado um CC, que na maioria das vezes foi o do próprio usuário, como também pode ser outro (CC que o usuário um dia esteve - agendamento)
					

					--/////////////////////////
					--/////CASO	C.3////////////
					--/////////////////////////

					SET @AccountID = @AccountIDOwner
					--Centro de Custo permanece o mesmo					
					SET @BuildListType = 1 --FILHOS


				END


			END
			ELSE
			BEGIN
				--se o filtro é um usuário qualquer (tirando ele mesmo)

				--/////////////////////////
				--/////CASO	C.2////////////
				--/////////////////////////

				SET @AccountID = 0 --não pode ver os dados de outro usuário
				--Centro de Custo permanece o mesmo
				--Lista continua vazia

			END

		END
		ELSE
		BEGIN
		
			--usuário é gerente
			IF (@IsManagerOfHimSelf = 1)
			BEGIN
			
				-- é gerente dele mesmo
				
				IF (@CostAccountID = -1) --não foi passado filtro de cc
				BEGIN

					IF(@AccountID = -1) -- não foi passado nenhum filtro de usuário
					BEGIN

						SET @HasJobsOutsideCCsManaged = dbo.[HasJobsOutsideCCsManaged](@AccountIDOwner,@StartDateTime,@EndDateTime)

						IF (@HasJobsOutsideCCsManaged = 1 )
						BEGIN

							--/////////////////////////
							--/////CASO	C.9//////////// ESSE É UM CASO EXTRA PQ PRECISA DOS DADOS DOS CCS MAIS OS DO USUÁRIO
							--/////////////////////////

							SET @UseORMethod = 1 
							SET @AccountID = @AccountIDOwner
							SET @CostAccountID = 0 --não quero todos os ccs, só os da lista						
							SET @BuildListType = 2 --GERENCIADOS


						END
						ELSE 
						BEGIN

							--/////////////////////////
							--/////CASO	C.91//////////// Deve ser exibidos todos os dados impressos pelos seus CCs gerenciados (e seus filhos) 
							--/////////////////////////


							--accountid continua igual (-1)
							SET @CostAccountID = 0
							SET @BuildListType = 2 --GERENCIADOS


						END

					END
					ELSE -- foi passado algum usuário no filtro
					BEGIN

						IF(@AccountID = @AccountIDOwner) 
						BEGIN

							--/////////////////////////
							--/////CASO	C.8//////////// Traz os dados que ele mesmo imprimiu em qualquer centro de custo (mesmo que não seja gerenciado) 
							--/////////////////////////

							-- account id permanece igual
							--cost center permanece igual (-1)
							-- lista continua vazia
							
							DECLARE @t BIT --precisa de algo dentro do IF pra nao dar erro
	
						END
						ELSE
						BEGIN
							
							-- foi passado de filtro de usuário qq usuário (tirando nulo e ele mesmo)
							
							--/////////////////////////
							--/////CASO	C.7//////////// Traz os dados que o usuário imprimiu nos seus CCs gerenciados (e seus filhos) (se o usuário nunca imprimiu nada nesses CCs o relatório estará vazio)
							--/////////////////////////

							-- account id permanece igual
							SET @CostAccountID = 0 --não quero todos os ccs, só os da lista							
							SET @BuildListType = 2 --GERENCIADOS

						END

					END

				END
				ELSE -- foi passado algum filtro de cc
				BEGIN
					
					SET @IsManagerOFCostCenter = dbo.[IsCostAccountManagedByAccount](@CostAccountID, @AccountIDOwner)
					
					IF (@IsManagerOFCostCenter = 1)
					BEGIN

						-- o CC filtrado é gerenciado pelo usuário						

						--/////////////////////////
						--/////CASO	C.5//////////// Traz os dados que o usuário selecionado imprimiu dentro do CC selecionado (e seus filhos)
						--/////////////////////////

						-- account id permanece igual 
						-- cc permanece igual						
						SET @BuildListType = 1 --FILHOS

					END
					ELSE
					BEGIN

						-- o CC filtrado não é gerenciado pelo usuário (pode ser um agendamento antigo)

						IF(@AccountID = @AccountIDOwner OR @AccountID = -1)
						BEGIN
						
							--/////////////////////////
							--/////CASO	6.2//////////// Traz os dados do próprio usuário no CC selecionado
							--/////////////////////////

							SET @AccountID = @AccountIDOwner 
							-- cc permanece igual							
							SET @BuildListType = 1 --FILHOS

		
						END
						ELSE
						BEGIN

							--/////////////////////////
							--/////CASO	6.1//////////// Traz o relatório vazio porque não pode ver os dados daquele CC
							--/////////////////////////

							SET @AccountID = 0
							SET @CostAccountID = 0 
							--lista continua vazia

						END

					END

				END 

			END
			ELSE
			BEGIN

				--é gerente, mas não dele mesmo

				IF (@CostAccountID = -1)
				BEGIN

					IF (@AccountID = -1)
					BEGIN

						SET @HasJobsOutsideCCsManaged = dbo.[HasJobsOutsideCCsManaged](@AccountIDOwner, @StartDateTime, @EndDateTime)

						IF (@HasJobsOutsideCCsManaged = 1 )
						BEGIN


							--ESSE É UM CASO EXTRA PQ PRECISA DOS DADOS DOS CCS MAIS OS DO USUÁRIO
							--/////////////////////////
							--/////CASO	C.14//////////// Deve ser exibidos todos os dados impressos pelos seus CCs gerenciados (e seus filhos) MAIS os dados impressos pelo próprio usuário
							--/////////////////////////

							SET @UseORMethod = 1 
							SET @AccountID = @AccountIDOwner 
							SET @CostAccountID = 0
							SET @BuildListType = 2 --GERENCIADOS

						END
						ELSE
						BEGIN
	
							--/////////////////////////
							--/////CASO	C.141//////////// Deve ser exibidos todos os dados impressos pelos seus CCs gerenciados (e seus filhos) 
							--/////////////////////////


							--accountid continua igual (-1)
							SET @CostAccountID = 0
							SET @BuildListType = 2 --GERENCIADOS

						END
						
					END
					ELSE
					BEGIN

						IF (@AccountID = @AccountIDOwner)
						BEGIN

							--/////////////////////////
							--/////CASO	C.16//////////// Exibe tudo que o usuário imprimiu, em qualquer CC
							--/////////////////////////

							--account id permanece igual
							--permanece igual
							--lista continua vazia
							
							DECLARE @t1 BIT --precisa de algo dentro do IF pra nao dar erro

						END
						ELSE
						BEGIN
							
							--/////////////////////////
							--/////CASO	C.15//////////// Exibe os dados impressos pelo usuário selecionado nos CCs gerenciados (e seus filhos)
							--/////////////////////////

							--account id permanece igual
							SET @CostAccountID = 0
							SET @BuildListType = 2 --GERENCIADOS

						END

					END


				END
				ELSE
				BEGIN

					IF (@CostAccountID = @MyCostAccountID)
					BEGIN

						--Usuário pertece ao cc que escolheu, mas nao gerencia-o

						IF (@AccountID = @AccountIDOwner OR @AccountID = -1)
						BEGIN

							--/////////////////////////
							--/////CASO	C.12//////////// Exibe os dados impressos pelo usuário no CC (e seus filhos)
							--/////////////////////////

							SET @AccountID = @AccountIDOwner 
							--CC PERMANECE IGUAL
							SET @BuildListType = 1 --FILHOS


						END
						ELSE
						BEGIN

							--/////////////////////////
							--/////CASO	C.13//////////// O relatório deve ser exibido vazio
							--/////////////////////////

							SET @AccountID = 0 
							--CC PERMANECE IGUAL
							--lista permanece vazia

						END

					END
					ELSE
					BEGIN

						SET @IsManagerOFCostCenter = dbo.[IsCostAccountManagedByAccount](@CostAccountID, @AccountIDOwner)
						
						IF (@IsManagerOFCostCenter = 1)
						BEGIN

							-- o CC filtrado é gerenciado pelo usuário						

							--/////////////////////////
							--/////CASO	C.10//////////// Exibe todos os dados impressos pelo centro de custo (e seus filhos) e pelo usuário selecionado
							--/////////////////////////

							-- account id permanece igual 
							-- cc permanece igual
							SET @BuildListType = 1 --FILHOS

						END
						ELSE
						BEGIN


							-- o CC filtrado não é gerenciado pelo usuário, nem é o cc do usuario (pode ser um agendamento antigo)

							IF(@AccountID = @AccountIDOwner OR @AccountID = -1)
							BEGIN
							
								--/////////////////////////
								--/////CASO	C.11.2//////////// Traz os dados do próprio usuário no CC selecionado
								--/////////////////////////

								SET @AccountID = @AccountIDOwner 
								-- cc permanece igual
								SET @BuildListType = 1 --FILHOS

							END
							ELSE
							BEGIN

								--/////////////////////////
								--/////CASO	C.11.1//////////// Traz o relatório vazio porque não pode ver os dados daquele CC
								--/////////////////////////

								SET @AccountID = 0
								SET @CostAccountID = 0 
								--lista continua vazia

							END


						END


					END
				END

			END


		END
	END
	ELSE
	BEGIN

		-- permissão ilimitada, o usuário pode ver tudo

		--/////////////////////////
		--/////CASO	C.1////////////
		--/////////////////////////

		--account continua o mesmo
		--centro de custo permanece o mesmo
		SET @BuildListType = 1 --FILHOS

	END
	
	INSERT INTO @Parameters (AccountID, CostAccountID, UseORMethod, BuildListType) VALUES (@AccountID, @CostAccountID, @UseORMethod, @BuildListType)

	RETURN
	
END
```

---

## 66. getParametersForQuotasReports

```sql
CREATE FUNCTION [dbo].[getParametersForQuotasReports]
(
	@CostAccountIDPAR INT,
	@AccountIDOwner INT
)
RETURNS 
@Parameters TABLE
(
	AccountID INT, --indica o ID do usuário que será usado nas queries
	CostCenterID INT, --indica o ID do centro de custo que será usado nas queries
	UseORMethod BIT, -- 0: indica que será usado o operado E na consulta (maioria dos cacos) 1: indica o operador OU (para os casos que tem que trazer dados dos CCs E do usuário)
	BuildListType INT -- 0: lista vazia; 1: lista de filhos dos ccs; 2: lista de ccs gerenciados do usuario
)

AS
BEGIN

	DECLARE @AccountID INT
	DECLARE @CostAccountID INT
	DECLARE @UseORMethod BIT
	DECLARE @BuildListType INT
	DECLARE @HasJobsOutsideCCsManaged BIT

	SET @AccountID = -1
	SET @CostAccountID = @CostAccountIDPAR
	SET @UseORMethod = 0
	SET @BuildListType = 0

	--////////////////////////////////////////////////
	--A partir da versão 4.2
	-- * Verificação das permissões do usuário de visualização do usuário dentro das SPs.
	--////////////////////////////////////////////////
	--/// início

	DECLARE @Permission BIT -- 0: Permissão FULL (Vê todos os CCs) , 1: Permissão limitada (Vê apenas os seus dados e/ou de seus centros de custo)
	DECLARE @IsManager BIT -- 0: Indica que o usuário não é gerente de ninguém , 1: Indica que o usuário é gerente de algum CC
	DECLARE @IsManagerOfHimSelf BIT -- 0: Indica que o usuário não é gerente do CC que ele está, 1: Indica que o usuário é gerente do seu CC
	DECLARE @IsManagerOFCostCenter BIT  -- 0: indica que o usuário gerencia o CC que ele está filtrando. 1: indica que nao gerencia o CC que está sendo filtrado

	SET @IsManagerOfHimSelf = 0--apenas inicializa


	IF (@AccountIDOwner = -1)
	BEGIN 
	
		-- Owner = -1 indica que é usuarios de parceiro: pode ver tudo de todos
		SET @Permission = 0

	END
	ELSE
	BEGIN


		IF (EXISTS(SELECT * FROM AccountsPermissions WHERE AccountID = @AccountIDOwner AND PermissionControlID = 1 AND PermissionAccessID = 9))
		BEGIN	
			-- Significa que o usuário pode ver todos os CCs
			SET @Permission = 0
		END
		ELSE
		BEGIN	
			-- Significa que o usuário só pode ver os seus dados e/ou seus CCs
			SET @Permission = 1
		END

		DECLARE @MyCostCenterID INT

		SELECT @MyCostCenterID = ISNULL(CostAccountID, -1) FROM Accounts WHERE AccountID = @AccountIDOwner

		IF (EXISTS (SELECT * FROM CostAccountsManagers WHERE AccountID = @AccountIDOwner))
		BEGIN
			--Significa que ele tem alguma gerência
			SET @IsManager = 1

			--Testar se ele é gerente dele mesmo
			IF (@MyCostCenterID <> -1)
			BEGIN
				SET @IsManagerOfHimSelf = dbo.[IsManagerOfHimself](@AccountIDOwner)
			END
			
		END
		ELSE
		BEGIN
			--Significa que ele não é gerente de ninguém
			SET @IsManager = 0
		END

	END
	
	IF (@Permission = 1) --permissão limitada
	BEGIN
		IF (@IsManager = 0)
		BEGIN
			

			IF (@CostAccountID = -1) --se não foi passado filtro de CC
			BEGIN	

				--/////////////////////////
				--/////CASO	C.19////////////Deve exibir apenas os dados do usuário logado
				--/////////////////////////

				SET @AccountID = @AccountIDOwner
				--Centro de Custo permanece o mesmo (-1)
				--Lista de CCs continua vazia				
		

			END
			ELSE
			BEGIN

				--foi passado um CC, que na maioria das vezes foi o do próprio usuário, como também pode ser outro (CC que o usuário um dia esteve - agendamento)

				--/////////////////////////
				--/////CASO	C.18////////////
				--/////////////////////////

				SET @AccountID = @AccountIDOwner
				--Centro de Custo permanece o mesmo					
				SET @BuildListType = 1 --FILHOS


			END

		END
		ELSE
		BEGIN
		
			--usuário é gerente
			IF (@IsManagerOfHimSelf = 1)
			BEGIN
			
				-- é gerente dele mesmo
				
				IF (@CostAccountID = -1) --não foi passado filtro de cc
				BEGIN
				
					--/////////////////////////
					--/////CASO	C.21//////////// Traz os dados impressos por todos os CCs gerenciados (e seus filhos)
					--/////////////////////////

					-- account id permanece igual 
					SET @CostAccountID = 0 --não quero todos os ccs, só os da lista			
					SET @BuildListType = 2 --FILHOS

				END
				ELSE -- foi passado algum filtro de cc
				BEGIN
					
					SET @IsManagerOFCostCenter = dbo.[IsCostAccountManagedByAccount](@CostAccountID, @AccountIDOwner)
					
					IF (@IsManagerOFCostCenter = 1)
					BEGIN


						-- o CC filtrado é gerenciado pelo usuário						

						--/////////////////////////
						--/////CASO	C.20//////////// Traz os dados impressos pelo CC selecionado (e seus filhos)
						--/////////////////////////

						-- account id permanece igual 
						-- cc permanece igual						
						SET @BuildListType = 1 --FILHOS

					END
					ELSE
					BEGIN


						-- o CC filtrado não é gerenciado pelo usuário (pode ser um agendamento antigo)

					
						--/////////////////////////
						--/////CASO	C.201//////////// Traz os dados impressos pelo próprio usuário no CC informado
						--/////////////////////////

						SET @AccountID = @AccountIDOwner 
						-- cc permanece igual							
						SET @BuildListType = 1 --FILHOS

					END

				END 

			END
			ELSE
			BEGIN

				--é gerente, mas não dele mesmo

				IF (@CostAccountID = -1)
				BEGIN
					
						--ESSE É UM CASO EXTRA PQ PRECISA DOS DADOS DOS CCS MAIS OS DO USUÁRIO
						--/////////////////////////
						--/////CASO	C.25//////////// Deve ser exibidos todos os dados impressos pelos seus CCs gerenciados (e seus filhos) MAIS os dados impressos pelo próprio usuário
						--/////////////////////////

						SET @UseORMethod = 1 
						SET @AccountID = @AccountIDOwner 
						SET @CostAccountID = 0
						SET @BuildListType = 2 --GERENCIADOS

				END	
				ELSE
				BEGIN
			
					--foi passado filtro de cc

					SET @IsManagerOFCostCenter = dbo.[IsCostAccountManagedByAccount](@CostAccountID, @AccountIDOwner)
					
					IF (@IsManagerOFCostCenter = 1)
					BEGIN

						-- o CC filtrado é gerenciado pelo usuário						

						--/////////////////////////
						--/////CASO	C.22//////////// Exibe todos os dados impressos pelo centro de custo (e seus filhos)
						--/////////////////////////

						-- account id permanece igual 
						-- cc permanece igual
						SET @BuildListType = 1 --FILHOS

					END
					ELSE
					BEGIN

						--/////////////////////////
						--/////CASO	C.23//////////// Exibe os dados impressos pelo usuário no CC (e seus filhos)
						--/////////////////////////

						SET @AccountID = @AccountIDOwner 
						--CC PERMANECE IGUAL
						SET @BuildListType = 1 --FILHOS

					END

				END

			END

		END

	END
	ELSE
	BEGIN

		-- permissão ilimitada, o usuário pode ver tudo

		--/////////////////////////
		--/////CASO	C.17////////////
		--/////////////////////////

		--account continua o mesmo
		--centro de custo permanece o mesmo
		SET @BuildListType = 1 --FILHOS

	END
	
	INSERT INTO @Parameters (AccountID, CostCenterID, UseORMethod, BuildListType) VALUES (@AccountID, @CostAccountID, @UseORMethod, @BuildListType)

	RETURN
	
END
```

---

## 67. getParametersForReports

```sql
CREATE FUNCTION [dbo].[getParametersForReports]
(
	@CostAccountIDPAR INT,
	@AccountIDOwner INT,
	@StartDateTime DATETIME, --data inicial, solicitada no relatório (o dia todo será considerado)
	@EndDateTime DATETIME --data final do relatório (o dia todo será considerado)

)
RETURNS 
@Parameters TABLE
(
	AccountID INT, --indica o ID do usuário que será usado nas queries
	CostAccountID INT, --indica o ID do centro de custo que será usado nas queries
	UseORMethod BIT, -- 0: indica que será usado o operado E na consulta (maioria dos cacos) 1: indica o operador OU (para os casos que tem que trazer dados dos CCs E do usuário)
	BuildListType INT -- 0: lista vazia; 1: lista de filhos dos ccs; 2: lista de ccs gerenciados do usuario
)

AS

BEGIN

	DECLARE @AccountID INT
	DECLARE @CostAccountID INT
	DECLARE @UseORMethod BIT
	DECLARE @BuildListType INT
	DECLARE @HasJobsOutsideCCsManaged BIT

	SET @AccountID = -1
	SET @CostAccountID = @CostAccountIDPAR
	SET @UseORMethod = 0
	SET @BuildListType = 0

	--////////////////////////////////////////////////
	--A partir da versão 4.2
	-- * Verificação das permissões do usuário de visualização do usuário dentro das SPs.
	--////////////////////////////////////////////////
	--/// início

	DECLARE @Permission BIT -- 0: Permissão FULL (Vê todos os CCs) , 1: Permissão limitada (Vê apenas os seus dados e/ou de seus centros de custo)
	DECLARE @IsManager BIT -- 0: Indica que o usuário não é gerente de ninguém , 1: Indica que o usuário é gerente de algum CC
	DECLARE @IsManagerOfHimSelf BIT -- 0: Indica que o usuário não é gerente do CC que ele está, 1: Indica que o usuário é gerente do seu CC
	DECLARE @IsManagerOFCostCenter BIT  -- 0: indica que o usuário gerencia o CC que ele está filtrando. 1: indica que nao gerencia o CC que está sendo filtrado

	SET @IsManagerOfHimSelf = 0--apenas inicializa

	IF (@AccountIDOwner = -1)
	BEGIN 
	
		-- Owner = -1 indica que é usuarios de parceiro: pode ver tudo de todos
		SET @Permission = 0

	END
	ELSE
	BEGIN


		IF (EXISTS(SELECT * FROM AccountsPermissions WHERE AccountID = @AccountIDOwner AND PermissionControlID = 1 AND PermissionAccessID = 9))
		BEGIN	
			-- Significa que o usuário pode ver todos os CCs
			SET @Permission = 0
		END
		ELSE
		BEGIN	
			-- Significa que o usuário só pode ver os seus dados e/ou seus CCs
			SET @Permission = 1
		END

		DECLARE @MyCostCenterID INT

		SELECT @MyCostCenterID = ISNULL(CostAccountID, -1) FROM Accounts WHERE AccountID = @AccountIDOwner

		IF (EXISTS (SELECT * FROM CostAccountsManagers WHERE AccountID = @AccountIDOwner))
		BEGIN
			--Significa que ele tem alguma gerência
			SET @IsManager = 1

			--Testar se ele é gerente dele mesmo
			IF (@MyCostCenterID <> -1)
			BEGIN
				SET @IsManagerOfHimSelf = dbo.[IsManagerOfHimself](@AccountIDOwner)
			END
			
		END
		ELSE
		BEGIN
			--Significa que ele não é gerente de ninguém
			SET @IsManager = 0
		END

	END
	
	IF (@Permission = 1) --permissão limitada
	BEGIN
		IF (@IsManager = 0)
		BEGIN
			

			IF (@CostAccountID = -1) --se não foi passado filtro de CC
			BEGIN	

				--/////////////////////////
				--/////CASO	C.19////////////Deve exibir apenas os dados do usuário logado
				--/////////////////////////

				SET @AccountID = @AccountIDOwner
				--Centro de Custo permanece o mesmo (-1)
				--Lista de CCs continua vazia				
		

			END
			ELSE
			BEGIN

				--foi passado um CC, que na maioria das vezes foi o do próprio usuário, como também pode ser outro (CC que o usuário um dia esteve - agendamento)

				--/////////////////////////
				--/////CASO	C.18////////////
				--/////////////////////////

				SET @AccountID = @AccountIDOwner
				--Centro de Custo permanece o mesmo					
				SET @BuildListType = 1 --FILHOS


			END

		END
		ELSE
		BEGIN
		
			--usuário é gerente
			IF (@IsManagerOfHimSelf = 1)
			BEGIN
			
				-- é gerente dele mesmo
				
				IF (@CostAccountID = -1) --não foi passado filtro de cc
				BEGIN

					SET @HasJobsOutsideCCsManaged = dbo.[HasJobsOutsideCCsManaged](@AccountIDOwner,@StartDateTime,@EndDateTime)

					IF (@HasJobsOutsideCCsManaged = 1 )
					BEGIN

						--/////////////////////////
						--/////CASO	C.211//////////// Traz os dados de todos os centros de custo gerenciados (e seus filhos) E os dados dele mesmo (que podem ou não estarem nos seus CCs gerenciados) 
						--/////////////////////////

						SET @UseORMethod = 1 
						SET @AccountID = @AccountIDOwner
						SET @CostAccountID = 0 --não quero todos os ccs, só os da lista						
						SET @BuildListType = 2 --GERENCIADOS

					END
					ELSE
					BEGIN

						--/////////////////////////
						--/////CASO	C.21//////////// Traz os dados impressos por todos os CCs gerenciados (e seus filhos)
						--/////////////////////////

						-- account id permanece igual 
						SET @CostAccountID = 0 --não quero todos os ccs, só os da lista			
						SET @BuildListType = 2 --FILHOS

					END


				END
				ELSE -- foi passado algum filtro de cc
				BEGIN
					
					SET @IsManagerOFCostCenter = dbo.[IsCostAccountManagedByAccount](@CostAccountID, @AccountIDOwner)
					
					IF (@IsManagerOFCostCenter = 1)
					BEGIN


						-- o CC filtrado é gerenciado pelo usuário						

						--/////////////////////////
						--/////CASO	C.20//////////// Traz os dados impressos pelo CC selecionado (e seus filhos)
						--/////////////////////////

						-- account id permanece igual 
						-- cc permanece igual						
						SET @BuildListType = 1 --FILHOS

					END
					ELSE
					BEGIN


						-- o CC filtrado não é gerenciado pelo usuário (pode ser um agendamento antigo)

					
						--/////////////////////////
						--/////CASO	C.201//////////// Traz os dados impressos pelo próprio usuário no CC informado
						--/////////////////////////

						SET @AccountID = @AccountIDOwner 
						-- cc permanece igual							
						SET @BuildListType = 1 --FILHOS

					END

				END 

			END
			ELSE
			BEGIN

				--é gerente, mas não dele mesmo

				IF (@CostAccountID = -1)
				BEGIN
					
					SET @HasJobsOutsideCCsManaged = dbo.[HasJobsOutsideCCsManaged](@AccountIDOwner,@StartDateTime, @EndDateTime)

					IF (@HasJobsOutsideCCsManaged = 1 )
					BEGIN

						--ESSE É UM CASO EXTRA PQ PRECISA DOS DADOS DOS CCS MAIS OS DO USUÁRIO
						--/////////////////////////
						--/////CASO	C.25//////////// Deve ser exibidos todos os dados impressos pelos seus CCs gerenciados (e seus filhos) MAIS os dados impressos pelo próprio usuário
						--/////////////////////////

						SET @UseORMethod = 1 
						SET @AccountID = @AccountIDOwner 
						SET @CostAccountID = 0
						SET @BuildListType = 2 --GERENCIADOS

					END
					ELSE
					BEGIN

						--/////////////////////////
						--/////CASO	C.24//////////// Traz os dados de todos os centros de custo gerenciados (e seus filhos) 
						--/////////////////////////

						-- account id permanece igual 
						SET @CostAccountID = 0 --não quero todos os ccs, só os da lista			
						SET @BuildListType = 2 --FILHOS


					END

				END	
				ELSE
				BEGIN
			
					--foi passado filtro de cc

					SET @IsManagerOFCostCenter = dbo.[IsCostAccountManagedByAccount](@CostAccountID, @AccountIDOwner)
					
					IF (@IsManagerOFCostCenter = 1)
					BEGIN

						-- o CC filtrado é gerenciado pelo usuário						

						--/////////////////////////
						--/////CASO	C.22//////////// Exibe todos os dados impressos pelo centro de custo (e seus filhos)
						--/////////////////////////

						-- account id permanece igual 
						-- cc permanece igual
						SET @BuildListType = 1 --FILHOS

					END
					ELSE
					BEGIN

						--/////////////////////////
						--/////CASO	C.23//////////// Exibe os dados impressos pelo usuário no CC (e seus filhos)
						--/////////////////////////

						SET @AccountID = @AccountIDOwner 
						--CC PERMANECE IGUAL
						SET @BuildListType = 1 --FILHOS

					END

				END

			END

		END

	END
	ELSE
	BEGIN

		-- permissão ilimitada, o usuário pode ver tudo

		--/////////////////////////
		--/////CASO	C.17////////////
		--/////////////////////////

		--account continua o mesmo
		--centro de custo permanece o mesmo
		SET @BuildListType = 1 --FILHOS

	END
	
	INSERT INTO @Parameters (AccountID, CostAccountID, UseORMethod, BuildListType) VALUES (@AccountID, @CostAccountID, @UseORMethod, @BuildListType)

	RETURN
	
END
```

---

## 68. getPoliciesAccountsCache

```sql
CREATE FUNCTION [dbo].[getPoliciesAccountsCache]() 
RETURNS 
	@ObjectsList TABLE
	(
		ObjectID INT
	)
	
AS

BEGIN

	--Busca todos os usuários que possuem políticas
	INSERT INTO
		@ObjectsList
	SELECT DISTINCT 
		ObjectID 
	FROM 
		dbo.getPoliciesMembers(1)
	
	--Busca todos os usuários que possuem aliases
	INSERT INTO
		@ObjectsList
	SELECT DISTINCT 
		AccountID 
	FROM 
		AccountsAliases WITH (NOLOCK)
	
	--Busca todos os usuários que possuem aliases
	INSERT INTO
		@ObjectsList
	SELECT DISTINCT 
		AccountIDMain 
	FROM 
		AccountsAliases WITH (NOLOCK)
	
	--Busca todos os usuários que possuem cotas de espaço em disco configuradas
	INSERT INTO
		@ObjectsList
	SELECT DISTINCT
		AI.AccountID 
	FROM 
		Accounts A 
		LEFT JOIN AccountsInfo AI ON A.AccountID = AI.AccountID 
	WHERE 
		AI.ReleaserStorageQuota IS NOT NULL
		AND AI.ReleaserStorageQuota <> -1
		
	RETURN
	
END
```

---

## 69. getPoliciesMembers

```sql
CREATE FUNCTION [dbo].[getPoliciesMembers] (@MemberType INT) --1: Accounts, 2:Printers
RETURNS @ObjectsList TABLE (ObjectID INT)
	
AS

BEGIN

	--Busca todos os usuários ou impressoras relacionados com as políticas existentes
	IF(@MemberType = 1) --Accounts
	BEGIN
		INSERT INTO
			@ObjectsList
		SELECT 
			ObjectID
		FROM 
			PoliciesMembers PM WITH (NOLOCK)
		WHERE
			PM.PolicyMemberType = 1
		
		UNION
		
		SELECT 
			ObjectID
		FROM 
			PoliciesMembers PM WITH (NOLOCK)
		WHERE
			PM.PolicyMemberType = 5
		
		UNION
		
		SELECT
			AccountID
		FROM
			AccountsGroupsObjects WITH (NOLOCK)
		WHERE
			AccountGroupID IN 
			(
				SELECT 
					ObjectID
				FROM 
					PoliciesMembers PM WITH (NOLOCK)
					INNER JOIN AccountsGroups AG WITH (NOLOCK) ON AG.AccountGroupID = PM.ObjectID AND PM.PolicyMemberType = 2
			)
			
		INSERT INTO
			@ObjectsList
		SELECT
			AccountID
		FROM
			AccountsAliases AA
			LEFT JOIN @ObjectsList OL ON OL.ObjectID = AA.AccountIDMain
		WHERE
			AccountID IS NOT NULL
			
		INSERT INTO
			@ObjectsList
		SELECT
			AccountIDMain
		FROM
			AccountsAliases AA
			LEFT JOIN @ObjectsList OL ON OL.ObjectID = AA.AccountID
		WHERE
			AccountIDMain IS NOT NULL
	END
	ELSE
	IF (@MemberType = 2) --Printers
	BEGIN
		INSERT INTO
			@ObjectsList
		
		SELECT 
			ObjectID
		FROM 
			PoliciesMembers PM WITH (NOLOCK)
		WHERE
			PM.PolicyMemberType = 3
		
		UNION
		
		SELECT 
			PrinterDeviceID
		FROM 
			PoliciesMembers PM WITH (NOLOCK)
		WHERE
			PM.PolicyMemberType = 5
		
		UNION
		
		SELECT
			PrinterDeviceID
		FROM
			PrintersDevices WITH (NOLOCK)
		WHERE
			CostGroupID IN 
			(
				SELECT 
					ObjectID
				FROM 
					PoliciesMembers PM WITH (NOLOCK)
					INNER JOIN CostGroups PDG WITH (NOLOCK) ON PDG.CostGroupID = PM.ObjectID AND PM.PolicyMemberType = 4
			)
			
		INSERT INTO
			@ObjectsList
		SELECT
			PDC.PrinterDeviceConsolidatedID
		FROM
			PrintersDevicesConsolidation PDC
			LEFT JOIN @ObjectsList OL ON OL.ObjectID = PDC.PrinterDeviceMainID
		WHERE
			PDC.PrinterDeviceConsolidatedID IS NOT NULL
			
		INSERT INTO
			@ObjectsList
		SELECT
			PDC.PrinterDeviceMainID
		FROM
			PrintersDevicesConsolidation PDC
			LEFT JOIN @ObjectsList OL ON OL.ObjectID = PDC.PrinterDeviceConsolidatedID
		WHERE
			PDC.PrinterDeviceMainID IS NOT NULL
	END
		
	RETURN
	
END
```

---

## 70. getPrintersAndCountersBehaviorsRetrocomp

```sql
CREATE FUNCTION [dbo].[getPrintersAndCountersBehaviorsRetrocomp]
(
	@PrinterDeviceID INT = NULL,
	@SiteID INT = NULL,
	@SiteDivisionID INT = NULL,
	@Engaged BIT = NULL
)
RETURNS @OutputPrintersAndBehaviors TABLE
	(
		PrinterDeviceID	INT,					
		LifeAdjustType TINYINT,				--Ajuste do contador de vida
		LifeComplementType TINYINT,			--Complemento do contador de vida
		ProductionAdjustType TINYINT,		--Ajuste do contador de produção
		ProductionComplementType TINYINT,	--Complemento do contador de produção
		ProductionIsLife BIT				--Indica se o contador de produção usa o de vida (1) ou a soma dos de impressão (0)
	)
BEGIN

	--***********************************************************************************************************
	-- Robson Wiggers, 05/03/2016
	-- *trazer os dados retrocompatívelmente
	--***********************************************************************************************************

	DECLARE @PrintersAndBehaviors TABLE
	(
		PDID INT,					
		PrinterModelID INT,		
		BrandID INT,
		LifeAdjustType TINYINT,				--Ajuste do contador de vida
		LifeComplementType TINYINT,			--Complemento do contador de vida
		ProductionAdjustType TINYINT,		--Ajuste do contador de produção
		ProductionComplementType TINYINT,	--Complemento do contador de produção
		ProductionIsLife BIT
	)

	--Primeiro pega AS impressoras que precisa
	INSERT INTO 
		@PrintersAndBehaviors
		SELECT 
			PD.PrinterDeviceID AS PDID,
			PD.PrinterModelID,
			B.BrandID,
			NULL AS LifeAdjustType, 
			NULL AS LifeComplementType,
			NULL AS ProductionAdjustType,
			NULL AS ProductionComplementType,
			NULL AS ProductionIsLife
		FROM
			PrintersDevices PD
			INNER JOIN PrintersModels PM ON PD.PrinterModelID = PM.PrinterModelID
			INNER JOIN Brands B ON PM.BrandID = B.BrandID
		WHERE
			(PD.EnabledCounterStatus  IN (1, 3)) AND
			(PD.PrinterDeviceID NOT IN (SELECT PrinterDeviceConsolidatedID FROM PrintersDevicesConsolidation)) AND
			((@PrinterDeviceID IS NULL) OR (PD.PrinterDeviceID = @PrinterDeviceID)) AND
			((@Engaged IS NULL OR @Engaged = 0) OR (PD.EngagedStatus in (1,3))) AND
			((@SiteID IS NULL) OR (PD.SiteID = @SiteID)) AND
			((@SiteDivisionID IS NULL) OR (PD.SiteDivisionID = @SiteDivisionID))
		
	
	--Atualiza os comportamentos. Primeiro os comportamentos padrão para todos.
	UPDATE
		@PrintersAndBehaviors
	SET
		LifeAdjustType = PDCC.AdjustType,
		LifeComplementType = PDCC.ComplementType
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 1 AND
			PDCC.PrinterBrandID IS NULL AND
			PDCC.ModelID IS NULL AND
			PDCC.PrinterDeviceID IS NULL 

	UPDATE
		@PrintersAndBehaviors
	SET
		ProductionAdjustType = PDCC.AdjustType,
		ProductionComplementType = PDCC.ComplementType,
		ProductionIsLife = PDCC.ProductionIsLife
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 0 AND
			PDCC.PrinterBrandID IS NULL AND
			PDCC.ModelID IS NULL AND
			PDCC.PrinterDeviceID IS NULL 

	--Agora atualiza os comportamentos por Fabricante
	UPDATE
		@PrintersAndBehaviors
	SET
		LifeAdjustType = PDCC.AdjustType,
		LifeComplementType = PDCC.ComplementType
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 1 AND
			PDCC.PrinterBrandID = BrandID AND
			PDCC.ModelID IS NULL AND
			PDCC.PrinterDeviceID IS NULL 

	UPDATE
		@PrintersAndBehaviors
	SET
		ProductionAdjustType = PDCC.AdjustType,
		ProductionComplementType = PDCC.ComplementType,
		ProductionIsLife = PDCC.ProductionIsLife
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 0 AND
			PDCC.PrinterBrandID = BrandID AND
			PDCC.ModelID IS NULL AND
			PDCC.PrinterDeviceID IS NULL 

	--Agora atualiza os comportamentos por Modelo
	UPDATE
		@PrintersAndBehaviors
	SET
		LifeAdjustType = PDCC.AdjustType,
		LifeComplementType = PDCC.ComplementType
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 1 AND
			PDCC.PrinterBrandID IS NULL AND
			PDCC.ModelID = PrinterModelID AND
			PDCC.PrinterDeviceID IS NULL 

	UPDATE
		@PrintersAndBehaviors
	SET
		ProductionAdjustType = PDCC.AdjustType,
		ProductionComplementType = PDCC.ComplementType,
		ProductionIsLife = PDCC.ProductionIsLife
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 0 AND
			PDCC.PrinterBrandID IS NULL AND
			PDCC.ModelID  = PrinterModelID AND
			PDCC.PrinterDeviceID IS NULL 

	--Agora atualiza os comportamentos por Impressora
	UPDATE
		@PrintersAndBehaviors
	SET
		LifeAdjustType = PDCC.AdjustType,
		LifeComplementType = PDCC.ComplementType
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 1 AND
			PDCC.PrinterBrandID IS NULL AND
			PDCC.ModelID IS NULL AND
			PDCC.PrinterDeviceID = PDID

	UPDATE
		@PrintersAndBehaviors
	SET
		ProductionAdjustType = PDCC.AdjustType,
		ProductionComplementType = PDCC.ComplementType,
		ProductionIsLife = PDCC.ProductionIsLife
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 0 AND
			PDCC.PrinterBrandID IS NULL AND
			PDCC.ModelID IS NULL AND
			PDCC.PrinterDeviceID = PDID

	INSERT INTO
		@OutputPrintersAndBehaviors
		SELECT 
			PDID AS PrinterDeviceID,					
			LifeAdjustType,
			LifeComplementType,
			ProductionAdjustType,
			ProductionComplementType,
			ProductionIsLife
		FROM 
			@PrintersAndBehaviors

	RETURN 

END
```

---

## 71. getPrintersAndCountersBehaviorsRetrocompToReference

```sql
CREATE FUNCTION [dbo].[getPrintersAndCountersBehaviorsRetrocompToReference]
(
	 @PrintersDevicesIDs IntTable READONLY
)
RETURNS @OutputPrintersAndBehaviors TABLE
	(
		PrinterDeviceID	INT,					
		LifeAdjustType TINYINT,				--Ajuste do contador de vida
		LifeComplementType TINYINT,			--Complemento do contador de vida
		ProductionAdjustType TINYINT,		--Ajuste do contador de produção
		ProductionComplementType TINYINT,	--Complemento do contador de produção
		ProductionIsLife BIT				--Indica se o contador de produção usa o de vida (1) ou a soma dos de impressão (0)
	)
BEGIN

	--***********************************************************************************************************
	-- Robson Wiggers, 26/12/2016
	-- *trazer os dados retrocompatívelmente para o contador de referencia
	--***********************************************************************************************************

	DECLARE @PrintersAndBehaviors TABLE
	(
		PDID INT,					
		PrinterModelID INT,		
		BrandID INT,
		LifeAdjustType TINYINT,				--Ajuste do contador de vida
		LifeComplementType TINYINT,			--Complemento do contador de vida
		ProductionAdjustType TINYINT,		--Ajuste do contador de produção
		ProductionComplementType TINYINT,	--Complemento do contador de produção
		ProductionIsLife BIT
	)

	--Primeiro pega AS impressoras que precisa
	INSERT INTO 
		@PrintersAndBehaviors
		SELECT 
			PD.PrinterDeviceID AS PDID,
			PD.PrinterModelID,
			B.BrandID,
			NULL AS LifeAdjustType, 
			NULL AS LifeComplementType,
			NULL AS ProductionAdjustType,
			NULL AS ProductionComplementType,
			NULL AS ProductionIsLife
		FROM
			@PrintersDevicesIDs PDIDS
			INNER JOIN PrintersDevices PD ON PDIDS.IntID = PD.PrinterDeviceID
			INNER JOIN PrintersModels PM ON PD.PrinterModelID = PM.PrinterModelID
			INNER JOIN Brands B ON PM.BrandID = B.BrandID	
		
	
	--Atualiza os comportamentos. Primeiro os comportamentos padrão para todos.
	UPDATE
		@PrintersAndBehaviors
	SET
		LifeAdjustType = PDCC.AdjustType,
		LifeComplementType = PDCC.ComplementType
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 1 AND
			PDCC.PrinterBrandID IS NULL AND
			PDCC.ModelID IS NULL AND
			PDCC.PrinterDeviceID IS NULL 

	UPDATE
		@PrintersAndBehaviors
	SET
		ProductionAdjustType = PDCC.AdjustType,
		ProductionComplementType = PDCC.ComplementType,
		ProductionIsLife = PDCC.ProductionIsLife
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 0 AND
			PDCC.PrinterBrandID IS NULL AND
			PDCC.ModelID IS NULL AND
			PDCC.PrinterDeviceID IS NULL 

	--Agora atualiza os comportamentos por Fabricante
	UPDATE
		@PrintersAndBehaviors
	SET
		LifeAdjustType = PDCC.AdjustType,
		LifeComplementType = PDCC.ComplementType
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 1 AND
			PDCC.PrinterBrandID = BrandID AND
			PDCC.ModelID IS NULL AND
			PDCC.PrinterDeviceID IS NULL 

	UPDATE
		@PrintersAndBehaviors
	SET
		ProductionAdjustType = PDCC.AdjustType,
		ProductionComplementType = PDCC.ComplementType,
		ProductionIsLife = PDCC.ProductionIsLife
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 0 AND
			PDCC.PrinterBrandID = BrandID AND
			PDCC.ModelID IS NULL AND
			PDCC.PrinterDeviceID IS NULL 

	--Agora atualiza os comportamentos por Modelo
	UPDATE
		@PrintersAndBehaviors
	SET
		LifeAdjustType = PDCC.AdjustType,
		LifeComplementType = PDCC.ComplementType
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 1 AND
			PDCC.PrinterBrandID IS NULL AND
			PDCC.ModelID = PrinterModelID AND
			PDCC.PrinterDeviceID IS NULL 

	UPDATE
		@PrintersAndBehaviors
	SET
		ProductionAdjustType = PDCC.AdjustType,
		ProductionComplementType = PDCC.ComplementType,
		ProductionIsLife = PDCC.ProductionIsLife
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 0 AND
			PDCC.PrinterBrandID IS NULL AND
			PDCC.ModelID  = PrinterModelID AND
			PDCC.PrinterDeviceID IS NULL 

	--Agora atualiza os comportamentos por Impressora
	UPDATE
		@PrintersAndBehaviors
	SET
		LifeAdjustType = PDCC.AdjustType,
		LifeComplementType = PDCC.ComplementType
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 1 AND
			PDCC.PrinterBrandID IS NULL AND
			PDCC.ModelID IS NULL AND
			PDCC.PrinterDeviceID = PDID

	UPDATE
		@PrintersAndBehaviors
	SET
		ProductionAdjustType = PDCC.AdjustType,
		ProductionComplementType = PDCC.ComplementType,
		ProductionIsLife = PDCC.ProductionIsLife
		FROM 
			PrintersDevicesCountersConfig PDCC
		WHERE
			PDCC.IsLifeCounter = 0 AND
			PDCC.PrinterBrandID IS NULL AND
			PDCC.ModelID IS NULL AND
			PDCC.PrinterDeviceID = PDID

	INSERT INTO
		@OutputPrintersAndBehaviors
		SELECT 
			PDID AS PrinterDeviceID,					
			LifeAdjustType,
			LifeComplementType,
			ProductionAdjustType,
			ProductionComplementType,
			ProductionIsLife
		FROM 
			@PrintersAndBehaviors

	RETURN 

END
```

---

## 72. getPrintersCountersDataRetrocomp

```sql
CREATE FUNCTION [dbo].[getPrintersCountersDataRetrocomp]
(
	@StartDateTime DATE,
	@EndDateTime DATE,
	@PrinterDeviceID INT = NULL,
	@SiteID INT = NULL,
	@SiteDivisionID INT = NULL,
	@Engaged BIT = NULL,    
	@MaxLimitDaysEarlier INT = 30,
	@GetLatestCounterNumbers BIT = 0,  --Informa se precisa buscar o valor do último contador no período. Se não precisar economiza performance.
	@GetJustProductionCounters BIT = 1, --Informa se precisa carregar todos os contadores ou apenas os contadores de produção (mais usado).       
	@OnlyPrintersWithCounters BIT = 1  --Informa se precisa mostrar todas AS impressoras, mesmo que não tenham dados
)
RETURNS @OutputCounters TABLE
(
	PrinterDeviceID INT, 
	CounterTypeID INT,
	AdjustType TINYINT,          -- [0]: Sem ajuste
								 -- [1]: M=T-C; 
								 -- [2]: T=M+C (ou M=T quando M+C=0)
	ComplementType TINYINT,		 -- [0]:Sem complemento; 
								 -- [1]: produção p/ mono e color quando não tem 
								 -- [2]: produção p/ mono e color sempre
								 -- [3]: produção p/ color quando não tem 
								 -- [4]: produção p/ color sempre
								 -- Usado no contador de vida; ou no de produção quando ProductionIsLife=1
	ProductionIsLife BIT,		-- [0]: Usar soma dos contadores de impressão
								 -- [1]: Usar o contador de vida
								 -- Usado apenas para o contador de produção
	FirstDateTimeRead DATETIME, 
	LastDateTimeRead DATETIME, 
	CounterTotalDif BIGINT, 
	CounterBlackDif BIGINT,
	CounterColorDif BIGINT,
	CounterTotalLatestNumber BIGINT, 
	CounterBlackLatestNumber BIGINT, 
	CounterColorLatestNumber BIGINT
)
BEGIN



      --***********************************************************************************************************
      -- BY Robson Wiggers, 03/05/2016
      --- Alterada para trazer os dados retrocompativelmente
      --***********************************************************************************************************


	--################################################################################################################
	-- Aqui pega AS impressoras que precisa e os seus comportamentos
	--################################################################################################################
	DECLARE @PrintersAndBehaviors TABLE --Esta tabela contém todas AS impressoras que se encaixam na pesquisa e os seus comportamentos
	(
		PrinterDeviceID   INT,              
		LifeAdjustType TINYINT,                  --Ajuste do contador de vida
		LifeComplementType TINYINT,              --Complemento do contador de vida
		ProductionAdjustType TINYINT,      --Ajuste do contador de produção
		ProductionComplementType TINYINT,  --Complemento do contador de produção
		ProductionIsLife BIT                     --Indica se o contador de produção usa o de vida (1) ou a soma dos de impressão (0)
	)

	INSERT INTO 
		@PrintersAndBehaviors
		SELECT 
			*
		FROM
			[dbo].[getPrintersAndCountersBehaviorsRetrocomp](@PrinterDeviceID, @SiteID, @SiteDivisionID, @Engaged)

	--################################################################################################################
	-- Primeira etapa: buscar os contadores de produção.
	-- Supostamente sempre é usado no mínimo os contadores de produção, portanto esse é meio
	-- fixo no retorno dessa função ter o de produção sempre
	--################################################################################################################      

	--Passa o nro de dias para negativo
	SET @MaxLimitDaysEarlier = @MaxLimitDaysEarlier * -1 

	--Se é pra usar mostrar só AS impressoras de contrato, são exibidas todas AS impressoras, mesmo que não possuam dados.
	IF (@Engaged = 1)
	BEGIN
		SET @OnlyPrintersWithCounters = 0
	END

	--primeiro descobre qual é o ID do contador de produção nessa empresa para colocar no retorno
	DECLARE @ProductionCounterTypeID SMALLINT
	SELECT @ProductionCounterTypeID = CounterTypeID FROM CounterTypes WHERE CounterTypeName = 'Production'

	--Crio AS tabelas temporárias com os contadores.
	--Estou jogando aqui porque pode ser que eu precise desses contadores depois e não quero carregá-los novamente.
	DECLARE @CountersBase TABLE 
	(
		CB_PrinterDeviceID INT,
		CB_CounterTypeID INT,
		CB_FirstDateTimeRead DATETIME, 
		CB_LastDateTimeRead DATETIME, 
		CB_CounterTotalDif BIGINT, 
		CB_CounterBlackDif BIGINT,
		CB_CounterColorDif BIGINT,
		CB_CounterTotalLatestNumber BIGINT, 
		CB_CounterBlackLatestNumber BIGINT, 
		CB_CounterColorLatestNumber BIGINT,
		CB_DateBeforeFirst DATETIME -- Usado quando não da para pegar dados dos cubos (campo interno apenas)
	)

	DECLARE @CountersBaseOutput TABLE --Vou pegar os dados para retorno daqui. Essa é uma tabela mais 'limpa', com somente os dados que precisa para o retorno
	(
		CBO_PrinterDeviceID INT,
		CBO_CounterTypeID INT,
		CBO_AdjustType TINYINT,
		CBO_ComplementType TINYINT,
		CBO_ProductionIsLife BIT,
		CBO_FirstDateTimeRead DATETIME, 
		CBO_LastDateTimeRead DATETIME, 
		CBO_CounterTotalDif BIGINT, 
		CBO_CounterBlackDif BIGINT,
		CBO_CounterColorDif BIGINT,
		CBO_CounterTotalLatestNumber BIGINT, 
		CBO_CounterBlackLatestNumber BIGINT, 
		CBO_CounterColorLatestNumber BIGINT
	)


      --Primeiro vou pegar os contadores de impressão, mas só para AS impressoras que o de produção está configurado para ser a soma dos de produção.
      -- Na verdade vou aproveitar para pegar também das impressoras que usam o de vida como produção, mas precisam de complemento (que é pego desses contadores de impressão).

	INSERT INTO 
		@CountersBase
		SELECT PrinterDeviceID,CounterTypeID, MIN(FirstDateTimeRead), MAX(LastDateTimeRead), SUM(CNDif), SUM(CBNDif), SUM(CCNDif),0,0,0, NULL FROM
		(
			SELECT 
				 CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN MIN(StartDate) ELSE MIN(BeforeDate) END AS FirstDateTimeRead,
				 MAX(EndDate) AS LastDateTimeRead,
				 CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN SUM(TodayTotal) ELSE SUM(FullTotal) END AS CNDif,
				  CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN SUM(TodayBlack) ELSE SUM(FullBlack) END AS CBNDif,     
				 CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN SUM(TodayColor) ELSE SUM(FullColor) END AS CCNDif,                             
				 PrinterDeviceID,
				 CounterTypeID
			FROM 
				 CubeCounterRetrocomp
			WHERE 
				 (CubeDate BETWEEN @StartDateTime AND @EndDateTime) AND
				 (PrinterDeviceID IN (SELECT PrinterDeviceID FROM @PrintersAndBehaviors WHERE ProductionIsLife = 0) OR --AS impressoras cuja config para contador de produção está para usar a soma dos de impressão
				 PrinterDeviceID IN (SELECT PrinterDeviceID FROM @PrintersAndBehaviors WHERE ProductionIsLife = 1 AND ProductionComplementType <> 0)) AND 
				 -- AS impressoras cuja config para contador de produção está para usar o contador de vida e que quer complementar com os de produção
				 CounterTypeID IN (SELECT CounterTypeID FROM CounterTypes WHERE CounterGroupID = 2) --SOMENTE OS CONTADORES DO GRUPO 'TYPE'
			GROUP BY PrinterDeviceID, CounterTypeID, BeforeDate
		) AS TABLE1
		GROUP BY PrinterDeviceID, CounterTypeID
     

      --AJUSTE:
      -- Pode ser que tenha impressoras que estao configuradas para usar a soma dos de impressão, mas que não possuem nenhum contador de impressão.
      -- Não podemos deixar essa impressora sem valores. Se ela tivesse os de impressão mas estivessem zerados tudo bem, mas nesse caso não tem nem os registros.
      -- O que podemos fazer é alterar o comportamento dela para que o contador de produção, para os relatórios, utilize exatamente a mesma configuração
      -- que está para o contador de vida. Ou seja, nas propriedades da impressora vai dizer que está usando a soma, mas no relatório vai mostrar que está 
      -- usando o de vida.
      -- Tenho que fazer esse ajuste exatamente aqui porque aqui ja sei AS impressoras que estao configuradas para somar mas não tem dados, e 
      -- logo abaixo vou pegar os de vida entao rpeciso informar isso agora.
      
      UPDATE
            @PrintersAndBehaviors
      SET 
            ProductionIsLife = 1, --forçando a produção ser o de vida
            ProductionAdjustType = LifeAdjustType, --forçando o ajuste de produção ser igual ao de vida
            ProductionComplementType = LifeComplementType -- forçando o complemento a ser o mesmo do de vida
      WHERE
            ProductionIsLife = 0 AND -- a impressora esta configurada para usar o de produção...
            PrinterDeviceID NOT IN 
            (     
                  SELECT DISTINCT CB_PrinterDeviceID FROM @CountersBase
            )-- ... mas nao tem nenhum contador de produção

      --agora pego os contadores de vida, mas só para AS impressoras que o de produção está configurado para ser o de vida (o que pode ter sido forçado no passo anterior).      
	  INSERT INTO 
          @CountersBase
          SELECT PrinterDeviceID,1, MIN(FirstDateTimeRead), MAX(LastDateTimeRead), SUM(CNDif), SUM(CBNDif), SUM(CCNDif),0,0,0, NULL FROM
          (
                SELECT 
                     CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN MIN(StartDate) ELSE MIN(BeforeDate) END AS FirstDateTimeRead,
                     MAX(EndDate) AS LastDateTimeRead,
                     CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN SUM(TodayTotal) ELSE SUM(FullTotal) END AS CNDif,
                     CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN SUM(TodayBlack) ELSE SUM(FullBlack) END AS CBNDif,     
                     CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN SUM(TodayColor) ELSE SUM(FullColor) END AS CCNDif,                             
                     PrinterDeviceID
                FROM 
                     CubeCounterRetrocomp 
                WHERE 
                     (CubeDate BETWEEN @StartDateTime AND @EndDateTime) AND
                     CounterTypeID = 1 AND
                     PrinterDeviceID IN (SELECT PrinterDeviceID FROM @PrintersAndBehaviors WHERE ProductionIsLife = 1) --Só AS impressoras cuja config para contador de produção está para usar o contador de vida
                GROUP BY PrinterDeviceID,BeforeDate
          ) AS TABLE1
          GROUP BY PrinterDeviceID


	--Agora já tenho os contadores que preciso (por enquanto). Pegar os últimos contadores de cada tipo (se for preciso). 
	IF (@GetLatestCounterNumbers = 1)
	BEGIN
            
		UPDATE @CountersBase
			SET 
				CB_CounterTotalLatestNumber = CF.CounterTotal ,
				CB_CounterBlackLatestNumber = CF.CounterMono,
				CB_CounterColorLatestNumber = CF.CounterColor
			FROM 
				Counters CF
				INNER JOIN CountersReadings CR ON CF.CounterReadingID = CR.CounterReadingID 
			WHERE 
				CR.DateTimeRead = CB_LastDateTimeRead AND 
				CR.PrinterDeviceID = CB_PrinterDeviceID AND 
				CF.CounterTypeID = CB_CounterTypeID
				
	END

      --Criar os dados do contador de produção na tabela que será usada para retorno
      --Primeiro cria o de produção baseado na soma dos de impressão (já que os contadores de impressão que estão na memória estão ali só pra isso)
      INSERT INTO 
            @CountersBaseOutput
            SELECT
                  CB_PrinterDeviceID,
                  @ProductionCounterTypeID,
                  NULL, --Ajuste. Esse será atualizado mais abaixo
                  NULL, --Complemento. Esse aqui vai ficar NULL mesmo, pois quando usa a soma de contadores nao tem complemento
                  0, -- ProductionIsLife. Fixo porque aqui são os que somam os de impressão
                  MIN(CB_FirstDateTimeRead), 
                  MAX(CB_LastDateTimeRead),
                  SUM(CB_CounterTotalDif), 
                  SUM(CB_CounterBlackDif),
                  SUM(CB_CounterColorDif),
                  SUM(CB_CounterTotalLatestNumber), 
                  SUM(CB_CounterBlackLatestNumber), 
                  SUM(CB_CounterColorLatestNumber)
            FROM
                  @CountersBase
            WHERE
                  CB_CounterTypeID <> 1 AND --Contadores de impressão (só tem o de vida ou os de impressão nesse momento)
                  CB_PrinterDeviceID IN (SELECT PrinterDeviceID FROM @PrintersAndBehaviors WHERE ProductionIsLife = 0) 
				  --Só os que querem a soma (porque na tabela pode ter contadores de impressão dos que querem o de vida também que serão usados para complemento)
            GROUP BY CB_PrinterDeviceID

      
      --Agora cria o que usa o contador de vida como base
      INSERT INTO 
            @CountersBaseOutput
            SELECT
                  CB_PrinterDeviceID,
                  @ProductionCounterTypeID,
                  NULL, --Ajuste. Esse será atualizado mais abaixo
                  NULL, --Complemento. Esse será atualizado mais abaixo
                  1, --ProductionIsLife. Fixo pq aqui são os de vida mesmo
                  CB_FirstDateTimeRead, 
                  CB_LastDateTimeRead, 
                  CB_CounterTotalDif, 
                  CB_CounterBlackDif,
                  CB_CounterColorDif,
                  CB_CounterTotalLatestNumber,  
                  CB_CounterBlackLatestNumber, 
                  CB_CounterColorLatestNumber
            FROM
                  @CountersBase
            WHERE
                  CB_CounterTypeID = 1 --Contador de vida (os contadores de vida que estao na tabela são só para AS impressoras que usam o de vida para produção)
      
      --Atualiza o tipo de ajuste e o tipo de complemento para os contadores de produção (que são os unicos que estao na tabela por enquanto)
      UPDATE
            @CountersBaseOutput
      SET
            CBO_AdjustType = ProductionAdjustType,
            CBO_ComplementType = ProductionComplementType
      FROM 
            @PrintersAndBehaviors 
      WHERE
            CBO_PrinterDeviceID = PrinterDeviceID
      
      
      --Nesse momento tenho na tabela temporária os contadores de produção (crus) e os que deram origem a eles na outra tabela, que pode ser que eu ainda use-os.
      --Poderia já fazer os complementos e ajustes aqui, mas como talvez seja preciso buscar os contadores de vida, e os cálculos são os mesmos,
      --passei AS queries que complementam e ajustam pra depois do IF a seguir.

      --################################################################################################################
      -- Segunda etapa: carregar os demais contadores.
      -- Na maioria dos casos ou é necessário apenas o de produção, ou todos. Portanto agora vou pegar os contadores
      -- de vida que faltam e os de impressão que faltam e todos os outros.
      --################################################################################################################      

      IF (@GetJustProductionCounters = 0)
      BEGIN
      
            -- Carregar os contadores de vida (crus) para a tabela temporária.
            -- Porém já há alguns contadores de vida na tabela, então tem que pegar só os que não estão carregados ainda.

          INSERT INTO 
                @CountersBase
                SELECT PrinterDeviceID, 1, MIN(FirstDateTimeRead), MAX(LastDateTimeRead), SUM(CNDif), SUM(CBNDif), SUM(CCNDif),0,0,0, NULL FROM
                (
					SELECT 
						CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN MIN(StartDate) ELSE MIN(BeforeDate) END AS FirstDateTimeRead,
						MAX(EndDate) AS LastDateTimeRead,
						CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN SUM(TodayTotal) ELSE SUM(FullTotal) END AS CNDif,
							CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN SUM(TodayBlack) ELSE SUM(FullBlack) END AS CBNDif,     
						CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN SUM(TodayColor) ELSE SUM(FullColor) END AS CCNDif,                             
						PrinterDeviceID
					FROM 
						CubeCounterRetrocomp
					WHERE 
						(CubeDate BETWEEN @StartDateTime AND @EndDateTime) AND
						CounterTypeID = 1 AND
						(PrinterDeviceID IN (SELECT PrinterDeviceID FROM @PrintersAndBehaviors WHERE --Todas AS impressoras da consulta
								PrinterDeviceID NOT IN (SELECT CB_PrinterDeviceID FROM @CountersBase WHERE CB_CounterTypeID = 1)))  -- menos AS que já foram carregadas antes
					GROUP BY PrinterDeviceID, BeforeDate
                ) AS TABLE1
                GROUP BY PrinterDeviceID
          
            
            --Agora vou pegar os contadores de impressão. Inicialmente pegaria só das impressoras que estão configuradas para complementar o de vida, menos AS que já foram carregadas os de impressão, 
            --mas como esses contadores serão usados também para o retorno da função, carrego tudo de uma vez (menos os que já foram carregados).
              INSERT INTO 
                    @CountersBase
                    SELECT PrinterDeviceID, CounterTypeID, MIN(FirstDateTimeRead), MAX(LastDateTimeRead), SUM(CNDif), SUM(CBNDif), SUM(CCNDif),0,0,0, NULL FROM
                    (
                         SELECT 
                               CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN MIN(StartDate) ELSE MIN(BeforeDate) END AS FirstDateTimeRead,
                               MAX(EndDate) AS LastDateTimeRead,
                               CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN SUM(TodayTotal) ELSE SUM(FullTotal) END AS CNDif,
                               CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN SUM(TodayBlack) ELSE SUM(FullBlack) END AS CBNDif,     
                               CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN SUM(TodayColor) ELSE SUM(FullColor) END AS CCNDif,                             
                               PrinterDeviceID,
                               CounterTypeID
                         FROM 
                               CubeCounterRetrocomp
                         WHERE 
                               (CubeDate BETWEEN @StartDateTime AND @EndDateTime) AND
                                (PrinterDeviceID IN (SELECT PrinterDeviceID FROM @PrintersAndBehaviors WHERE 
                                     PrinterDeviceID NOT IN (SELECT DISTINCT CB_PrinterDeviceID FROM @CountersBase WHERE CB_CounterTypeID <> 1))) AND--Não precisa carregar os contadores de impressão das impressoras 
									 --cujo esses contadores já foram carregados. Pode perder tempo aqui com impressoras que realmente nao tem os contadores de produção :(
                               CounterTypeID <> 1 --só estao os de producao no cubo -----IN (SELECT CounterTypeID FROM CounterTypes WHERE CounterGroupID = 2) --SOMENTE OS CONTADORES DO GRUPO 'TYPE'
                         GROUP BY PrinterDeviceID, CounterTypeID, BeforeDate
                    ) AS TABLE1
                    GROUP BY PrinterDeviceID, CounterTypeID
           

		   --Agora vou pegar todos os demais contadores, menos os de impressão e os de vida que já foram carregados
            INSERT INTO 
                @CountersBase
                SELECT PrinterDeviceID, CounterTypeID, MIN(FirstDateTimeRead), MAX(LastDateTimeRead), SUM(CNDif), SUM(CBNDif), SUM(CCNDif),0,0,0, NULL FROM
                (
                        SELECT 
							CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN MIN(StartDate) ELSE MIN(BeforeDate) END AS FirstDateTimeRead,
                            MAX(EndDate) AS LastDateTimeRead,
                            CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN SUM(TodayTotal) ELSE SUM(FullTotal) END AS CNDif,
                            CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN SUM(TodayBlack) ELSE SUM(FullBlack) END AS CBNDif,     
                            CASE WHEN BeforeDate < DATEADD(D,@MaxLimitDaysEarlier, @StartDateTime) THEN SUM(TodayColor) ELSE SUM(FullColor) END AS CCNDif,                             
                            PrinterDeviceID,
                            CounterTypeID
                        FROM 
                            CubeCounterRetrocomp
                        WHERE 
                            (CubeDate BETWEEN @StartDateTime AND @EndDateTime) AND
                            (PrinterDeviceID IN (SELECT PrinterDeviceID FROM @PrintersAndBehaviors)) AND
                            CounterTypeID NOT IN (SELECT CounterTypeID FROM CounterTypes WHERE CounterGroupID = 2 UNION SELECT 1) --Tira fora o de vida e os de impressão
                        GROUP BY PrinterDeviceID, CounterTypeID, BeforeDate
                ) AS TABLE1
                GROUP BY PrinterDeviceID, CounterTypeID   

            
            --Pegar os últimos contadores de cada tipo (se for preciso). 
            IF (@GetLatestCounterNumbers = 1)
            BEGIN
            
                  UPDATE @CountersBase
                        SET 
                             CB_CounterTotalLatestNumber = CF.CounterTotal,
                             CB_CounterBlackLatestNumber = CF.CounterMono,
							 CB_CounterColorLatestNumber = CF.CounterColor
                        FROM 
                             Counters CF 
                             INNER JOIN CountersReadings CR ON CF.CounterReadingID = CR.CounterReadingID
                        WHERE 
                             CR.DateTimeRead = CB_LastDateTimeRead AND 
                             CR.PrinterDeviceID = CB_PrinterDeviceID AND 
                             CF.CounterTypeID = CB_CounterTypeID AND 
                             CB_CounterTotalLatestNumber = 0 --só os que não tem ainda, tem uns que já foram preenchidos lá em cima
            END   
            
            --Agora vou inserir na tabela auxiliar de retorno TODOS os contadores, tanto de vida quanto os demais
            INSERT INTO 
                  @CountersBaseOutput
                  SELECT
                        CB_PrinterDeviceID,
                        CB_CounterTypeID, 
                        NULL, --Ajuste. Esse será atualizado mais abaixo (mas só o de vida)
                        NULL, --Complemento. Esse será atualizado mais abaixo (mas só o de vida)
                        NULL, --ProductionIsLife. Esse é fixo NULL porque não tem esse valor para os contadores de vida, e nem para os outros
                        CB_FirstDateTimeRead, 
                        CB_LastDateTimeRead, 
                        CB_CounterTotalDif, 
                        CB_CounterBlackDif,
                        CB_CounterColorDif,
                        CB_CounterTotalLatestNumber,  
                        CB_CounterBlackLatestNumber, 
                        CB_CounterColorLatestNumber
                  FROM
                        @CountersBase
      
            --Atualiza o tipo de ajuste e o tipo de complemento para os contadores de vida
            UPDATE
                  @CountersBaseOutput
            SET
                  CBO_AdjustType = LifeAdjustType,
                  CBO_ComplementType = LifeComplementType
            FROM 
                  @PrintersAndBehaviors 
            WHERE
                  CBO_PrinterDeviceID = PrinterDeviceID AND
                  CBO_CounterTypeID = 1 -- Porque nessa tabela já tem os de produção que já estão atualizados (e porque estou pegando os campos dos de vida).
      
      END


      --ROBSON, 04-06-2012, UPDATE 4.12 -- Se quer todos (ou seja, os de vida tmb) e os últimos contadores, aplica complemento nas 
      -- ultimas leituras do de vida também.
      --IF (@GetLatestCounterNumbers = 1 AND @GetJustProductionCounters = 0)
      --ROBSON, 14-06-2012, UPDATE 4.12 -- Se é pra pegar os ultimos contadores, aplica o complemento no último contador também (no caso
      -- no de vida ou no de produção que é de vida). Tem que aplicar porque se vai ser complementado a diferença, o último contador tem que 
      -- refletir a mesma coisa. Não precisa no de produção que é a soma porque nao tem complemento dai.
      IF (@GetLatestCounterNumbers = 1)
      BEGIN

            UPDATE 
                  @CountersBaseOutput
            SET 
                  CBO_CounterColorLatestNumber = CB_CounterColorLatestNumber
            FROM 
                  (SELECT CB_PrinterDeviceID, SUM(CB_CounterColorLatestNumber) AS CB_CounterColorLatestNumber FROM @CountersBase 
                   WHERE CB_CounterTypeID IN (SELECT CounterTypeID FROM CounterTypes WHERE CounterGroupID = 2) GROUP BY CB_PrinterDeviceID) AS T
            WHERE 
                  CBO_PrinterDeviceID = CB_PrinterDeviceID AND 
                  ((CBO_CounterTypeID = 1) OR (CBO_CounterTypeID = @ProductionCounterTypeID AND CBO_ProductionIsLife = 1) )AND 
                  (
                        (CBO_ComplementType = 1 AND CBO_CounterColorDif = 0 AND CBO_CounterBlackDif = 0) OR        -- Complemento 1 atualiza mono e cor se ambos forem 0 (aqui ta atualizando só cor)
                        (CBO_ComplementType = 2) OR                                                             -- Complemento 2 atualiza mono e cor sempre (aqui ta atualizando só cor)
                        (CBO_ComplementType = 3 AND CBO_CounterColorDif = 0) OR                                                   -- Complemento 3 atualiza cor se cor for 0
                        (CBO_ComplementType = 4)                                                                                              -- Complemento 4 atualiza cor sempre
                  )
      
      END
      

      -- Agora estão na tabela os contadores crus de produção e talvez os contadores crus de vida. Aplicar os complementos para quem quer:
      --- Aplica o complemento para o contador de produção que está configurado para usar o de vida (porque o que está para usar a soma não tem complemento)
      --- Aplica o complemento para o contador de vida.
      -- que seria o CBO_ComplementType = NULL (usa a soma já, no caso do de produção) ou CBO_ComplementType = 0 (sem complemento)
      UPDATE 
            @CountersBaseOutput
      SET 
            CBO_CounterColorDif = CB_CounterColorDif
      FROM 
            (SELECT CB_PrinterDeviceID, SUM(CB_CounterColorDif) AS CB_CounterColorDif FROM @CountersBase 
             WHERE CB_CounterTypeID IN (SELECT CounterTypeID FROM CounterTypes WHERE CounterGroupID = 2) GROUP BY CB_PrinterDeviceID) AS T
      WHERE 
            CBO_PrinterDeviceID = CB_PrinterDeviceID AND 
            (
                  (CBO_ComplementType = 1 AND CBO_CounterColorDif = 0 AND CBO_CounterBlackDif = 0) OR           -- Complemento 1 atualiza mono e cor se ambos forem 0 (aqui ta atualizando só cor)
                  (CBO_ComplementType = 2) OR                                                                                           -- Complemento 2 atualiza mono e cor sempre (aqui ta atualizando só cor)
                  (CBO_ComplementType = 3 AND CBO_CounterColorDif = 0) OR                                                   -- Complemento 3 atualiza cor se cor for 0
                  (CBO_ComplementType = 4)                           -- Complemento 4 atualiza cor sempre
            )     
      


      --ROBSON, 04-06-2012, UPDATE 4.12 -- Se quer todos (ou seja, os de vida tmb) e os últimos contadores, aplica complemento nas 
      -- ultimas leituras do de vida também.
      --IF (@GetLatestCounterNumbers = 1 AND @GetJustProductionCounters = 0)
      --ROBSON, 14-06-2012, UPDATE 4.12 -- Se é pra pegar os ultimos contadores, aplica o complemento no último contador também (no caso
      -- no de vida ou no de produção que é de vida). Tem que aplicar porque se vai ser complementado a diferença, o último contador tem que 
      -- refletir a mesma coisa. Não precisa no de produção que é a soma porque nao tem complemento dai.
      IF (@GetLatestCounterNumbers = 1)
      BEGIN

            UPDATE 
                  @CountersBaseOutput
            SET 
                  CBO_CounterBlackLatestNumber = CB_CounterBlackLatestNumber
            FROM 
                  (SELECT CB_PrinterDeviceID, SUM(CB_CounterBlackLatestNumber) AS CB_CounterBlackLatestNumber FROM @CountersBase 
                   WHERE CB_CounterTypeID IN (SELECT CounterTypeID FROM CounterTypes WHERE CounterGroupID = 2) GROUP BY CB_PrinterDeviceID) AS T
            WHERE 
                  CBO_PrinterDeviceID = CB_PrinterDeviceID AND 
                  ((CBO_CounterTypeID = 1) OR (CBO_CounterTypeID = @ProductionCounterTypeID AND CBO_ProductionIsLife = 1) )AND 
                  (
                        (CBO_ComplementType = 1 AND /*CBO_CounterColorDif = 0 AND*/ CBO_CounterBlackDif = 0) OR        -- Complemento 1 atualiza mono e cor se ambos forem 0 (aqui ta atualizando só mono)
                        (CBO_ComplementType = 2)                             -- Complemento 2 atualiza mono e cor sempre (aqui ta atualizando só mono)
                  )
      
      END         
                  
            
      --Alterado para não precisar validar novamente se o Contador color é igual 0, se ele está zerado OK e se foi modificado, foi pelo updade acima.
      --Héber Savedra, 2012-03-22
      UPDATE 
            @CountersBaseOutput
      SET 
            CBO_CounterBlackDif = CB_CounterBlackDif
      FROM 
            (SELECT CB_PrinterDeviceID, SUM(CB_CounterBlackDif) AS CB_CounterBlackDif FROM @CountersBase 
             WHERE CB_CounterTypeID IN (SELECT CounterTypeID FROM CounterTypes WHERE CounterGroupID = 2) GROUP BY CB_PrinterDeviceID) AS T
      WHERE 
            CBO_PrinterDeviceID = CB_PrinterDeviceID AND 
            (
                  (CBO_ComplementType = 1 AND /*CBO_CounterColorDif = 0 AND*/ CBO_CounterBlackDif = 0) OR        -- Complemento 1 atualiza mono e cor se ambos forem 0 (aqui ta atualizando só mono)
                  (CBO_ComplementType = 2)                                                                                              -- Complemento 2 atualiza mono e cor sempre (aqui ta atualizando só mono)
            )
      
      -----------------------------------------------------------------------------------------
      --Agora aqui começo a tratar do ajuste dos contadores (de produção e de vida - se tiver).     
      --Ajuste 1: MONO = TOTAL - COLOR
      UPDATE 
            @CountersBaseOutput
      SET 
            CBO_CounterBlackDif = CBO_CounterTotalDif - CBO_CounterColorDif
      WHERE 
            CBO_AdjustType = 1

      --ROBSON, 14-06-2012, UPDATE 4.12 -- Se é pra pegar os últimos contadores, aplica o ajuste no último contador também. Não importa de onde 
      --veio esse dado (vida ou soma de impressão), mas como foi ajustado a diferença, é preciso ajustar o ultimo contador.
      IF (@GetLatestCounterNumbers = 1)
      BEGIN

            UPDATE 
                  @CountersBaseOutput
            SET 
                  CBO_CounterBlackLatestNumber = CBO_CounterTotalLatestNumber - CBO_CounterColorLatestNumber
            WHERE 
                  CBO_AdjustType = 1
     
      END   
      

      --Ajuste 2: TOTAL = MONO + COLOR (MAS SÓ QUANDO ISSO GERAR UM VALOR, CASO CONTRARIO AJUSTA O MONO)
      
      --ROBSON, 14-06-2012, UPDATE 4.12 -- Se é pra pegar os últimos contadores, aplica o ajuste no último contador também. Não importa de onde 
      --veio esse dado (vida ou soma de impressão), mas como foi ajustado a diferença, é preciso ajustar o ultimo contador.
      --Tem que fazer antes do ajuste de volume pq o ajuste de volume pode alterar dados que sao usados no WHERE
      IF (@GetLatestCounterNumbers = 1)
      BEGIN

            UPDATE 
                  @CountersBaseOutput
            SET 
                  CBO_CounterTotalLatestNumber = CBO_CounterBlackLatestNumber + CBO_CounterColorLatestNumber
            WHERE 
                  CBO_AdjustType = 2 AND (CBO_CounterBlackDif + CBO_CounterColorDif <> 0)

            UPDATE 
                  @CountersBaseOutput
            SET 
                  CBO_CounterBlackLatestNumber = CBO_CounterTotalLatestNumber
            WHERE 
                  CBO_AdjustType = 2 AND (CBO_CounterBlackDif + CBO_CounterColorDif = 0) 
      
      END
      
      
      UPDATE 
            @CountersBaseOutput
      SET 
            CBO_CounterTotalDif = CBO_CounterBlackDif + CBO_CounterColorDif
      WHERE 
            CBO_AdjustType = 2 AND (CBO_CounterBlackDif + CBO_CounterColorDif <> 0)

      UPDATE 
            @CountersBaseOutput
      SET 
            CBO_CounterBlackDif = CBO_CounterTotalDif
      WHERE 
            CBO_AdjustType = 2 AND (CBO_CounterBlackDif + CBO_CounterColorDif = 0)

      --------------------------------------------------------------------------------------
      --Colocar AS impressoras que faltam, caso seja necessário, para o contador de produção
      IF (@OnlyPrintersWithCounters = 0)
      BEGIN
            INSERT INTO 
                  @CountersBaseOutput
                  SELECT                       
                        PrinterDeviceID,
                        @ProductionCounterTypeID,
                        ProductionAdjustType,
                        ProductionComplementType,
                        ProductionIsLife,
                        @StartDateTime, 
                        @EndDateTime, 
                        0, 
                        0,
                        0,
                        0, 
                        0, 
                        0
                  FROM 
                        @PrintersAndBehaviors
                  WHERE
                        PrinterDeviceID NOT IN (SELECT DISTINCT CBO_PrinterDeviceID FROM @CountersBaseOutput WHERE CBO_CounterTypeID = @ProductionCounterTypeID)
      END
      ELSE
      BEGIN
            --Bom, se não precisa de todas AS impressoras, então podemos tirar fora AS que não tem dados no período (levando em consideração o contador de produção)
            DELETE FROM 
                  @CountersBaseOutput
            WHERE 
                  CBO_PrinterDeviceID IN (SELECT CBO_PrinterDeviceID FROM @CountersBaseOutput WHERE CBO_CounterTypeID = @ProductionCounterTypeID AND CBO_CounterTotalDif =0)          
      END

      --------------------------------------------------------------------
      --inserir o retorno na tabela real
      INSERT INTO 
            @OutputCounters
            SELECT 
                  CBO_PrinterDeviceID AS PrinterDeviceID,
                  CBO_CounterTypeID AS CounterTypeID,
                  CBO_AdjustType AS AdjustType,
                  CBO_ComplementType AS ComplementType,
                  CBO_ProductionIsLife AS ProductionIsLife,
                  CBO_FirstDateTimeRead AS FirstDateTimeRead, 
                  CBO_LastDateTimeRead AS LastDateTimeRead, 
                  CBO_CounterTotalDif AS CounterTotalDif, 
                  CBO_CounterBlackDif AS CounterBlackDif,
                  CBO_CounterColorDif AS CounterColorDif,
                  CBO_CounterTotalLatestNumber AS CounterTotalLatestNumber, 
                  CBO_CounterBlackLatestNumber AS CounterBlackLatestNumber, 
                  CBO_CounterColorLatestNumber AS CounterColorLatestNumber
            FROM 
                  @CountersBaseOutput

      RETURN 

END
```

---

## 73. getTableIDs

```sql
CREATE FUNCTION [dbo].[getTableIDs] (@ObjectList NVARCHAR(max)) RETURNS 
@ParsedList TABLE (ObjectID INT PRIMARY KEY)

AS

BEGIN

	DECLARE @ObjectID NVARCHAR(10)
	DECLARE @Position INT
	DECLARE @Found INT 

	SET @ObjectList = LTRIM(RTRIM(@ObjectList))+ ','
	SET @Position = CHARINDEX(',', @ObjectList, 1)

	IF REPLACE(@ObjectList, ',', '') <> ''
	BEGIN
		WHILE @Position > 0
		BEGIN
			SET @ObjectID = LTRIM(RTRIM(LEFT(@ObjectList, @Position - 1)))
			IF @ObjectID <> ''
			BEGIN

				SELECT @Found = ObjectID FROM @ParsedList WHERE ObjectID = CAST(@ObjectID AS INT)

				IF (@Found IS NULL)
				BEGIN
					INSERT INTO @ParsedList (ObjectID) 
					VALUES (CAST(@ObjectID AS INT))
				END
			END
			
			SET @ObjectList = RIGHT(@ObjectList, LEN(@ObjectList) - @Position)
			SET @Position = CHARINDEX(',', @ObjectList, 1)
		END
	END	
	
	RETURN
	
END
```

---

## 74. getTotalPagesMobile

```sql
CREATE FUNCTION [dbo].[getTotalPagesMobile](@AccountID INT)
	 RETURNS @Table TABLE (MonthValue TINYINT, PagesMono BIGINT, PagesColor BIGINT)

AS

BEGIN

	DECLARE @DateTimeNow DATETIME
	SET @DateTimeNow = GETDATE()
	--SET @DateTimeNow = '2014-2-13'
	
	DECLARE @CountMonth TINYINT
	SET @CountMonth = 3
	
	WHILE (@CountMonth > 0)
	BEGIN
		INSERT INTO
			@Table
		SELECT
			DATEPART(MONTH, @DateTimeNow),
			ISNULL(SUM(PDFN + PDCN + PDIN + PSFN + PSCN + PSIN), 0),--Calcula total de páginas mono
			ISNULL(SUM(CDFN + CDCN + CDIN + CSFN + CSCN + CSIN), 0) --Calcula total de páginas color				
		FROM 
			CubeUserAccount C 
		WHERE
			MONTH(C.Data) = DATEPART(MONTH, @DateTimeNow)
			AND YEAR(C.Data) = DATEPART(YEAR, @DateTimeNow)
			AND C.AccountID = @AccountID
			
		SET @DateTimeNow = DATEADD(MONTH, -1, @DateTimeNow)
		
		SET @CountMonth = @CountMonth - 1
	END
	
	RETURN
	
END
```

---

## 75. preGetPrinterDeviceID

```sql
CREATE FUNCTION [dbo].[preGetPrinterDeviceID]
(
	@AddressName NVARCHAR(50),
	@AddressPort NVARCHAR(200),
	@PrinterModelID INT,
	@SerialNumber NVARCHAR(50),
	@AddressMAC NVARCHAR(50)
) RETURNS INT

BEGIN

	--*************************************************************************************************
	--** Alterado para 5.0
	--** Regras continuam AS mesmas. Só mudei para esperar o modelid e nao só o modelname. 
	--** Robson 18/02/2013
	--*************************************************************************************************
	--** Foi criado um parâmetro na tabela Parameters GetPrinterDeviceIDDisableConditionalCheck1 para desabilitar determinado condicional.
	--** Assim definindo que a impressora não foi encontrada e que uma nova impressora deve ser criada.
	--** Rafael Machado, 06/06/2017
	--** Robson 13/10/2017: colocado esse bloco do RAFA nessa função porque só estava na outra função ([GetPrinterDeviceID])
	--*************************************************************************************************


	DECLARE @PrinterDeviceIDFound INT 
	
	--********************************************************************
	-- LIMPEZA DE SERIAL TERÁ QUE SAIR DAQUI. ROBSON.
	
	--Verifica se o SN tem mais do que 3 caracters
	IF(LEN(@SerialNumber) <= 3)
	BEGIN
		SET @SerialNumber = ''
	END
	ELSE IF (REPLACE(@SerialNumber, SUBSTRING(@SerialNumber, 1, 1), '') = '')--Verifica se o SN é composto por caracteres todos iguais
	BEGIN
		SET @SerialNumber = ''
	END

		IF (@SerialNumber IN (SELECT InvalidData FROM InvalidPrinterKeys WHERE IsMac = 0))
		BEGIN
			SET @SerialNumber = ''
		END

	
		IF (@AddressMAC IN (SELECT InvalidData FROM InvalidPrinterKeys WHERE IsMac = 1))
		BEGIN
			SET @AddressMAC = ''
		END
		
		
		
		
	IF (@SerialNumber <> '')
	BEGIN
		--A IMPRESSORA NOVA TEM SERIAL NUMBER
		--PROCURA NO BANCO POR UMA IMPRESSORA COM O MESMO SERIAL
		SELECT
			@PrinterDeviceIDFound = PrinterDeviceID
		FROM 
			PrintersDevices 
		WHERE
			SerialNumber = @SerialNumber

		IF (@PrinterDeviceIDFound IS NULL)		
		BEGIN 			
			-- NÃO ACHOU NO BANCO NENHUMA IMPRESSORA COM ESSE SERIAL	
			IF ( @AddressMAC = '')
			BEGIN
				--O MAC DA IMPRESSORA NOVA NÃO É CONHECIDO
				--PROCURA POR UMA IMPRESSORA NO BANCO COM MESMO IP, MODELO E PORTA, E COM SERIAL NUMBER EM BRANCO,
				SELECT
					@PrinterDeviceIDFound = PD.PrinterDeviceID
				FROM 
					PrintersDevices PD						
				WHERE
					(PD.AddressName = @AddressName) 
					AND (PD.AddressPort = @AddressPort) 
					AND (Pd.PrinterModelID = @PrinterModelID) 
					AND (PD.SerialNumber = '' OR PD.SerialNumber IS NULL)

				IF (@PrinterDeviceIDFound IS NULL)		
				BEGIN 		

					--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
					--PROCURA POR UMA IMPRESSORA NO BANCO COM MESMO IP, PORTA, E COM SERIAL NUMBER EM BRANCO,
					SELECT
						@PrinterDeviceIDFound = PrinterDeviceID
					FROM 
						PrintersDevices 
					WHERE
						(AddressName = @AddressName) 
						AND (AddressPort = @AddressPort) 
						AND (SerialNumber = '' OR SerialNumber IS NULL)

					IF (@PrinterDeviceIDFound IS NULL)		
					BEGIN 		
						--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
						--ENTÃO TEM QUE CRIAR UM NOVO REGISTRO NO BANCO PARA ESTA IMPRESSORA 
						--RETORNA 0 PARA O BUSINESS FAZER ISSO
						SET @PrinterDeviceIDFound = 0
					END
					ELSE
					BEGIN
						--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
						--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
						--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
						--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
						SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
					END
				END
				ELSE
				BEGIN
					--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
					--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
					--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
					--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
					SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
				END

			END
			ELSE
			BEGIN
				-- A IMPRESSORA NOVA TEM UM MAC 
				--PROCURA NO BANCO POR UMA IMPRESSORA COM ESSE MAC E SEM SERIAL NUMBER
				SELECT 
					@PrinterDeviceIDFound = PrinterDeviceID
				FROM
					PrintersDevices 
				WHERE 
					(AddressMAC = @AddressMAC) 
					AND (SerialNumber = '' OR SerialNumber IS NULL)
			
				IF (@PrinterDeviceIDFound IS NULL)		
				BEGIN 	
					-- NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍSTICAS
					--PROCURA POR UMA IMPRESSORA NO BANCO COM MESMO IP, MODELO E PORTA, E COM SERIAL NUMBER EM BRANCO,
					SELECT
						@PrinterDeviceIDFound = PD.PrinterDeviceID
					FROM 
						PrintersDevices PD							
					WHERE 
						(PD.AddressName = @AddressName) 
						AND (PD.AddressPort = @AddressPort) 
						AND (PD.PrinterModelID = @PrinterModelID) 
						AND (PD.SerialNumber = '' OR PD.SerialNumber IS NULL)

					IF (@PrinterDeviceIDFound IS NULL)		
					BEGIN 		

						--Criamos esse parâmetro (GetPrinterDeviceIDDisableConditionalCheck1) para desabilitar essa verificação.
						--Assim definindo que a impressora não foi encontrada e que uma nova impressora deve ser criada.
						--Issues relacionadas a essa alteração: #3801 e #5398.
						IF EXISTS (SELECT * FROM Parameters WHERE ParameterName = 'GetPrinterDeviceIDDisableConditionalCheck1' AND ParameterValue = '1')
						BEGIN
							SET @PrinterDeviceIDFound = 0
						END
						ELSE
						BEGIN

							--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
							--PROCURA POR UMA IMPRESSORA NO BANCO COM MESMO IP, PORTA, E COM SERIAL NUMBER EM BRANCO,
							SELECT
								@PrinterDeviceIDFound = PrinterDeviceID
							FROM 
								PrintersDevices 
							WHERE 
								(AddressName = @AddressName) 
								AND (AddressPort = @AddressPort) 
								AND (SerialNumber = '' OR SerialNumber IS NULL)

							IF (@PrinterDeviceIDFound IS NULL)		
							BEGIN 		

								--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
								--ENTÃO TEM QUE CRIAR UM NOVO REGISTRO NO BANCO PARA ESTA IMPRESSORA 
								--RETORNA 0 PARA O BUSINESS FAZER ISSO
								SET @PrinterDeviceIDFound = 0
							END
							ELSE
							BEGIN
								--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
								--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
								--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
								--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
								SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
							END
						END
					END
					ELSE
					BEGIN
						--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
						--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
						--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
						--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
						SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
					END

				END
				ELSE
				BEGIN
					--ACHOU NO BANCO A IMPRESSORA COM ESTE MAC E SEM SERIAL NUMBER
					--ATUALIZA OS OUTROS DADOS, INCLUSIVE O SERIAL NUMBER, JÁ QUE NÃO TINHA
					--AQUI NÃO FAZ NADA, NO FINAL DA SP QUE OS DADOS DA IMPRESSORA SERÃO RETORNADOS
					SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
				END
			END		
		END
		ELSE
		BEGIN
			--ACHOU A IMPRESSORA NO BANCO QUE TEM ESSE MESMO SERIAL
			--NÃO FAZ NADA AQUI. RETORNA NO FINAL DA SP OS DADOS DA IMPRESSORA
			SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
		END

	END
	ELSE
	BEGIN
		--O SERIAL NUMBER DA IMPRESSORA NOVA É DESCONHECIDO
		IF (@AddressMAC = '')
		BEGIN
			--O MAC DA IMPRESSORA NOVA NÃO É CONHECIDO
			-- PROCURA POR UMA IMPRESSORA COM O MESMO IP, PORTA E MODELO (E QUALQUER MAC E SERIAL)
			SELECT
				@PrinterDeviceIDFound = PD.PrinterDeviceID
			FROM 
				PrintersDevices PD					
			WHERE
				(PD.AddressName = @AddressName) 
				AND (PD.AddressPort = @AddressPort) 
				AND (PD.PrinterModelID = @PrinterModelID)
		
			IF (@PrinterDeviceIDFound IS NULL)		
			BEGIN 		

				--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
				--PROCURA POR UMA IMPRESSORA NO BANCO COM MESMO IP E PORTA
				SELECT
					@PrinterDeviceIDFound = PrinterDeviceID
				FROM 
					PrintersDevices 
				WHERE
					(AddressName = @AddressName) 
					AND (AddressPort = @AddressPort) 

				IF (@PrinterDeviceIDFound IS NULL)		
				BEGIN 		
					--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
					--ENTÃO TEM QUE CRIAR UM NOVO REGISTRO NO BANCO PARA ESTA IMPRESSORA 
					--RETORNA 0 PARA O BUSINESS FAZER ISSO
					SET @PrinterDeviceIDFound = 0
				END
				ELSE
				BEGIN
					--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
					--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
					--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
					--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
					SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
				END
			END
			ELSE
			BEGIN
				--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
				--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
				--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
				--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
				SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
			END
		END
		ELSE
		BEGIN
			--O MAC DA IMPRESSORA É CONHECIDO
			-- PROCURA POR UMA IMPRESSORA COM ESSE MAC E QUALQUER SERIAL NUMBER
			SELECT 
				@PrinterDeviceIDFound = PrinterDeviceID
			FROM
				PrintersDevices
			WHERE 
				AddressMAC = @AddressMAC

			IF (@PrinterDeviceIDFound  IS NULL)
			BEGIN
				-- NÃO ACHOU A IMPRESSORA COM ESSE MAC
				-- PROCURA POR UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SEM MAC
				SELECT
					@PrinterDeviceIDFound = PD.PrinterDeviceID
				FROM 
					PrintersDevices PD						
				WHERE
					(PD.AddressName = @AddressName) 
					AND (PD.AddressPort = @AddressPort) 
					AND (PD.PrinterModelID = @PrinterModelID)
					AND (PD.AddressMAC = '' OR PD.AddressMAC IS NULL)

				IF (@PrinterDeviceIDFound IS NULL)		
				BEGIN 		
					--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
					--PROCURA POR UMA IMPRESSORA NO BANCO COM MESMO IP E PORTA E SEM MAC
					SELECT
						@PrinterDeviceIDFound = PrinterDeviceID
					FROM 
						PrintersDevices 
					WHERE 
						(AddressName = @AddressName) 
						AND (AddressPort = @AddressPort)  
						AND (AddressMAC = '' OR AddressMAC IS NULL)

					IF (@PrinterDeviceIDFound IS NULL)		
					BEGIN 		
						--NÃO ACHOU NENHUMA IMPRESSORA COM ESSAS CARACTERÍTICAS
						--ENTÃO TEM QUE CRIAR UM NOVO REGISTRO NO BANCO PARA ESTA IMPRESSORA 
						--RETORNA 0 PARA O BUSINESS FAZER ISSO
						SET @PrinterDeviceIDFound = 0
					END
					ELSE
					BEGIN
						--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
						--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
						--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
						--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
						SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
					END
				END
			ELSE
			BEGIN
				--ACHOU UMA IMPRESSORA COM A MESMA PORTA, IP E MODELO, E SERIAL NULO
				--RETORNA ESSA IMPRESSORA PARA O SISTEMA ATUALIZAR OS DADOS DELA
				--INCLUSIVE O MAC, QUE A IMPRESSORA DO BANCO OU NAO TEM OU É OUTRO
				--AQUI NÃO FAZ NADA, NO FIM DA SP SERÁ FEITO
				SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
			END
			END	
			ELSE
			BEGIN
				--ACHOU UMA IMPRESSORA COM ESSE MAC, COM OU SEM SERIAL
				--ATUALIZA OS DADOS DESSA IMPRESSORA, MENOS O SERIAL, PORQUE SE JÁ TIVER UM NO BANCO
				--CONTINUA CERTO. AQUI NÃO FAZ NADA, NO FIM DA SP QUE SERÁ FEITO
				SET @PrinterDeviceIDFound = @PrinterDeviceIDFound --SETA ISSO SÓ PRA NAO DAR ERRO NA SP
			END			
		END
	END


	RETURN (@PrinterDeviceIDFound);

END
```

---

