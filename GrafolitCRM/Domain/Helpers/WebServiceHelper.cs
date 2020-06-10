using DatabaseWebService.Models.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace AnalizaProdaje.Domain.Helpers
{
    public static class WebServiceHelper
    {
        private static string BaseWebServiceSignInURI
        {
            get
            {
                return WebConfigurationManager.AppSettings["BaseServiceSignInURI"].ToString();
            }
        }
        private static string BaseWebServiceURI
        {
            get
            {
                return WebConfigurationManager.AppSettings["BaseServiceURI"].ToString();
            }
        }

        private static string BaseWebServiceClientURI
        {
            get
            {
                return BaseWebServiceURI + WebConfigurationManager.AppSettings["ClientPartialURI"].ToString();
            }
        }

        private static string BaseWebServiceEventURI
        {
            get
            {
                return BaseWebServiceURI + WebConfigurationManager.AppSettings["EventPartialURI"].ToString();
            }
        }

        private static string WebServiceEmployeeURI
        {
            get
            {
                return BaseWebServiceURI + WebConfigurationManager.AppSettings["EmployeePartialURI"].ToString();
            }
        }

        private static string WebServiceSendEmailURI
        {
            get
            {
                return BaseWebServiceURI + WebConfigurationManager.AppSettings["SendEventEmailPartialURI"].ToString();
            }
        }

        public static string SignInService(string username, string password)
        {
            return BaseWebServiceSignInURI + "SignIn?username=" + username + "&password=" + password;
        }

        private static string WebServiceChartsURI
        {
            get
            {
                return BaseWebServiceURI + WebConfigurationManager.AppSettings["ChartsPartialURI"].ToString();
            }
        }

        private static string WebServiceFinancialControlURI
        {
            get
            {
                return BaseWebServiceURI + WebConfigurationManager.AppSettings["FinancialControlPartialURI"].ToString();
            }
        }

        #region Employees
        public static string GetAllEmployees()
        {
            return WebServiceEmployeeURI + "GetAllEmployees";
        }

        public static string GetEmployeeByID(int id)
        {
            return WebServiceEmployeeURI + "GetEmployeeByID?employeeID=" + id;
        }

        public static string SaveEmployeeChanges()
        {
            return WebServiceEmployeeURI + "SaveEmployeeData";
        }

        public static string DeleteSelectedEmployee(int id)
        {
            return WebServiceEmployeeURI + "DeleteEmployee?employeeID=" + id.ToString();
        }

        public static string GetAllRoles()
        {
            return WebServiceEmployeeURI + "GetAllRoles";
        }

        public static string GetAllEmployeeSupervisors()
        {
            return WebServiceEmployeeURI + "GetAllEmployeeSupervisors";
        }
        
        #endregion
        public static string GetGraphDataForRendering()
        {
            return BaseWebServiceSignInURI + "GetDataForGraphRendering";
        }

        #region Clients

        public static string GetClientsFromDb()
        {
            return BaseWebServiceClientURI + "GetAllClients";
        }
        public static string GetClientsFromDb(int employeeID)
        {
            return BaseWebServiceClientURI + "GetAllClients?employeeID=" + employeeID.ToString();
        }

        public static string GetClientByID(int id)
        {
            return BaseWebServiceClientURI + "GetClientByID?clientID=" + id.ToString();
        }

        public static string GetClientByID(int id, int employeeID)
        {
            return BaseWebServiceClientURI + "GetClientByID?clientID=" + id.ToString() + "&employeeID=" + employeeID.ToString();
        }

        public static string SaveClientDataChanges()
        {
            return BaseWebServiceClientURI + "SaveClientData";
        }

        public static string DeleteClient(int id)
        {
            return BaseWebServiceClientURI + "DeleteClient?clientID=" + id;
        }

        public static string SavePlanChanges()
        {
            return BaseWebServiceClientURI + "SavePlanToClient";
        }

        public static string DeletePlan(int planID, int clientID)
        {
            return BaseWebServiceClientURI + "DeletePlan?planID=" + planID + "&clientID=" + clientID;
        }

        public static string SaveContactPersonChanges()
        {
            return BaseWebServiceClientURI + "SaveContactPersonToClient";
        }

        public static string DeleteContactPerson(int contactPersonID, int clientID)
        {
            return BaseWebServiceClientURI + "DeleteContactPerson?contactPersonID=" + contactPersonID + "&clientID=" + clientID;
        }

        public static string GetAllCategories()
        {
            return BaseWebServiceClientURI + "GetAllCategories";
        }

        public static string SaveClientEmployeeChanges()
        {
            return BaseWebServiceClientURI + "SaveClientEmployee";
        }

        public static string DeleteClientEmployee(int clientID, int employeeID)
        {
            return BaseWebServiceClientURI + "DeleteClientEmployee?clientID=" + clientID + "&employeeID=" + employeeID;
        }

        public static string ClientEmployeeExist(int clientID, int employeeID)
        {
            return BaseWebServiceClientURI + "ClientEmployeeExist?clientID=" + clientID + "&employeeID=" + employeeID;
        }

        public static string SaveDeviceChanges()
        {
            return BaseWebServiceClientURI + "SaveDeviceData";
        }

        public static string DeleteDevice(int deviceID, int clientID)
        {
            return BaseWebServiceClientURI + "DeleteDevice?deviceID=" + deviceID + "&clientID=" + clientID;
        }
        public static string SaveClientCategorieChanges()
        {
            return BaseWebServiceClientURI + "SaveClientCategorie";
        }

        public static string DeleteClientCategorie(int clientID, int clientCategorieID)
        {
            return BaseWebServiceClientURI + "DeleteClientCategorie?clientID=" + clientID + "&clientCategorieID=" + clientCategorieID;
        }
        public static string GetFreeClientCategorie(int clientID, int catToSkip = 0)
        {
            return BaseWebServiceClientURI + "GetAllFreeClientCategories?clientID=" + clientID + "&catToSkip=" + catToSkip;
        }
        public static string GetClientsByFilters(string propertyName, string containsValue)
        {
            return BaseWebServiceClientURI + "GetClientsByFilter?propertyName=" + propertyName + "&containsValue=" + containsValue;
        }
        #endregion

        #region Events
        public static string GetAllEvents()
        {
            return BaseWebServiceEventURI + "GetAllEvents";
        }
        public static string GetAllEvents(int employeeID)
        {
            return BaseWebServiceEventURI + "GetAllEvents?employeeID=" + employeeID.ToString();
        }

        public static string GetEventByID(int id)
        {
            return BaseWebServiceEventURI + "GetEventByID?eventID=" + id.ToString();
        }

        public static string GetEventByID(int id, int employeeID)
        {
            return BaseWebServiceEventURI + "GetEventByID?eventID=" + id.ToString() + "&employeeID=" + employeeID;
        }

        public static string GetEmployeesByRoleID(int id)
        {
            return BaseWebServiceEventURI + "GetEmployeesByRoleID?roleID=" + id;
        }
        public static string GetAllEventStatuses()
        {
            return BaseWebServiceEventURI + "GetEventStatuses";
        }
        public static string SaveEventChanges()
        {
            return BaseWebServiceEventURI + "SaveEventData";
        }
        public static string DeleteEvent(int eventID)
        {
            return BaseWebServiceEventURI + "DeleteClient?eventID=" + eventID;
        }
        public static string SaveMessageChanges()
        {
            return BaseWebServiceEventURI + "SaveMessageData";
        }
        public static string DeleteMessage(int messageID, int eventID)
        {
            return BaseWebServiceEventURI + "DeleteMessage?messageID=" + messageID + "&eventID=" + eventID;
        }

        public static string GetEmployeeSupervisorByID(int employeeID)
        {
            return BaseWebServiceEventURI + "GetEmployeeSupervisorByEmployeeID?employeeID=" + employeeID;
        }
        public static string SaveEventMeetingChanges()
        {
            return BaseWebServiceEventURI + "SaveEventMeetingData";
        }
        public static string DeleteEventMeeting(int eventMeetingID, int eventID)
        {
            return BaseWebServiceEventURI + "DeleteEventMeeting?eventMeetingID=" + eventMeetingID + "&eventID=" + eventID;
        }
        #endregion

        #region Send email messages
        public static string SendEmailMessage()
        {
            return WebServiceSendEmailURI + "SaveSystemMessageData";
        }
        #endregion

        #region Charts
        public static string GetDataForChart(int clientID, int categorieID, int period, int type, DateTime dateFROM, DateTime dateTO)
        {
            return WebServiceChartsURI + "GetChartsData?clientID=" + clientID.ToString() + "&categorieID=" + categorieID.ToString() + "&period=" + period.ToString() + "&type=" + type.ToString() + "&dateFrom=" + dateFROM.ToString() + "&dateTo=" + dateTO.ToString();
        }
        public static string GetDataForChartAllTypes(int clientID, int categorieID, int period, DateTime dateFROM, DateTime dateTO)
        {
            return WebServiceChartsURI + "GetChartsDataForAllTypes?clientID=" + clientID.ToString() + "&categorieID=" + categorieID.ToString() + "&period=" + period.ToString() + "&dateFrom=" + dateFROM.ToString() + "&dateTo=" + dateTO.ToString();
        }
        public static string GetDataForChartFromSQLFunction(int clientID, int categorieID, int period, int type, DateTime? dateFROM, DateTime? dateTO)
        {
            string dFROM = "", dTO = "";

            if (dateFROM.HasValue) dFROM = dateFROM.Value.ToString();
            if (dateTO.HasValue) dTO = dateTO.Value.ToString(); 

            return WebServiceChartsURI + "GetChartsDataFromSQLFunction?clientID=" + clientID.ToString() + 
                "&categorieID=" + categorieID.ToString() +
                "&period=" + period.ToString() + 
                "&type=" + type.ToString() + 
                "&dateFrom=" + dFROM +
                "&dateTo=" + dTO;
        }
        public static string GetDataForChartAllTypesSQLFunction(int clientID, int categorieID, int period, DateTime? dateFROM, DateTime? dateTO)
        {
            string dFROM = "", dTO = "";

            if (dateFROM.HasValue) dFROM = dateFROM.Value.ToString();
            if (dateTO.HasValue) dTO = dateTO.Value.ToString();

            return WebServiceChartsURI + "GetChartsDataForAllTypesSQLFunction?clientID=" + clientID.ToString() + 
                "&categorieID=" + categorieID.ToString() + 
                "&period=" + period.ToString() +
                "&dateFrom=" + dFROM +
                "&dateTo=" + dTO;
        }
        #endregion

        #region FinancialControl
        public static string GetFinancialControlData()
        {
            return WebServiceFinancialControlURI + "GetFinancialControlData";
        }
        #endregion
    }
}