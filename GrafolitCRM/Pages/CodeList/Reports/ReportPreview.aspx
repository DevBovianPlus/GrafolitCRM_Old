<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="ReportPreview.aspx.cs" Inherits="AnalizaProdaje.Pages.CodeList.Reports.ReportPreview" %>

<%@ Register Assembly="DevExpress.XtraReports.v19.2.Web.WebForms, Version=19.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraReports.Web" TagPrefix="dx" %>

<%@ MasterType VirtualPath="~/MasterPage.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function customizeActions(s, e) {
            e.Actions.push({
                text: "Izhod",
                imageClassName: "exit-logo-html5",
                disabled: ko.observable(false),
                visible: true,
                clickAction: function () {
                    history.back();
                }
            });
        }
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <dx:ASPxRoundPanel ID="ASPxRoundPanelRacuni" runat="server" Theme="MetropolisBlue"
        Width="100%" ShowHeader="false">
        <ContentPaddings PaddingBottom="7px" PaddingLeft="3px" PaddingRight="3px" PaddingTop="7px" />
        <PanelCollection>
            <dx:PanelContent ID="PanelContentStranke2" runat="server">
                <div class="report-filter-wrap">
                    <div class="report-filter">
                        <%--<dx:ASPxWebDocumentViewer ID="ASPxWebDocumentViewer1" runat="server" ColorScheme="light" Height="1250px" Width="900px">
								<ClientSideEvents Init="function(s, e) {s.previewModel.reportPreview.zoom(1);}" CustomizeMenuActions="customizeActions" />
							</dx:ASPxWebDocumentViewer>--%>
                        <dx:ReportToolbar ID="ReportToolbar1" runat='server' ShowDefaultButtons='False'
                            ReportViewerID="ReportViewer1" EnableTheming="True" Theme="MetropolisBlue" Width="100%">
                            <Items>
                                <dx:ReportToolbarButton ItemKind='Search' ToolTip="Iskanje" />
                                <dx:ReportToolbarSeparator />
                                <dx:ReportToolbarButton ItemKind='PrintReport' ToolTip="Izpis dokumenta" />
                                <dx:ReportToolbarSeparator />
                                <dx:ReportToolbarButton Enabled='False' ItemKind='FirstPage' Text="Prva" ToolTip="Pojdi na prvo stran" />
                                <dx:ReportToolbarButton Enabled='False' ItemKind='PreviousPage' Text="Prejšnja" ToolTip="Pojdi na prejšnjo stran" />
                                <dx:ReportToolbarLabel ItemKind='PageLabel' Text="Stran" />
                                <dx:ReportToolbarComboBox ItemKind='PageNumber' Width='65px'>
                                </dx:ReportToolbarComboBox>
                                <dx:ReportToolbarLabel ItemKind='OfLabel' Text="Od" />
                                <dx:ReportToolbarTextBox ItemKind='PageCount' Width='45px' />
                                <dx:ReportToolbarButton ItemKind='NextPage' Text="Naslednja" ToolTip="Pojdi na naslednjo stran" />
                                <dx:ReportToolbarButton ItemKind='LastPage' Text="Zadnja" ToolTip="Pojdi na zadnjo stran" />
                                <dx:ReportToolbarSeparator />
                                <dx:ReportToolbarButton ItemKind='SaveToDisk' ToolTip="Izvozi dokument in ga shrani na disk" />
                                <dx:ReportToolbarButton ItemKind='SaveToWindow' ToolTip="Izvozi dokument in ga prikaži" />
                                <dx:ReportToolbarComboBox ItemKind='SaveFormat' Width='70px'>
                                    <Elements>
                                        <dx:ListElement Value='pdf' Text="PDF" />
                                        <dx:ListElement Value='png' Text="Slika" />
                                    </Elements>
                                </dx:ReportToolbarComboBox>
                            </Items>
                            <Styles>
                                <LabelStyle>
                                    <Margins MarginLeft='3px' MarginRight='3px' />
                                </LabelStyle>
                            </Styles>
                        </dx:ReportToolbar>
                    </div>
                    <div class="report-exit-btn">
                        <dx:ASPxButton ID="GumbNazaj" runat="server" Text="Zapri"
                            AutoPostBack="false" Theme="MetropolisBlue" Width="100%">
                            <ClientSideEvents Click="function(s,e){window.history.go(-1);}" />
                        </dx:ASPxButton>
                    </div>
                </div>

                <div class="alignCenter">
                    <dx:ReportViewer ID="ReportViewer1" runat="server" Height="700px"
                        Theme="MetropolisBlue" AutoSize="False" BackColor="White" CssClass="report-viewer">
                    </dx:ReportViewer>
                </div>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxRoundPanel>
</asp:Content>
