--  drop table VoucherLine; drop table Voucher; 

if object_id('Voucher') is null 
create table Voucher(
	Id						int not null identity(1,1) primary key,
	VoucherType_Id			int not null references VoucherType(id),

	SourceHotelId			uniqueidentifier not null,

	Ordinal					int,
	VoucherId				uniqueidentifier not null,  -- GUID

	[Status]				int,									-- 0=created; 10=SOLD;  20=REDEEMED ; 99=cancelled

	InvoiceReference		varchar(50),       --invoice (or equivalent) from PMS/POS side

	TransactionInProgress	bit,

	SalePrice				decimal(19,4),   -- 100 euros
	VoucherValue			decimal(19,4),   -- 120 euros

	ValidUntil				date,
	Notes					nvarchar(max),

	[CreatedByUserId]		int null ,
	[UpdatedByUserId]		int null ,

	[CreatedOn]				datetime default getdate(),
	[LastUpdate]			datetime default getdate()

)

