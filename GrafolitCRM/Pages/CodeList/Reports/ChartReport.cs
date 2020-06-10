using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using System.Collections.Generic;
using AnalizaProdaje.Domain.Helpers;
using DevExpress.XtraCharts;
using System.Data;
using DatabaseWebService.Models;
using AnalizaProdaje.Common;
using DatabaseWebService.Models.Client;
using System.Linq;
using DevExpress.XtraPrinting;

namespace AnalizaProdaje.Pages.CodeList.Reports
{
    public partial class ChartReport : DevExpress.XtraReports.UI.XtraReport
    {
        private List<GraphBinding> ChartData;
        private ClientFullModel clientModel;
        public ChartReport(List<GraphBinding> data, ClientFullModel _clientModel)
        {
            ChartData = data;
            clientModel = _clientModel;
            InitializeComponent();
            
            if (ChartData != null && ChartData.Count > 0)
            {
                ReportChartDescription();
                PrintDocument();
            }
        }

        private void ReportChartDescription()
        {
            xrLblCreationDate.Text = "Datum izpisa: " + DateTime.Now.ToShortDateString();
            xrLblClient.Text = clientModel != null ? "Stranka: " + clientModel.NazivPrvi : "";
            xrLblClientEmployee.Text = clientModel != null ? (clientModel.StrankaZaposleni != null && clientModel.StrankaZaposleni.Count > 0) ? "Zaposlen: " +
                clientModel.StrankaZaposleni[0].oseba.Ime + " " +
                clientModel.StrankaZaposleni[0].oseba.Priimek : "" : "";
            
            
            xrLblCategorieTitle.Text = ChartData[0].HeaderText;
            companyLogo.ImageUrl = "~/Images/logoGrafoLit.png";
            companyLogo.Visible = true;

            if (ChartData[0].chartDataMultiplePanes != null)//if we show all types on one chart in report
                xrLblType.Text = "Tip: " + "Vsi";
            else
                xrLblType.Text = ChartData[0].tip > 0 ? "Tip: " + ((Enums.ChartRenderType)ChartData[0].tip).ToString() : "";

            if (ChartData[0].dateFrom.CompareTo(DateTime.MinValue) > 0 && ChartData[0].dateTo.CompareTo(DateTime.MinValue) > 0)//if we select period from and to date
                xrLblPeriod.Text = "Obdobje: " + ChartData[0].dateFrom.ToShortDateString() + " - " + ChartData[0].dateTo.ToShortDateString();
            else
                xrLblPeriod.Text = ChartData[0].obdobje > 0 ? "Obdobje: " + ((Enums.ChartRenderPeriod)ChartData[0].obdobje).ToString() : "";
        }
        private void PrintDocument()
        {
            if (ChartData[0].chartDataMultiplePanes != null)
            {
                DrawMultiplePane();
                RenderEventTableOnReport(ChartData[0].chartDataMultiplePanes[0]);
            }
            else
            {
                DrawSinglePane();
                RenderEventTableOnReport(ChartData[0].chartData);
            }
        }

        private void DrawSinglePane()
        {
            Series series1 = new Series("My Series", ViewType.Line);

            series1.ArgumentDataMember = "Datum";
            series1.ArgumentScaleType = ScaleType.DateTime;

            series1.ValueDataMembers[0] = "Vrednost";
            series1.ValueScaleType = ScaleType.Numerical;
            series1.Label.ResolveOverlappingMode = ResolveOverlappingMode.JustifyAllAroundPoint;
            series1.Label.ResolveOverlappingMinIndent = 1;
            series1.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;


            foreach (ChartRenderSimple item in ChartData[0].chartData.chartRenderData)
            {

                SeriesPoint point1 = new SeriesPoint(item.Datum, new double[] { Convert.ToDouble(item.Vrednost) });
                point1.ToolTipHint = item.Datum.ToString("dd MMMM yyyy");
                series1.Points.Add(point1);
                series1.ToolTipEnabled = DevExpress.Utils.DefaultBoolean.True;
                series1.ToolTipPointPattern = "Datum: {HINT}";
                series1.CrosshairEnabled = DevExpress.Utils.DefaultBoolean.False;
            }

            //xrDataChart.DataSource = dt;
            xrDataChart.Series.Add(series1);
            CreateEventsOnCharts(ChartData[0].chartData);

            ((XYDiagram2D)xrDataChart.Diagram).GetAllAxesY()[0].Title.Visible = true;
            ((XYDiagram2D)xrDataChart.Diagram).GetAllAxesY()[0].Title.Alignment = StringAlignment.Center;
            ((XYDiagram2D)xrDataChart.Diagram).GetAllAxesY()[0].Title.Text = ChartData[0].YAxisTitle;
        }

        private void DrawMultiplePane()
        {
            xrDataChart.Legend.Visible = false;
            xrDataChart.HeightF = 500f;
            // Cast the chart's diagram to the XYDiagram type, 
            // to access its axes and panes.
            XYDiagram diagram = (XYDiagram)xrDataChart.Diagram;
            bool isFirstItem = true;
            int index = 0;

            foreach (var item in ChartData[0].chartDataMultiplePanes)
            {
                if (item.chartRenderData.Count > 0)
                {
                    string enotaMere = item.chartRenderData[0].EnotaMere;
                    string type = ((Enums.ChartRenderType)item.chartRenderData[0].Tip).ToString() + " - " + enotaMere;
                    Series series = new Series(type, ViewType.Line);
                    series.ArgumentScaleType = ScaleType.DateTime;
                    series.LabelsVisibility = DevExpress.Utils.DefaultBoolean.True;

                    foreach (var chartData in item.chartRenderData)
                    {
                        series.Points.Add(new SeriesPoint(chartData.Datum, new double[] { Convert.ToDouble(chartData.Vrednost) }));
                    }

                    xrDataChart.Series.Add(series);

                    if (!isFirstItem)
                    {
                        diagram = (XYDiagram)xrDataChart.Diagram;

                        diagram.SecondaryAxesX.Add(new SecondaryAxisX(type + "AxisX"));
                        diagram.SecondaryAxesY.Add(new SecondaryAxisY(type + "AxisY"));

                        diagram.SecondaryAxesX[index].Alignment = AxisAlignment.Near;
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
                        CreateEventsOnCharts(item, true);

                    if (index == 0)
                        isFirstItem = false;
                }
            }

            //myView.Transparency = 0;

            //diagram.AxisX.GridLines.Visible = true;
            diagram.AxisX.Visible = false;
            //diagram.AxisX.CrosshairAxisLabelOptions.Pattern = "{A:g}";

            diagram.AxisY.Title.Visible = true;
            diagram.AxisY.Title.TextColor = Color.Black;
            diagram.AxisY.Title.Alignment = StringAlignment.Center;
            diagram.AxisY.Title.Text = ((Enums.ChartRenderType)ChartData[0].chartDataMultiplePanes[0].chartRenderData[0].Tip).ToString();


            // Customize the layout of the diagram's panes.
            diagram.PaneDistance = 2;
            diagram.PaneLayoutDirection = PaneLayoutDirection.Vertical;
            diagram.DefaultPane.SizeMode = PaneSizeMode.UseWeight;
            diagram.DefaultPane.Weight = 1.2;
        }

        private void CreateEventsOnCharts(ChartRenderModel model, bool isMultiPaneChart = false)
        {

            Series series2 = new Series("My Series2", ViewType.Bar);
            series2.ArgumentDataMember = "Datum";
            series2.ArgumentScaleType = ScaleType.DateTime;
            series2.ValueDataMembers[0] = "Vrednost";

            series2.LabelsVisibility = DevExpress.Utils.DefaultBoolean.False;

            series2.ValueScaleType = ScaleType.Numerical;

            ((SideBySideBarSeriesView)series2.View).BarWidth = 1.4;

            double maxVrednost = Convert.ToDouble(model.chartRenderData.Max(crd => crd.Vrednost));
            if (model.EventList.Count > 0)
            {
                //EventLinkWrap.Style.Add("max-width", ((width / chartsCount) - 50).ToString() + "px");
                model.EventList = model.EventList.OrderBy(el => el.DatumOtvoritve).ToList();//we sor elements from the youngest event to the oldest
                foreach (EventSimpleModel item in model.EventList)
                {
                    SeriesPoint point = new SeriesPoint(item.DatumOtvoritve, new double[] { maxVrednost });
                    point.ToolTipHint = item.DatumOtvoritve.ToString("dd MMMM yyyy") + (String.IsNullOrEmpty(item.Opis) ? "" : "\r\n" + "Opis: " + item.Opis);
                    series2.Points.Add(point);
                    /*string link = RedirectToEvent(item.idDogodek, item.idStranka, item.idKategorija, item.Izvajalec);
                    EventLinkWrap.InnerHtml += "<div class='eventLinkWrap'><a class='eventLink' href='" + link + "' title='Pojdi na dogodek st.: "
                        + item.idDogodek.ToString() + "'>" + item.DatumOtvoritve.ToString("dd MMMM yyyy") + "</a></div>";*/
                }

                /*ToolTipRelativePosition relativePosition = new ToolTipRelativePosition();
                xrDataChart.ToolTipOptions.ToolTipPosition = relativePosition;

                relativePosition.OffsetX = 2;
                relativePosition.OffsetY = 2;*/

                series2.ToolTipEnabled = DevExpress.Utils.DefaultBoolean.True;
                series2.ToolTipPointPattern = "Datum dogodka: {HINT}";

                series2.CrosshairEnabled = DevExpress.Utils.DefaultBoolean.False;
            }

            xrDataChart.Series.Add(series2);

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
            if (CommonMethods.ParseInt(model.chartRenderData[0].Obdobje) == (int)Enums.ChartRenderPeriod.LETNO)
                dateTimeGridAlignment = DateTimeGridAlignment.Year;


            ((XYDiagram)xrDataChart.Diagram).AxisX.Label.ResolveOverlappingOptions.AllowHide = false;
            if (!isMultiPaneChart) ((XYDiagram)xrDataChart.Diagram).AxisX.DateTimeScaleOptions.GridAlignment = dateTimeGridAlignment;
            //((XYDiagram)WebChartControl1.Diagram).AxisX.DateTimeScaleOptions.MeasureUnit = DateTimeMeasureUnit.Month;
            ((XYDiagram)xrDataChart.Diagram).AxisX.Label.ResolveOverlappingOptions.AllowRotate = true;
            ((XYDiagram2D)xrDataChart.Diagram).EnableAxisYZooming = true;
            ((XYDiagram2D)xrDataChart.Diagram).GetAllAxesY()[0].WholeRange.MinValue = newMinValue;

        }

        private void RenderEventTableOnReport(ChartRenderModel model)
        {
            if (model.EventList != null && model.EventList.Count > 0)
            {
                PaddingInfo info = new PaddingInfo();
                info.Top = 10;
                info.Bottom = 5;

                foreach (var item in model.EventList)
                {
                    XRTableRow row = new XRTableRow();
                    XRTableCell cell = new XRTableCell();
                    cell.WidthF = 182.5f;
                    cell.Text = item.DatumOtvoritve.ToShortDateString();
                    cell.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
                    row.Cells.Add(cell);

                    cell = new XRTableCell();
                    cell.WidthF = 182.5f;
                    cell.Text = item.Rok.CompareTo(DateTime.MaxValue) > 0 ? item.Rok.ToShortDateString() : "Not-defined";
                    cell.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
                    row.Cells.Add(cell);

                    cell = new XRTableCell();
                    cell.WidthF = 515f;
                    cell.Text = !String.IsNullOrEmpty(item.Opis) ? item.Opis : "Not-defined";
                    cell.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
                    cell.Multiline = true;
                    row.Cells.Add(cell);

                    row.Padding = info;

                    xrTableDogodki.Rows.Add(row);
                }
            }
            else
            {
                xrTableDogodki.Visible = false;
                xrLabelTitleDogodki.Visible = false;
            }
        }
    }
}
