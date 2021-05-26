using Final.Models;
using Rotativa;
using System.Linq;
using System.Web.Mvc;

namespace Final.Controllers
{
    public class UsersPrintController : Controller
    {
        private BaseForAuthorizeEntities db = new BaseForAuthorizeEntities();

        public ActionResult Index()
        {
            return View(db.User.ToList());
        }

        public ActionResult Header()
        {
            return PartialView();
        }

        public ActionResult PrintIndex()
        {
            return PartialView(db.User.ToList());
        }

        public ActionResult Print()
        {
            return new ViewAsPdf
            {
                ViewName = "PrintIndex",
                PageSize = Rotativa.Options.Size.A4,
                Model = db.User.ToList(),
                CustomSwitches = $"--header-html \"{Url.Action("Header", "UsersPrint", new { area = "" }, "http")}\""
            };
        }

    }
}
