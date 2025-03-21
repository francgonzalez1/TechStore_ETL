USE [TechStore]
GO
/****** Object:  Table [dbo].[Clientes_Clasificados]    Script Date: 13/3/2025 17:10:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes_Clasificados](
	[id_cliente] [int] NOT NULL,
	[nombre_cliente] [nvarchar](50) NOT NULL,
	[codigo_pais] [varchar](2) NULL,
	[numero_compras] [int] NULL,
	[monto_total_compras] [decimal](38, 20) NULL,
	[clasificacion] [varchar](9) NOT NULL
) ON [PRIMARY]
GO
