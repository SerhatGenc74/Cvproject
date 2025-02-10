create PROCEDURE AdminLogin
@nickName VARCHAR(25),
@password VARCHAR(MAX),
@userId VARCHAR(5) OUTPUT
AS
BEGIN TRAN
    SET NOCOUNT ON;

    -- Symmetric Key A�
    OPEN SYMMETRIC KEY MySymmetricKey  
    DECRYPTION BY CERTIFICATE MyCert;

    DECLARE @storedEncryptedPassword VARBINARY(MAX);
    DECLARE @decryptedPassword VARCHAR(MAX);

    -- Kullan�c�n�n �ifreli parolas�n� �ek
    SELECT @storedEncryptedPassword = password
    FROM AdminUsers
    WHERE nickName = @nickName;

	   if @@ERROR > 0
   begin
     ROLLBACK TRAN
	 RETURN;
   end


    -- E�er kullan�c� yoksa hata d�nd�r
    IF @storedEncryptedPassword IS NULL
    BEGIN
        RAISERROR ('Kullan�c� ad� veya �ifre hatal�.', 16, 1);
        ROLLBACK TRAN;
        RETURN;
    END

    -- �ifreyi ��z
    SET @decryptedPassword = CONVERT(VARCHAR(MAX), DECRYPTBYKEY(@storedEncryptedPassword));

    -- �ifre e�le�mesini kontrol et
    IF @decryptedPassword = @password
    BEGIN
        -- Kullan�c�n�n userId'sini d�nd�r
        SELECT @userId = userId FROM AdminUsers WHERE nickName = @nickName;
    END
    ELSE
    BEGIN
        RAISERROR ('Kullan�c� ad� veya �ifre hatal�.', 16, 1);
        ROLLBACK TRAN;
        RETURN;
    END

    -- Symmetric Key Kapat
    CLOSE SYMMETRIC KEY MySymmetricKey;

COMMIT TRAN;
