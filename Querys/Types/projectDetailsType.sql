CREATE TYPE ProjectDetailsType AS TABLE
(
    id int,
	projectId nchar(4),
    type NVARCHAR(100),
    visibleContent NVARCHAR(MAX),
    content NVARCHAR(MAX),
    subContent NVARCHAR(MAX),
	deleteId bit
);