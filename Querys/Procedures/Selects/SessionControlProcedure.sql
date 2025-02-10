create Procedure SessionControl
@userId nchar(5),
@isSessionOpen bit OUTPUT
as
BEGIN 
 SET NOCOUNT ON;
 if @userId is null OR LTRIM(RTRIM(@userId)) = ''
 begin
   Set @isSessionOpen = 0;
   return;
 end

  SET @isSessionOpen = ISNULL((SELECT 1 FROM AdminUsers WHERE userId = @userId), 0);
end 