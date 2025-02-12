Create Procedure GetAllAdmins

AS
BEGIN
 SET NOCOUNT ON;
 
 OPEN SYMMETRIC KEY MySymmetricKey
 DECRYPTION BY CERTIFICATE MyCert;

Select 
    userId, 
	nickName,
	Role,
    CASE 
	    WHEN Role = 'Admin' THEN '***'
		WHEN Role = 'NewAdmin' THEN Convert(varchar(max),DecryptbyKey(password))
		else 'Yetkisiz'
	end as password
	from AdminUsers;

END