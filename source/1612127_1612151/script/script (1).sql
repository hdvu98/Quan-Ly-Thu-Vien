USE [master]
GO
/****** Object:  Database [LIBRARY]    Script Date: 6/24/2019 3:15:01 PM ******/
CREATE DATABASE [LIBRARY]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LIBRARY', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\LIBRARY.mdf' , SIZE = 5312KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'LIBRARY_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\LIBRARY_log.ldf' , SIZE = 1856KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 COLLATE SQL_Latin1_General_CP1_CI_AI
GO
ALTER DATABASE [LIBRARY] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LIBRARY].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LIBRARY] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LIBRARY] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LIBRARY] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LIBRARY] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LIBRARY] SET ARITHABORT OFF 
GO
ALTER DATABASE [LIBRARY] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [LIBRARY] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LIBRARY] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LIBRARY] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LIBRARY] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LIBRARY] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LIBRARY] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LIBRARY] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LIBRARY] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LIBRARY] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LIBRARY] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LIBRARY] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LIBRARY] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LIBRARY] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LIBRARY] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LIBRARY] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LIBRARY] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LIBRARY] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [LIBRARY] SET  MULTI_USER 
GO
ALTER DATABASE [LIBRARY] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LIBRARY] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LIBRARY] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LIBRARY] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [LIBRARY] SET DELAYED_DURABILITY = DISABLED 
GO
USE [LIBRARY]
GO
/****** Object:  FullTextCatalog [booktypeCatalog]    Script Date: 6/24/2019 3:15:02 PM ******/
CREATE FULLTEXT CATALOG [booktypeCatalog]WITH ACCENT_SENSITIVITY = ON
AS DEFAULT

GO
/****** Object:  UserDefinedFunction [dbo].[func_NextAccountID]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[func_NextAccountID](@lastID varchar(10), @prefix varchar(7), @size int)
	returns varchar(10)
as
	BEGIN
	if(@lastID='')
	set @lastID = @prefix +REPLICATE(0,@size - LEN(@prefix))
	declare @num_nextID int, @nextID varchar(10)
	set @lastID = LTRIM(RTRIM(@lastID))
	set @num_nextID = REPLACE(@lastID,@prefix,'')+1
	set @size = @size - LEN(@prefix)
	set @nextID = @prefix +REPLICATE(0,@size -LEN(@prefix))
	set @nextID = @prefix +RIGHT(REPLICATE(0,@size) +CONVERT(varchar(MAX),@num_nextID),@size)
	return @nextID
	END

GO
/****** Object:  UserDefinedFunction [dbo].[func_NextID]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[func_NextID](@lastID varchar(6), @prefix varchar(3), @size int)
	returns varchar(6)
as
	BEGIN
	if(@lastID='')
	set @lastID = @prefix +REPLICATE(0,@size - LEN(@prefix))
	declare @num_nextID int, @nextID varchar(6)
	set @lastID = LTRIM(RTRIM(@lastID))
	set @num_nextID = REPLACE(@lastID,@prefix,'')+1
	set @size = @size - LEN(@prefix)
	set @nextID = @prefix +REPLICATE(0,@size -LEN(@prefix))
	set @nextID = @prefix +RIGHT(REPLICATE(0,@size) +CONVERT(varchar(MAX),@num_nextID),@size)
	return @nextID
	END

GO
/****** Object:  Table [dbo].[ACCOUNT]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ACCOUNT](
	[USERNAME] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PASS] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ROLE] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[USERNAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BLACK_LIST]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BLACK_LIST](
	[ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[READER_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BOOK]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BOOK](
	[BOOK_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[NAME] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AUTHOR] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PH_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BTYPE_ID] [int] NULL,
	[PRICE] [float] NULL,
	[AMOUNT] [int] NULL,
	[SUMMARY] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PUBLISH_YEAR] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[BOOK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BOOK_TYPE]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOOK_TYPE](
	[BTYPE_ID] [int] IDENTITY(1,1) NOT NULL,
	[BTYPE] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[BTYPE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BORROW_DETAILS]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BORROW_DETAILS](
	[ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FORM_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BOOK_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AMOUNT] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[FORM_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BORROW_FORM]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BORROW_FORM](
	[FORM_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[READER_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[EMPLOYEE_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LOAN_DATE] [date] NULL,
	[EXP_DATE] [date] NULL,
	[DEPOSIT] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[FORM_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EMPLOYEE]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EMPLOYEE](
	[EMPLOYEE_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[USERNAME] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[NAME] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EMPLOYEE_ADDRESS] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EMAIL] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PHONE_NUMBER] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DATE_OF_BIRTH] [date] NULL,
	[GENDER] [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[EMPLOYEE_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PAY_DETAILS]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PAY_DETAILS](
	[ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FORM_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BOOK_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AMOUNT] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[FORM_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PAY_FORM]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PAY_FORM](
	[ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BORROW_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EMPLOYEE_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PAY_DATE] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PUBLISHING_HOUSE]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PUBLISHING_HOUSE](
	[PH_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[NAME] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PH_ADDRESS] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PHONE_NUMBER] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EMAIL] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[PH_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[READER]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[READER](
	[READER_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[NAME] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DATE_OF_BIRTH] [date] NULL,
	[READER_ADDRESS] [nvarchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GENDER] [nvarchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PHONE_NUMBER] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EMAIL] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[READER_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[ACCOUNT] ([USERNAME], [PASS], [ROLE]) VALUES (N'account001', N'21232f297a57a5a743894a0e4a801fc3', 1)
INSERT [dbo].[ACCOUNT] ([USERNAME], [PASS], [ROLE]) VALUES (N'account002', N'c4416a65eb507b7cede15d98eb2adb54', 0)
INSERT [dbo].[ACCOUNT] ([USERNAME], [PASS], [ROLE]) VALUES (N'account003', N'd5ef89eaf60140d19c691c06829a36ba', 0)
INSERT [dbo].[BOOK] ([BOOK_ID], [NAME], [AUTHOR], [PH_ID], [BTYPE_ID], [PRICE], [AMOUNT], [SUMMARY], [PUBLISH_YEAR]) VALUES (N'MB0001', N'Tiếng Anh 10', N'Trần Phương', N'PH0003', 2, 30000, 16, N'Giáo trình', CAST(N'2013-06-01' AS Date))
INSERT [dbo].[BOOK] ([BOOK_ID], [NAME], [AUTHOR], [PH_ID], [BTYPE_ID], [PRICE], [AMOUNT], [SUMMARY], [PUBLISH_YEAR]) VALUES (N'MB0002', N'Tiếng Anh 11', N'Trần Phương', N'PH0003', 2, 40000, 6, N'Giáo trình', CAST(N'2013-06-01' AS Date))
INSERT [dbo].[BOOK] ([BOOK_ID], [NAME], [AUTHOR], [PH_ID], [BTYPE_ID], [PRICE], [AMOUNT], [SUMMARY], [PUBLISH_YEAR]) VALUES (N'MB0003', N'Thế giới phẳng', N'Thomas', N'PH0005', 6, 123000, 9, N'Tài liệu', CAST(N'1998-07-21' AS Date))
INSERT [dbo].[BOOK] ([BOOK_ID], [NAME], [AUTHOR], [PH_ID], [BTYPE_ID], [PRICE], [AMOUNT], [SUMMARY], [PUBLISH_YEAR]) VALUES (N'MB0004', N'Dế mèn phiêu lưu ký', N'Tô Hoài', N'PH0005', 3, 30000, 11, N'Truyện tranh', CAST(N'2019-05-31' AS Date))
SET IDENTITY_INSERT [dbo].[BOOK_TYPE] ON 

INSERT [dbo].[BOOK_TYPE] ([BTYPE_ID], [BTYPE]) VALUES (1, N'Sách khoa học')
INSERT [dbo].[BOOK_TYPE] ([BTYPE_ID], [BTYPE]) VALUES (2, N'Sách tiếng anh')
INSERT [dbo].[BOOK_TYPE] ([BTYPE_ID], [BTYPE]) VALUES (3, N'Sách văn học')
INSERT [dbo].[BOOK_TYPE] ([BTYPE_ID], [BTYPE]) VALUES (4, N'Sách nước ngoài')
INSERT [dbo].[BOOK_TYPE] ([BTYPE_ID], [BTYPE]) VALUES (5, N'Sách tham khảo')
INSERT [dbo].[BOOK_TYPE] ([BTYPE_ID], [BTYPE]) VALUES (6, N'Sách kinh tế')
INSERT [dbo].[BOOK_TYPE] ([BTYPE_ID], [BTYPE]) VALUES (7, N'Sách xã hội học')
SET IDENTITY_INSERT [dbo].[BOOK_TYPE] OFF
INSERT [dbo].[BORROW_DETAILS] ([ID], [FORM_ID], [BOOK_ID], [AMOUNT]) VALUES (N'BFD004', N'BF0002', N'MB0001', 30000)
INSERT [dbo].[BORROW_DETAILS] ([ID], [FORM_ID], [BOOK_ID], [AMOUNT]) VALUES (N'BFD005', N'BF0002', N'MB0002', 40000)
INSERT [dbo].[BORROW_DETAILS] ([ID], [FORM_ID], [BOOK_ID], [AMOUNT]) VALUES (N'BFD006', N'BF0003', N'MB0001', 30000)
INSERT [dbo].[BORROW_DETAILS] ([ID], [FORM_ID], [BOOK_ID], [AMOUNT]) VALUES (N'BFD008', N'BF0005', N'MB0004', 25000)
INSERT [dbo].[BORROW_DETAILS] ([ID], [FORM_ID], [BOOK_ID], [AMOUNT]) VALUES (N'BFD019', N'BF0006', N'MB0002', 40000)
INSERT [dbo].[BORROW_DETAILS] ([ID], [FORM_ID], [BOOK_ID], [AMOUNT]) VALUES (N'BFD023', N'BF0005', N'MB0002', 40000)
INSERT [dbo].[BORROW_DETAILS] ([ID], [FORM_ID], [BOOK_ID], [AMOUNT]) VALUES (N'BFD024', N'BF0004', N'MB0003', 123000)
INSERT [dbo].[BORROW_DETAILS] ([ID], [FORM_ID], [BOOK_ID], [AMOUNT]) VALUES (N'BFD025', N'BF0003', N'MB0004', 25000)
INSERT [dbo].[BORROW_DETAILS] ([ID], [FORM_ID], [BOOK_ID], [AMOUNT]) VALUES (N'BFD026', N'BF0006', N'MB0003', 123000)
INSERT [dbo].[BORROW_DETAILS] ([ID], [FORM_ID], [BOOK_ID], [AMOUNT]) VALUES (N'BFD027', N'BF0001', N'MB0003', 123000)
INSERT [dbo].[BORROW_FORM] ([FORM_ID], [READER_ID], [EMPLOYEE_ID], [LOAN_DATE], [EXP_DATE], [DEPOSIT]) VALUES (N'BF0001', N'DG0001', N'NV0002', CAST(N'2012-03-15' AS Date), CAST(N'2012-03-22' AS Date), 123000)
INSERT [dbo].[BORROW_FORM] ([FORM_ID], [READER_ID], [EMPLOYEE_ID], [LOAN_DATE], [EXP_DATE], [DEPOSIT]) VALUES (N'BF0002', N'DG0002', N'NV0003', CAST(N'2010-05-04' AS Date), CAST(N'2010-05-11' AS Date), 70000)
INSERT [dbo].[BORROW_FORM] ([FORM_ID], [READER_ID], [EMPLOYEE_ID], [LOAN_DATE], [EXP_DATE], [DEPOSIT]) VALUES (N'BF0003', N'DG0001', N'NV0002', CAST(N'2012-03-15' AS Date), CAST(N'2012-03-22' AS Date), 55000)
INSERT [dbo].[BORROW_FORM] ([FORM_ID], [READER_ID], [EMPLOYEE_ID], [LOAN_DATE], [EXP_DATE], [DEPOSIT]) VALUES (N'BF0004', N'DG0003', N'NV0002', CAST(N'2013-07-20' AS Date), CAST(N'2013-07-27' AS Date), 123000)
INSERT [dbo].[BORROW_FORM] ([FORM_ID], [READER_ID], [EMPLOYEE_ID], [LOAN_DATE], [EXP_DATE], [DEPOSIT]) VALUES (N'BF0005', N'DG0001', N'NV0002', CAST(N'2019-05-08' AS Date), CAST(N'2019-05-15' AS Date), 65000)
INSERT [dbo].[BORROW_FORM] ([FORM_ID], [READER_ID], [EMPLOYEE_ID], [LOAN_DATE], [EXP_DATE], [DEPOSIT]) VALUES (N'BF0006', N'DG0003', N'NV0002', CAST(N'2019-05-31' AS Date), CAST(N'2019-05-31' AS Date), 163000)
INSERT [dbo].[EMPLOYEE] ([EMPLOYEE_ID], [USERNAME], [NAME], [EMPLOYEE_ADDRESS], [EMAIL], [PHONE_NUMBER], [DATE_OF_BIRTH], [GENDER]) VALUES (N'NV0001', N'account001', N'Nguyễn Hoàng Giang', N'477 Lê Hồng Phong', N'giang12021998@gmail.com', N'0389041102', CAST(N'1998-02-12' AS Date), N'Nam')
INSERT [dbo].[EMPLOYEE] ([EMPLOYEE_ID], [USERNAME], [NAME], [EMPLOYEE_ADDRESS], [EMAIL], [PHONE_NUMBER], [DATE_OF_BIRTH], [GENDER]) VALUES (N'NV0002', N'account002', N'Ngô Quỳnh Như', N'01 Hoa Mai', N'quynhnhu@gmail.com', N'0344158409', CAST(N'1999-02-09' AS Date), N'Nữ')
INSERT [dbo].[EMPLOYEE] ([EMPLOYEE_ID], [USERNAME], [NAME], [EMPLOYEE_ADDRESS], [EMAIL], [PHONE_NUMBER], [DATE_OF_BIRTH], [GENDER]) VALUES (N'NV0003', N'account003', N'Hồ Bích Phương', N'08 Mai Chí Thọ', N'bichphuong@gmail.com', N'0240578542', CAST(N'1995-12-12' AS Date), N'Nữ')
INSERT [dbo].[PAY_DETAILS] ([ID], [FORM_ID], [BOOK_ID], [AMOUNT]) VALUES (N'PFD001', N'PF0001', N'MB0002', 0)
INSERT [dbo].[PAY_DETAILS] ([ID], [FORM_ID], [BOOK_ID], [AMOUNT]) VALUES (N'PFD002', N'PF0002', N'MB0003', 0)
INSERT [dbo].[PAY_DETAILS] ([ID], [FORM_ID], [BOOK_ID], [AMOUNT]) VALUES (N'PFD003', N'PF0003', N'MB0004', 0)
INSERT [dbo].[PAY_FORM] ([ID], [BORROW_ID], [EMPLOYEE_ID], [PAY_DATE]) VALUES (N'PF0001', N'BF0001', N'NV0002', CAST(N'2012-03-22' AS Date))
INSERT [dbo].[PAY_FORM] ([ID], [BORROW_ID], [EMPLOYEE_ID], [PAY_DATE]) VALUES (N'PF0002', N'BF0002', N'NV0003', CAST(N'2010-05-15' AS Date))
INSERT [dbo].[PAY_FORM] ([ID], [BORROW_ID], [EMPLOYEE_ID], [PAY_DATE]) VALUES (N'PF0003', N'BF0003', N'NV0002', CAST(N'2012-03-25' AS Date))
INSERT [dbo].[PUBLISHING_HOUSE] ([PH_ID], [NAME], [PH_ADDRESS], [PHONE_NUMBER], [EMAIL]) VALUES (N'PH0001', N'Kim đồng', N'123 Trần Phú', N'0123874123', N'kimdong@gmail.com')
INSERT [dbo].[PUBLISHING_HOUSE] ([PH_ID], [NAME], [PH_ADDRESS], [PHONE_NUMBER], [EMAIL]) VALUES (N'PH0002', N'Thiếu nhi', N'98 Lê Duẩn', N'0121268033', N'thieunhi@gmail.com')
INSERT [dbo].[PUBLISHING_HOUSE] ([PH_ID], [NAME], [PH_ADDRESS], [PHONE_NUMBER], [EMAIL]) VALUES (N'PH0003', N'Giáo dục', N'12 Hoàng Mai', N'011202547', N'giaoduc@gmail.com')
INSERT [dbo].[PUBLISHING_HOUSE] ([PH_ID], [NAME], [PH_ADDRESS], [PHONE_NUMBER], [EMAIL]) VALUES (N'PH0004', N'Nhi đồng', N'17 Đường Yên', N'0357410218', N'nhidong@gmail.com')
INSERT [dbo].[PUBLISHING_HOUSE] ([PH_ID], [NAME], [PH_ADDRESS], [PHONE_NUMBER], [EMAIL]) VALUES (N'PH0005', N'Văn hóa', N'05 Điện Biên Phủ', N'0245725001', N'vanhoa@gmail.com')
INSERT [dbo].[READER] ([READER_ID], [NAME], [DATE_OF_BIRTH], [READER_ADDRESS], [GENDER], [PHONE_NUMBER], [EMAIL]) VALUES (N'DG0001', N'Nguyễn Hoàng Giang', CAST(N'1998-02-12' AS Date), N'477 Lê Hồng Phong', N'Nam', N'0381923102', N'giang@gmail.com')
INSERT [dbo].[READER] ([READER_ID], [NAME], [DATE_OF_BIRTH], [READER_ADDRESS], [GENDER], [PHONE_NUMBER], [EMAIL]) VALUES (N'DG0002', N'Lê Hồ Nhi', CAST(N'2001-05-25' AS Date), N'13 Trần Phú', N'Nữ', N'0351200157', N'honhi@gmail.com')
INSERT [dbo].[READER] ([READER_ID], [NAME], [DATE_OF_BIRTH], [READER_ADDRESS], [GENDER], [PHONE_NUMBER], [EMAIL]) VALUES (N'DG0003', N'Nguyễn Mạnh Cường', CAST(N'1999-03-08' AS Date), N'25 Điện Biên Phủ', N'Nam', N'0312356631', N'mcuong@gmail.com')
INSERT [dbo].[READER] ([READER_ID], [NAME], [DATE_OF_BIRTH], [READER_ADDRESS], [GENDER], [PHONE_NUMBER], [EMAIL]) VALUES (N'DG0004', N'Trần Như Quỳnh', CAST(N'1990-01-15' AS Date), N'08 Hoàng Diệu', N'Nữ', N'0324515417', N'nhuquynh@gmail.com')
INSERT [dbo].[READER] ([READER_ID], [NAME], [DATE_OF_BIRTH], [READER_ADDRESS], [GENDER], [PHONE_NUMBER], [EMAIL]) VALUES (N'DG0005', N'Trần Chí', CAST(N'1989-03-26' AS Date), N'117 Lê Xuân Thọ', N'Nam', N'0396514008', N'thongtran@gmail.com')
/****** Object:  FullTextIndex     Script Date: 6/24/2019 3:15:02 PM ******/
CREATE FULLTEXT INDEX ON [dbo].[BOOK](
[AUTHOR] LANGUAGE 'Vietnamese', 
[BOOK_ID] LANGUAGE 'Vietnamese', 
[NAME] LANGUAGE 'Vietnamese', 
[PH_ID] LANGUAGE 'Vietnamese', 
[SUMMARY] LANGUAGE 'Vietnamese')
KEY INDEX [PK__BOOK__054D27E47A2E69D9]ON ([booktypeCatalog], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)


GO
/****** Object:  FullTextIndex     Script Date: 6/24/2019 3:15:02 PM ******/
CREATE FULLTEXT INDEX ON [dbo].[BOOK_TYPE](
[BTYPE] LANGUAGE 'Vietnamese')
KEY INDEX [PK__BOOK_TYP__F5B0DA4ABB0C8E57]ON ([booktypeCatalog], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)


GO
/****** Object:  FullTextIndex     Script Date: 6/24/2019 3:15:02 PM ******/
CREATE FULLTEXT INDEX ON [dbo].[PUBLISHING_HOUSE](
[EMAIL] LANGUAGE 'English', 
[NAME] LANGUAGE 'English', 
[PH_ADDRESS] LANGUAGE 'English', 
[PH_ID] LANGUAGE 'English', 
[PHONE_NUMBER] LANGUAGE 'English')
KEY INDEX [PK__PUBLISHI__D139182ADA5C0F44]ON ([booktypeCatalog], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)


GO
/****** Object:  FullTextIndex     Script Date: 6/24/2019 3:15:02 PM ******/
CREATE FULLTEXT INDEX ON [dbo].[READER](
[EMAIL] LANGUAGE 'Vietnamese', 
[GENDER] LANGUAGE 'Vietnamese', 
[NAME] LANGUAGE 'Vietnamese', 
[PHONE_NUMBER] LANGUAGE 'Vietnamese', 
[READER_ADDRESS] LANGUAGE 'Vietnamese', 
[READER_ID] LANGUAGE 'Vietnamese')
KEY INDEX [PK__READER__7C6E39BA3DF7FD9B]ON ([booktypeCatalog], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)


GO
ALTER TABLE [dbo].[BLACK_LIST]  WITH CHECK ADD  CONSTRAINT [FK_READER_BLACKLIST] FOREIGN KEY([READER_ID])
REFERENCES [dbo].[READER] ([READER_ID])
GO
ALTER TABLE [dbo].[BLACK_LIST] CHECK CONSTRAINT [FK_READER_BLACKLIST]
GO
ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD  CONSTRAINT [FK_BOOKTYPE_BOOK] FOREIGN KEY([BTYPE_ID])
REFERENCES [dbo].[BOOK_TYPE] ([BTYPE_ID])
GO
ALTER TABLE [dbo].[BOOK] CHECK CONSTRAINT [FK_BOOKTYPE_BOOK]
GO
ALTER TABLE [dbo].[BOOK]  WITH CHECK ADD  CONSTRAINT [FK_PHOUSE_BOOK] FOREIGN KEY([PH_ID])
REFERENCES [dbo].[PUBLISHING_HOUSE] ([PH_ID])
GO
ALTER TABLE [dbo].[BOOK] CHECK CONSTRAINT [FK_PHOUSE_BOOK]
GO
ALTER TABLE [dbo].[BORROW_DETAILS]  WITH CHECK ADD  CONSTRAINT [FK_BOOK_BORROWDETAILS] FOREIGN KEY([BOOK_ID])
REFERENCES [dbo].[BOOK] ([BOOK_ID])
GO
ALTER TABLE [dbo].[BORROW_DETAILS] CHECK CONSTRAINT [FK_BOOK_BORROWDETAILS]
GO
ALTER TABLE [dbo].[BORROW_DETAILS]  WITH CHECK ADD  CONSTRAINT [FK_BORROWFORM_BORROWDETAILS] FOREIGN KEY([FORM_ID])
REFERENCES [dbo].[BORROW_FORM] ([FORM_ID])
GO
ALTER TABLE [dbo].[BORROW_DETAILS] CHECK CONSTRAINT [FK_BORROWFORM_BORROWDETAILS]
GO
ALTER TABLE [dbo].[BORROW_FORM]  WITH CHECK ADD  CONSTRAINT [FK_EMPLOYEE_BORROW_FORM] FOREIGN KEY([EMPLOYEE_ID])
REFERENCES [dbo].[EMPLOYEE] ([EMPLOYEE_ID])
GO
ALTER TABLE [dbo].[BORROW_FORM] CHECK CONSTRAINT [FK_EMPLOYEE_BORROW_FORM]
GO
ALTER TABLE [dbo].[BORROW_FORM]  WITH CHECK ADD  CONSTRAINT [FK_READER_BORROW_FORM] FOREIGN KEY([READER_ID])
REFERENCES [dbo].[READER] ([READER_ID])
GO
ALTER TABLE [dbo].[BORROW_FORM] CHECK CONSTRAINT [FK_READER_BORROW_FORM]
GO
ALTER TABLE [dbo].[EMPLOYEE]  WITH CHECK ADD  CONSTRAINT [FK_ACCOUNT_EMPLOYEE] FOREIGN KEY([USERNAME])
REFERENCES [dbo].[ACCOUNT] ([USERNAME])
GO
ALTER TABLE [dbo].[EMPLOYEE] CHECK CONSTRAINT [FK_ACCOUNT_EMPLOYEE]
GO
ALTER TABLE [dbo].[PAY_DETAILS]  WITH CHECK ADD  CONSTRAINT [FK_BOOK_PAYDETAILS] FOREIGN KEY([BOOK_ID])
REFERENCES [dbo].[BOOK] ([BOOK_ID])
GO
ALTER TABLE [dbo].[PAY_DETAILS] CHECK CONSTRAINT [FK_BOOK_PAYDETAILS]
GO
ALTER TABLE [dbo].[PAY_DETAILS]  WITH CHECK ADD  CONSTRAINT [FK_PAYFORM_PAYDETAILS] FOREIGN KEY([FORM_ID])
REFERENCES [dbo].[PAY_FORM] ([ID])
GO
ALTER TABLE [dbo].[PAY_DETAILS] CHECK CONSTRAINT [FK_PAYFORM_PAYDETAILS]
GO
ALTER TABLE [dbo].[PAY_FORM]  WITH CHECK ADD  CONSTRAINT [FK_BORRROWFORM_PAYFORM] FOREIGN KEY([BORROW_ID])
REFERENCES [dbo].[BORROW_FORM] ([FORM_ID])
GO
ALTER TABLE [dbo].[PAY_FORM] CHECK CONSTRAINT [FK_BORRROWFORM_PAYFORM]
GO
/****** Object:  Trigger [dbo].[tr_NextAccountID]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create trigger [dbo].[tr_NextAccountID] on [dbo].[ACCOUNT]
for insert
as
	begin
		DECLARE @lastID varchar(10)
		SET @lastID = (SELECT TOP 1 USERNAME from [ACCOUNT] order by USERNAME desc)
		UPDATE [ACCOUNT] set USERNAME = dbo.func_NextAccountID(@lastID,'account',10) where USERNAME =''
	end


GO
/****** Object:  Trigger [dbo].[tr_NextBOOKID]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create trigger [dbo].[tr_NextBOOKID] on [dbo].[BOOK]
for insert
as
	begin
		DECLARE @lastID varchar(6)
		SET @lastID = (SELECT TOP 1 BOOK_ID from [BOOK] order by BOOK_ID desc)
		UPDATE [BOOK] set BOOK_ID = dbo.func_NextID(@lastID,'MB',6) where BOOK_ID =''
	end


GO
/****** Object:  Trigger [dbo].[tr_NextBorrowFormDetailsID]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create trigger [dbo].[tr_NextBorrowFormDetailsID] on [dbo].[BORROW_DETAILS]
for insert
as
	begin
		DECLARE @lastID varchar(6)
		SET @lastID = (SELECT TOP 1 ID from [BORROW_DETAILS] order by ID desc)
		UPDATE [BORROW_DETAILS] set ID = dbo.func_NextID(@lastID,'BFD',6) where ID =''
	end


GO
/****** Object:  Trigger [dbo].[tr_NextBorrowFormID]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create trigger [dbo].[tr_NextBorrowFormID] on [dbo].[BORROW_FORM]
for insert
as
	begin
		DECLARE @lastID varchar(6)
		SET @lastID = (SELECT TOP 1 FORM_ID from [BORROW_FORM] order by FORM_ID desc)
		UPDATE [BORROW_FORM] set FORM_ID = dbo.func_NextID(@lastID,'BF',6) where FORM_ID =''
	end


GO
/****** Object:  Trigger [dbo].[tr_NextEmployeeID]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create trigger [dbo].[tr_NextEmployeeID] on [dbo].[EMPLOYEE]
for insert
as
	begin
		DECLARE @lastID varchar(6)
		SET @lastID = (SELECT TOP 1 EMPLOYEE_ID from [EMPLOYEE] order by EMPLOYEE_ID desc)
		UPDATE [EMPLOYEE] set EMPLOYEE_ID = dbo.func_NextID(@lastID,'NV',6) where EMPLOYEE_ID =''
	end


GO
/****** Object:  Trigger [dbo].[tr_NextPayFormDetailsID]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create trigger [dbo].[tr_NextPayFormDetailsID] on [dbo].[PAY_DETAILS]
for insert
as
	begin
		DECLARE @lastID varchar(6)
		SET @lastID = (SELECT TOP 1 ID from [PAY_DETAILS] order by ID desc)
		UPDATE [PAY_DETAILS] set ID = dbo.func_NextID(@lastID,'PFD',6) where ID =''
	end


GO
/****** Object:  Trigger [dbo].[tr_NextPayFormID]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create trigger [dbo].[tr_NextPayFormID] on [dbo].[PAY_FORM]
for insert
as
	begin
		DECLARE @lastID varchar(6)
		SET @lastID = (SELECT TOP 1 ID from [PAY_FORM] order by ID desc)
		UPDATE [PAY_FORM] set ID = dbo.func_NextID(@lastID,'PF',6) where ID =''
	end


GO
/****** Object:  Trigger [dbo].[tr_NextPHHOUSEID]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create trigger [dbo].[tr_NextPHHOUSEID] on [dbo].[PUBLISHING_HOUSE]
for insert
as
	begin
		DECLARE @lastID varchar(6)
		SET @lastID = (SELECT TOP 1 PH_ID from [PUBLISHING_HOUSE] order by PH_ID desc)
		UPDATE [PUBLISHING_HOUSE] set PH_ID = dbo.func_NextID(@lastID,'PH',6) where PH_ID =''
	end


GO
/****** Object:  Trigger [dbo].[tr_NextREADERID]    Script Date: 6/24/2019 3:15:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create trigger [dbo].[tr_NextREADERID] on [dbo].[READER]
for insert
as
	begin
		DECLARE @lastID varchar(6)
		SET @lastID = (SELECT TOP 1 READER_ID from [READER] order by READER_ID desc)
		UPDATE [READER] set READER_ID = dbo.func_NextID(@lastID,'DG',6) where READER_ID =''
	end


GO
USE [master]
GO
ALTER DATABASE [LIBRARY] SET  READ_WRITE 
GO
