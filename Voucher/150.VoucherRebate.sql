
if object_id('VoucherRebate') is null 
create table VoucherRebate(
	Id						int not null identity(1,1) primary key,
	VoucherType_Id			int not null references VoucherType(id),

	HotelId					uniqueidentifier not null,

	SortOrder				int,

	Code					varchar(50),
	Description				nvarchar(200),

	Quantity				int,

	SaleValidFrom			date,
	SaleValidTo				date,

	RedeemValidFrom			date,
	RedeemValidTo			date,
		
	[CreatedByUserId]		int null ,
	[UpdatedByUserId]		int null ,

	[CreatedOn]				datetime default getdate(),
	[LastUpdate]			datetime default getdate()

)

