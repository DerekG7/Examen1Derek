using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Entity;
using Entity.dbo;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WBL;

namespace WebApplication.Pages.Instituto { 

    public class GridModel : PageModel
    {
        private readonly IInstitutoService InstitutoService;

        public GridModel(IInstitutoService InstitutoService)
        {
            this.InstitutoService = InstitutoService;
        }

        
        public IEnumerable<InstitutoEntity> GridList { get; set; } = new List<InstitutoEntity>();

        public string Mensaje { get; set; } = "";
        public async Task<IActionResult> OnGet()
        {
            try
            {
                GridList = await InstitutoService.Get();

                if (TempData.ContainsKey("Msg")) 
                {
                    Mensaje = TempData["Msg"] as string;
                }

                TempData.Clear();
                return Page();
            }
            catch (Exception ex)
            {

                return Content(ex.Message);
            }

        }

        public async Task<IActionResult> OnGetELiminar(int id)
        {
            try
            {

                var result = await InstitutoService.Delete(new() { 
                
                Id_Institucion=id
                });

                if (result.CodeError!=0)
                {
                    throw new Exception(result.MsgError);
                }

                TempData["Msg"] = "El registro ha sido eliminado";

                return Redirect("Grid");
                
            }
            catch (Exception ex)
            {

                return Content(ex.Message);
            }

        }

    }
}
