-- drop table DocumentLine

if object_id('DocumentLine') is null
create table DocumentLine(
	Id							int not null identity(1,1) primary key,

	DocumentHeader_Id			int not null references DocumentHeader(id),		-- this transaction belongs to the document
	
	ItemCode					varchar(20) not null,							-- a charge, a payment, etc. TODO: keep it as code, or change to
	PackageCode					varchar(20)     null,							-- if any

	TransactionType				int,											-- possible types: 0=charges;1=payments
	Pieces						decimal(19,4),
	PaxPieces					int,											-- number of persons, which makes sense only for package transactions
	UnitPrice					decimal(19,4),

	DiscountAmount				decimal(19,4),
	TotalAmount					decimal(19,4),									-- always local currency

	TransactionDate				date,											-- the business date that makes sense for this transaction; example, "today" we can be posting a transaction for "tomorrow", so "TransactionDate=tomorrow"
	CurrentBusinessDate			date,											-- the business date of the moment this transaction as created
	
	TaxAmount					decimal(19,4),									-- reason to have this here: tax percentage can change in the future; let's keep the exact value for the TransactionDate
	TaxCode						varchar(20),
	TaxPercentage				decimal(19,4),
	TaxExemptionCode			varchar(20) null,

	ForeignUnitPrice			decimal(19,4) null,
	ForeignDiscountAmount		decimal(19,4) null,
	ForeignTotalAmount			decimal(19,4) null,									
	ForeignTaxAmount			decimal(19,4) null,

	ForeignCurrencyCode			varchar(10) null,								-- if different from local currency

	IsAutomatic					bit not null default 0,							-- transactions originated from interfaces
	ExternalDescription			nvarchar(100) null,								-- example: telephone dialed
	ExternalReference			varchar(50) null,								-- avoiding duplication for interface transactions
	
	IsPackage					bit,
	PackageAggregator			int null,										-- ability to print (on invoice) two or more transactions as a single line

	PrintDescription			nvarchar(100),									-- if present, will override the default description

	ComplimentaryStatus			int,											-- 0=none; 1=complimentary; 2=house use
	IsVoid						bit not null default 0,							-- if True, this transaction voids an existing one (see: RelatedTransaction_Id)
	VoidReson					nvarchar(100),

	RelatedTransaction_Id		int null references DocumentLine(id),			-- can point to the original transaction in case of void; or to the deposit, in case of deposit usage

	OriginalReservation_Id		int null,
	OriginalRoomStay_Id			int null,
	Guest_id					int null,
	OriginalRoom_Id				int null,
	OriginalDocument_Id			int null references DocumentHeader(id),			-- useful to trace the origin of the transaction, when a transation is transferred

	RedirectedFromDocument_Id	int null references DocumentHeader(id),			-- the intended folio; due to a "billing instruction", the transaction was automatically posted in "DocumentHeader_Id"  instead of "RedirectedFromDocument_Id"
	

	StatPriceList				varchar(20),
	StatProfitCenter			varchar(20),
	StatFamily					varchar(20),
	StatSubFamily				varchar(20),
	StatChargeGroup				varchar(20),
	StatSegment					varchar(20),
	StatSubSegment				varchar(20),
	StatDistributionChannel		varchar(20),

	StatGuestNationality		varchar(20),
	
	RevenueAccount1				varchar(50),
	RevenueAccount2				varchar(50),
	RevenueAccount3				varchar(50),
	TaxAccount1					varchar(50),
	TaxAccount2					varchar(50),
	TaxAccount3					varchar(50),


	[CreatedByUserId]			int not null references T_USER(id),
	[UpdatedByUserId]			int not null references T_USER(id),

	[CreatedByCashboxId]		int not null references T_CASHBOX(id),
	[UpdatedByCashboxId]		int not null references T_CASHBOX(id),

	[CreatedOn]					datetime default getdate(),
	[LastUpdate]				datetime default getdate()
	
)

-- select top 100 * from t_booking order by id desc