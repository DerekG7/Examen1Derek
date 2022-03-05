using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BD;
using Entity;
using Entity.dbo;

namespace WBL
{
    public interface IInstitutoService
    {
        Task<DBEntity> Create(InstitutoEntity entity);
        Task<DBEntity> Delete(InstitutoEntity entity);
        Task<IEnumerable<InstitutoEntity>> Get();
        Task<InstitutoEntity> GetById(InstitutoEntity entity);
        Task<DBEntity> Update(InstitutoEntity entity);
    }

    public class InstitutoService : IInstitutoService
    {

        private readonly IDataAccess sql;

        public InstitutoService(IDataAccess _sql)
        {
            sql = _sql;
        }


        public async Task<IEnumerable<InstitutoEntity>> Get()
        {
            try
            {
                var result = sql.QueryAsync<InstitutoEntity>("Instituto_Get");

                return await result;
            }
            catch (Exception)
            {

                throw;
            }

        }


        public async Task<InstitutoEntity> GetById(InstitutoEntity entity)
        {
            try
            {
                var result = sql.QueryFirstAsync<InstitutoEntity>("Instituto_Get", new
                {

                    entity.Id_Institucion
                });

                return await result;
            }
            catch (Exception)
            {

                throw;
            }

        }


        public async Task<DBEntity> Create(InstitutoEntity entity)
        {
            try
            {
                var result = sql.ExecuteAsync("Instituto_Insert", new
                {
                    entity.Codigo,
                    entity.Nombre,
                    entity.Telefono,
                    entity.Estado

                });

                return await result;
            }
            catch (Exception)
            {

                throw;
            }



        }

        public async Task<DBEntity> Update(InstitutoEntity entity)
        {
            try
            {
                var result = sql.ExecuteAsync("Instituto_Update", new
                {
                    entity.Id_Institucion,
                    entity.Codigo,
                    entity.Nombre,
                    entity.Telefono,
                    entity.Estado

                });

                return await result;
            }
            catch (Exception)
            {

                throw;
            }



        }

        public async Task<DBEntity> Delete(InstitutoEntity entity)
        {
            try
            {
                var result = sql.ExecuteAsync("Instituto_Delete", new
                {
                    entity.Id_Institucion,


                });

                return await result;
            }
            catch (Exception)
            {

                throw;
            }



        }
    }
}
