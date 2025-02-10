create procedure AddAdmin 
  @nickName varchar(25),
  @email varchar(100),
  @password varchar(max)
as
begin TRAN
   SET NOCOUNT ON;


   if @nickName is null OR LTRIM(RTRIM(@nickName)) = ''
   OR @email is null OR LTRIM(RTRIM(@email)) =''
   OR @password is null OR LTRIM(RTRIM(@password)) = ''
   begin
      RAISERROR('Kullanýcý adý, E-posta veya Þifre boþ olamaz', 16,1);
	  return;
   end

   if exists (select 1 from AdminUsers Where nickName = @nickName) 
   begin
      RAISERROR('Var olan bir kullanýcý adýný kullananmazsýnýz.',16,1);
	  return;
   end
      if exists (select 1 from AdminUsers Where email = @email) 
   begin
      RAISERROR('Var olan bir eposta adresini kullananmazsýnýz.',16,1);
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

	Declare @encryptedPassword  varBinary(max);

	Set @encryptedPassword = EncryptByKey(KEY_GUID('MySymmetricKey'), @password);

	CLOSE SYMMETRIC KEY MySymmetricKey;

   Insert Into AdminUsers(userId,nickName,email,password) 
   values (@userId, @nickName, @email, @encryptedPassword);

   if @@ERROR > 0
   begin
     ROLLBACK TRAN
	 RETURN;
   end

   Print 'Admin Baþarýyla eklendi.';
Commit Tran 