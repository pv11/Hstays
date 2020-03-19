--  drop table DocumentLine; drop table DocumentRelation; drop table DocumentType; drop table DocumentHeader

if object_id('DocumentHeader') is null -- filio, conta
create table DocumentHeader(
	Id						int not null identity(1,1) primary key,
	
	HotelId					uniqueidentifier not null,
	EntityId				uniqueidentifier not null,
	Reservation_Id			int null,
	RoomStay_Id				int null,
	Housetype_Id			int null,

	DocumentType_Id			int references DocumentType(id),
	DocumentNumber			bigint,									-- 12345678
	DocumentNumberFormatted varchar(100) null,						-- FR 2020100/12345678

	DocumentDate			date,
	
	IsMaster				bit not null default 0,					-- in a group, this is the "common" folio for all rooms
	IsClosed				bit not null default 0,

	GrossTotal				decimal(10,9),							-- import to calculate document Hash

	InfoText				varchar(100) null,
	InfoNumberOfRooms		int null,								-- useful for group reservations
	InfoNumberOfPax			int null,
	
	Voucher					varchar(50),

	InvoiceSignature		nvarchar(max),
	PrivateKeyVersion		int not null default 1,
	
	[CreatedByUserId]		int not null references T_USER(id),
	[UpdatedByUserId]		int not null references T_USER(id),

	[CreatedOn]				datetime default getdate(),
	[LastUpdate]			datetime default getdate()

)

