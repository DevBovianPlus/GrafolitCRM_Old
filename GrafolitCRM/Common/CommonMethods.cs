using DevExpress.Web;
using DevExpress.XtraPrintingLinks;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Text;
using System.Web;
using System.Web.UI;

namespace AnalizaProdaje.Common
{
    public static class CommonMethods
    {
        public static int ParseInt(object param)
        {
            int num = 0;

            if (param != null)
            {
                int.TryParse(param.ToString(), out num);

                if (num < 0)
                    num = 0;
            }

            return num;
        }

        public static Nullable<int> ParseNullableInt(object param)
        {
            int num = 0;

            if (param != null)
            {
                int.TryParse(param.ToString(), out num);

                if (num < 0)
                    return null;

                return num;
            }
            else
                return null;
        }

        public static decimal ParseDecimal(object param)
        {
            decimal num = 0;
            if (param != null)
            {
                decimal.TryParse(param.ToString(), out num);

                if (num < 0)
                    num = 0;
            }

            return num;
        }

        public static double ParseDouble(object param)
        {
            double num = 0;
            if (param != null)
            {
                double.TryParse(param.ToString(), out num);

                if (num < 0)
                    num = 0;
            }

            return num;
        }

        public static bool ParseBool(string param)
        {
            bool value = false;
            bool.TryParse(param, out value);

            return value;
        }

        public static string PreveriZaSumnike(string _crka)
        {
            char crkaC = ' ';
            string novS = "";

            _crka = _crka.ToUpper();

            foreach (char item in _crka)
            {
                switch (item)
                {
                    case 'Č':
                        crkaC = 'C';
                        break;
                    case 'Š':
                        crkaC = 'S';
                        break;
                    case 'Ž':
                        crkaC = 'Z';
                        break;
                    case 'Đ':
                        crkaC = 'D';
                        break;
                    default:
                        crkaC = item;
                        break;
                }

                novS += crkaC.ToString();
            }

            return novS;
        }

        public static string Trim(string sTrim)
        {
            return String.IsNullOrEmpty(sTrim) ? "" : sTrim.Trim(); ;
        }

        public static void LogThis(string message)
        {
            var directory = AppDomain.CurrentDomain.BaseDirectory;
            File.AppendAllText(directory + "log.txt", DateTime.Now + " " + message + Environment.NewLine);
        }

        public static T ToType<T>(this string value)
        {
            object parsedValue = default(T);
            try
            {
                parsedValue = Convert.ChangeType(value, typeof(T));
            }
            catch (InvalidCastException)
            {
                parsedValue = null;
            }
            catch (ArgumentException)
            {
                parsedValue = null;
            }
            return (T)parsedValue;
        }

        public static bool SendEmailToDeveloper(string displayName, string subject, string body)
        {
            try
            {
                SmtpClient client = new SmtpClient();
                client.Host = "smtp.gmail.com";
                client.Port = 587;//Port 465 (SSL required)
                client.EnableSsl = true;
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.Credentials = new NetworkCredential("bovianplus@gmail.com", "Geslo123.");
                client.Timeout = 6000;

                MailMessage message;

                message = new MailMessage();
                message.To.Add(new MailAddress("martin@bovianplus.si"));

                message.Sender = new MailAddress("bovianplus@gmail.com");
                message.From = new MailAddress("bovianplus@gmail.com", displayName);
                message.Subject = subject;
                message.IsBodyHtml = false;
                message.Body = body;
                message.BodyEncoding = Encoding.UTF8;

                client.Send(message);

            }
            catch (SmtpFailedRecipientsException ex)
            {
                LogThis(ex.Message + "\r\n " + ex.Source + "\r\n " + ex.StackTrace);
                return false;
            }
            catch (SmtpException ex)
            {
                LogThis(ex.Message + "\r\n " + ex.Source + "\r\n " + ex.StackTrace);
                return false;
            }
            catch (Exception ex)
            {
                LogThis(ex.Message + "\r\n " + ex.Source + "\r\n " + ex.StackTrace);
                return false;
            }

            return true;
        }

        public static bool IsCallbackRequest(this HttpRequest request)
        {
            if (request == null)
            {
                throw new ArgumentNullException("request");
            }
            var context = HttpContext.Current;
            var isCallbackRequest = false;// callback requests are ajax requests
            if (context != null && context.CurrentHandler != null && context.CurrentHandler is System.Web.UI.Page)
            {
                isCallbackRequest = ((System.Web.UI.Page)context.CurrentHandler).IsCallback;
            }
            return isCallbackRequest || (request["X-Requested-With"] == "XMLHttpRequest") || (request.Headers["X-Requested-With"] == "XMLHttpRequest");
        }

        public static string GetTimeStamp()
        {
            return  "_" + DateTime.Now.ToString("dd.MM.yyyy - hh:mm");
        }

        public static void ExportToPDFFitToPage(ASPxGridViewExporter GridViewExporter, Page pg)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                PrintableComponentLinkBase pcl = new PrintableComponentLinkBase(new DevExpress.XtraPrinting.PrintingSystemBase());
                pcl.Component = GridViewExporter;
                pcl.Margins.Left = pcl.Margins.Right = 50;
                pcl.Landscape = true;
                pcl.CreateDocument(false);
                pcl.PrintingSystemBase.Document.AutoFitToPagesWidth = 1;
                pcl.ExportToPdf(ms);
                WriteResponse(pg.Response, ms.ToArray(), System.Net.Mime.DispositionTypeNames.Inline.ToString());
            }
        }

        public static void WriteResponse(HttpResponse response, byte[] filearray, string type)
        {
            response.ClearContent();
            response.Buffer = true;
            response.Cache.SetCacheability(HttpCacheability.Private);
            response.ContentType = "application/pdf";
            ContentDisposition contentDisposition = new ContentDisposition();
            contentDisposition.FileName = "test.pdf";
            contentDisposition.DispositionType = type;
            response.AddHeader("Content-Disposition", contentDisposition.ToString());
            response.BinaryWrite(filearray);
            HttpContext.Current.ApplicationInstance.CompleteRequest();
            try
            {
                response.End();
            }
            catch (System.Threading.ThreadAbortException)
            {
            }

        }

    }
}