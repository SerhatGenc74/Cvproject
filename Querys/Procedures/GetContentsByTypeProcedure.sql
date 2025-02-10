CREATE PROCEDURE GetContentsByType
    @type VARCHAR(max)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        id,
        contentId,
        type,
        tags,
        visibleContent,
        content,
        subContent,
        deleteId
    FROM dbo.Contents
    WHERE type = @type;
END
