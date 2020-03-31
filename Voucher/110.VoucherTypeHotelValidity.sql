
if object_id('VoucherTypeHotelValidity') is null 
create table VoucherTypeHotelValidity(
	Id						int not null identity(1,1) primary key,
	
	VoucherType_Id			int not null references VoucherType(id),
	ValidTargetHotelId		uniqueidentifier not null
)

