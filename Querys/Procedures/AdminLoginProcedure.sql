create procedure AdminLogin
@nickName varchar(25),
@password varchar(20),
@userId varchar(5) output
AS 
BEGIN TRAN
   SET NOCOUNT ON;

   DECLARE @hashedPassword varchar(20);
    SET @hashedPassword = convert(varchar(20),HASHBYTES('SHA2_256', @password),1);

    IF EXISTS (SELECT 1 FROM AdminUsers WHERE nickName = @nickName AND password = @hashedPassword)
    BEGIN
        -- Kullanýcýnýn userId'sini döndür
        SELECT @userId = userId FROM AdminUsers WHERE nickName = @nickName;
    END
    ELSE
    BEGIN
        RAISERROR ('Kullanýcý adý veya þifre hatalý.', 16, 1);
    END
COMMIT TRAN