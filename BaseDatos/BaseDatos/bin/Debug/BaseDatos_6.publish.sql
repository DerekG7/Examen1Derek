/*
Script de implementación para Examen1

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Examen1"
:setvar DefaultFilePrefix "Examen1"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creando Procedimiento [dbo].[Titulos_Delete]...';


GO
CREATE PROCEDURE [dbo].[Titulos_Delete]
@Id_Titulo INT
AS
  BEGIN 
  SET NOCOUNT ON

    BEGIN TRANSACTION TRASA

    BEGIN TRY
     
     DELETE FROM Titulos
     WHERE
         Id_Titulo=@Id_Titulo

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
GO
PRINT N'Creando Procedimiento [dbo].[Titulos_Get]...';


GO
CREATE PROCEDURE [dbo].[Titulos_Get]
	@Id_Titulo INT= null

AS
BEGIN
  SET NOCOUNT ON

SELECT 
		Id_Titulo,
		Descripcion,
		Estado
FROM Titulos
WHERE (@Id_Titulo IS NULL OR Id_Titulo=@Id_Titulo)

END
GO
PRINT N'Creando Procedimiento [dbo].[Titulos_Insert]...';


GO
CREATE PROCEDURE dbo.Titulos_Insert
    
	@Descripcion varchar(250),	
	@Estado BIT
	
AS BEGIN
SET NOCOUNT ON

	BEGIN TRANSACTION TRASA

	BEGIN TRY

		
		INSERT INTO dbo.Titulos
		(
	    Descripcion
	    , Estado 		
		)
		VALUES
		( 
		   @Descripcion  
	    , @Estado 
		
		)

		COMMIT TRANSACTION TRASA
		
		SELECT 0 AS CodeError, '' AS MsgError

	END TRY

	BEGIN CATCH
		SELECT 
				ERROR_NUMBER() AS CodeError
			,	ERROR_MESSAGE() AS MsgError

			ROLLBACK TRANSACTION TRASA
	END CATCH


END
GO
PRINT N'Creando Procedimiento [dbo].[Titulos_Update]...';


GO
create PROCEDURE [dbo].[Titulos_Update]
@Id_Titulo INT,
@Descripcion VARCHAR(250),
@Estado BIT

AS
  BEGIN 
  SET NOCOUNT ON

    BEGIN TRANSACTION TRASA

    BEGIN TRY

       UPDATE Titulos
       SET
       Descripcion=@Descripcion,
       Estado=@Estado
       WHERE 
           Id_Titulo=@Id_Titulo

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
GO
PRINT N'Actualización completada.';


GO
