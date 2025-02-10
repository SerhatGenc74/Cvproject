Create Procedure GetAllProjects 
AS
BEGIN
  SET NOCOUNT ON;
  Select id,projectId,title, description, coverImgUrl,tags, deleteId From Projects;
END