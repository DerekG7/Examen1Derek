/*
Script de implementación para LaboratorioProgra6

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "LaboratorioProgra6"
:setvar DefaultFilePrefix "LaboratorioProgra6"
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
PRINT N'Modificando Procedimiento [dbo].[MarcaVehiculoActualizar]...';


GO
ALTER PROCEDURE [dbo].[MarcaVehiculoActualizar]
@MarcaVehiculoId INT,
@Descripcion VARCHAR(250),
@Estado BIT

AS
  BEGIN 
  SET NOCOUNT ON

    BEGIN TRANSACTION TRASA

    BEGIN TRY

       UPDATE MarcaVehiculo
       SET
       Descripcion=@Descripcion,
       Estado=@Estado
       WHERE 
           MarcaVehiculoId=@MarcaVehiculoId

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
PRINT N'Modificando Procedimiento [dbo].[MarcaVehiculoEliminar]...';


GO
ALTER PROCEDURE [dbo].[MarcaVehiculoEliminar]
@MarcaVehiculoId INT
AS
  BEGIN 
  SET NOCOUNT ON

    BEGIN TRANSACTION TRASA

    BEGIN TRY
     
     DELETE FROM MarcaVehiculo
     WHERE
         MarcaVehiculoId=@MarcaVehiculoId

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
PRINT N'Modificando Procedimiento [dbo].[MarcaVehiculoInsertar]...';


GO
ALTER PROCEDURE [dbo].[MarcaVehiculoInsertar]
@Descripcion VARCHAR(250),
@Estado BIT

AS
  BEGIN 
  SET NOCOUNT ON

    BEGIN TRANSACTION TRASA

    BEGIN TRY
       INSERT INTO MarcaVehiculo
       ( Descripcion, Estado)
       VALUES
       (@Descripcion, @Estado)


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
PRINT N'Modificando Procedimiento [dbo].[MarcaVehiculoObtener]...';


GO
ALTER PROCEDURE [dbo].[MarcaVehiculoObtener]
	@MarcaVehiculoId INT=NULL
AS
BEGIN
  SET NOCOUNT ON

SELECT 
      MarcaVehiculoId
	, Descripcion
	, Estado
FROM MarcaVehiculo
WHERE (@MarcaVehiculoId IS NULL OR MarcaVehiculoId=@MarcaVehiculoId)

END
GO
PRINT N'Actualización completada.';


GO
