SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Order Details] (
		[OrderID]       [int] NOT NULL,
		[ProductID]     [int] NOT NULL,
		[UnitPrice]     [money] NOT NULL,
		[Quantity]      [smallint] NOT NULL,
		[Discount]      [real] NOT NULL
)
GO
ALTER TABLE [dbo].[Order Details]
	ADD
	CONSTRAINT [PK_Order_Details]
	PRIMARY KEY
	CLUSTERED
	([OrderID], [ProductID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Order Details]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_Discount]
	CHECK
	([Discount]>=(0) AND [Discount]<=(1))
GO
ALTER TABLE [dbo].[Order Details]
CHECK CONSTRAINT [CK_Discount]
GO
ALTER TABLE [dbo].[Order Details]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_Quantity]
	CHECK
	([Quantity]>(0))
GO
ALTER TABLE [dbo].[Order Details]
CHECK CONSTRAINT [CK_Quantity]
GO
ALTER TABLE [dbo].[Order Details]
	WITH NOCHECK
	ADD
	CONSTRAINT [CK_UnitPrice]
	CHECK
	([UnitPrice]>=(0))
GO
ALTER TABLE [dbo].[Order Details]
CHECK CONSTRAINT [CK_UnitPrice]
GO
ALTER TABLE [dbo].[Order Details]
	ADD
	CONSTRAINT [DF_Order_Details_UnitPrice]
	DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[Order Details]
	ADD
	CONSTRAINT [DF_Order_Details_Quantity]
	DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Order Details]
	ADD
	CONSTRAINT [DF_Order_Details_Discount]
	DEFAULT ((0)) FOR [Discount]
GO
ALTER TABLE [dbo].[Order Details]
	WITH NOCHECK
	ADD CONSTRAINT [FK_Order_Details_Orders]
	FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Orders] ([OrderID])
ALTER TABLE [dbo].[Order Details]
	CHECK CONSTRAINT [FK_Order_Details_Orders]

GO
ALTER TABLE [dbo].[Order Details]
	WITH NOCHECK
	ADD CONSTRAINT [FK_Order_Details_Products]
	FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
ALTER TABLE [dbo].[Order Details]
	CHECK CONSTRAINT [FK_Order_Details_Products]

GO
CREATE NONCLUSTERED INDEX [OrderID]
	ON [dbo].[Order Details] ([OrderID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [OrdersOrder_Details]
	ON [dbo].[Order Details] ([OrderID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ProductID]
	ON [dbo].[Order Details] ([ProductID])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ProductsOrder_Details]
	ON [dbo].[Order Details] ([ProductID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[Order Details] SET (LOCK_ESCALATION = TABLE)
GO
