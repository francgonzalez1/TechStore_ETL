USE [TechStore]
GO
/****** Object:  User [NT AUTHORITY\SYSTEM]    Script Date: 13/3/2025 17:10:08 ******/
CREATE USER [NT AUTHORITY\SYSTEM] FOR LOGIN [NT AUTHORITY\SYSTEM] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [SQLArcExtensionUserRole] ADD MEMBER [NT AUTHORITY\SYSTEM]
GO
