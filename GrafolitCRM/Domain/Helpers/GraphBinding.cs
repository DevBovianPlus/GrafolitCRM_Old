using DatabaseWebService.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace AnalizaProdaje.Domain.Helpers
{
    public class GraphBinding
    {
        public Control control { get; set; }
        public ChartRenderModel chartData { get; set; }

        public List<ChartRenderModel> chartDataMultiplePanes { get; set; }

        public string HeaderText { get; set; }

        public int obdobje { get; set; }
        public string Obdobje { get; set; }
        public int tip { get; set; }
        public string Tip { get; set; }

        public int CategorieID { get; set; }

        public string YAxisTitle { get; set; }

        public bool ShowFilterFromToDate { get; set; }

        public DateTime dateFrom { get; set; }//only for report use
        public DateTime dateTo { get; set; }//only for report use
    }
}