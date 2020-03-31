
if object_id('VoucherRedeem') is null 
create table VoucherRedeem(
	Id						int not null identity(1,1) primary key,
	Voucher_Id				int not null references Voucher(id),
	Rebate_Id				int     null references VoucherRebate(id),  -- if any
	TargetHotelId			uniqueidentifier,
	TargetReference			varchar(50),

	BusinessDate			date,

	PointOfSaleLocation		varchar(50),
	PointOfSaleUser			varchar(50),
	PointOfSaleCashbox		varchar(50),

	Quantity				decimal(19,4),
	UnitPrice				decimal(19,4),
	Amount					decimal(19,4),   -- negative: consumption; positive: correction

	Notes					nvarchar(max),
		
	[CreatedByUserId]		int null ,
	[UpdatedByUserId]		int null ,

	[CreatedOn]				datetime default getdate(),
	[LastUpdate]			datetime default getdate()

)

