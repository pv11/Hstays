-- drop table DocumentLine

if object_id('DocumentLine') is null
create table DocumentLine(
	Id							int not null identity(1,1) primary key,

	DocumentHeader_Id			int not null references DocumentHeader(id),		-- this transaction belongs to the document
	
	Item_Id						int not null references TransactionItem(id),									-- a charge, a payment, etc. 
	Package_Id					int     null,							-- if any

	Quantity					decimal(19,4),
	PaxPieces					int,											-- number of persons, which makes sense only for package transactions
	UnitPrice					decimal(19,4),

	DiscountPercent				decimal(19,4) null,								-- if any	

	DiscountAmount				decimal(19,4),									-- absolute value
	TotalAmount					decimal(19,4),									-- always local currency (Quantity*UnitPrice)-DiscountAmount

	TransactionDate				date,											-- the business date that makes sense for this transaction; example, "today" we can be posting a transaction for "tomorrow", so "TransactionDate=tomorrow"
	CurrentBusinessDate			date,											-- the business date of the moment this transaction as created
	
	TaxAmount					decimal(19,4),									-- reason to have this here: tax percentage can change in the future; let's keep the exact value for the TransactionDate
	Tax_Id						int	null references Tax(id),					-- not all transactions have tax
	TaxPercentage				decimal(19,4) null,								-- if any
	TaxExemption_Id				int null,										-- if any

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

	RelatedLine_Id				int null references DocumentLine(id),					-- can point to the original line in case of void; or to the deposit, in case of deposit usage

	OriginalReservation_Id		int null,
	OriginalRoomStay_Id			int null,
	Guest_id					int null,
	OriginalRoom_Id				int null,
	OriginalDocument_Id			int null references DocumentHeader(id),			-- useful to trace the origin of the transaction, when a transation is transferred

	RedirectedFromDocument_Id	int null references DocumentHeader(id),			-- the intended folio; due to a "billing instruction", the transaction was automatically posted in "DocumentHeader_Id"  instead of "RedirectedFromDocument_Id"
	

	[CreatedByUserId]			int  null ,
	[CreatedByCashboxId]		int  null ,
	[CreatedOn]					datetime default getdate()
	
)

-- select top 100 * from t_booking order by id desc