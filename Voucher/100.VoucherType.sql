
if object_id('VoucherType') is null 
create table VoucherType(
	Id						int not null identity(1,1) primary key,
	
	HotelId					uniqueidentifier not null,

	Code					varchar(50),
	Description				nvarchar(200),

	DefaultPrefix			varchar(20),

	IsPaymentMode			bit, 
	AllowPartialRedeem		bit,

	SalesHasTax				bit,

	MaxQuantity				int

)

