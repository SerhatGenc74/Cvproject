create procedure AddAdmin 
  @email varchar(100)
as
begin TRAN
   SET NOCOUNT ON;

   if  @email is null OR LTRIM(RTRIM(@email)) =''
   begin
      RAISERROR(' E-posta boþ olamaz', 16,1);
	  return;
   end
    
	Declare @userId nchar(5);
	 WHILE 1 = 1
    BEGIN
        SET @userId = (SELECT LEFT(NEWID(), 5) AS RandomID);
        IF NOT EXISTS (SELECT 1 FROM AdminUsers WHERE userId = @userId)
            BREAK;
    END

	OPEN SYMMETRIC KEY MySymmetricKey
    DECRYPTION BY CERTIFICATE MyCert;

	Declare @password varchar(8) =(SELECT LEFT(NEWID(), 10) AS RandomID);
	Declare @encryptedPassword  varBinary(max);

	Set @encryptedPassword = EncryptByKey(KEY_GUID('MySymmetricKey'), @password);

	CLOSE SYMMETRIC KEY MySymmetricKey;

   Insert Into AdminUsers(userId,nickName,email, Role,password) 
   values (@userId, @userId, @email, 'NewAdmin', @encryptedPassword);

   if @@ERROR > 0
   begin
     ROLLBACK TRAN
	 RETURN;
   end

   Print 'Admin Baþarýyla eklendi.';
Commit Tran 