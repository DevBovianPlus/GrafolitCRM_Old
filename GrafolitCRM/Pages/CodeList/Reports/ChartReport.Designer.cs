namespace AnalizaProdaje.Pages.CodeList.Reports
{
    partial class ChartReport
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary> 
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            DevExpress.XtraCharts.LineSeriesView lineSeriesView1 = new DevExpress.XtraCharts.LineSeriesView();
            this.Detail = new DevExpress.XtraReports.UI.DetailBand();
            this.TopMargin = new DevExpress.XtraReports.UI.TopMarginBand();
            this.BottomMargin = new DevExpress.XtraReports.UI.BottomMarginBand();
            this.DetailReport = new DevExpress.XtraReports.UI.DetailReportBand();
            this.Detail1 = new DevExpress.XtraReports.UI.DetailBand();
            this.xrDataChart = new DevExpress.XtraReports.UI.XRChart();
            this.xrLblCategorieTitle = new DevExpress.XtraReports.UI.XRLabel();
            this.ReportHeader = new DevExpress.XtraReports.UI.ReportHeaderBand();
            this.xrLblPeriod = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLblClientEmployee = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLblType = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLblClient = new DevExpress.XtraReports.UI.XRLabel();
            this.xrLblCreationDate = new DevExpress.XtraReports.UI.XRLabel();
            this.companyLogo = new DevExpress.XtraReports.UI.XRPictureBox();
            this.directorySearcher1 = new System.DirectoryServices.DirectorySearcher();
            this.xrTableDogodki = new DevExpress.XtraReports.UI.XRTable();
            this.xrTableRow1 = new DevExpress.XtraReports.UI.XRTableRow();
            this.xrTableCell1 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell2 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrTableCell3 = new DevExpress.XtraReports.UI.XRTableCell();
            this.xrLabelTitleDogodki = new DevExpress.XtraReports.UI.XRLabel();
            this.DetailReport1 = new DevExpress.XtraReports.UI.DetailReportBand();
            this.Detail2 = new DevExpress.XtraReports.UI.DetailBand();
            ((System.ComponentModel.ISupportInitialize)(this.xrDataChart)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(lineSeriesView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.xrTableDogodki)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this)).BeginInit();
            // 
            // Detail
            // 
            this.Detail.Expanded = false;
            this.Detail.HeightF = 0F;
            this.Detail.KeepTogether = true;
            this.Detail.Name = "Detail";
            this.Detail.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.Detail.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // TopMargin
            // 
            this.TopMargin.HeightF = 0F;
            this.TopMargin.Name = "TopMargin";
            this.TopMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.TopMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // BottomMargin
            // 
            this.BottomMargin.HeightF = 28.33333F;
            this.BottomMargin.Name = "BottomMargin";
            this.BottomMargin.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 0, 100F);
            this.BottomMargin.TextAlignment = DevExpress.XtraPrinting.TextAlignment.TopLeft;
            // 
            // DetailReport
            // 
            this.DetailReport.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail1});
            this.DetailReport.Level = 0;
            this.DetailReport.Name = "DetailReport";
            // 
            // Detail1
            // 
            this.Detail1.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.Detail1.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrDataChart});
            this.Detail1.HeightF = 410F;
            this.Detail1.Name = "Detail1";
            this.Detail1.StylePriority.UseBorders = false;
            // 
            // xrDataChart
            // 
            this.xrDataChart.BorderColor = System.Drawing.Color.Black;
            this.xrDataChart.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrDataChart.Legend.Visible = false;
            this.xrDataChart.LocationFloat = new DevExpress.Utils.PointFloat(9.999988F, 0F);
            this.xrDataChart.Name = "xrDataChart";
            this.xrDataChart.SeriesSerializable = new DevExpress.XtraCharts.Series[0];
            this.xrDataChart.SeriesTemplate.View = lineSeriesView1;
            this.xrDataChart.SizeF = new System.Drawing.SizeF(880F, 349.1667F);
            // 
            // xrLblCategorieTitle
            // 
            this.xrLblCategorieTitle.Font = new System.Drawing.Font("Verdana", 13F, System.Drawing.FontStyle.Bold);
            this.xrLblCategorieTitle.LocationFloat = new DevExpress.Utils.PointFloat(351.6667F, 139.1667F);
            this.xrLblCategorieTitle.Name = "xrLblCategorieTitle";
            this.xrLblCategorieTitle.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLblCategorieTitle.SizeF = new System.Drawing.SizeF(198.3333F, 23F);
            this.xrLblCategorieTitle.StylePriority.UseFont = false;
            this.xrLblCategorieTitle.StylePriority.UseTextAlignment = false;
            this.xrLblCategorieTitle.Text = "PAGE HEADER";
            this.xrLblCategorieTitle.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            // 
            // ReportHeader
            // 
            this.ReportHeader.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrLblPeriod,
            this.xrLblClientEmployee,
            this.xrLblType,
            this.xrLblClient,
            this.xrLblCreationDate,
            this.companyLogo,
            this.xrLblCategorieTitle});
            this.ReportHeader.HeightF = 185.8333F;
            this.ReportHeader.Name = "ReportHeader";
            // 
            // xrLblPeriod
            // 
            this.xrLblPeriod.Font = new System.Drawing.Font("Verdana", 9F);
            this.xrLblPeriod.LocationFloat = new DevExpress.Utils.PointFloat(700.8333F, 102F);
            this.xrLblPeriod.Name = "xrLblPeriod";
            this.xrLblPeriod.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLblPeriod.SizeF = new System.Drawing.SizeF(199.1667F, 22.99999F);
            this.xrLblPeriod.StylePriority.UseFont = false;
            this.xrLblPeriod.Text = "Obdobje";
            // 
            // xrLblClientEmployee
            // 
            this.xrLblClientEmployee.Font = new System.Drawing.Font("Verdana", 9F);
            this.xrLblClientEmployee.LocationFloat = new DevExpress.Utils.PointFloat(700.8333F, 78.99999F);
            this.xrLblClientEmployee.Name = "xrLblClientEmployee";
            this.xrLblClientEmployee.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLblClientEmployee.SizeF = new System.Drawing.SizeF(199.1667F, 23.00001F);
            this.xrLblClientEmployee.StylePriority.UseFont = false;
            this.xrLblClientEmployee.Text = "StrankaZaposlen";
            // 
            // xrLblType
            // 
            this.xrLblType.Font = new System.Drawing.Font("Verdana", 9F);
            this.xrLblType.LocationFloat = new DevExpress.Utils.PointFloat(700.8333F, 55.99998F);
            this.xrLblType.Name = "xrLblType";
            this.xrLblType.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLblType.SizeF = new System.Drawing.SizeF(199.1667F, 23F);
            this.xrLblType.StylePriority.UseFont = false;
            this.xrLblType.Text = "Tip";
            // 
            // xrLblClient
            // 
            this.xrLblClient.Font = new System.Drawing.Font("Verdana", 9F);
            this.xrLblClient.LocationFloat = new DevExpress.Utils.PointFloat(700.8333F, 32.99999F);
            this.xrLblClient.Name = "xrLblClient";
            this.xrLblClient.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLblClient.SizeF = new System.Drawing.SizeF(199.1667F, 23F);
            this.xrLblClient.StylePriority.UseFont = false;
            this.xrLblClient.Text = "Stranka";
            // 
            // xrLblCreationDate
            // 
            this.xrLblCreationDate.Font = new System.Drawing.Font("Verdana", 9F);
            this.xrLblCreationDate.LocationFloat = new DevExpress.Utils.PointFloat(700.8333F, 10F);
            this.xrLblCreationDate.Name = "xrLblCreationDate";
            this.xrLblCreationDate.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLblCreationDate.SizeF = new System.Drawing.SizeF(199.1667F, 23F);
            this.xrLblCreationDate.StylePriority.UseFont = false;
            this.xrLblCreationDate.Text = "Datum izpisa";
            // 
            // companyLogo
            // 
            this.companyLogo.LocationFloat = new DevExpress.Utils.PointFloat(0F, 0F);
            this.companyLogo.Name = "companyLogo";
            this.companyLogo.SizeF = new System.Drawing.SizeF(160F, 70F);
            this.companyLogo.Sizing = DevExpress.XtraPrinting.ImageSizeMode.Squeeze;
            // 
            // directorySearcher1
            // 
            this.directorySearcher1.ClientTimeout = System.TimeSpan.Parse("-00:00:01");
            this.directorySearcher1.ServerPageTimeLimit = System.TimeSpan.Parse("-00:00:01");
            this.directorySearcher1.ServerTimeLimit = System.TimeSpan.Parse("-00:00:01");
            // 
            // xrTableDogodki
            // 
            this.xrTableDogodki.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrTableDogodki.Font = new System.Drawing.Font("Verdana", 9F);
            this.xrTableDogodki.LocationFloat = new DevExpress.Utils.PointFloat(10.00003F, 65F);
            this.xrTableDogodki.Name = "xrTableDogodki";
            this.xrTableDogodki.Rows.AddRange(new DevExpress.XtraReports.UI.XRTableRow[] {
            this.xrTableRow1});
            this.xrTableDogodki.SizeF = new System.Drawing.SizeF(880F, 25F);
            this.xrTableDogodki.StylePriority.UseBorders = false;
            this.xrTableDogodki.StylePriority.UseFont = false;
            this.xrTableDogodki.StylePriority.UseTextAlignment = false;
            this.xrTableDogodki.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            // 
            // xrTableRow1
            // 
            this.xrTableRow1.Cells.AddRange(new DevExpress.XtraReports.UI.XRTableCell[] {
            this.xrTableCell1,
            this.xrTableCell2,
            this.xrTableCell3});
            this.xrTableRow1.Name = "xrTableRow1";
            this.xrTableRow1.Weight = 1D;
            // 
            // xrTableCell1
            // 
            this.xrTableCell1.Borders = DevExpress.XtraPrinting.BorderSide.Bottom;
            this.xrTableCell1.Font = new System.Drawing.Font("Verdana", 9F, System.Drawing.FontStyle.Bold);
            this.xrTableCell1.Name = "xrTableCell1";
            this.xrTableCell1.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 5, 100F);
            this.xrTableCell1.StylePriority.UseBorders = false;
            this.xrTableCell1.StylePriority.UseFont = false;
            this.xrTableCell1.StylePriority.UsePadding = false;
            this.xrTableCell1.StylePriority.UseTextAlignment = false;
            this.xrTableCell1.Text = "DATUM OTVORITVE";
            this.xrTableCell1.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            this.xrTableCell1.Weight = 0.62215905623002477D;
            // 
            // xrTableCell2
            // 
            this.xrTableCell2.Font = new System.Drawing.Font("Verdana", 9F, System.Drawing.FontStyle.Bold);
            this.xrTableCell2.Name = "xrTableCell2";
            this.xrTableCell2.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 5, 100F);
            this.xrTableCell2.StylePriority.UseFont = false;
            this.xrTableCell2.StylePriority.UsePadding = false;
            this.xrTableCell2.StylePriority.UseTextAlignment = false;
            this.xrTableCell2.Text = "ROK";
            this.xrTableCell2.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            this.xrTableCell2.Weight = 0.62215910824862408D;
            // 
            // xrTableCell3
            // 
            this.xrTableCell3.Font = new System.Drawing.Font("Verdana", 9F, System.Drawing.FontStyle.Bold);
            this.xrTableCell3.Name = "xrTableCell3";
            this.xrTableCell3.Padding = new DevExpress.XtraPrinting.PaddingInfo(0, 0, 0, 5, 100F);
            this.xrTableCell3.StylePriority.UseFont = false;
            this.xrTableCell3.StylePriority.UsePadding = false;
            this.xrTableCell3.StylePriority.UseTextAlignment = false;
            this.xrTableCell3.Text = "OPIS";
            this.xrTableCell3.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleCenter;
            this.xrTableCell3.Weight = 1.7556818355213513D;
            // 
            // xrLabelTitleDogodki
            // 
            this.xrLabelTitleDogodki.Borders = DevExpress.XtraPrinting.BorderSide.None;
            this.xrLabelTitleDogodki.Font = new System.Drawing.Font("Verdana", 12F, System.Drawing.FontStyle.Bold);
            this.xrLabelTitleDogodki.LocationFloat = new DevExpress.Utils.PointFloat(10.00003F, 10F);
            this.xrLabelTitleDogodki.Multiline = true;
            this.xrLabelTitleDogodki.Name = "xrLabelTitleDogodki";
            this.xrLabelTitleDogodki.Padding = new DevExpress.XtraPrinting.PaddingInfo(2, 2, 0, 0, 100F);
            this.xrLabelTitleDogodki.SizeF = new System.Drawing.SizeF(240F, 23F);
            this.xrLabelTitleDogodki.StylePriority.UseBorders = false;
            this.xrLabelTitleDogodki.StylePriority.UseFont = false;
            this.xrLabelTitleDogodki.StylePriority.UseTextAlignment = false;
            this.xrLabelTitleDogodki.Text = "Dogodki:";
            this.xrLabelTitleDogodki.TextAlignment = DevExpress.XtraPrinting.TextAlignment.MiddleLeft;
            // 
            // DetailReport1
            // 
            this.DetailReport1.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail2});
            this.DetailReport1.Level = 1;
            this.DetailReport1.Name = "DetailReport1";
            // 
            // Detail2
            // 
            this.Detail2.Controls.AddRange(new DevExpress.XtraReports.UI.XRControl[] {
            this.xrTableDogodki,
            this.xrLabelTitleDogodki});
            this.Detail2.HeightF = 100F;
            this.Detail2.KeepTogether = true;
            this.Detail2.Name = "Detail2";
            // 
            // ChartReport
            // 
            this.Bands.AddRange(new DevExpress.XtraReports.UI.Band[] {
            this.Detail,
            this.TopMargin,
            this.BottomMargin,
            this.DetailReport,
            this.ReportHeader,
            this.DetailReport1});
            this.Landscape = true;
            this.Margins = new System.Drawing.Printing.Margins(100, 100, 0, 28);
            this.PageHeight = 850;
            this.PageWidth = 1100;
            this.Version = "14.1";
            ((System.ComponentModel.ISupportInitialize)(lineSeriesView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.xrDataChart)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.xrTableDogodki)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this)).EndInit();

        }

        #endregion

        private DevExpress.XtraReports.UI.DetailBand Detail;
        private DevExpress.XtraReports.UI.TopMarginBand TopMargin;
        private DevExpress.XtraReports.UI.BottomMarginBand BottomMargin;
        private DevExpress.XtraReports.UI.DetailReportBand DetailReport;
        private DevExpress.XtraReports.UI.DetailBand Detail1;
        private DevExpress.XtraReports.UI.XRLabel xrLblCategorieTitle;
        private DevExpress.XtraReports.UI.XRChart xrDataChart;
        private DevExpress.XtraReports.UI.ReportHeaderBand ReportHeader;
        private DevExpress.XtraReports.UI.XRLabel xrLblPeriod;
        private DevExpress.XtraReports.UI.XRLabel xrLblClientEmployee;
        private DevExpress.XtraReports.UI.XRLabel xrLblType;
        private DevExpress.XtraReports.UI.XRLabel xrLblClient;
        private DevExpress.XtraReports.UI.XRLabel xrLblCreationDate;
        private DevExpress.XtraReports.UI.XRPictureBox companyLogo;
        private System.DirectoryServices.DirectorySearcher directorySearcher1;
        private DevExpress.XtraReports.UI.XRTable xrTableDogodki;
        private DevExpress.XtraReports.UI.XRTableRow xrTableRow1;
        private DevExpress.XtraReports.UI.XRTableCell xrTableCell1;
        private DevExpress.XtraReports.UI.XRTableCell xrTableCell2;
        private DevExpress.XtraReports.UI.XRTableCell xrTableCell3;
        private DevExpress.XtraReports.UI.XRLabel xrLabelTitleDogodki;
        private DevExpress.XtraReports.UI.DetailReportBand DetailReport1;
        private DevExpress.XtraReports.UI.DetailBand Detail2;
    }
}
