USE [GentleMenShop]
GO
/****** Object:  Table [dbo].[ChiTietSanPham]    Script Date: 8/21/2021 6:52:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietSanPham](
	[maSP] [int] IDENTITY(1,1) NOT NULL,
	[maDanhMuc] [int] NULL,
	[tenSP] [nvarchar](30) NULL,
	[donGia] [int] NULL,
	[khuyenMai] [nvarchar](max) NULL,
	[thongTinSP] [ntext] NULL,
	[dungTich] [nvarchar](30) NULL,
	[hinhAnh] [nvarchar](max) NULL,
 CONSTRAINT [PK__ChiTietS__7A227A7A44FF419A] PRIMARY KEY CLUSTERED 
(
	[maSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[showSảnPhẩmTóc]    Script Date: 8/21/2021 6:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[showSảnPhẩmTóc]
as 
select * from ChiTietSanPham where maDanhMuc=9 or maDanhMuc=10
GO
/****** Object:  View [dbo].[showNướcHoa]    Script Date: 8/21/2021 6:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[showNướcHoa]
as
select * from ChiTietSanPham where maDanhMuc=4 or maDanhMuc=5
GO
/****** Object:  View [dbo].[showChămSócDa]    Script Date: 8/21/2021 6:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[showChămSócDa]
as
select *from ChiTietSanPham where maDanhMuc=7 or maDanhMuc=8
GO
/****** Object:  Table [dbo].[ChiTietHoaDon]    Script Date: 8/21/2021 6:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietHoaDon](
	[IDHD] [int] NOT NULL,
	[maSP] [int] NOT NULL,
	[donGia] [int] NULL,
	[soLuong] [int] NULL,
 CONSTRAINT [pk] PRIMARY KEY CLUSTERED 
(
	[IDHD] ASC,
	[maSP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[thongkebanhang]    Script Date: 8/21/2021 6:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[thongkebanhang]
as
select ChiTietSanPham.tenSP,ChiTietSanPham.hinhAnh ,ChiTietSanPham.donGia,SUM(ChiTietHoaDon.soLuong) as 'Số lượng mua',
sum(ChiTietHoaDon.donGia*ChiTietHoaDon.soLuong) as N'Doanh Thu',
SUM(ChiTietHoaDon.donGia*ChiTietHoaDon.soLuong*0.5) as N'Lợi Nhuận'
from ChiTietSanPham  inner join ChiTietHoaDon on ChiTietSanPham.maSP=ChiTietHoaDon.maSP
group by tenSP,ChiTietSanPham.donGia,ChiTietSanPham.hinhAnh
GO
/****** Object:  View [dbo].[showSanPhamMoi]    Script Date: 8/21/2021 6:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[showSanPhamMoi]
as
select *from ChiTietSanPham where donGia >= 320000
GO
/****** Object:  View [dbo].[showSanPhamHotSale]    Script Date: 8/21/2021 6:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[showSanPhamHotSale]
as
select *from ChiTietSanPham where donGia <= 320000
GO
/****** Object:  Table [dbo].[Users]    Script Date: 8/21/2021 6:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[IDDN] [int] IDENTITY(1,1) NOT NULL,
	[tenDN] [nvarchar](30) NULL,
	[email] [nvarchar](30) NULL,
	[diaChi] [nvarchar](30) NULL,
	[sdt] [nvarchar](15) NULL,
	[matkhauDN] [nvarchar](30) NULL,
	[quyen] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IDDN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[thongkenguoidung]    Script Date: 8/21/2021 6:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[thongkenguoidung]
as
select Count(IDDN) as 'tong nguoi dung'
from Users
GO
/****** Object:  View [dbo].[thongkesanpham]    Script Date: 8/21/2021 6:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[thongkesanpham]
as
select Count(maSP) as 'tổng sản phẩm'
from ChiTietSanPham
GO
/****** Object:  Table [dbo].[HoaDon]    Script Date: 8/21/2021 6:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoaDon](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDDN] [int] NULL,
	[tenDN] [nvarchar](20) NULL,
	[sdt] [nvarchar](15) NULL,
	[ngayDat] [datetime] NULL,
	[diaChiNhan] [nvarchar](30) NULL,
	[tongTien] [int] NULL,
	[trangThai] [bit] NULL,
 CONSTRAINT [PK__HoaDon__3214EC2742E1EEFE] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[thongkehoadon]    Script Date: 8/21/2021 6:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[thongkehoadon]
as
select Count(ID) as 'tổng số hoá đơn'
from HoaDon
GO
/****** Object:  View [dbo].[thongkedoanhthu]    Script Date: 8/21/2021 6:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[thongkedoanhthu]
as
select Sum(ChiTietHoaDon.donGia*ChiTietHoaDon.soLuong) as 'tổng doanh thu'
from ChiTietSanPham  inner join ChiTietHoaDon on ChiTietSanPham.maSP=ChiTietHoaDon.maSP
GO
/****** Object:  Table [dbo].[Blog]    Script Date: 8/21/2021 6:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[maTin] [int] IDENTITY(1,1) NOT NULL,
	[tieuDe] [nvarchar](max) NULL,
	[hinhAnh] [nvarchar](max) NULL,
	[noiDung] [nvarchar](max) NULL,
	[ngayDangTin] [nvarchar](20) NULL,
	[tacGia] [nvarchar](30) NULL,
PRIMARY KEY CLUSTERED 
(
	[maTin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhMucSanPham]    Script Date: 8/21/2021 6:52:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhMucSanPham](
	[maDanhMuc] [int] IDENTITY(1,1) NOT NULL,
	[tenDanhMuc] [nvarchar](30) NULL,
	[maThuongHieu] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[maDanhMuc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [fk_ChiTietHoaDon] FOREIGN KEY([IDHD])
REFERENCES [dbo].[HoaDon] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [fk_ChiTietHoaDon]
GO
ALTER TABLE [dbo].[ChiTietHoaDon]  WITH CHECK ADD  CONSTRAINT [fk_ChiTietHoaDonSP] FOREIGN KEY([maSP])
REFERENCES [dbo].[ChiTietSanPham] ([maSP])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietHoaDon] CHECK CONSTRAINT [fk_ChiTietHoaDonSP]
GO
ALTER TABLE [dbo].[ChiTietSanPham]  WITH CHECK ADD  CONSTRAINT [fk_ChiTietSanPham_LoaiMyPham] FOREIGN KEY([maDanhMuc])
REFERENCES [dbo].[DanhMucSanPham] ([maDanhMuc])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietSanPham] CHECK CONSTRAINT [fk_ChiTietSanPham_LoaiMyPham]
GO
ALTER TABLE [dbo].[HoaDon]  WITH CHECK ADD  CONSTRAINT [fk_HoaDon_KH] FOREIGN KEY([IDDN])
REFERENCES [dbo].[Users] ([IDDN])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HoaDon] CHECK CONSTRAINT [fk_HoaDon_KH]
GO
