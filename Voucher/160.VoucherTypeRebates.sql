
if object_id('VoucherTypeRebates') is null 
create table VoucherTypeRebates(
	Id						int not null identity(1,1) primary key,
	VoucherType_Id			int not null references VoucherType(id),

	VoucherRebate_Id		int not null references VoucherRebate(id),

)

