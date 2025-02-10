
-- ADD ADMIN
EXEC AddAdmin
@nickName = 'ismail',
@email = 'is@gmail.com',
@password = '12345';
--/ ADD ADMIN


-- ADMIN LOGIN - SESSION CONTROL

DECLARE @showUserId VARCHAR(max);

EXEC AdminLogin 
@nickName = 'ismail',
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



