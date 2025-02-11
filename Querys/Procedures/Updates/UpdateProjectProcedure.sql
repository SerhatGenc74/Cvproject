Create Procedure UpdateProject
@projectId nchar(4),
@title varchar(100),
@description varchar(max),
@coverImgUrl varchar(50),
@tags varchar(max),
@deleteId bit,
@details ProjectDetailsType READONLY
AS
BEGIN TRAN

Update Projects 
set title = @title, description = @description, coverImgUrl = @coverImgUrl, tags = @tags,deleteId= @deleteId 
where projectId = @projectId;

if @@ERROR > 0
begin
ROLLBACK TRAN;
Return;
end


 MERGE INTO ProjectDetails AS target
    USING @details AS source
    ON target.id = source.id AND target.projectId = @projectId

    WHEN MATCHED THEN
        UPDATE SET 
            target.type = source.type,
            target.visibleContent = source.visibleContent,
            target.content = source.content,
            target.subContent = source.subContent,
			target.deleteId = source.deleteId

    WHEN NOT MATCHED BY TARGET THEN
        INSERT (projectId, type, visibleContent, content, subContent, deleteId)
        VALUES (@projectId, source.type, source.visibleContent, source.content, source.subContent, source.deleteId)

    WHEN NOT MATCHED BY SOURCE AND target.projectId = @projectId THEN
        DELETE;

if @@ERROR > 0
begin
ROLLBACK TRAN;
Return;
end

COMMIT TRAN