Create Procedure GetProjectDetails
@projectId nchar(4)
AS
BEGIN
SET NOCOUNT ON;
Select id,title, description, coverImgUrl,tags, deleteId  From Projects where projectId = @projectId;
Select id,type, visibleContent, content, subContent, deleteId From ProjectDetails where projectId = @projectId;
END