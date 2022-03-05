using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WBL;
using Entity;
using Entity.dbo;

namespace WebApplication.Pages.Instituto
{
    public class EditModel : PageModel
    {
        private readonly IInstitutoService InstitutoService;

        public EditModel(IInstitutoService InstitutoService)
        {
            this.InstitutoService = InstitutoService;
        }


        [BindProperty(SupportsGet =true)]
        public int? id { get; set; }

        [BindProperty]
        public InstitutoEntity Entity { get; set; } = new InstitutoEntity();

        public async Task<IActionResult> OnGet()
        {
            try
            {
                if (id.HasValue)
                {
                    Entity = await InstitutoService.GetById(new() { Id_Institucion = id });
                }

                return Page();
            }
            catch (Exception ex)
            {

                return Content(ex.Message);
            }
        }

        public async Task<IActionResult> OnPostAsync()
        {
            try
            {
                if (Entity.Id_Institucion.HasValue)
                {
                    //Actualizar
                    var result = await InstitutoService.Update(Entity);

                    if (result.CodeError != 0)
                    {
                        throw new Exception(result.MsgError);
                    }

                    TempData["Msg"] = "El registro ha sido actualizado";
                }
                else
                {
                    //Nuevo Registro
                    var result = await InstitutoService.Create(Entity);

                    if (result.CodeError != 0)
                    {
                        throw new Exception(result.MsgError);
                    }

                    TempData["Msg"] = "El registro ha sido ingresado";

                }

                return RedirectToPage("Grid");
            }
            catch (Exception ex)
            {

                return Content(ex.Message);
            }
        }
    }
}
