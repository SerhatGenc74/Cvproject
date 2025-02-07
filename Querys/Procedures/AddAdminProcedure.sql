create procedure AddAdmin 
  @nickName varchar(25),
  @email varchar(100),
  @password varchar(20)
as
begin TRAN
   SET NOCOUNT ON;


   if @nickName is null OR LTRIM(RTRIM(@nickName)) = ''
   OR @email is null OR LTRIM(RTRIM(@email)) =''
   OR @password is null OR LTRIM(RTRIM(@password)) = ''
   begin
      RAISERROR('Kullan�c� ad�, E-posta veya �ifre bo� olamaz', 16,1);
	  return;
   end

   if exists (select 1 from AdminUsers Where nickName = @nickName) 
   begin
      RAISERROR('Var olan bir kullan�c� ad�n� kullananmazs�n�z.',16,1);
	  return;
   end
      if exists (select 1 from AdminUsers Where email = @email) 
   begin
      RAISERROR('Var olan bir eposta adresini kullananmazs�n�z.',16,1);
	  return;
   end


	Declare @userId varchar(5);
	 WHILE 1 = 1
    BEGIN
        SET @userId = (SELECT LEFT(NEWID(), 5) AS RandomID);
        IF NOT EXISTS (SELECT 1 FROM AdminUsers WHERE userId = @userId)
            BREAK;
    END
	Declare @hashedPassword varchar(20);

	Set @hashedPassword = Convert(varchar(20),HASHBYTES('SHA2_256', @password),1);


   Insert Into AdminUsers(userId,nickName,email,password) 
   values (@userId, @nickName, @email, @hashedPassword);

   if @@ERROR > 0
   begin
     ROLLBACK TRAN
	 RETURN;
   end

   Print 'Admin Ba�ar�yla eklendi.';
Commit Tran 