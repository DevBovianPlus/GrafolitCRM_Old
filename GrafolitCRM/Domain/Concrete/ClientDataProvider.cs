using DatabaseWebService.Models;
using DatabaseWebService.Models.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AnalizaProdaje.Common;
using AnalizaProdaje.Domain.Helpers;

namespace AnalizaProdaje.Domain.Concrete
{
    public class ClientDataProvider : ServerMasterPage
    {
        /// <summary>
        /// Add clientFullModel instance to session
        /// </summary>
        /// <param name="model"></param>
        public void SetClientFullModel(ClientFullModel model)
        {
            AddValueToSession(Enums.ClientSession.ClientModel, model);
        }

        /// <summary>
        /// Returns all client data From session. If session does not exist it returs null.
        /// </summary>
        /// <returns></returns>
        public ClientFullModel GetFullModelFromClientModel()
        {
            if (SessionHasValue(Enums.ClientSession.ClientModel))
                return (ClientFullModel)GetValueFromSession(Enums.ClientSession.ClientModel);

            return null;
        }

        /// <summary>
        /// Returns PlanModel Instance from ClientModel session.
        /// </summary>
        /// <param name="planID">Plan ID</param>
        /// <param name="clientID">Client ID</param>
        /// <returns></returns>
        public PlanModel GetPlanFromClientModelSession(int planID, int clientID)
        {

            ClientFullModel tmp = GetFullModelFromClientModel();

            return tmp.Plan.Where(p => p.idPlan == planID && p.IDStranka == clientID).FirstOrDefault();
        }

        /// <summary>
        /// Delete Plan instance from client model session and add new data to session.
        /// </summary>
        /// <param name="planID">Plan ID</param>
        /// <param name="clientID">Client ID</param>
        /// <returns>Return true if delete is succesfull. Otherwise false.</returns>
        public bool DeletePlanFromClientModelSession(int planID, int clientID)
        {
            PlanModel model = GetPlanFromClientModelSession(planID, clientID);
            ClientFullModel tmp = GetFullModelFromClientModel();

            if (model != null && tmp != null)
            {
                bool isDeleted = tmp.Plan.Remove(model);
                AddValueToSession(Enums.ClientSession.ClientModel, tmp);

                return isDeleted;
            }
            return false;
        }

        /// <summary>
        /// Add new Plan instance to client model session
        /// </summary>
        /// <param name="model">New plan instance to add</param>
        /// <returns>Returns true if adding was succesfull. Otherwise false.</returns>
        public bool AddPlanToClientModelSession(PlanModel model)
        {
            ClientFullModel fullModel = GetFullModelFromClientModel();
            if (fullModel != null)
            {
                fullModel.Plan.Add(model);
                AddValueToSession(Enums.ClientSession.ClientModel, fullModel);

                return true;
            }
            return false;
        }

        /// <summary>
        /// Udate existing Plan in client model session
        /// </summary>
        /// <param name="model">Existing plan instance to update</param>
        /// <returns>Returns true if updating was succesfull. Otherwise false.</returns>
        public bool UpdatePlanToClientModelSession(PlanModel model)
        {
            ClientFullModel fullModel = GetFullModelFromClientModel();
            if (fullModel != null)
            {
                var record = fullModel.Plan.Where(p => p.idPlan == model.idPlan).FirstOrDefault();
                if (record != null)
                {
                    int index = fullModel.Plan.IndexOf(record);
                    if (index != -1)
                        fullModel.Plan[index] = model;
                    else
                        return false;
                }
                else
                    return false;

                AddValueToSession(Enums.ClientSession.ClientModel, fullModel);

                return true;
            }
            return false;
        }

        #region ContactPerson Provider

        /// <summary>
        /// Returns ContactPerson Instance from ClientModel session.
        /// </summary>
        /// <param name="planID">Contact person ID</param>
        /// <param name="clientID">Client ID</param>
        /// <returns></returns>
        public ContactPersonModel GetContactPersonFromClientModelSession(int contactPersonID, int clientID)
        {

            ClientFullModel tmp = GetFullModelFromClientModel();

            return tmp.KontaktneOsebe.Where(ko => ko.idKontaktneOsebe == contactPersonID && ko.idStranka == clientID).FirstOrDefault();
        }

        /// <summary>
        /// Add new Contact person instance to Client model session
        /// </summary>
        /// <param name="model">New contact person instance to add</param>
        /// <returns>Returns true if adding was succesfull. Otherwise false.</returns>
        public bool AddContactPersonToClientModelSession(ContactPersonModel model)
        {
            ClientFullModel fullModel = GetFullModelFromClientModel();
            if (fullModel != null)
            {
                fullModel.KontaktneOsebe.Add(model);
                AddValueToSession(Enums.ClientSession.ClientModel, fullModel);

                return true;
            }
            return false;
        }

        /// <summary>
        /// Delete Contact person instance from client model session and add new data to session.
        /// </summary>
        /// <param name="planID">contact person ID</param>
        /// <param name="clientID">Client ID</param>
        /// <returns>Return true if delete is succesfull. Otherwise false.</returns>
        public bool DeleteContactPersonFromClientModelSession(int contactPersonID, int clientID)
        {
            ContactPersonModel model = GetContactPersonFromClientModelSession(contactPersonID, clientID);
            ClientFullModel tmp = GetFullModelFromClientModel();

            if (model != null && tmp != null)
            {
                bool isDeleted = tmp.KontaktneOsebe.Remove(model);
                AddValueToSession(Enums.ClientSession.ClientModel, tmp);

                return isDeleted;
            }
            return false;
        }

        /// <summary>
        /// Udate existing contact person in client model session
        /// </summary>
        /// <param name="model">Existing contact person instance to update</param>
        /// <returns>Returns true if updating was succesfull. Otherwise false.</returns>
        public bool UpdateContactPersonToClientModelSession(ContactPersonModel model)
        {
            ClientFullModel fullModel = GetFullModelFromClientModel();
            if (fullModel != null)
            {
                var record = fullModel.KontaktneOsebe.Where(ko => ko.idKontaktneOsebe == model.idKontaktneOsebe).FirstOrDefault();
                if (record != null)
                {
                    int index = fullModel.KontaktneOsebe.IndexOf(record);
                    if (index != -1)
                        fullModel.KontaktneOsebe[index] = model;
                    else
                        return false;
                }
                else
                    return false;

                AddValueToSession(Enums.ClientSession.ClientModel, fullModel);

                return true;
            }
            return false;
        }

        #endregion

        #region Devices
        /// <summary>
        /// Returns DeviceModel Instance from ClientModel session.
        /// </summary>
        /// <param name="planID">Device ID</param>
        /// <param name="clientID">Client ID</param>
        /// <returns></returns>
        public DevicesModel GetDeviceFromClientModelSession(int deviceID, int clientID)
        {

            ClientFullModel tmp = GetFullModelFromClientModel();

            return tmp.Naprave.Where(n => n.idNaprava == deviceID && n.idStranka == clientID).FirstOrDefault();
        }

        /// <summary>
        /// Delete Device instance from client model session and add new data to session.
        /// </summary>
        /// <param name="planID">Device ID</param>
        /// <param name="clientID">Client ID</param>
        /// <returns>Return true if delete is succesfull. Otherwise false.</returns>
        public bool DeleteDeviceFromClientModelSession(int deviceID, int clientID)
        {
            DevicesModel model = GetDeviceFromClientModelSession(deviceID, clientID);
            ClientFullModel tmp = GetFullModelFromClientModel();

            if (model != null && tmp != null)
            {
                bool isDeleted = tmp.Naprave.Remove(model);
                AddValueToSession(Enums.ClientSession.ClientModel, tmp);

                return isDeleted;
            }
            return false;
        }

        /// <summary>
        /// Add new Device instance to client model session
        /// </summary>
        /// <param name="model">New device instance to add</param>
        /// <returns>Returns true if adding was succesfull. Otherwise false.</returns>
        public bool AddDeviceToClientModelSession(DevicesModel model)
        {
            ClientFullModel fullModel = GetFullModelFromClientModel();
            if (fullModel != null)
            {
                fullModel.Naprave.Add(model);
                AddValueToSession(Enums.ClientSession.ClientModel, fullModel);

                return true;
            }
            return false;
        }

        /// <summary>
        /// Udate existing Device in client model session
        /// </summary>
        /// <param name="model">Existing device instance to update</param>
        /// <returns>Returns true if updating was succesfull. Otherwise false.</returns>
        public bool UpdateDeviceToClientModelSession(DevicesModel model)
        {
            ClientFullModel fullModel = GetFullModelFromClientModel();
            if (fullModel != null)
            {
                var record = fullModel.Naprave.Where(n => n.idNaprava == model.idNaprava).FirstOrDefault();
                if (record != null)
                {
                    int index = fullModel.Naprave.IndexOf(record);
                    if (index != -1)
                        fullModel.Naprave[index] = model;
                    else
                        return false;
                }
                else
                    return false;

                AddValueToSession(Enums.ClientSession.ClientModel, fullModel);

                return true;
            }
            return false;
        }
        #endregion

        #region Notes
        /// <summary>
        /// Returns NotesModel Instance from ClientModel session.
        /// </summary>
        /// <param name="planID">Device ID</param>
        /// <param name="clientID">Client ID</param>
        /// <returns></returns>
        public NotesModel GetNotesFromClientModelSession(int NotesID, int clientID)
        {

            ClientFullModel tmp = GetFullModelFromClientModel();

            return tmp.Opombe.Where(n => n.idOpombaStranka == NotesID && n.idStranka == clientID).FirstOrDefault();
        }

        /// <summary>
        /// Delete Notes instance from client model session and add new data to session.
        /// </summary>
        /// <param name="planID">Notes ID</param>
        /// <param name="clientID">Client ID</param>
        /// <returns>Return true if delete is succesfull. Otherwise false.</returns>
        public bool DeleteNotesFromClientModelSession(int NotesID, int clientID)
        {
            NotesModel model = GetNotesFromClientModelSession(NotesID, clientID);
            ClientFullModel tmp = GetFullModelFromClientModel();

            if (model != null && tmp != null)
            {
                bool isDeleted = tmp.Opombe.Remove(model);
                AddValueToSession(Enums.ClientSession.ClientModel, tmp);

                return isDeleted;
            }
            return false;
        }

        /// <summary>
        /// Add new Notes instance to client model session
        /// </summary>
        /// <param name="model">New Notes instance to add</param>
        /// <returns>Returns true if adding was succesfull. Otherwise false.</returns>
        public bool AddNotesToClientModelSession(NotesModel model)
        {
            ClientFullModel fullModel = GetFullModelFromClientModel();
            if (fullModel != null)
            {
                fullModel.Opombe.Add(model);
                AddValueToSession(Enums.ClientSession.ClientModel, fullModel);

                return true;
            }
            return false;
        }

        /// <summary>
        /// Udate existing Notes in client model session
        /// </summary>
        /// <param name="model">Existing Notes instance to update</param>
        /// <returns>Returns true if updating was succesfull. Otherwise false.</returns>
        public bool UpdateNotesToClientModelSession(NotesModel model)
        {
            ClientFullModel fullModel = GetFullModelFromClientModel();
            if (fullModel != null)
            {
                var record = fullModel.Opombe.Where(n => n.idOpombaStranka == model.idOpombaStranka).FirstOrDefault();
                if (record != null)
                {
                    int index = fullModel.Opombe.IndexOf(record);
                    if (index != -1)
                        fullModel.Opombe[index] = model;
                    else
                        return false;
                }
                else
                    return false;

                AddValueToSession(Enums.ClientSession.ClientModel, fullModel);

                return true;
            }
            return false;
        }
        #endregion

        #region Categorie
        /// <summary>
        /// Returns ClientCategorieModel Instance from ClientModel session.
        /// </summary>
        /// <param name="planID">Categorie ID</param>
        /// <param name="clientID">Client ID</param>
        /// <returns></returns>
        public ClientCategorieModel GetCategorieFromClientModelSession(int clientCategorieID, int clientID)
        {

            ClientFullModel tmp = GetFullModelFromClientModel();

            return tmp.StrankaKategorija.Where(sK => sK.idStrankaKategorija == clientCategorieID && sK.idStranka == clientID).FirstOrDefault();
        }


        /// <summary>
        /// Delete ClientCateogire instance from client model session and add new data to session.
        /// </summary>
        /// <param name="planID">Categorie ID</param>
        /// <param name="clientID">Client ID</param>
        /// <returns>Return true if delete is succesfull. Otherwise false.</returns>
        public bool DeleteCategorieFromClientModelSession(int clientCategorieID, int clientID)
        {
            ClientCategorieModel model = GetCategorieFromClientModelSession(clientCategorieID, clientID);
            ClientFullModel tmp = GetFullModelFromClientModel();

            if (model != null && tmp != null)
            {
                bool isDeleted = tmp.StrankaKategorija.Remove(model);
                AddValueToSession(Enums.ClientSession.ClientModel, tmp);

                return isDeleted;
            }
            return false;
        }

        /// <summary>
        /// Add new ClientCategorie instance to client model session
        /// </summary>
        /// <param name="model">New clientCategorie instance to add</param>
        /// <returns>Returns true if adding was succesfull. Otherwise false.</returns>
        public bool AddCategorieToClientModelSession(ClientCategorieModel model)
        {
            ClientFullModel fullModel = GetFullModelFromClientModel();
            if (fullModel != null)
            {
                fullModel.StrankaKategorija.Add(model);
                AddValueToSession(Enums.ClientSession.ClientModel, fullModel);

                return true;
            }
            return false;
        }

        /// <summary>
        /// Udate existing ClientCategorie in client model session
        /// </summary>
        /// <param name="model">Existing clientCategorie instance to update</param>
        /// <returns>Returns true if updating was succesfull. Otherwise false.</returns>
        public bool UpdateCategorieToClientModelSession(ClientCategorieModel model)
        {
            ClientFullModel fullModel = GetFullModelFromClientModel();
            if (fullModel != null)
            {
                var record = fullModel.StrankaKategorija.Where(sK => sK.idStrankaKategorija == model.idStrankaKategorija).FirstOrDefault();
                if (record != null)
                {
                    int index = fullModel.StrankaKategorija.IndexOf(record);
                    if (index != -1)
                        fullModel.StrankaKategorija[index] = model;
                    else
                        return false;
                }
                else
                    return false;

                AddValueToSession(Enums.ClientSession.ClientModel, fullModel);

                return true;
            }
            return false;
        }
        #endregion

        #region Charts
        /// <summary>
        /// Add list of charts to session
        /// </summary>
        /// <param name="model"></param>
        public void SetGraphBindingList(List<GraphBinding> list)
        {
            AddValueToSession(Enums.ChartSession.GraphCollection, list);
        }
        /// <summary>
        /// Returns all chart data From session. If session does not exist it returs null.
        /// </summary>
        /// <returns></returns>
        public List<GraphBinding> GetGraphBindingList()
        {
            if (SessionHasValue(Enums.ChartSession.GraphCollection))
                return (List<GraphBinding>)GetValueFromSession(Enums.ChartSession.GraphCollection);

            return null;
        }
        /// <summary>
        /// Set the main width of charts to be rendered on Chart Tab
        /// </summary>
        /// <param name="width">Width in pixels.</param>
        public void SetMainContentWidthForCharts(double width)
        {
            AddValueToSession(Enums.ChartSession.MainContentDivWidth, width);
        }
        /// <summary>
        /// Return the main content width for charts.
        /// </summary>
        /// <returns>
        ///     Returns number in pixels.
        /// </returns>
        public double GetMainContentWidthForCharts()
        {
            if (SessionHasValue(Enums.ChartSession.MainContentDivWidth))
                return (double)GetValueFromSession(Enums.ChartSession.MainContentDivWidth);

            return 0;
        }
        /// <summary>
        /// Set number of charts in row.
        /// </summary>
        /// <param name="width">Number of charts in row.</param>
        public void SetChartsCoutInRow(int num)
        {
            AddValueToSession(Enums.ChartSession.ChartDivWidth, num);
        }
        /// <summary>
        /// Return the number of charts in row.
        /// </summary>
        /// <returns>
        ///     Returns number.
        /// </returns>
        public int GetChartsCoutInRow()
        {
            if (SessionHasValue(Enums.ChartSession.ChartDivWidth))
                return (int)GetValueFromSession(Enums.ChartSession.ChartDivWidth);

            return 1;
        }

        #region Detail Chart
        /// <summary>
        /// Save current period selection in "detail chart display all types"
        /// </summary>
        /// <param name="selectedItemValue">Selected item value. Enums.ChartRenderPeriod type value.</param>
        public void SetSelectedPeriod_AllTypesDisplay(int? selectedItemValue)
        {
            AddValueToSession(Enums.ClientSession.DetailChartPeriodSelection, selectedItemValue.HasValue ? selectedItemValue.Value : selectedItemValue);
        }
        /// <summary>
        /// Returns previous period selection in Detail chart "Display All types filter".
        /// </summary>
        /// <returns>Value of Enums.ChartRenderPeriod type</returns>
        public int GetSelectedPeriod_AllTypesDisplay()
        {
            if (SessionHasValue(Enums.ClientSession.DetailChartPeriodSelection))
                return (int)GetValueFromSession(Enums.ClientSession.DetailChartPeriodSelection);
            return -1;
        }
        #endregion
        #endregion
    }
}