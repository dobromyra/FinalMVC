USE [master]
GO
/****** Object:  Database [BaseForAuthorize]    Script Date: 25.02.2021 19:30:55 ******/
CREATE DATABASE [BaseForAuthorize]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BaseForAuthorize', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\BaseForAuthorize.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BaseForAuthorize_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\BaseForAuthorize_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BaseForAuthorize].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BaseForAuthorize] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET ARITHABORT OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BaseForAuthorize] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BaseForAuthorize] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BaseForAuthorize] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BaseForAuthorize] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BaseForAuthorize] SET  MULTI_USER 
GO
ALTER DATABASE [BaseForAuthorize] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BaseForAuthorize] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BaseForAuthorize] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BaseForAuthorize] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BaseForAuthorize] SET DELAYED_DURABILITY = DISABLED 
GO
USE [BaseForAuthorize]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 25.02.2021 19:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 25.02.2021 19:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Login] [varchar](50) NOT NULL,
	[PassHash] [varchar](50) NOT NULL,
	[FName] [varchar](50) NOT NULL,
	[MName] [varchar](50) NULL,
	[LName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 25.02.2021 19:30:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[RoleID] [int] NOT NULL,
	[UserID] [int] NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([ID], [Name]) VALUES (1, N'Seller')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (2, N'Accountant')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (3, N'Manager')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (4, N'Storekeeper')
INSERT [dbo].[Role] ([ID], [Name]) VALUES (5, N'Client')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [Login], [PassHash], [FName], [MName], [LName]) VALUES (1, N'Ivan', N'202CB962AC59075B964B07152D234B70', N'Иван', NULL, N'Иванов')
INSERT [dbo].[User] ([ID], [Login], [PassHash], [FName], [MName], [LName]) VALUES (2, N'Petr', N'202CB962AC59075B964B07152D234B70', N'Петр', NULL, N'Петров')
INSERT [dbo].[User] ([ID], [Login], [PassHash], [FName], [MName], [LName]) VALUES (3, N'Vasek', N'202CB962AC59075B964B07152D234B70', N'Вася', NULL, N'Васечкин')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
INSERT [dbo].[UserRole] ([RoleID], [UserID]) VALUES (1, 1)
INSERT [dbo].[UserRole] ([RoleID], [UserID]) VALUES (2, 1)
INSERT [dbo].[UserRole] ([RoleID], [UserID]) VALUES (4, 2)
INSERT [dbo].[UserRole] ([RoleID], [UserID]) VALUES (3, 2)
INSERT [dbo].[UserRole] ([RoleID], [UserID]) VALUES (5, 3)
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([ID])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Role]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([ID])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_User]
GO
USE [master]
GO
ALTER DATABASE [BaseForAuthorize] SET  READ_WRITE 
GO
