Create Procedure DeleteProject 
@projectId nchar(4)
as
BEGIN TRAN
SET NOCOUNT ON;

IF EXISTS (select 1 from Projects where projectId = @projectId and deleteId = 1)
BEGIN
  DELETE FROM ProjectDetails where projectId = @projectId;
  if @@ERROR > 0
  begin
   ROLLBACK TRAN
   return;
  end
  DELETE FROM Projects where projectId = @projectId;
    if @@ERROR > 0
  begin
   ROLLBACK TRAN
   return;
  end
END
ELSE
BEGIN
  RAISERROR ('Proje raftan kaldýrýlmadýðý için silinemez.', 16, 1);
  return;
END

COMMIT TRAN