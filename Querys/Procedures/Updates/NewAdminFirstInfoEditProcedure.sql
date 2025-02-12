create Procedure NewAdminFirstInfoEdit
@userId nchar(5),
@nickname varchar(25),
@password varchar(max)
AS
BEGIN TRAN
SET NOCOUNT ON;
OPEN SYMMETRIC KEY MySymmetricKey
    DECRYPTION BY CERTIFICATE MyCert;
 Declare @encryptedPassword varbinary(max) =EncryptByKey(KEY_GUID('MySymmetricKey'), @password);

 Update AdminUsers Set nickName = @nickname, password = @encryptedPassword, Role = 'Admin' 
 Where  userId = @userId AND userId = nickName AND Role = 'NewAdmin';

 if @@ERROR > 0
 begin
  ROLLBACK TRAN
  Return;
 end
COMMIT TRAN