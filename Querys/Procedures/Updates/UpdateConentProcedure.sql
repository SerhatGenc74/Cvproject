Create Procedure UpdateContent
@contentId nchar(10),
@type nchar(20),
@tags varchar(max),
@visibleContent varchar(max),
@content varchar(max),
@subContent varchar(max),
@deleteId bit
AS
BEGIN TRAN
SET NOCOUNT ON;
Update Contents
set type = @type, tags = @tags, visibleContent = @visibleContent, content = @content,
    subContent = @subContent, deleteId = @deleteId
where contentId = @contentId;

if @@ERROR > 0
begin
ROLLBACK TRAN
return;
end

COMMIT TRAN