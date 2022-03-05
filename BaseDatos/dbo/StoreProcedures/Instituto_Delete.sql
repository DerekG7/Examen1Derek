CREATE PROCEDURE [dbo].[Instituto_Delete]
@Id_Institucion INT
AS
  BEGIN 
  SET NOCOUNT ON

    BEGIN TRANSACTION TRASA

    BEGIN TRY
     
     DELETE FROM Institucion
     WHERE
          Id_Institucion=@Id_Institucion

       COMMIT TRANSACTION TRASA

          SELECT 0 AS CodeError, '' AS MsgError

    END TRY

    BEGIN CATCH
          SELECT 
                 ERROR_NUMBER() AS CodeError, 
                 ERROR_MESSAGE() AS MsgError
           ROLLBACK TRANSACTION TRASA    
    END CATCH

  END


