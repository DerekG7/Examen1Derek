CREATE PROCEDURE [dbo].[Instituto_Get]
	@Id_Institucion INT= null

AS
BEGIN
  SET NOCOUNT ON

SELECT 
		Id_Institucion,
		Codigo,
		Nombre,
		Telefono,
		Estado
FROM Institucion
WHERE (@Id_Institucion IS NULL OR Id_Institucion=@Id_Institucion)

END
