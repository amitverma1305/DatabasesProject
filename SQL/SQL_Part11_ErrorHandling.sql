--Amit Verma
--SQL Basics Part-11
--Date: 06/22/2020

--Error Handling

select * from tblProduct
select * from tblProductSales

--Without Rollback
Create Procedure spSellProduct
@ProductId int,
@QuantityToSell int
as
Begin
 -- Check the stock available, for the product we want to sell
 Declare @StockAvailable int
 Select @StockAvailable = QtyAvailable 
 from tblProduct where ProductId = @ProductId
 
 -- Throw an error to the calling application, if enough stock is not available
 if(@StockAvailable < @QuantityToSell)
   Begin
  Raiserror('Not enough stock available',16,1)
   End
 -- If enough stock available
 Else
   Begin
    Begin Tran
         -- First reduce the quantity available
  Update tblProduct set QtyAvailable = (QtyAvailable - @QuantityToSell)
  where ProductId = @ProductId
  
  Declare @MaxProductSalesId int
  -- Calculate MAX ProductSalesId  
  Select @MaxProductSalesId = Case When 
          MAX(ProductSalesId) IS NULL 
          Then 0 else MAX(ProductSalesId) end 
         from tblProductSales
  -- Increment @MaxProductSalesId by 1, so we don't get a primary key violation
  Set @MaxProductSalesId = @MaxProductSalesId + 1
  Insert into tblProductSales values(@MaxProductSalesId, @ProductId, @QuantityToSell)
    Commit Tran
   End
End

execute spSellProduct 1, 

--With Roll Back using @@Error
Alter Procedure spSellProduct
@ProductId int,
@QuantityToSell int
as
Begin
 -- Check the stock available, for the product we want to sell
 Declare @StockAvailable int
 Select @StockAvailable = QtyAvailable 
 from tblProduct where ProductId = @ProductId
 
 -- Throw an error to the calling application, if enough stock is not available
 if(@StockAvailable < @QuantityToSell)
   Begin
  Raiserror('Not enough stock available',16,1)
   End
 -- If enough stock available
 Else
   Begin
    Begin Tran
         -- First reduce the quantity available
  Update tblProduct set QtyAvailable = (QtyAvailable - @QuantityToSell)
  where ProductId = @ProductId
  
  Declare @MaxProductSalesId int
  -- Calculate MAX ProductSalesId  
  Select @MaxProductSalesId = Case When 
          MAX(ProductSalesId) IS NULL 
          Then 0 else MAX(ProductSalesId) end 
         from tblProductSales
  -- Increment @MaxProductSalesId by 1, so we don't get a primary key violation
  Set @MaxProductSalesId = @MaxProductSalesId + 1
  Insert into tblProductSales values(@MaxProductSalesId, @ProductId, @QuantityToSell)
  if(@@ERROR <> 0)
  Begin
   Rollback Tran
   Print 'Rolled Back Transaction'
  End
  Else
  Begin
   Commit Tran 
   Print 'Committed Transaction'
  End
   End
End

/*Note: @@ERROR is cleared and reset on each statement execution. Check it immediately following the statement being 
verified, or save it to a local variable that can be checked later.*/

select * from tblProduct
select * from tblProductSales

--Error Handling using Try Catch
Alter Procedure spSellProduct
@ProductId int,
@QuantityToSell int
as
Begin
 -- Check the stock available, for the product we want to sell
 Declare @StockAvailable int
 Select @StockAvailable = QtyAvailable 
 from tblProduct where ProductId = @ProductId
 
 -- Throw an error to the calling application, if enough stock is not available
 if(@StockAvailable < @QuantityToSell)
   Begin
  Raiserror('Not enough stock available',16,1)
   End
 -- If enough stock available
 Else
   Begin
    Begin Try
     Begin Transaction
         -- First reduce the quantity available
  Update tblProduct set QtyAvailable = (QtyAvailable - @QuantityToSell)
  where ProductId = @ProductId
  
  Declare @MaxProductSalesId int
  -- Calculate MAX ProductSalesId  
  Select @MaxProductSalesId = Case When 
          MAX(ProductSalesId) IS NULL 
          Then 0 else MAX(ProductSalesId) end 
         from tblProductSales
  --Increment @MaxProductSalesId by 1, so we don't get a primary key violation
  Set @MaxProductSalesId = @MaxProductSalesId + 1
  Insert into tblProductSales values(@MaxProductSalesId, @ProductId, @QuantityToSell)
     Commit Transaction
    End Try
    Begin Catch 
  Rollback Transaction
  Select 
   ERROR_NUMBER() as ErrorNumber,
   ERROR_MESSAGE() as ErrorMessage,
   ERROR_PROCEDURE() as ErrorProcedure,
   ERROR_STATE() as ErrorState,
   ERROR_SEVERITY() as ErrorSeverity,
   ERROR_LINE() as ErrorLine
    End Catch 
   End
End


select * from tblProduct
select * from tblProductSales

exec spSellProduct 3,50