EXEC AddAdmin
@nickName = 'serhat',
@email = 'ses@gmail.com',
@password = 'Aa15876444';


DECLARE @showUserId VARCHAR(20);

EXEC AdminLogin 
@nickName = 'serhat',
@password = 'Aa15876444',
@userId = @showUserId OUTPUT;

SELECT @showUserId AS SessionID;

Declare @isOpen bit;

Exec SessionControl
@userId = @showUserId,
@isSessionOpen = @isOpen OUTPUT;

Select @isOpen;



DECLARE @hashedPassword varchar(20);
SET @hashedPassword = convert(varchar(20), HASHBYTES('SHA2_256', 'Aa15876444'),1); -- Kullanýcýnýn girdiði þifre

SELECT *, @hashedPassword FROM AdminUsers WHERE nickName = 'serhat' ;
