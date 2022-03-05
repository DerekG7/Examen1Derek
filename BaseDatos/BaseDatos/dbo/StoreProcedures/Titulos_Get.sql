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


