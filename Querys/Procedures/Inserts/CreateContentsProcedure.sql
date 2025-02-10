create Procedure CreateContent
@type nchar(20),
@tags varchar(50),
@visibleContent varchar(max),
@content varchar(max),
@subContent varchar(max)
AS
BEGIN TRAN
SET NOCOUNT ON;

Declare @contentId nchar(10);

if @type is null OR LTRIM(RTRIM(@type)) = ''
begin
  RAISERROR('Type Boþ býrakýlamaz!!', 16,1);
  return;
end

WHILE 1 = 1
BEGIN
  SET @contentId = (SELECT LEFT(NEWID(), 10) AS RandomID);
  IF NOT EXISTS (SELECT 1 FROM Contents WHERE contentId = @contentId)
    BREAK;
  END
if @@ERROR > 0
begin
  ROLLBACK TRAN
  RETURN;
end

insert Into Contents(contentId, type,tags,visibleContent,content,subContent,deleteId)
values (@contentId,@type, @tags, @visibleContent, @content, @subContent, 1);
if @@ERROR > 0
begin
  ROLLBACK TRAN
  RETURN;
end
COMMIT TRAN