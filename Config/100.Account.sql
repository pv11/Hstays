
-- drop table Account

if object_id('Account') is null
create table Account(
	Id						int not null identity(3000,1) primary key,
	HotelId					uniqueidentifier not null,
	Active					bit not null default 1,
	Code					nvarchar(100) not null, 
	Description				nvarchar(100) not null,

	TransactionDirection	int,											--  1=CREDIT  -1=DEBIT

	RevenueAccount1			varchar(100) null,
	RevenueAccount2			varchar(100) null,
	RevenueAccount3			varchar(100) null,
	RevenueAccount4			varchar(100) null,
	RevenueAccount5			varchar(100) null,
	
	TaxAccount1				varchar(100) null,
	TaxAccount2				varchar(100) null,
	TaxAccount3				varchar(100) null,
	TaxAccount4				varchar(100) null,
	TaxAccount5				varchar(100) null,

	Notes					varchar(max) null,

	Deleted					bit not null default 0,

	[CreatedByUserId]		int  null ,
	[UpdatedByUserId]		int  null ,

	[CreatedOn]				datetime default getdate(),
	[LastUpdate]			datetime default getdate()

)


if not exists(select * from Account)
 begin
	insert into Account (HotelId,Code,Description,TransactionDirection)
	values ('D348E3AF-D306-41D6-AB7F-840B1BC96819', 'ROOM', 'Room', 1),
	       ('D348E3AF-D306-41D6-AB7F-840B1BC96819', 'ROOM-DISC', 'Room Discount', -1),

		   ('D348E3AF-D306-41D6-AB7F-840B1BC96819', 'PAY', 'Payments', -1)

 end

 select * from Account
