using Final.Models;
using MailKit.Net.Smtp;
using MailKit;
using MimeKit;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Final.Controllers
{
    public class UsersExportController : Controller
    {
        private BaseForAuthorizeEntities db = new BaseForAuthorizeEntities();

        public ActionResult Index()
        {
            return View(db.User.ToList());
        }

    }
}
