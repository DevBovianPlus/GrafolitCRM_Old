using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AnalizaProdaje.Domain.Helpers;
using System.Net;
using DatabaseWebService.Domain;
using System.IO;
using Newtonsoft.Json.Linq;
using DatabaseWebService.Models;
using Newtonsoft.Json;
using System.Data;
using System.Web.Script.Serialization;
using System.Net.Http;
using DatabaseWebService.Models.Client;
using DatabaseWebService.Models.Event;
using DatabaseWebService.Models.Employee;
using DatabaseWebService.Models.EmailMessage;
using DatabaseWebService.Models.FinancialControl;

namespace AnalizaProdaje.Domain.Concrete
{
    public class DatabaseConnection
    {
        public UserModel SignIn(string username, string password)
        {
            WebResponseContentModel<UserModel> user = GetResponseFromWebRequest<WebResponseContentModel<UserModel>>(WebServiceHelper.SignInService(username, password), "get");
            return user.Content;
        }

        #region Employees
        public WebResponseContentModel<List<EmployeeSimpleModel>> GetAllCompanyEmployees()
        {
            WebResponseContentModel<List<EmployeeSimpleModel>> dt = new WebResponseContentModel<List<EmployeeSimpleModel>>();
            try
            {
                dt = GetResponseFromWebRequest<WebResponseContentModel<List<EmployeeSimpleModel>>>(WebServiceHelper.GetAllEmployees(), "get");
            }
            catch (Exception ex)
            {
                dt.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return dt;
        }

        public WebResponseContentModel<EmployeeFullModel> GetEmployee(int employeeID)
        {
            WebResponseContentModel<EmployeeFullModel> employee = new WebResponseContentModel<EmployeeFullModel>();
            try
            {
                employee = GetResponseFromWebRequest<WebResponseContentModel<EmployeeFullModel>>(WebServiceHelper.GetEmployeeByID(employeeID), "get");
            }
            catch (Exception ex)
            {
                employee.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return employee;
        }

        public WebResponseContentModel<EmployeeFullModel> SaveEmployeeChanges(EmployeeFullModel newData)
        {
            WebResponseContentModel<EmployeeFullModel> model = new WebResponseContentModel<EmployeeFullModel>();

            try
            {
                model.Content = newData;
                model = PostWebRequestData<WebResponseContentModel<EmployeeFullModel>>(WebServiceHelper.SaveEmployeeChanges(), "post", model);
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<bool> DeleteEmployee(int employeeID)
        {
            WebResponseContentModel<bool> model = new WebResponseContentModel<bool>();

            try
            {
                model = GetResponseFromWebRequest<WebResponseContentModel<bool>>(WebServiceHelper.DeleteSelectedEmployee(employeeID), "get");
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<List<RoleModel>> GetAllRoles()
        {
            WebResponseContentModel<List<RoleModel>> dt = new WebResponseContentModel<List<RoleModel>>();
            try
            {
                dt = GetResponseFromWebRequest<WebResponseContentModel<List<RoleModel>>>(WebServiceHelper.GetAllRoles(), "get");
            }
            catch (Exception ex)
            {
                dt.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return dt;
        }

        public WebResponseContentModel<List<EmployeeSimpleModel>> GetAllEmployeeSupervisors()
        {
            WebResponseContentModel<List<EmployeeSimpleModel>> dt = new WebResponseContentModel<List<EmployeeSimpleModel>>();
            try
            {
                dt = GetResponseFromWebRequest<WebResponseContentModel<List<EmployeeSimpleModel>>>(WebServiceHelper.GetAllEmployeeSupervisors(), "get");
            }
            catch (Exception ex)
            {
                dt.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return dt;
        }

        #endregion
        public DataTable GetDataForGraphRendering()
        {
            WebResponseContentModel<DataTable> dt = GetResponseFromWebRequest<WebResponseContentModel<DataTable>>(WebServiceHelper.GetGraphDataForRendering(), "get");
            return dt.Content;
        }


        #region Clients

        public WebResponseContentModel<DataTable> GetAllClients()
        {
            WebResponseContentModel<DataTable> dt = new WebResponseContentModel<DataTable>();
            try
            {
                dt = GetResponseFromWebRequest<WebResponseContentModel<DataTable>>(WebServiceHelper.GetClientsFromDb(), "get");
            }
            catch (Exception ex)
            {
                dt.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return dt;
        }

        public WebResponseContentModel<DataTable> GetAllClients(int employeeID)
        {
            WebResponseContentModel<DataTable> dt = new WebResponseContentModel<DataTable>();
            try
            {
                dt = GetResponseFromWebRequest<WebResponseContentModel<DataTable>>(WebServiceHelper.GetClientsFromDb(employeeID), "get");
            }
            catch (Exception ex)
            {
                dt.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return dt;
        }

        public WebResponseContentModel<ClientFullModel> GetClient(int clientID)
        {
            WebResponseContentModel<ClientFullModel> client = new WebResponseContentModel<ClientFullModel>();
            try
            {
                client = GetResponseFromWebRequest<WebResponseContentModel<ClientFullModel>>(WebServiceHelper.GetClientByID(clientID), "get");
            }
            catch (Exception ex)
            {
                client.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return client;
        }

        public WebResponseContentModel<ClientFullModel> GetClient(int clientID, int employeeID)
        {
            WebResponseContentModel<ClientFullModel> client = new WebResponseContentModel<ClientFullModel>();
            try
            {
                client = GetResponseFromWebRequest<WebResponseContentModel<ClientFullModel>>(WebServiceHelper.GetClientByID(clientID, employeeID), "get");
            }
            catch (Exception ex)
            {
                client.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return client;
        }

        public WebResponseContentModel<ClientFullModel> SaveClientChanges(ClientFullModel newData)
        {
            WebResponseContentModel<ClientFullModel> model = new WebResponseContentModel<ClientFullModel>();

            try
            {
                model.Content = newData;
                model = PostWebRequestData<WebResponseContentModel<ClientFullModel>>(WebServiceHelper.SaveClientDataChanges(), "post", model);
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<bool> DeleteClient(int clientID)
        {
            WebResponseContentModel<bool> model = new WebResponseContentModel<bool>();

            try
            {
                model = GetResponseFromWebRequest<WebResponseContentModel<bool>>(WebServiceHelper.DeleteClient(clientID), "get");
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<PlanModel> SavePlanChanges(PlanModel newData)
        {
            WebResponseContentModel<PlanModel> model = new WebResponseContentModel<PlanModel>();
            try
            {
                model.Content = newData;
                model = PostWebRequestData<WebResponseContentModel<PlanModel>>(WebServiceHelper.SavePlanChanges(), "post", model);
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<bool> DeletePlan(int planID, int clientID)
        {
            WebResponseContentModel<bool> model = new WebResponseContentModel<bool>();

            try
            {
                model = GetResponseFromWebRequest<WebResponseContentModel<bool>>(WebServiceHelper.DeletePlan(planID, clientID), "get");
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<ContactPersonModel> SaveContactPersonChanges(ContactPersonModel newData)
        {
            WebResponseContentModel<ContactPersonModel> model = new WebResponseContentModel<ContactPersonModel>();
            try
            {
                model.Content = newData;
                model = PostWebRequestData<WebResponseContentModel<ContactPersonModel>>(WebServiceHelper.SaveContactPersonChanges(), "post", model);
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<bool> DeleteContactPerson(int contactPersonID, int clientID)
        {
            WebResponseContentModel<bool> model = new WebResponseContentModel<bool>();

            try
            {
                model = GetResponseFromWebRequest<WebResponseContentModel<bool>>(WebServiceHelper.DeleteContactPerson(contactPersonID, clientID), "get");
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<List<CategorieModel>> GetAllCategories()
        {
            WebResponseContentModel<List<CategorieModel>> categories = new WebResponseContentModel<List<CategorieModel>>();
            try
            {
                categories = GetResponseFromWebRequest<WebResponseContentModel<List<CategorieModel>>>(WebServiceHelper.GetAllCategories(), "get");
            }
            catch (Exception ex)
            {
                categories.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return categories;
        }

        public WebResponseContentModel<ClientEmployeeModel> SaveClientEmployeeChanges(ClientEmployeeModel newData)
        {
            WebResponseContentModel<ClientEmployeeModel> model = new WebResponseContentModel<ClientEmployeeModel>();
            try
            {
                model.Content = newData;
                model = PostWebRequestData<WebResponseContentModel<ClientEmployeeModel>>(WebServiceHelper.SaveClientEmployeeChanges(), "post", model);
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<bool> DeleteClientEmployee(int clientID, int employeeID)
        {
            WebResponseContentModel<bool> model = new WebResponseContentModel<bool>();

            try
            {
                model = GetResponseFromWebRequest<WebResponseContentModel<bool>>(WebServiceHelper.DeleteClientEmployee(clientID, employeeID), "get");
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<bool> ClientEmployeeExist(int clientID, int employeeID)
        {
            WebResponseContentModel<bool> model = new WebResponseContentModel<bool>();

            try
            {
                model = GetResponseFromWebRequest<WebResponseContentModel<bool>>(WebServiceHelper.ClientEmployeeExist(clientID, employeeID), "get");
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<DevicesModel> SaveDeviceChanges(DevicesModel newData)
        {
            WebResponseContentModel<DevicesModel> model = new WebResponseContentModel<DevicesModel>();
            try
            {
                model.Content = newData;
                model = PostWebRequestData<WebResponseContentModel<DevicesModel>>(WebServiceHelper.SaveDeviceChanges(), "post", model);
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<bool> DeleteDevice(int deviceID, int clientID)
        {
            WebResponseContentModel<bool> model = new WebResponseContentModel<bool>();

            try
            {
                model = GetResponseFromWebRequest<WebResponseContentModel<bool>>(WebServiceHelper.DeleteDevice(deviceID, clientID), "get"); ;
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<ClientCategorieModel> SaveClientCategorieChanges(ClientCategorieModel newData)
        {
            WebResponseContentModel<ClientCategorieModel> model = new WebResponseContentModel<ClientCategorieModel>();
            try
            {
                model.Content = newData;
                model = PostWebRequestData<WebResponseContentModel<ClientCategorieModel>>(WebServiceHelper.SaveClientCategorieChanges(), "post", model);
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<bool> DeleteClientCategorie(int clientID, int clientCategorieID)
        {
            WebResponseContentModel<bool> model = new WebResponseContentModel<bool>();

            try
            {
                model = GetResponseFromWebRequest<WebResponseContentModel<bool>>(WebServiceHelper.DeleteClientCategorie(clientID, clientCategorieID), "get");
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<List<CategorieModel>> GetAllFreeClientCategories(int clientID, int catToSkip = 0)
        {
            WebResponseContentModel<List<CategorieModel>> categories = new WebResponseContentModel<List<CategorieModel>>();
            try
            {
                categories = GetResponseFromWebRequest<WebResponseContentModel<List<CategorieModel>>>(WebServiceHelper.GetFreeClientCategorie(clientID, catToSkip), "get");
            }
            catch (Exception ex)
            {
                categories.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return categories;
        }

        public WebResponseContentModel<List<ClientSimpleModel>> GetClientsByFilter(string propertyName, string containsValue)
        {
            WebResponseContentModel<List<ClientSimpleModel>> clients = new WebResponseContentModel<List<ClientSimpleModel>>();
            try
            {
                clients = GetResponseFromWebRequest<WebResponseContentModel<List<ClientSimpleModel>>>(WebServiceHelper.GetClientsByFilters(propertyName, containsValue), "get");
            }
            catch (Exception ex)
            {
                clients.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return clients;
        }

        #endregion

        #region Events
        public WebResponseContentModel<DataTable> GetAllEvents()
        {
            WebResponseContentModel<DataTable> dt = new WebResponseContentModel<DataTable>();
            try
            {
                dt = GetResponseFromWebRequest<WebResponseContentModel<DataTable>>(WebServiceHelper.GetAllEvents(), "get");
            }
            catch (Exception ex)
            {
                dt.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return dt;
        }

        public WebResponseContentModel<DataTable> GetAllEvents(int employeeID)
        {
            WebResponseContentModel<DataTable> dt = new WebResponseContentModel<DataTable>();
            try
            {
                dt = GetResponseFromWebRequest<WebResponseContentModel<DataTable>>(WebServiceHelper.GetAllEvents(employeeID), "get");
            }
            catch (Exception ex)
            {
                dt.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return dt;
        }

        public WebResponseContentModel<EventFullModel> GetEvent(int eventID)
        {
            WebResponseContentModel<EventFullModel> eventFull = new WebResponseContentModel<EventFullModel>();
            try
            {
                eventFull = GetResponseFromWebRequest<WebResponseContentModel<EventFullModel>>(WebServiceHelper.GetEventByID(eventID), "get");
            }
            catch (Exception ex)
            {
                eventFull.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return eventFull;
        }

        public WebResponseContentModel<EventFullModel> GetEvent(int eventID, int employeeID)
        {
            WebResponseContentModel<EventFullModel> eventFull = new WebResponseContentModel<EventFullModel>();
            try
            {
                eventFull = GetResponseFromWebRequest<WebResponseContentModel<EventFullModel>>(WebServiceHelper.GetEventByID(eventID, employeeID), "get");
            }
            catch (Exception ex)
            {
                eventFull.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return eventFull;
        }

        public WebResponseContentModel<List<EmployeeSimpleModel>> GetEmployeesByRoleID(int roleID)
        {
            WebResponseContentModel<List<EmployeeSimpleModel>> employeesByRole = new WebResponseContentModel<List<EmployeeSimpleModel>>();
            try
            {
                employeesByRole = GetResponseFromWebRequest<WebResponseContentModel<List<EmployeeSimpleModel>>>(WebServiceHelper.GetEmployeesByRoleID(roleID), "get");
            }
            catch (Exception ex)
            {
                employeesByRole.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return employeesByRole;
        }

        public WebResponseContentModel<List<EventStatusModel>> GetAllEventStatuses()
        {
            WebResponseContentModel<List<EventStatusModel>> employeesByRole = new WebResponseContentModel<List<EventStatusModel>>();
            try
            {
                employeesByRole = GetResponseFromWebRequest<WebResponseContentModel<List<EventStatusModel>>>(WebServiceHelper.GetAllEventStatuses(), "get");
            }
            catch (Exception ex)
            {
                employeesByRole.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return employeesByRole;
        }

        public WebResponseContentModel<EventFullModel> SaveEventChanges(EventFullModel newData)
        {
            WebResponseContentModel<EventFullModel> model = new WebResponseContentModel<EventFullModel>();
            try
            {
                model.Content = newData;
                model = PostWebRequestData<WebResponseContentModel<EventFullModel>>(WebServiceHelper.SaveEventChanges(), "post", model);
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<bool> DeleteEvent(int eventID)
        {
            WebResponseContentModel<bool> model = new WebResponseContentModel<bool>();

            try
            {
                model = GetResponseFromWebRequest<WebResponseContentModel<bool>>(WebServiceHelper.DeleteEvent(eventID), "get");
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<MessageModel> SaveMessageChanges(MessageModel newData)
        {
            WebResponseContentModel<MessageModel> model = new WebResponseContentModel<MessageModel>();
            try
            {
                model.Content = newData;
                model = PostWebRequestData<WebResponseContentModel<MessageModel>>(WebServiceHelper.SaveMessageChanges(), "post", model);
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<bool> DeleteMessage(int messageID, int eventID)
        {
            WebResponseContentModel<bool> model = new WebResponseContentModel<bool>();

            try
            {
                model = GetResponseFromWebRequest<WebResponseContentModel<bool>>(WebServiceHelper.DeleteMessage(messageID, eventID), "get");
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<List<EmployeeSimpleModel>> GetEmployeeSupervisorByEmployeeID(int employeeID)
        {
            WebResponseContentModel<List<EmployeeSimpleModel>> employeesSupervisor = new WebResponseContentModel<List<EmployeeSimpleModel>>();
            try
            {
                employeesSupervisor = GetResponseFromWebRequest<WebResponseContentModel<List<EmployeeSimpleModel>>>(WebServiceHelper.GetEmployeeSupervisorByID(employeeID), "get");
            }
            catch (Exception ex)
            {
                employeesSupervisor.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return employeesSupervisor;
        }

        public WebResponseContentModel<EventMeetingModel> SaveEventMeetingChanges(EventMeetingModel newData)
        {
            WebResponseContentModel<EventMeetingModel> model = new WebResponseContentModel<EventMeetingModel>();
            try
            {
                model.Content = newData;
                model = PostWebRequestData<WebResponseContentModel<EventMeetingModel>>(WebServiceHelper.SaveEventMeetingChanges(), "post", model);
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }

        public WebResponseContentModel<bool> DeleteEventMeeting(int eventMeetingID, int eventID)
        {
            WebResponseContentModel<bool> model = new WebResponseContentModel<bool>();

            try
            {
                model = GetResponseFromWebRequest<WebResponseContentModel<bool>>(WebServiceHelper.DeleteEventMeeting(eventMeetingID, eventID), "get");
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }
        #endregion

        #region Sending Email messages
        public WebResponseContentModel<EmailMessageModel> SendEmailMessage(EmailMessageModel newData)
        {
            WebResponseContentModel<EmailMessageModel> model = new WebResponseContentModel<EmailMessageModel>();
            try
            {
                model.Content = newData;
                model = PostWebRequestData<WebResponseContentModel<EmailMessageModel>>(WebServiceHelper.SendEmailMessage(), "post", model);
            }
            catch (Exception ex)
            {
                model.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return model;
        }
        #endregion

        #region Charts
        public WebResponseContentModel<ChartRenderModel> GetChartData(int clientID, int categorieID, int period, int type, DateTime? dateFROM = null, DateTime? dateTO = null)
        {
            WebResponseContentModel<ChartRenderModel> chartData = new WebResponseContentModel<ChartRenderModel>();
            try
            {
                if (!dateFROM.HasValue) dateFROM = DateTime.MinValue;
                if (!dateTO.HasValue) dateTO = DateTime.MinValue;

                chartData = GetResponseFromWebRequest<WebResponseContentModel<ChartRenderModel>>(WebServiceHelper.GetDataForChart(clientID, categorieID, period, type, dateFROM.Value, dateTO.Value), "get");
            }
            catch (Exception ex)
            {
                chartData.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return chartData;
        }

        public WebResponseContentModel<List<ChartRenderModel>> GetChartDataForAllTypes(int clientID, int categorieID, int period, DateTime? dateFROM, DateTime? dateTO)
        {
            WebResponseContentModel<List<ChartRenderModel>> chartData = new WebResponseContentModel<List<ChartRenderModel>>();
            try
            {
                if (!dateFROM.HasValue) dateFROM = DateTime.MinValue;
                if (!dateTO.HasValue) dateTO = DateTime.MinValue;

                chartData = GetResponseFromWebRequest<WebResponseContentModel<List<ChartRenderModel>>>(WebServiceHelper.GetDataForChartAllTypes(clientID, categorieID, period, dateFROM.Value, dateTO.Value), "get");
            }
            catch (Exception ex)
            {
                chartData.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return chartData;
        }

        public WebResponseContentModel<ChartRenderModel> GetChartDataFromSQLFunction(int clientID, int categorieID, int period, int type, DateTime? dateFROM = null, DateTime? dateTO = null)
        {
            WebResponseContentModel<ChartRenderModel> chartData = new WebResponseContentModel<ChartRenderModel>();
            try
            {
                chartData = GetResponseFromWebRequest<WebResponseContentModel<ChartRenderModel>>(WebServiceHelper.GetDataForChartFromSQLFunction(clientID, categorieID, period, type, dateFROM, dateTO), "get");
            }
            catch (Exception ex)
            {
                chartData.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return chartData;
        }
        public WebResponseContentModel<List<ChartRenderModel>> GetChartDataForAllTypesSQLFunction(int clientID, int categorieID, int period, DateTime? dateFROM = null, DateTime? dateTO = null)
        {
            WebResponseContentModel<List<ChartRenderModel>> chartData = new WebResponseContentModel<List<ChartRenderModel>>();
            try
            {
                chartData = GetResponseFromWebRequest<WebResponseContentModel<List<ChartRenderModel>>>(WebServiceHelper.GetDataForChartAllTypesSQLFunction(clientID, categorieID, period, dateFROM, dateTO), "get");
            }
            catch (Exception ex)
            {
                chartData.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return chartData;
        }
        #endregion

        #region FinancialControl
        public WebResponseContentModel<FinancialControlModel> GetFinancialControlData()
        {
            WebResponseContentModel<FinancialControlModel> clients = new WebResponseContentModel<FinancialControlModel>();
            try
            {
                clients = GetResponseFromWebRequest<WebResponseContentModel<FinancialControlModel>>(WebServiceHelper.GetFinancialControlData(), "get");
            }
            catch (Exception ex)
            {
                clients.ValidationErrorAppSide = ConcatenateExceptionMessage(ex);
            }

            return clients;
        }
        #endregion

        public T GetResponseFromWebRequest<T>(string uri, string requestMethod)
        {
            object obj = default(T);

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(uri);
            request.Method = requestMethod.ToUpper();

            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            Stream stream = response.GetResponseStream();
            StreamReader reader = new StreamReader(stream);
            string streamString = reader.ReadToEnd();

            obj = JsonConvert.DeserializeObject<T>(streamString);

            return (T)obj;
        }

        public T PostWebRequestData<T>(string uri, string requestMethod, T objectToSerialize)
        {
            object obj = default(T);

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(uri);
            request.Method = requestMethod.ToUpper();
            request.ContentType = "application/json; charset=utf-8";

            using (var sw = new StreamWriter(request.GetRequestStream()))
            {
                string clientData = JsonConvert.SerializeObject(objectToSerialize);
                sw.Write(clientData);
                sw.Flush();
                sw.Close();
            }


            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            Stream stream = response.GetResponseStream();
            StreamReader reader = new StreamReader(stream);
            string streamString = reader.ReadToEnd();

            obj = JsonConvert.DeserializeObject<T>(streamString);

            return (T)obj;
        }

        private string ConcatenateExceptionMessage(Exception ex)
        {
            return ex.Message + " \r\n" + ex.Source + (ex.InnerException != null ? ex.InnerException.Message + " \r\n" + ex.Source : "");
        }
    }
}