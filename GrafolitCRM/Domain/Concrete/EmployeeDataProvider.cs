using AnalizaProdaje.Common;
using DatabaseWebService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AnalizaProdaje.Domain.Concrete
{
    public class EmployeeDataProvider : ServerMasterPage
    {
        public bool AddEmployeesToSession(List<EmployeeSimpleModel> model)
        {
            if (model != null)
            {
                AddValueToSession(Enums.EmployeeSession.EmployeesList, model);

                return true;
            }
            return false;
        }

        public List<EmployeeSimpleModel> GetEmployeesFromSession()
        {
            if (SessionHasValue(Enums.EmployeeSession.EmployeesList))
                return (List<EmployeeSimpleModel>)GetValueFromSession(Enums.EmployeeSession.EmployeesList);

            return null;
        }

        /// <summary>
        /// Add employeeFullModel instance to session
        /// </summary>
        /// <param name="model"></param>
        public void SetEmployeeFullModel(EmployeeFullModel model)
        {
            AddValueToSession(Enums.EmployeeSession.EmployeeFullModel, model);
        }

        /// <summary>
        /// Returns all employee data From session. If session does not exist it returs null.
        /// </summary>
        /// <returns></returns>
        public EmployeeFullModel GetFullEmployeeModel()
        {
            if (SessionHasValue(Enums.EmployeeSession.EmployeeFullModel))
                return (EmployeeFullModel)GetValueFromSession(Enums.EmployeeSession.EmployeeFullModel);

            return null;
        }
    }
}