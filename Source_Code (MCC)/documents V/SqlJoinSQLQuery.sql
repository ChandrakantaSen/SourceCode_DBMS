
/****** Object:  Table [dbo].[tblCustomer]    Script Date: 10/18/2012 23:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCustomer](
	[CustID] [int] NOT NULL,
	[Name] [varchar](100) NULL,
	[Address] [varchar](200) NULL,
	[ContactNo] [varchar](20) NULL,
 CONSTRAINT [PK_tblCustomer] PRIMARY KEY CLUSTERED 
(
	[CustID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tblCustomer] ([CustID], [Name], [Address], [ContactNo]) VALUES (1, N'Sam', N'New Delhi', N'9555555555')
INSERT [dbo].[tblCustomer] ([CustID], [Name], [Address], [ContactNo]) VALUES (2, N'Rahul', N'Gurgaon', N'9666666666')
INSERT [dbo].[tblCustomer] ([CustID], [Name], [Address], [ContactNo]) VALUES (3, N'Hans', N'Noida', N'9444444444')
INSERT [dbo].[tblCustomer] ([CustID], [Name], [Address], [ContactNo]) VALUES (4, N'Jeetu', N'Delhi', N'9333333333')
INSERT [dbo].[tblCustomer] ([CustID], [Name], [Address], [ContactNo]) VALUES (5, N'Ankit', N'Noida', N'9222222222')
/****** Object:  Table [dbo].[tblProduct]    Script Date: 10/18/2012 23:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblProduct](
	[ProductID] [int] NOT NULL,
	[Name] [varchar](100) NULL,
	[UnitPrice] [float] NULL,
	[CatID] [int] NULL,
	[EntryDate] [datetime] NULL,
	[ExpiryDate] [datetime] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tblProduct] ([ProductID], [Name], [UnitPrice], [CatID], [EntryDate], [ExpiryDate]) VALUES (1, N'Dell Computer', 25000, 1, CAST(0x0000A0EC017C6D51 AS DateTime), CAST(0x0000A0EC017C6D51 AS DateTime))
INSERT [dbo].[tblProduct] ([ProductID], [Name], [UnitPrice], [CatID], [EntryDate], [ExpiryDate]) VALUES (2, N'HCL Computer', 20000, 1, CAST(0x0000A0EC017C9DE1 AS DateTime), CAST(0x0000A0EC017C9DE1 AS DateTime))
INSERT [dbo].[tblProduct] ([ProductID], [Name], [UnitPrice], [CatID], [EntryDate], [ExpiryDate]) VALUES (3, N'Apple Mobile', 40000, 3, CAST(0x0000A0EC017CBA59 AS DateTime), CAST(0x0000A0EC017CBA59 AS DateTime))
INSERT [dbo].[tblProduct] ([ProductID], [Name], [UnitPrice], [CatID], [EntryDate], [ExpiryDate]) VALUES (4, N'Samsung Mobile', 25000, 3, CAST(0x0000A0EC017CCECA AS DateTime), CAST(0x0000A0EC017CCECA AS DateTime))
INSERT [dbo].[tblProduct] ([ProductID], [Name], [UnitPrice], [CatID], [EntryDate], [ExpiryDate]) VALUES (5, N'Sony Laptop', 35000, 2, CAST(0x0000A0EC017CEA3B AS DateTime), CAST(0x0000A0EC017CEA3B AS DateTime))
INSERT [dbo].[tblProduct] ([ProductID], [Name], [UnitPrice], [CatID], [EntryDate], [ExpiryDate]) VALUES (6, N'Dell Laptop', 36000, 2, CAST(0x0000A0EC017CFC16 AS DateTime), CAST(0x0000A0EC017CFC16 AS DateTime))
INSERT [dbo].[tblProduct] ([ProductID], [Name], [UnitPrice], [CatID], [EntryDate], [ExpiryDate]) VALUES (7, N'HP Printer', 12000, 4, CAST(0x0000A0EC017D1C77 AS DateTime), CAST(0x0000A0EC017D1C77 AS DateTime))
INSERT [dbo].[tblProduct] ([ProductID], [Name], [UnitPrice], [CatID], [EntryDate], [ExpiryDate]) VALUES (8, N'Canon Printer', 10000, 4, CAST(0x0000A0EC017D32F8 AS DateTime), CAST(0x0000A0EC017D32F8 AS DateTime))
/****** Object:  Table [dbo].[tblOrder]    Script Date: 10/18/2012 23:45:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblOrder](
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NULL,
	[Price] [float] NULL,
	[CustomerID] [int] NULL,
	[ContactNo] [varchar](20) NULL,
 CONSTRAINT [PK_tblOrder] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[tblOrder] ([OrderID], [ProductID], [Quantity], [Price], [CustomerID], [ContactNo]) VALUES (1, 1, 6, 150000, 1, N'9555555555')
INSERT [dbo].[tblOrder] ([OrderID], [ProductID], [Quantity], [Price], [CustomerID], [ContactNo]) VALUES (2, 2, 4, 80000, 2, NULL)
INSERT [dbo].[tblOrder] ([OrderID], [ProductID], [Quantity], [Price], [CustomerID], [ContactNo]) VALUES (3, 2, 2, 40000, 3, N'9444444444')
INSERT [dbo].[tblOrder] ([OrderID], [ProductID], [Quantity], [Price], [CustomerID], [ContactNo]) VALUES (4, 3, 5, 200000, 4, N'9333333333')
INSERT [dbo].[tblOrder] ([OrderID], [ProductID], [Quantity], [Price], [CustomerID], [ContactNo]) VALUES (5, 5, 1, 35000, 5, N'9666666666')
/****** Object:  Default [DF_Product_EntryDate]    Script Date: 10/18/2012 23:45:47 ******/
ALTER TABLE [dbo].[tblProduct] ADD  CONSTRAINT [DF_Product_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
/****** Object:  Default [DF_Product_ExpiryDate]    Script Date: 10/18/2012 23:45:47 ******/
ALTER TABLE [dbo].[tblProduct] ADD  CONSTRAINT [DF_Product_ExpiryDate]  DEFAULT (getdate()) FOR [ExpiryDate]
GO
/****** Object:  ForeignKey [FK_tblOrder_tblCustomer]    Script Date: 10/18/2012 23:45:47 ******/
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD  CONSTRAINT [FK_tblOrder_tblCustomer] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[tblCustomer] ([CustID])
GO
ALTER TABLE [dbo].[tblOrder] CHECK CONSTRAINT [FK_tblOrder_tblCustomer]
GO
/****** Object:  ForeignKey [FK_tblProduct_tblCategory]    Script Date: 10/18/2012 23:45:47 ******/
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK_tblProduct_tblCategory] FOREIGN KEY([CatID])
REFERENCES [dbo].[tblCategory] ([CatID])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_tblProduct_tblCategory]
GO
