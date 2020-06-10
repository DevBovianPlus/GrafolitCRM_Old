using AnalizaProdaje.Common;
using DatabaseWebService.Models.Event;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AnalizaProdaje.Domain.Concrete
{
    public class EventDataProvider : ServerMasterPage
    {
        /// <summary>
        /// Add Event full model instance to session
        /// </summary>
        /// <param name="model"></param>
        public void SetEventFullModel(EventFullModel model)
        {
            AddValueToSession(Enums.EventSession.EventModel, model);
        }

        /// <summary>
        /// Returns all event data From session. If session does not exist it returs null.
        /// </summary>
        /// <returns></returns>
        public EventFullModel GetEventFullModel()
        {
            if (SessionHasValue(Enums.EventSession.EventModel))
                return (EventFullModel)GetValueFromSession(Enums.EventSession.EventModel);

            return null;
        }

        /// <summary>
        /// Returns MessageModel Instance from EventFulModel session.
        /// </summary>
        /// <param name="planID">Message ID</param>
        /// <param name="clientID">Event ID</param>
        /// <returns>MessageModel</returns>
        public MessageModel GetMessageFromEventModelSession(int messageID, int eventID)
        {

            EventFullModel tmp = GetEventFullModel();

            return tmp.Sporocila.Where(s => s.idSporocila == messageID && s.IDDogodek == eventID).FirstOrDefault();
        }

        /// <summary>
        /// Add new Message instance to event model session
        /// </summary>
        /// <param name="model">New message instance to add</param>
        /// <returns>Returns true if adding was succesfull. Otherwise false.</returns>
        public bool AddMessageToEventModelSession(MessageModel model)
        {
            EventFullModel fullModel = GetEventFullModel();
            if (fullModel != null)
            {
                fullModel.Sporocila.Add(model);
                AddValueToSession(Enums.EventSession.EventModel, fullModel);

                return true;
            }
            return false;
        }

        /// <summary>
        /// Udate existing Message in event model session
        /// </summary>
        /// <param name="model">Existing message instance to update</param>
        /// <returns>Returns true if updating was succesfull. Otherwise false.</returns>
        public bool UpdateMessageToEventModelSession(MessageModel model)
        {
            EventFullModel fullModel = GetEventFullModel();
            if (fullModel != null)
            {
                var record = fullModel.Sporocila.Where(s => s.idSporocila == model.idSporocila).FirstOrDefault();
                if (record != null)
                {
                    int index = fullModel.Sporocila.IndexOf(record);
                    if (index != -1)
                        fullModel.Sporocila[index] = model;
                    else
                        return false;
                }
                else
                    return false;

                AddValueToSession(Enums.EventSession.EventModel, fullModel);

                return true;
            }
            return false;
        }

        /// <summary>
        /// Delete Message instance from event model session and add new data to session.
        /// </summary>
        /// <param name="planID">Message ID</param>
        /// <param name="clientID">Event ID</param>
        /// <returns>Return true if delete is succesfull. Otherwise false.</returns>
        public bool DeletePlanFromClientModelSession(int messageID, int eventID)
        {
            MessageModel model = GetMessageFromEventModelSession(messageID, eventID);
            EventFullModel tmp = GetEventFullModel();

            if (model != null && tmp != null)
            {
                bool isDeleted = tmp.Sporocila.Remove(model);
                AddValueToSession(Enums.EventSession.EventModel, tmp);

                return isDeleted;
            }
            return false;
        }


        /// <summary>
        /// Returns EventMeetingModel Instance from EventFulModel session.
        /// </summary>
        /// <param name="planID">Event meeting ID</param>
        /// <param name="clientID">Event ID</param>
        /// <returns>EventMeetingModel</returns>
        public EventMeetingModel GetEventMeetingFromEventModelSession(int eventMeetingID, int eventID)
        {

            EventFullModel tmp = GetEventFullModel();

            return tmp.SestanekDokumenti.Where(sd => sd.DogodekSestanekID == eventMeetingID && sd.DogodekID == eventID).FirstOrDefault();
        }


        /// <summary>
        /// Add new EventMeetingModel instance to event model session
        /// </summary>
        /// <param name="model">New EventMeetingModel instance to add</param>
        /// <returns>Returns true if adding was succesfull. Otherwise false.</returns>
        public bool AddEventMeetingToEventModelSession(EventMeetingModel model)
        {
            EventFullModel fullModel = GetEventFullModel();
            if (fullModel != null)
            {
                if (fullModel.SestanekDokumenti == null)
                    fullModel.SestanekDokumenti = new List<EventMeetingModel>();

                fullModel.SestanekDokumenti.Add(model);
                AddValueToSession(Enums.EventSession.EventModel, fullModel);

                return true;
            }
            return false;
        }

        /// <summary>
        /// Udate existing EventMeetingModel in event model session
        /// </summary>
        /// <param name="model">Existing eventMeeting instance to update</param>
        /// <returns>Returns true if updating was succesfull. Otherwise false.</returns>
        public bool UpdateEventMeetingToEventModelSession(EventMeetingModel model)
        {
            EventFullModel fullModel = GetEventFullModel();
            if (fullModel != null)
            {
                var record = fullModel.SestanekDokumenti.Where(sd => sd.DogodekSestanekID == model.DogodekSestanekID).FirstOrDefault();
                if (record != null)
                {
                    int index = fullModel.SestanekDokumenti.IndexOf(record);
                    if (index != -1)
                        fullModel.SestanekDokumenti[index] = model;
                    else
                        return false;
                }
                else
                    return false;

                AddValueToSession(Enums.EventSession.EventModel, fullModel);

                return true;
            }
            return false;
        }

        /// <summary>
        /// Delete EventMeetingModel instance from event model session and add new data to session.
        /// </summary>
        /// <param name="planID">Message ID</param>
        /// <param name="clientID">Event ID</param>
        /// <returns>Return true if delete is succesfull. Otherwise false.</returns>
        public bool DeleteEventMeetingClientModelSession(int eventMeetingID, int eventID)
        {
            EventMeetingModel model = GetEventMeetingFromEventModelSession(eventMeetingID, eventID);
            EventFullModel tmp = GetEventFullModel();

            if (model != null && tmp != null)
            {
                bool isDeleted = tmp.SestanekDokumenti.Remove(model);
                AddValueToSession(Enums.EventSession.EventModel, tmp);

                return isDeleted;
            }
            return false;
        }
    }
}