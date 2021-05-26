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
    public class UsersMailController : Controller
    {
        public static string RenderViewToString(string controllerName, string viewName, object viewData)
        {
            using (var writer = new StringWriter())
            {
                var routeData = new RouteData();
                routeData.Values.Add("controller", controllerName);
                var fakeControllerContext = new ControllerContext(new HttpContextWrapper(new HttpContext(new HttpRequest(null, "http://google.com", null), new HttpResponse(null))), routeData, new UsersMailController());
                var razorViewEngine = new RazorViewEngine();
                var razorViewResult = razorViewEngine.FindView(fakeControllerContext, viewName, "", false);

                var viewContext = new ViewContext(fakeControllerContext, razorViewResult.View, new ViewDataDictionary(viewData), new TempDataDictionary(), writer);
                razorViewResult.View.Render(viewContext, writer);
                return writer.ToString();

            }
        }

        private BaseForAuthorizeEntities db = new BaseForAuthorizeEntities();

        public ActionResult Index()
        {
            return View(db.User.ToList());
        }

        //public ActionResult Letter(int? id)
        //{
        //    if (id != null)
        //    {
        //        User user = db.User.Where(u => u.ID == id).FirstOrDefault();
        //        return View(user);
        //    }
        //    else
        //    {
        //        return RedirectToAction("Index");
        //    }
        //}

        public ActionResult SendLetter(int? id)
        {
            var message = new MimeMessage();
            message.From.Add(new MailboxAddress("ОАО ОААОО", "mail@mail.com"));
            message.To.Add(new MailboxAddress("Иванову ИИ", "starikovadyu@gmail.com"));
            message.Subject = "Приветствуем вас в вашем приложении!";

            var bodyBuilder = new BodyBuilder();
            bodyBuilder.HtmlBody = RenderViewToString("UsersMail", "Letter", db.User.Where(u => u.ID == id).FirstOrDefault());
            //bodyBuilder.TextBody = RenderViewToString("UsersMail", "Letter", db.User.Where(u => u.ID == id).FirstOrDefault();

            message.Body = bodyBuilder.ToMessageBody();

            using (var client = new SmtpClient())
            {
                client.Connect("smtp.gmail.com", 465, true);

                // Note: only needed if the SMTP server requires authentication
                client.Authenticate("testvuusijivan@gmail.com", "Passw0rd))");

                client.Send(message);
                client.Disconnect(true);
            }

            return RedirectToAction("Index");
        }

    }
}
