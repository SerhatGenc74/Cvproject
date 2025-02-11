Create Procedure DeleteContent
@contentId nchar(10)
AS
BEGIN TRAN

Delete from Contents where contentId = @contentId and deleteId = 1;
if @@ERROR > 0
begin
 ROLLBACK TRAN
 return;
end
COMMIT TRAN