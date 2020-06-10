using AnalizaProdaje.Common;
using AnalizaProdaje.Domain.Concrete;
using DatabaseWebService.Models;
using DatabaseWebService.Models.Client;
using DevExpress.Web;
using DevExpress.XtraCharts;
using DevExpress.XtraCharts.Native;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.XtraCharts.Web;
namespace AnalizaProdaje.UserControls
{
    public delegate void ASPxButton1_Click(object sender, System.EventArgs e);
    public delegate void btnDeleteGraph_Click(object sender, System.EventArgs e);
    public delegate void addEventBtn_Click(object sender, System.EventArgs e);

    public partial class UserControlGraph : System.Web.UI.UserControl
    {
        public DataTable dataTableToBind;
        public event ASPxButton1_Click btnPostClk;
        public event btnDeleteGraph_Click btnDeleteGraphClick;
        public event addEventBtn_Click btnAddEventClick;

        private const int defaultChartWidth = 1100;
        private const int defaultChartHeight = 300;

        protected virtual void OnbtnDelClk(EventArgs e)
        {
            // Call btnPost_Click event delegate instance
            btnPostClk(this, e);
        }

        protected virtual void OnBtnDeleteGraphClick(EventArgs e)
        {
            btnDeleteGraphClick(this, e);
        }

        protected virtual void OnBtnAddEventClick(EventArgs e)
        {
            btnAddEventClick(this, e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            //ASPxGridLookupKomercialisti.DataBind();
            //CreateGraph("", "");/* $(document).ready(function () {});*/
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "script", "$(document).ready(function () {document.getElementById('clientBtnPrintChart').addEventListener('click', PrintChart); function PrintChart(){ chart.Print();}})", true);
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "script", "alert('hi');", true);

        }

        protected void ASPxButton1_Click(object sender, EventArgs e)
        {
            OnbtnDelClk(e);
        }

        private void InitializeWebChartControl()
        {
            WebChartControl1.Visible = true;

            int chartsCount = GetChartsCount();
            int width = GetChartDivWidth();

            WebChartControl1.Width = Unit.Pixel((width / chartsCount) - 50);
            WebChartControl1.Height = Unit.Pixel(defaultChartHeight);

            WebChartControl1.Legend.Visible = false;
        }

        public void CreateGraph(ChartRenderModel model)
        {
            InitializeWebChartControl();

            Series series1 = new Series("My Series", ViewType.Line);
            series1.ArgumentDataMember = "Datum";
            series1.ArgumentScaleType = ScaleType.DateTime;

            series1.ValueDataMembers[0] = "Vrednost";
            series1.ValueScaleType = ScaleType.Numerical;
            series1.Label.ResolveOverlappingMode = ResolveOverlappingMode.JustifyAllAroundPoint;
            series1.Label.ResolveOverlappingMinIndent = 1;
            series1.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;

            foreach (ChartRenderSimple item in model.chartRenderData)
            {
                SeriesPoint point1 = new SeriesPoint(item.Datum, new double[] { Convert.ToDouble(item.Vrednost) });
                point1.ToolTipHint = item.Datum.ToString("dd MMMM yyyy");
                series1.Points.Add(point1);
                series1.ToolTipEnabled = DevExpress.Utils.DefaultBoolean.True;
                series1.ToolTipPointPattern = "Datum: {HINT}";
                series1.CrosshairEnabled = DevExpress.Utils.DefaultBoolean.False;
            }

            WebChartControl1.Series.Add(series1);
            CreateEventsOnCharts(model, GetChartDivWidth(), GetChartsCount());

            ((XYDiagram2D)WebChartControl1.Diagram).GetAllAxesY()[0].Title.Visible = true;
            ((XYDiagram2D)WebChartControl1.Diagram).GetAllAxesY()[0].Title.Alignment = StringAlignment.Center;
            ((XYDiagram2D)WebChartControl1.Diagram).GetAllAxesY()[0].Title.Text = YAxisTitle;

        }

        public void CreateGraphMultiPane(List<ChartRenderModel> model = null)
        {
            InitializeWebChartControl();

            WebChartControl1.Height = Unit.Pixel(500);
            WebChartControl1.CrosshairEnabled = DevExpress.Utils.DefaultBoolean.True;
            WebChartControl1.CrosshairOptions.ArgumentLineColor = Color.DeepSkyBlue;
            WebChartControl1.CrosshairOptions.ArgumentLineStyle.Thickness = 1;
            WebChartControl1.CrosshairOptions.ShowOnlyInFocusedPane = false;


            // Cast the chart's diagram to the XYDiagram type, 
            // to access its axes and panes.
            XYDiagram diagram = (XYDiagram)WebChartControl1.Diagram;
            bool isFirstItem = true;
            int index = 0;

            foreach (var item in model)
            {
                if (item.chartRenderData.Count > 0)
                {
                    string enotaMere = item.chartRenderData[0].EnotaMere;
                    string type = ((Enums.ChartRenderType)item.chartRenderData[0].Tip).ToString() + " - " + enotaMere;
                    Series series = new Series(type, ViewType.Line);
                    series.ArgumentScaleType = ScaleType.DateTime;

                    foreach (var chartData in item.chartRenderData)
                    {
                        series.Points.Add(new SeriesPoint(chartData.Datum, new double[] { Convert.ToDouble(chartData.Vrednost) }));
                    }

                    WebChartControl1.Series.Add(series);

                    if (!isFirstItem)
                    {
                        diagram = (XYDiagram)WebChartControl1.Diagram;

                        diagram.SecondaryAxesX.Add(new SecondaryAxisX(type + "AxisX"));
                        diagram.SecondaryAxesY.Add(new SecondaryAxisY(type + "AxisY"));

                        diagram.SecondaryAxesX[index].Alignment = AxisAlignment.Near;
                        //diagram.SecondaryAxesX[0].Visible = true;
                        diagram.SecondaryAxesY[index].Alignment = AxisAlignment.Near;
                        diagram.SecondaryAxesY[index].Title.Visible = true;
                        diagram.SecondaryAxesY[index].Title.TextColor = Color.Black;
                        diagram.SecondaryAxesY[index].Title.Alignment = StringAlignment.Center;
                        diagram.SecondaryAxesY[index].Title.Text = type;
                        diagram.SecondaryAxesY[index].GridLines.Visible = true;

                        // Add a new additional pane to the diagram.
                        diagram.Panes.Add(new XYDiagramPane(type + "Pane"));

                        // Assign both the additional pane and, if required,
                        // the secondary axes to the second series. 
                        LineSeriesView myView = (LineSeriesView)series.View;

                        myView.AxisY = diagram.SecondaryAxesY[index];
                        myView.AxisY.Title.Text = type;

                        myView.AxisX = diagram.SecondaryAxesX[index];
                        // Note that the created pane has the zero index in the collection,
                        // because the existing Default pane is a separate entity.
                        myView.Pane = diagram.Panes[index];
                        myView.MarkerVisibility = DevExpress.Utils.DefaultBoolean.True;

                        if ((index - 1) >= 0)
                            diagram.SecondaryAxesX[index - 1].Visible = false;

                        index++;
                    }
                    else
                        CreateEventsOnCharts(item, GetChartDivWidth(), GetChartsCount(), true);

                    if (index == 0)
                        isFirstItem = false;
                }
            }

            //diagram.AxisX.GridLines.Visible = true;
            diagram.AxisX.Visible = false;
            diagram.AxisX.CrosshairAxisLabelOptions.Pattern = "{A:g}";

            diagram.AxisY.Title.Visible = true;
            diagram.AxisY.Title.TextColor = Color.Black;
            diagram.AxisY.Title.Alignment = StringAlignment.Center;
            diagram.AxisY.Title.Text = ((Enums.ChartRenderType)model[0].chartRenderData[0].Tip).ToString();


            // Customize the layout of the diagram's panes.
            diagram.PaneDistance = 4;
            diagram.PaneLayoutDirection = PaneLayoutDirection.Vertical;
            diagram.DefaultPane.SizeMode = PaneSizeMode.UseWeight;
            diagram.DefaultPane.Weight = 1.2;
        }

        private void CreateEventsOnCharts(ChartRenderModel model, int width, int chartsCount, bool isMultiPaneChart = false)
        {
            Series series2 = new Series("My Series2", ViewType.Bar);
            series2.ArgumentDataMember = "Datum";
            series2.ArgumentScaleType = ScaleType.DateTime;
            series2.ValueDataMembers[0] = "Vrednost";

            series2.ValueScaleType = ScaleType.Numerical;

            ((SideBySideBarSeriesView)series2.View).BarWidth = 1.4;

            double maxVrednost = Convert.ToDouble(model.chartRenderData.Max(crd => crd.Vrednost));
            if (model.EventList.Count > 0)
            {
                EventLinkWrap.Style.Add("max-width", ((width / chartsCount) - 50).ToString() + "px");
                model.EventList = model.EventList.OrderBy(el => el.DatumOtvoritve).ToList();//we sor elements from the youngest event to the oldest
                foreach (EventSimpleModel item in model.EventList)
                {
                    SeriesPoint point = new SeriesPoint(item.DatumOtvoritve, new double[] { maxVrednost });
                    point.ToolTipHint = item.DatumOtvoritve.ToString("dd MMMM yyyy") + (String.IsNullOrEmpty(item.Opis) ? "" : "\r\n" + "Opis: " + item.Opis);
                    series2.Points.Add(point);
                    string link = RedirectToEvent(item.idDogodek, item.idStranka, item.idKategorija, item.Izvajalec);
                    EventLinkWrap.InnerHtml += "<div class='eventLinkWrap'><a class='eventLink' href='" + link + "' title='Pojdi na dogodek st.: "
                        + item.idDogodek.ToString() + "'>" + item.DatumOtvoritve.ToString("dd MMMM yyyy") + "</a></div>";
                }

                ToolTipRelativePosition relativePosition = new ToolTipRelativePosition();
                WebChartControl1.ToolTipOptions.ToolTipPosition = relativePosition;

                relativePosition.OffsetX = 2;
                relativePosition.OffsetY = 2;

                series2.ToolTipEnabled = DevExpress.Utils.DefaultBoolean.True;
                series2.ToolTipPointPattern = "Datum dogodka: {HINT}";

                series2.CrosshairEnabled = DevExpress.Utils.DefaultBoolean.False;
            }

            WebChartControl1.Series.Add(series2);

            int newMinValue = -10;
            if (maxVrednost > 1000)
            {
                newMinValue = -100;
            }
            else if (maxVrednost > 100)
            {
                newMinValue = -10;
            }
            else
                newMinValue = -1;

            DateTimeGridAlignment dateTimeGridAlignment = DateTimeGridAlignment.Month;
            if (CommonMethods.ParseInt(rbPeriod.Value) == (int)Enums.ChartRenderPeriod.LETNO)
                dateTimeGridAlignment = DateTimeGridAlignment.Year;


            ((XYDiagram)WebChartControl1.Diagram).AxisX.Label.ResolveOverlappingOptions.AllowHide = false;
            if(!isMultiPaneChart) ((XYDiagram)WebChartControl1.Diagram).AxisX.DateTimeScaleOptions.GridAlignment = dateTimeGridAlignment;
            /*((XYDiagram)WebChartControl1.Diagram).AxisX.DateTimeScaleOptions.MeasureUnit = DateTimeMeasureUnit.Month;*/
            ((XYDiagram)WebChartControl1.Diagram).AxisX.Label.ResolveOverlappingOptions.AllowRotate = true;
            ((XYDiagram2D)WebChartControl1.Diagram).EnableAxisYZooming = true;
            ((XYDiagram2D)WebChartControl1.Diagram).GetAllAxesY()[0].WholeRange.MinValue = newMinValue;
        }

        private static String RedirectToEvent(int eventID, int clientID, int categorieID, int employeeID = 0)
        {
            List<QueryStrings> queryList = new List<QueryStrings>();

            QueryStrings item = new QueryStrings() { Attribute = Enums.QueryStringName.action.ToString(), Value = "2" };//edit
            queryList.Add(item);
            item = new QueryStrings() { Attribute = Enums.QueryStringName.recordId.ToString(), Value = eventID.ToString() };
            queryList.Add(item);
            item = new QueryStrings() { Attribute = Enums.QueryStringName.eventClientId.ToString(), Value = clientID.ToString() };
            queryList.Add(item);
            item = new QueryStrings() { Attribute = Enums.QueryStringName.eventCategorieId.ToString(), Value = categorieID.ToString() };
            queryList.Add(item);
            item = new QueryStrings() { Attribute = Enums.QueryStringName.eventEmployeeId.ToString(), Value = employeeID.ToString() };
            queryList.Add(item);
            QueryStringBuilder instance = new QueryStringBuilder(queryList);

            if(HttpContext.Current.Request.IsLocal)
                return "/Pages/CodeList/Events/EventsForm.aspx?" + instance.GenerateQueryString();
            else
                return ConfigurationManager.AppSettings["ServerTag"].ToString() + "Pages/CodeList/Events/EventsForm.aspx?" + instance.GenerateQueryString();
        }

        private int GetChartDivWidth()
        {
            double widthtmp = CommonMethods.ParseDouble(Session[Enums.ChartSession.MainContentDivWidth.ToString()].ToString());
            int width = Convert.ToInt32(widthtmp);
            if (width == 0)
                width = defaultChartWidth;

            return width;
        }

        private int GetChartsCount()
        {
            return CommonMethods.ParseInt(Session[Enums.ChartSession.ChartDivWidth.ToString()].ToString());
        }

        public ASPxHeadline HeaderName
        {
            get { return ChartHeaderName; }
            set { ChartHeaderName = value; }
        }

        public ASPxHyperLink HeaderLink
        {
            get { return ChartHyperLink; }
            set { ChartHyperLink = value; }
        }

        public ASPxRadioButtonList Period
        {
            get { return rbPeriod; }
        }

        public ASPxRadioButtonList Type
        {
            get { return rbType; }
        }

        public ASPxButton RenderChart
        {
            get { return ASPxButton1; }
        }

        public ASPxDateEdit DateEdit_OD
        {
            get { return UserControlDateEdit_OD; }
        }

        public ASPxDateEdit DateEdit_DO
        {
            get { return UserControlDateEdit_DO; }
        }

        private int catID;
        public int CategorieID
        {
            get { return catID; }
            set { catID = value; }
        }

        private string yAxisTitle;
        public string YAxisTitle
        {
            get { return yAxisTitle; }
            set { yAxisTitle = value; }
        }

        private bool showFromToDateFilteringUserControl;
        public bool ShowFromToDateFilteringUserControl
        {
            get { return showFromToDateFilteringUserControl; }
            set
            {
                showFromToDateFilteringUserControl = value;
                if (showFromToDateFilteringUserControl) filteringFromToDateBlock.Style.Add("display", "flex");
            }
        }

        protected void btnDeleteGraph_Click(object sender, EventArgs e)
        {
            OnBtnDeleteGraphClick(e);
        }



        protected void addEventBtn_Click(object sender, EventArgs e)
        {
            OnBtnAddEventClick(e);
        }
    }
}