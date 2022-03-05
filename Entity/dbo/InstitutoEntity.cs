using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity.dbo
{
    public class InstitutoEntity:EN
    {
        public int? Id_Institucion { get; set; }
        public string Codigo { get; set; }
        public string Nombre { get; set; }
        public string Telefono { get; set; }
        
    }
}
