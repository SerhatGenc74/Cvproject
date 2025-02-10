Create Procedure CreateProject
    @title NVARCHAR(100),
    @description NVARCHAR(MAX),
    @coverImgUrl NVARCHAR(50),
    @tags NVARCHAR(max),
    @details ProjectDetailsType READONLY
AS
BEGIN TRAN
   SET NOCOUNT ON;
   Declare @newProjectId nchar(4);
   	 WHILE 1 = 1
    BEGIN
        SET @newProjectId = (SELECT LEFT(NEWID(), 4) AS RandomID);
        IF NOT EXISTS (SELECT 1 FROM Projects WHERE projectId = @newProjectId)
            BREAK;
    END
	insert Into Projects (projectId,title, description, coverImgUrl, tags, deleteId)
	values (@newProjectId,@title, @description, @coverImgUrl, @tags, 0);
	if @@ERROR > 0
	begin
	 ROLLBACK TRAN
	 Return;
	end
	Insert Into ProjectDetails (projectId, type, visibleContent, content, subContent, deleteId)
	Select @newProjectId, type, visibleContent, content, subContent, 0 From @details;
	if @@ERROR > 0
	begin
	 ROLLBACK TRAN
	 Return;
	end
COMMIT TRAN