-- ADD ADMIN
EXEC AddAdmin
@email = 'ismail@gmail.com'
--/ ADD ADMIN

EXEC GetAllAdmins;


EXEC NewAdminFirstInfoEdit
@userId = 'D207D',
@nickName = 'ismailKemal',
@password = '12345';



-- ADMIN LOGIN - SESSION CONTROL

DECLARE @showUserId VARCHAR(max);

EXEC AdminLogin 
@nickName = 'ismailEmme',
@password = '12345',
@userId = @showUserId OUTPUT;

SELECT @showUserId AS SessionID;

Declare @isOpen bit;

Exec SessionControl
@userId = @showUserId,
@isSessionOpen = @isOpen OUTPUT;

Select @isOpen;

--/ ADMIN LOGIN - SESSION CONTROL


-- CREATE CONTENT 

EXEC CreateContent 
@type = 'about',
@tags = 'gamedevCV, devCV, myDeveloperBackground',
@visibleContent = 'Ben Küçük bir çocuk iken kod dünyasına giriş yaptım.',
@content = '',
@subContent = '';

--/ CREATE CONTENT 

-- Project Create

DECLARE @details ProjectDetailsType;

-- 📌 Örnek Proje Detayları Ekle
INSERT INTO @details (type, visibleContent, content, subContent)
VALUES 
    ('Type1', 'Visible Content 1', 'Content 1', 'Sub Content 1'),
    ('Type2', 'Visible Content 2', 'Content 2', 'Sub Content 2'),
    ('Type3', 'Visible Content 3', 'Content 3', 'Sub Content 3');

-- 📌 Prosedürü Çağır
EXEC CreateProject
   'Test Project 2',
     'This is a test 2 project description.',
     'https://example.com/test.jpg',
   'test,project',
     @details;

--/ Project Create


-- GetProject
EXEC GetProjectDetails
'26B0';

--/ GetProject 

select * from Projects;


-- Project Update

DECLARE @details ProjectDetailsType;

-- 📌 Güncellenecek ve eklenecek proje detayları
INSERT INTO @details (id, projectId, type, visibleContent, content, subContent, deleteId)
VALUES 
    (1, '26B0', 'Updated Type 1', 'Updated Visible Content 1', 'Updated Content 1', 'Updated Sub Content 1',0),
    (2, '26B0', 'Updated Type 2', 'Updated Visible Content 2', 'Updated Content 2', 'Updated Sub Content 2',1),
    (NULL, '26B0', 'New Type 3', 'New Visible Content 3', 'New Content 3', 'New Sub Content 3',1); -- Yeni detay ekleniyor

-- 📌 Prosedürü çalıştır
EXEC UpdateProject
    @projectId = '26B0',
    @title = 'Updated Project Title',
    @description = 'Updated Project Description',
    @coverImgUrl = 'https://example.com/updated.jpg',
    @tags = 'updated,project',
	@deleteId = 0,
    @details = @details;



-- Project Update
