-- drop table DocumentLine; drop table DocumentRelation; drop table DocumentHeader; drop table DocumentType

if object_id('DocumentType') is null
create table DocumentType(
	Id						int not null identity(1,1) primary key,
	HotelId					uniqueidentifier not null,
	Name					nvarchar(100) not null, 
	Description				nvarchar(100) not null,

	IsFiscal				bit not null default 1,

	FiscalCode				varchar(50) not null default '',	-- example: RF
	FiscalSerialNumber		varchar(50) not null default '',	-- example: 2020100
																-- example of full invoice number: FR 2020100/123456
	StartingCounter			bigint not null default 0,
	CurrentCounter			bigint not null default 0,
	
	SerialGroup				varchar(20),						-- a way to automatically determine the CreditNote serial for a given Invoice serial, etc

	IsManual				bit not null default 0,				-- special document typ for invoice recovery (manual input after data loss)		
	ManualSufix				varchar(50) null,

	Modules					int not null default 0,											-- bitmask flag to allow or not this Item on each software module; 1=PMS; 2=POS; 4=EMS; 8=Other

	IsDeposit				bit not null default 0,
	IsWorkingDocument		bit not null default 0,				-- conference documents (statement, "consulta de mesa", etc)
	IsPaymentReceipt		bit not null default 0,

	IsActive				bit not null default 1,
	IsClosed				bit not null default 0,
	CloseDate				datetime null,

	Notes					nvarchar(100),

	SpecificHousetype_Id	int null,							-- automatically pick this serial depending on the current housetype

	DefaultLayout			int null,							

	SaftDocType				varchar(50),						-- fixed types: FT, FR, NC (Warning: depends on the country)
	SaftHash				nvarchar(1000) null,				-- future use

	
	[CreatedByUserId]		int not null references T_USER(id),
	[UpdatedByUserId]		int not null references T_USER(id),

	[CreatedOn]				datetime default getdate(),
	[LastUpdate]			datetime default getdate()

)

--  select * from T_INVOICE_SERIAL


--sp_help t_doc_sign