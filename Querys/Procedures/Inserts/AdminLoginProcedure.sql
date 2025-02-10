create PROCEDURE AdminLogin
@nickName VARCHAR(25),
@password VARCHAR(MAX),
@userId VARCHAR(5) OUTPUT
AS
BEGIN TRAN
    SET NOCOUNT ON;

    -- Symmetric Key Aç
    OPEN SYMMETRIC KEY MySymmetricKey  
    DECRYPTION BY CERTIFICATE MyCert;

    DECLARE @storedEncryptedPassword VARBINARY(MAX);
    DECLARE @decryptedPassword VARCHAR(MAX);

    -- Kullanýcýnýn þifreli parolasýný çek
    SELECT @storedEncryptedPassword = password
    FROM AdminUsers
    WHERE nickName = @nickName;

	   if @@ERROR > 0
   begin
     ROLLBACK TRAN
	 RETURN;
   end


    -- Eðer kullanýcý yoksa hata döndür
    IF @storedEncryptedPassword IS NULL
    BEGIN
        RAISERROR ('Kullanýcý adý veya þifre hatalý.', 16, 1);
        ROLLBACK TRAN;
        RETURN;
    END

    -- Þifreyi çöz
    SET @decryptedPassword = CONVERT(VARCHAR(MAX), DECRYPTBYKEY(@storedEncryptedPassword));

    -- Þifre eþleþmesini kontrol et
    IF @decryptedPassword = @password
    BEGIN
        -- Kullanýcýnýn userId'sini döndür
        SELECT @userId = userId FROM AdminUsers WHERE nickName = @nickName;
    END
    ELSE
    BEGIN
        RAISERROR ('Kullanýcý adý veya þifre hatalý.', 16, 1);
        ROLLBACK TRAN;
        RETURN;
    END

    -- Symmetric Key Kapat
    CLOSE SYMMETRIC KEY MySymmetricKey;

COMMIT TRAN;
