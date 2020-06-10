<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" Title="Podrobna analiza" AutoEventWireup="true" CodeBehind="ClientsChartsDetail.aspx.cs" Inherits="AnalizaProdaje.Pages.CodeList.Clients.ClientsChartsDetail" %>

<%@ MasterType VirtualPath="~/MasterPage.Master" %>

<asp:Content ID="HeadForJavaScript" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            var value = hfRadioButtonDisabled.Get("RadioButtonDisabled");
            if (value != null && value)
            {
                clientRBLTypeDetail.SetEnabled(true);
            }
            else if (value != null && !value)
            {
                clientRBLTypeDetail.SetEnabled(false);
            }
        });

        function PageControlInit(s, e) {
            var activeTab = s.GetActiveTab();
            if (activeTab.name == "Charts")
                clientChartsCallback.PerformCallback();
        }

        function OnDateChanged_DateControl_DO(s, e) {
            var date = clientDateEdit_DO.GetDate();
            if (date != null) {
                clientRBLTypeDetail.SetEnabled(false);
                hfRadioButtonDisabled.Set("RadioButtonDisabled", false);
                //clientRBLTypeDetail.SetSelectedItem(null);
            }
            else {
                clientRBLTypeDetail.SetEnabled(true);
                hfRadioButtonDisabled.Set("RadioButtonDisabled", true);
            }
        }

        function OnDateChanged_UserCotrol_DO(s, e) {
            var date = clientUserControlDateEdit_DO.GetDate();
            if (date != null) {
                radioButtonsPeriod.SetEnabled(false);
                hfUSCRadioButtonDisabled.Set("RadioButtonUSCDisabled", false);
                //clientRBLTypeDetail.SetSelectedItem(null);
            }
            else {
                radioButtonsPeriod.SetEnabled(true);
                hfUSCRadioButtonDisabled.Set("RadioButtonUSCDisabled", true);
            }
        }

        function CallbackPanelEndCallback(s, e)
        {
            var hiddenFieldRadioButtonDisabled = hfUSCRadioButtonDisabled;
            if (hiddenFieldRadioButtonDisabled != null) {
                var valueUSC = hiddenFieldRadioButtonDisabled.Get("RadioButtonUSCDisabled");
                if (valueUSC != null && valueUSC) {
                    radioButtonsPeriod.SetEnabled(true);
                }
                else if (valueUSC != null && !valueUSC) {
                    radioButtonsPeriod.SetEnabled(false);
                }
            }
        }

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="false" Theme="MetropolisBlue"
        HeaderStyle-HorizontalAlign="Center" Font-Bold="true" Width="100%" HeaderText="Stranke">
        <ContentPaddings PaddingBottom="7px" PaddingLeft="3px" PaddingRight="3px" PaddingTop="7px" />
        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
        <PanelCollection>
            <dx:PanelContent>
                <dx:ASPxPageControl ID="ClientPageControl" runat="server" ActiveTabIndex="0" Theme="MetropolisBlue" Width="100%"
                    BackColor="#f8f8f8" ClientInstanceName="clientPageControl">
                    <ClientSideEvents Init="PageControlInit" />
                    <TabPages>
                        <dx:TabPage Name="Charts" Text="GRAFI - PODROBNO">
                            <ContentCollection>
                                <dx:ContentControl>
                                    <dx:ASPxHiddenField ID="hiddenField" runat="server" ClientInstanceName="hiddenFieldClient">
                                        <ClientSideEvents Init="function(s,e){hiddenFieldClient.Set('browserWidth', $('.main-content-section').width());}" />
                                    </dx:ASPxHiddenField>
                                    <div class="overflow-hidden">
                                        <div style="display: inline-block; position: relative; left: 30%">                                            
                                            <dx:ASPxLabel ID="ErrorLabel" runat="server" ForeColor="Red"></dx:ASPxLabel>
                                        </div>
                                        <div class="float-left">
                                            <div class="float-left">
                                                <span class="AddEditButtons no-margin-top">
                                                    <dx:ASPxButton ID="btnGraphCancel" runat="server" Text="Nazaj" AutoPostBack="false" OnClick="btnCancel_Click"
                                                        Height="30" Width="100">
                                                        <Image Url="../../../Images/BackButton.png"></Image>
                                                    </dx:ASPxButton>
                                                </span>
                                                <span class="AddEditButtons no-margin-top">
                                                    <dx:ASPxButton ID="btnDisplayAllCharts" runat="server" Text="Prikaži vse tipe" AutoPostBack="false" GroupName="CG"
                                                        Height="30" Width="100" CheckedStyle-CssClass="" OnClick="btnDisplayAllCharts_Click">
                                                        <Image Url="../../../Images/DisplayAllCharts.png"></Image>
                                                    </dx:ASPxButton>
                                                </span>
                                            </div>
                                            <div class="float-left big-margin-l initial-hide-block" id="filteringBlock" runat="server">
                                                <div class="no-margin-top float-left">
                                                    <dx:ASPxRadioButtonList runat="server" Caption="Tip" RepeatColumns="3" ID="rbTypeDetail"
                                                        RepeatLayout="Table" Visible="true" ClientInstanceName="clientRBLTypeDetail">
                                                        <Paddings Padding="0" />
                                                        <CaptionSettings Position="Left" VerticalAlign="Middle" />
                                                        <Items>
                                                            <dx:ListEditItem Text="Mesečno" Value="1" />
                                                            <dx:ListEditItem Text="Letno" Value="2" />
                                                            <dx:ListEditItem Text="Tedensko" Value="3" />
                                                        </Items>
                                                    </dx:ASPxRadioButtonList>
                                                </div>
                                                <div class="float-left medium-margin-l flex-box-vertical-align">
                                                    <dx:ASPxDateEdit Theme="MetropolisBlue" ID="DateEdit_OD" runat="server" Caption="Od " EditFormat="Date"
                                                        Width="100">
                                                        <CaptionSettings VerticalAlign="Middle" />
                                                        <CalendarProperties TodayButtonText="Danes" ClearButtonText="Izbriši"></CalendarProperties>
                                                        <DropDownButton Visible="true"></DropDownButton>
                                                    </dx:ASPxDateEdit>

                                                </div>
                                                <div class="float-left small-margin-l flex-box-vertical-align small-margin-r">
                                                    <dx:ASPxDateEdit Theme="MetropolisBlue" ID="DateEdit_DO" runat="server" Caption="Do " EditFormat="Date"
                                                        Width="100" ClientInstanceName="clientDateEdit_DO">
                                                        <CaptionSettings VerticalAlign="Middle" />
                                                        <ClientSideEvents DateChanged="OnDateChanged_DateControl_DO" />
                                                        <CalendarProperties TodayButtonText="Danes" ClearButtonText="Izbriši"></CalendarProperties>
                                                        <DropDownButton Visible="true"></DropDownButton>
                                                    </dx:ASPxDateEdit>
                                                    <dx:ASPxHiddenField runat="server" ClientInstanceName="hfRadioButtonDisabled" ID="hfRadioButtonDisabled">
                                                    </dx:ASPxHiddenField>
                                                </div>
                                                <div class="float-left small-margin-l">
                                                    <dx:ASPxButton ID="btnFilterCharts" runat="server" Text="Izriši" AutoPostBack="false"
                                                        Height="20" Width="70" Visible="true" OnClick="btnFilterCharts_Click">
                                                        <Image Url="../../../Images/DrawChart.png"></Image>
                                                    </dx:ASPxButton>
                                                </div>
                                            </div>
                                            <div class="float-left medium-margin-l">
                                                <span class="AddEditButtons no-margin-top">
                                                    <dx:ASPxButton ID="btnPrintChart" runat="server" Text="Natisni" AutoPostBack="false"
                                                        Height="30" Width="100" ClientInstanceName="clientBtnPrintChart"
                                                        OnClick="btnPrintChart_Click">
                                                        <Image Url="../../../Images/PrintChart.png"></Image>
                                                    </dx:ASPxButton>
                                                </span>
                                                <span class="AddEditButtons no-margin-top" style="display: none;">
                                                    <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Prenesi PDF" AutoPostBack="false"
                                                        Height="30" Width="100">
                                                        <Image Url="../../../Images/downloadPDF.png"></Image>
                                                    </dx:ASPxButton>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <dx:ASPxCallbackPanel ID="ChartsCallback" runat="server" ClientInstanceName="clientChartsCallback" OnCallback="ChartsCallback_Callback">
                                        <PanelCollection>
                                            <dx:PanelContent>

                                                <table style="width: 100%;" runat="server" id="ChartTable"></table>

                                            </dx:PanelContent>
                                        </PanelCollection>
                                        <ClientSideEvents EndCallback="CallbackPanelEndCallback" />
                                    </dx:ASPxCallbackPanel>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>

                    </TabPages>
                </dx:ASPxPageControl>

            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxRoundPanel>
    <script type="text/javascript" src="../../../Scripts/ChromeFix_14.js"></script>
</asp:Content>
