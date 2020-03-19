-- drop table TransactionItem

if object_id('TransactionItem') is null
create table TransactionItem(
	Id							int not null identity(1,1) primary key,
	HotelId						uniqueidentifier not null,

	Code						nvarchar(100) not null, 
	Description					nvarchar(100) not null,

	ItemType					int,											-- 0=charge;  1=payment
	Account_Id					int not null references Account(id),
	Tax_Id						int     null references Tax(id),

	Modules						int not null default 1,											-- bitmask flag to allow or not this Item on each software module; 1=PMS; 2=POS; 4=EMS; 8=Other
	
	DefaultPrice				decimal(19,4) null,
	DefaultTExExemption_id		int null,

	SortOrder					int not null default 100,
	Notes						varchar(max) null,
	IsActive					bit not null default 1,
	Deleted						bit not null default 0,


	[CreatedByUserId]			int  null,
	[UpdatedByUserId]			int  null,

	[CreatedOn]					datetime default getdate(),
	[LastUpdate]				datetime default getdate()
	
)


if not exists(select * from TransactionItem)
 begin
	insert into TransactionItem (HotelId,Code,Description, ItemType, Account_Id, Tax_id)
	values ( 'D348E3AF-D306-41D6-AB7F-840B1BC96819','ROOM', 'Room', 0,  (select top 1 id from Account where code = 'ROOM')  ,  (select top 1 id from Tax where code = 'RED')  ),
	       ( 'D348E3AF-D306-41D6-AB7F-840B1BC96819','BF', 'Breakfast', 0,  (select top 1 id from Account where code = 'ROOM')  ,  (select top 1 id from Tax where code = 'INT')  ),
		   ( 'D348E3AF-D306-41D6-AB7F-840B1BC96819','CASH', 'Cash', 1,  (select top 1 id from Account where code = 'PAY')  ,  NULL  )


 end


-- select top 100 * from t_booking order by id desc

select * from TransactionItem


