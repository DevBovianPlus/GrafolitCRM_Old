using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AnalizaProdaje.Common
{
    public class Enums
    {
        public enum UserRole
        {
            SuperAdmin,
            Admin,
            Salesman,
            User
        }

        public enum UserAction : int
        {
            Add = 1,
            Edit = 2,
            Delete = 3
        }

        public enum QueryStringName
        {
            action,
            recordId,
            eventClientId,
            eventCategorieId,
            eventEmployeeId,
            categorieId
        }

        public enum ClientSession
        {
            ClientId,
            PlanPopUpID,
            ContactPersonPopUp,
            DevicePopUpID,
            NotesPopUpID,
            ClientCategoriePopUpID,
            CategorieID,
            Events,
            ClientModel,
            ColumnFilters,
            DetailChartPeriodSelection
        }

        public enum EmployeeSession
        { 
            EmployeePopUpId,
            EmployeesList,
            EmployeeFullModel
        }

        public enum EventSession
        { 
            EventModel,
            MessagePopupID, 
            EventID,
            SendEmail
        }

        public enum CommonSession
        {
            ShowWarning,
            UserActionPopUp,
            activeTab,
            DownloadDocument
        }

        public enum ChartSession
        {
            GraphCollection,
            ChartDivWidth,
            MainContentDivWidth
        }

        public enum ChartRenderPeriod
        { 
            MESECNO = 1,
            LETNO = 2,
            TEDENSKO = 3
        }

        public enum ChartRenderType
        {
            PRODAJA = 1,
            KOLICINA = 2,
            RVC = 3,
            RVC_ODSTOTEK = 4
        }

        public enum UserCredentialCookie
        {   
            User,
            UserPass
        }

        public enum EventMeetingType
        { 
            PRIPRAVA,
            POROCILO
        }
    }
}