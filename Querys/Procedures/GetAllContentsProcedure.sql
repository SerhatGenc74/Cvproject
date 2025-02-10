Create Procedure GetAllContents 
AS
BEGIN
  SET NOCOUNT ON;

  Select id, contentId, type, tags, visibleContent, content, subContent, deleteId from Contents 
END