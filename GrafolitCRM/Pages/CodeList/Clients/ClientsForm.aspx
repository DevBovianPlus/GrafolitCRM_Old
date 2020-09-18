<%@ Page Language="C#" MasterPageFile="~/MasterPage.Master" Title="Urejanje stranke" AutoEventWireup="true" CodeBehind="ClientsForm.aspx.cs" Inherits="AnalizaProdaje.Pages.CodeList.Clients.ClientsForm" %>

<%@ MasterType VirtualPath="~/MasterPage.Master" %>

<asp:Content ID="HeadForJavaScript" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            /*else if (e.tab.name == "Charts")
            {
                hiddenFieldClient.Set('browserWidth', $(".main-content-section").width());
                
            }*/
        });


        function TabChanged(s, e) {

            if (e.tab.name == "Plan")
                gridPlan.Refresh();
            else if (e.tab.name == "ContactPerson")
                gridContactPerson.Refresh();
            else if (e.tab.name == "Events")
                gridEvents.Refresh();
            else if (e.tab.name == "Device")
                gridDevice.Refresh();
            else if (e.tab.name == "Notes")
                gridNotes.Refresh();
            else if (e.tab.name == "Categorie")
                gridCategorie.Refresh();
            else if (e.tab.name == "Charts")
                clientChartsCallback.PerformCallback();

        }

        function OnClosePopupEventHandler_Plan(command) {
            switch (command) {
                case 'Potrdi':
                    clientPopUpPlan.Hide();
                    //gridPlan.Refresh();
                    clientPlanCallback.PerformCallback("RefreshGrid");
                    break;
                case 'Preklici':
                    clientPopUpPlan.Hide();
                    break;
            }
        }

        function OnClosePopupEventHandler_ContactPerson(command) {
            switch (command) {
                case 'Potrdi':
                    clientPopUpContactPerson.Hide();
                    //gridContactPerson.Refresh();
                    clientContactPersonCallback.PerformCallback("RefreshGrid");
                    break;
                case 'Preklici':
                    clientPopUpContactPerson.Hide();
                    break;
            }
        }

        function OnClosePopupEventHandler_Device(command) {
            switch (command) {
                case 'Potrdi':
                    clientPopUpDevice.Hide();
                    //gridDevice.Refresh();
                    clientDeviceCallback.PerformCallback("RefreshGrid");
                    break;
                case 'Preklici':
                    clientPopUpDevice.Hide();
                    break;
            }
        }

        function OnClosePopupEventHandler_Notes(command) {
            switch (command) {
                case 'Potrdi':
                    clientPopUpNotes.Hide();
                    //gridDevice.Refresh();
                    clientNotesCallback.PerformCallback("RefreshGrid");
                    break;
                case 'Preklici':
                    clientPopUpNotes.Hide();
                    break;
            }
        }

        function OnClosePopupEventHandler_Categorie(command) {
            switch (command) {
                case 'Potrdi':
                    clientPopUpCategorie.Hide();
                    //gridDevice.Refresh();
                    clientCategorieCallback.PerformCallback("RefreshGrid");
                    break;
                case 'Preklici':
                    clientPopUpCategorie.Hide();
                    break;
            }
        }

        function PlanPopUpShow(s, e) {

            var activeTab = clientPageControl.GetActiveTab();

            var parameter = "";

            switch (activeTab.name) {
                case "Plan":
                    parameter = HandleUserActionsOnTabs(gridPlan, clientBtnAdd, clientBtnEdit, clientBtnDelete, s);
                    clientPlanCallback.PerformCallback(parameter);
                    break;
                case "ContactPerson":
                    parameter = HandleUserActionsOnTabs(gridContactPerson, clientBtnAddContactPerson, clientBtnEditContactPerson, clientBtnDeleteContactPerson, s);
                    clientContactPersonCallback.PerformCallback(parameter);
                    break;
                case "Events":
                    //parameter = "eventDblClick";
                    parameter = HandleUserActionsOnTabs(gridEvents, clientBtnAddEvent, clientBtnEditEvent, clientBtnDeleteEvent, s);
                    clientEventsCallback.PerformCallback(parameter);
                    break;
                case "Device":
                    parameter = HandleUserActionsOnTabs(gridDevice, clientBtnAddDevice, clientBtnEditDevice, clientBtnDeleteDevice, s);
                    clientDeviceCallback.PerformCallback(parameter);
                    break;
                case "Notes":
                    parameter = HandleUserActionsOnTabs(gridNotes, clientBtnAddNotes, clientBtnEditNotes, clientBtnDeleteNotes, s);
                    clientNotesCallback.PerformCallback(parameter);
                    break;
                case "Categorie":
                    parameter = HandleUserActionsOnTabs(gridCategorie, clientBtnAddCategorie, clientBtnEditCategorie, clientBtnDeleteCategorie, s);
                    clientCategorieCallback.PerformCallback(parameter);
                    break;
            }
        }
        function FillCodeInput(s, e) {
            /*var codeText = clientCode.GetText();
            if (clientCode.GetText().length <= 0 || clientCode.GetText().indexOf("TMP") > -1) {
                var currentText = clientName.GetText();
                var len = currentText.length;
                if (currentText.length >= 3) {
                    var code = currentText.substring(0, 3).toUpperCase();
                    code = CheckForSpecialCharacters(code);
                    //code += "00";
                    clientCode.SetText(code);
                }
            }*/
        }

        function PageControlInit(s, e) {
            var activeTab = s.GetActiveTab();
            if (activeTab.name == "Charts")
                clientChartsCallback.PerformCallback();
        }

        function clientTwoInRow(s, e) {
            clientChartsCallback.PerformCallback("TwoInRow");
        }
        function clientOneInRow(s, e) {
            clientChartsCallback.PerformCallback("OneInRow");
        }
        function clientThreeInRow(s, e) {
            clientChartsCallback.PerformCallback("ThreeInRow");
        }

        function AutoAddEventClick(s, e) {
            clientAutoAddEventCallback.PerformCallback();
        }
        function AutoAddEventCallbackComplete(s, e) {
            ShowSuccessPopUp(e.result, 2, 'Dodajanje dogodka');
        }

        function OnDateChanged_UserCotrol_DO(s, e) {
            var date = clientUserControlDateEdit_DO.GetDate();
            if (date != null) {
                radioButtonsPeriod.SetEnabled(false);
                //hfRadioButtonDisabled.Set("RadioButtonDisabled", false);
                //clientRBLTypeDetail.SetSelectedItem(null);
            }
            else {
                radioButtonsPeriod.SetEnabled(true);
                //hfRadioButtonDisabled.Set("RadioButtonDisabled", true);
            }
        }

        function CauseValidation(s, e) {
            var procees = false;
            var inputItems = [clientName];

            if (clientBtnConfirm.GetText() == 'Izbrisi')
                procees = true;
            else
                procees = InputFieldsValidation(null, inputItems, null, null);

            if (procees)
                e.processOnServer = true;
            else
                e.processOnServer = false;
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
                    BackColor="#f8f8f8" ClientInstanceName="clientPageControl" EnableTabScrolling="true">
                    <ClientSideEvents ActiveTabChanged="TabChanged" Init="PageControlInit" />
                    <TabPages>
                        <dx:TabPage Name="Charts" Text="ANALIZA - GRAFI">
                            <ContentCollection>
                                <dx:ContentControl>
                                    <dx:ASPxHiddenField ID="hiddenField" runat="server" ClientInstanceName="hiddenFieldClient">
                                        <ClientSideEvents Init="function(s,e){hiddenFieldClient.Set('browserWidth', $('.main-content-section').width());}" />
                                    </dx:ASPxHiddenField>
                                    <div class="overflow-hidden">
                                        <div class="float-left">
                                            <div class="float-left">
                                                <span class="AddEditButtons no-margin-top">
                                                    <dx:ASPxButton ID="btnGraphCancel" runat="server" Text="Preklici" AutoPostBack="false" OnClick="btnCancel_Click"
                                                        Height="30" Width="100">
                                                        <Image Url="../../../Images/cancel1.png"></Image>
                                                    </dx:ASPxButton>
                                                </span>
                                            </div>
                                        </div>
                                        <div style="display: block; float: right; margin: auto; top: 6px; position: relative">
                                            <dx:ASPxButton ID="btnThreeInRow" runat="server" AutoPostBack="False" AllowFocus="False" RenderMode="Link" EnableTheming="False">
                                                <Image>
                                                    <SpriteProperties CssClass="threeInRow" HottrackedCssClass="threeInRowHover" PressedCssClass="blueBallPressed" />
                                                </Image>
                                                <ClientSideEvents Click="clientThreeInRow" />
                                            </dx:ASPxButton>
                                            <dx:ASPxButton ID="btnTwoInRow" runat="server" AutoPostBack="False" AllowFocus="False" RenderMode="Link" EnableTheming="False">
                                                <Image>
                                                    <SpriteProperties CssClass="twoInRow" HottrackedCssClass="twoInRowHover" PressedCssClass="blueBallPressed" />
                                                </Image>
                                                <ClientSideEvents Click="clientTwoInRow" />
                                            </dx:ASPxButton>
                                            <dx:ASPxButton ID="btnOneInRow" runat="server" AutoPostBack="False" AllowFocus="False" RenderMode="Link" EnableTheming="False">
                                                <Image>
                                                    <SpriteProperties CssClass="oneInRow" HottrackedCssClass="oneInRowHover" PressedCssClass="blueBallPressed" />
                                                </Image>
                                                <ClientSideEvents Click="clientOneInRow" />
                                            </dx:ASPxButton>
                                        </div>
                                    </div>
                                    <dx:ASPxCallbackPanel ID="ChartsCallback" runat="server" ClientInstanceName="clientChartsCallback" OnCallback="ChartsCallback_Callback">
                                        <PanelCollection>
                                            <dx:PanelContent>

                                                <table style="width: 100%;" runat="server" id="ChartTable"></table>

                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxCallbackPanel>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Name="Basic" Text="OSNOVNI PODATKI">
                            <ContentCollection>
                                <dx:ContentControl BackColor="#f8f8f8">
                                    <div class="section group">
                                        <div class="col span_1_of_3 hide-block-important">
                                            <div class="content-form-element-label-flex lable-width-medium">
                                                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="ŠIFRA :" Visible="false"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtSifraStranke" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                                    ClientInstanceName="clientCode" ReadOnly="true" BackColor="LightGray" MaxLength="50" Visible="false">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 hide-block-important">
                                            <div class="content-form-element-label-flex lable-width-medium">
                                                <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="ID :" Visible="false"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtIdStranke" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                                    ReadOnly="true" BackColor="LightGray" Visible="false">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 no-margin-left-important">
                                            <div class="content-form-element-label-flex lable-width-large">
                                                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="NAZIV PRVI :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtNazivPrvi" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                                    ClientInstanceName="clientName" MaxLength="50">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                    <ValidationSettings ValidationGroup="Confirm" Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true"
                                                        RequiredField-ErrorText="Enter valid value">
                                                    </ValidationSettings>
                                                    <ClientSideEvents TextChanged="FillCodeInput" Init="SetFocus" />
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 align_center_column_content">
                                            <div class="content-form-element-label-flex lable-width-larger">
                                                <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="NAZIV DRUGI :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtNazivDrugi" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 align_right_column_content">
                                            <div class="content-form-element-label-flex lable-width-larger">
                                                <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="NASLOV :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtNaslov" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                                    MaxLength="50">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 no-margin-left-important">
                                            <div class="content-form-element-label-flex lable-width-large">
                                                <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="ŠTEV. POŠTE :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtStevPoste" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                                    MaxLength="12">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 align_center_column_content">
                                            <div class="content-form-element-label-flex lable-width-larger">
                                                <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="NAZIV POŠTE :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtNazivPoste" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                                    MaxLength="50">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 align_right_column_content">
                                            <div class="content-form-element-label-flex lable-width-larger">
                                                <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="EMAIL :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtEmail" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                                    MaxLength="50">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 no-margin-left-important">
                                            <div class="content-form-element-label-flex lable-width-large">
                                                <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="TELEFON :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtTelefon" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                                    MaxLength="50">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 align_center_column_content">
                                            <div class="content-form-element-label-flex lable-width-larger">
                                                <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="FAX :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtFax" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                                    MaxLength="50">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 align_right_column_content">
                                            <div class="content-form-element-label-flex lable-width-larger">
                                                <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="SPLETNI NASL. :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtInternetniNalov" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                                    MaxLength="50">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 no-margin-left-important">
                                            <div class="content-form-element-label-flex lable-width-large">
                                                <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text="KONTAKT :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtKontaktnaOseba" runat="server" Width="170px" Font-Size="Small" CssClass="text-box-input"
                                                    MaxLength="50">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 align_center_column_content">
                                            <div class="content-form-element-label-flex lable-width-larger">
                                                <dx:ASPxLabel ID="ASPxLabel13" runat="server" Text="ROK PLAČILA :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtRokPlacila" runat="server" MaxLength="3" Width="170px" Font-Size="Small" CssClass="text-box-input">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 align_right_column_content">
                                            <div class="content-form-element-label-flex lable-width-larger">
                                                <dx:ASPxLabel ID="ASPxLabel14" runat="server" Text="SKRBNIK :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxComboBox ID="ComboBoxZaposleniStranke" runat="server" ValueType="System.String" DropDownStyle="DropDownList"
                                                    IncrementalFilteringMode="StartsWith" TextField="CelotnoIme" ValueField="idOsebe"
                                                    EnableSynchronization="False" OnDataBinding="ComboBoxZaposleniStranke_DataBinding"
                                                    Font-Size="Small" CssClass="text-box-input">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                    <ValidationSettings ValidationGroup="Confirm" Display="Dynamic" ErrorDisplayMode="ImageWithTooltip" SetFocusOnError="true"
                                                        RequiredField-ErrorText="Enter valid value">
                                                        <RequiredField IsRequired="true" />
                                                    </ValidationSettings>
                                                </dx:ASPxComboBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 no-margin-left-important">
                                            <div class="content-form-element-label-flex lable-width-large">
                                                <dx:ASPxLabel ID="ASPxLabel16" runat="server" Text="RANG :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxTextBox ID="txtRangStranke" runat="server" Width="90px" Font-Size="Small" CssClass="text-box-input"
                                                    BackColor="LightGray" ReadOnly="true" ForeColor="Black">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                </dx:ASPxTextBox>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 align_center_column_content">
                                            <div class="content-form-element-label-flex lable-width-large">
                                                <dx:ASPxLabel ID="ASPxLabel15" runat="server" Text="DOGODEK :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxCallback runat="server" ID="AutoAddEventCallback" ClientInstanceName="clientAutoAddEventCallback"
                                                    OnCallback="AutoAddEventCallback_Callback">
                                                    <ClientSideEvents CallbackComplete="AutoAddEventCallbackComplete" />
                                                </dx:ASPxCallback>
                                                <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Samodejno dodaj dogodek" AutoPostBack="false"
                                                    Height="35" Width="150" ValidationGroup="Confirm" CssClass="autoAddEventBtn">
                                                    <ClientSideEvents Click="AutoAddEventClick" />
                                                </dx:ASPxButton>
                                            </div>
                                        </div>
                                        <div class="col span_1_of_3 align_center_column_content">
                                            <div style="margin-left: -76px" class="content-form-element-label-flex lable-width-large">
                                                <dx:ASPxLabel ID="ASPxLabel17" runat="server" Text="AKTIVNOST :"></dx:ASPxLabel>
                                            </div>
                                            <div class="content-input-filed">
                                                <dx:ASPxComboBox ID="cmbAktivnost" runat="server" Width="80px" CssClass="text-box-input">
                                                    <FocusedStyle CssClass="focus-text-box-input"></FocusedStyle>
                                                    <Items>                                                        
                                                        <dx:ListEditItem Text="NE" Value="0" Selected="true" />
                                                        <dx:ListEditItem Text="DA" Value="1" />
                                                    </Items>
                                                </dx:ASPxComboBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="AddEditButtonsWrap">
                                        <div style="display: block; float: left; margin-top: 10px;">
                                            <dx:ASPxButton ID="addEventBtn" runat="server" AutoPostBack="False" AllowFocus="False"
                                                Text="Dodaj/Uredi dogodek" OnClick="addEventBtn_Click">
                                                <Image Url="/Images/addEventBtn.png" UrlHottracked="/Images/addEventBtnPressed.png">
                                                    <%--<SpriteProperties CssClass="addEvent" HottrackedCssClass="addEventHottracked" PressedCssClass="addEventPressed" />--%>
                                                </Image>
                                            </dx:ASPxButton>
                                        </div>
                                        <div style="display: inline-block; position: relative; left: 30%">
                                            <dx:ASPxLabel ID="ErrorLabel" runat="server" ForeColor="Red"></dx:ASPxLabel>
                                        </div>
                                        <div class="AddEditButtonsElements">
                                            <span class="AddEditButtons">
                                                <dx:ASPxButton ID="btnConfirm" runat="server" Text="Potrdi" AutoPostBack="false" OnClick="btnConfirm_Click"
                                                    Height="30" Width="100" ValidationGroup="Confirm" ClientInstanceName="clientBtnConfirm">
                                                    <ClientSideEvents Click="CauseValidation" />
                                                </dx:ASPxButton>
                                            </span>
                                            <span class="AddEditButtons">
                                                <dx:ASPxButton ID="btnCancel" runat="server" Text="Preklici" AutoPostBack="false" OnClick="btnCancel_Click"
                                                    Height="30" Width="100">
                                                    <Image Url="../../../Images/cancel1.png"></Image>
                                                </dx:ASPxButton>
                                            </span>
                                        </div>
                                    </div>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Name="Plan" Text="PLAN">
                            <ContentCollection>
                                <dx:ContentControl>

                                    <dx:ASPxCallbackPanel ID="PlanCallback" runat="server" ClientInstanceName="clientPlanCallback" OnCallback="PlanCallback_Callback">
                                        <PanelCollection>
                                            <dx:PanelContent>
                                                <dx:ASPxGridView ID="ASPxGridViewPlan" runat="server" AutoGenerateColumns="False"
                                                    EnableTheming="True" EnableCallbackCompression="true" ClientInstanceName="gridPlan"
                                                    Theme="Moderno" Width="100%" KeyboardSupport="true" AccessKey="G"
                                                    KeyFieldName="idPlan" OnDataBinding="ASPxGridViewPlan_DataBinding">
                                                    <ClientSideEvents RowDblClick="PlanPopUpShow" />
                                                    <Settings ShowVerticalScrollBar="True" VerticalScrollableHeight="450"
                                                        ShowHorizontalScrollBar="True" ShowFilterBar="Auto" ShowFilterRow="True"
                                                        ShowFilterRowMenu="True" />
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn Caption="Plan Id" FieldName="idPlan" Width="80px"
                                                            ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="1">
                                                        </dx:GridViewDataTextColumn>

                                                        <dx:GridViewDataTextColumn Caption="Kategorija"
                                                            FieldName="Kategorija" ShowInCustomizationForm="True"
                                                            VisibleIndex="2" Width="220px">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Stranka"
                                                            FieldName="Stranka" ShowInCustomizationForm="True"
                                                            VisibleIndex="3" Width="220px">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Letni znesek"
                                                            FieldName="LetniZnesek" ShowInCustomizationForm="True"
                                                            VisibleIndex="4" Width="200px">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Leto"
                                                            FieldName="Leto" ShowInCustomizationForm="True"
                                                            VisibleIndex="5" Width="170px">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataDateColumn Caption="Datum vpisa"
                                                            FieldName="ts" ShowInCustomizationForm="True"
                                                            VisibleIndex="6" Width="180px">
                                                            <PropertiesDateEdit DisplayFormatString="dd.MM.yyyy - HH:mm"></PropertiesDateEdit>
                                                            <CellStyle HorizontalAlign="Right"></CellStyle>
                                                        </dx:GridViewDataDateColumn>
                                                        <dx:GridViewDataTextColumn Caption="Oseba vnosa"
                                                            FieldName="tsIDOsebe" ShowInCustomizationForm="True"
                                                            VisibleIndex="7" Width="145px">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                                <dx:ASPxPopupControl ID="ASPxPopupControl_Plan" runat="server" ContentUrl="Plan_popup.aspx"
                                                    ClientInstanceName="clientPopUpPlan" Modal="True" HeaderText="DODAJ PLAN"
                                                    Theme="MetropolisBlue" CloseAction="None" Width="630px" Height="290px" PopupHorizontalAlign="WindowCenter"
                                                    PopupVerticalAlign="WindowCenter" PopupAnimationType="Fade" AllowDragging="true" ShowSizeGrip="true"
                                                    AllowResize="true">
                                                    <ContentStyle BackColor="#F7F7F7">
                                                        <Paddings PaddingBottom="0px" PaddingLeft="6px" PaddingRight="0px" PaddingTop="0px"></Paddings>
                                                    </ContentStyle>
                                                    <ContentCollection>
                                                        <dx:PopupControlContentControl ID="PopUpContentControl" runat="server">
                                                        </dx:PopupControlContentControl>
                                                    </ContentCollection>
                                                </dx:ASPxPopupControl>
                                                <div class="AddEditButtonsWrap">
                                                    <div class="DeleteButtonElements">
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnDeletePlan" runat="server" Text="Izbriši" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnDelete">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/trashForPopUp.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                    </div>
                                                    <div class="AddEditButtonsElements">
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnAddPlan" runat="server" Text="Dodaj" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnAdd">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/addForPopUp.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnEditPlan" runat="server" Text="Spremeni" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnEdit">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/editForPopup.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                    </div>
                                                </div>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxCallbackPanel>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Name="ContactPerson" Text="KONTAKTNE OSEBE">
                            <ContentCollection>
                                <dx:ContentControl>

                                    <dx:ASPxCallbackPanel ID="ContactPersonCallback" runat="server" ClientInstanceName="clientContactPersonCallback" OnCallback="ContactPersonCallback_Callback">
                                        <PanelCollection>
                                            <dx:PanelContent>
                                                <dx:ASPxGridView ID="ASPxGridViewContactPerson" runat="server" AutoGenerateColumns="False"
                                                    EnableTheming="True" EnableCallbackCompression="true" ClientInstanceName="gridContactPerson"
                                                    Theme="Moderno" Width="100%" KeyboardSupport="true" AccessKey="G"
                                                    KeyFieldName="idKontaktneOsebe" OnDataBinding="ASPxGridViewContactPerson_DataBinding"
                                                    Paddings-PaddingTop="0" Paddings-PaddingBottom="0"
                                                    CssClass="gridview-no-header-padding">
                                                    <ClientSideEvents RowDblClick="PlanPopUpShow" />
                                                    <Settings ShowVerticalScrollBar="True" VerticalScrollableHeight="400"
                                                        ShowHorizontalScrollBar="True" ShowFilterBar="Auto" ShowFilterRow="True"
                                                        ShowFilterRowMenu="True" VerticalScrollBarStyle="Standard" />
                                                    <SettingsPager PageSize="10" ShowNumericButtons="true">
                                                        <PageSizeItemSettings Visible="true" Items="10,20,30" Caption="Zapisi na stran : " AllItemText="Vsi">
                                                        </PageSizeItemSettings>
                                                        <Summary Visible="true" Text="Vseh zapisov : {2}" EmptyText="Ni zapisov" />
                                                    </SettingsPager>
                                                    <SettingsBehavior AllowFocusedRow="true" />
                                                    <Styles Header-Wrap="True">
                                                        <Header Paddings-PaddingTop="5" HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="true"></Header>
                                                        <FocusedRow BackColor="#d1e6fe" Font-Bold="true" ForeColor="#606060"></FocusedRow>
                                                    </Styles>
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn Caption="ID" FieldName="idKontaktneOsebe" Width="80px"
                                                            ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="1" Visible="false">
                                                        </dx:GridViewDataTextColumn>

                                                        <dx:GridViewDataTextColumn Caption="Stranka"
                                                            FieldName="Stranka" ShowInCustomizationForm="True"
                                                            VisibleIndex="2" Width="25%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Naziv"
                                                            FieldName="NazivKontaktneOsebe" ShowInCustomizationForm="True"
                                                            VisibleIndex="3" Width="25%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Telefon"
                                                            FieldName="Telefon" ShowInCustomizationForm="True"
                                                            VisibleIndex="4" Width="12%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="GSM"
                                                            FieldName="GSM" ShowInCustomizationForm="True"
                                                            VisibleIndex="5" Width="12%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Email"
                                                            FieldName="Email" ShowInCustomizationForm="True"
                                                            VisibleIndex="6" Width="15%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Delovno mesto"
                                                            FieldName="DelovnoMesto" ShowInCustomizationForm="True"
                                                            VisibleIndex="7" Width="12%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Zap. stev."
                                                            FieldName="ZaporednaStevika" ShowInCustomizationForm="True"
                                                            VisibleIndex="8" Width="170px" Visible="false">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataDateColumn Caption="Datum vpisa"
                                                            FieldName="ts" ShowInCustomizationForm="True"
                                                            VisibleIndex="9" Width="105px" Visible="false">
                                                            <PropertiesDateEdit DisplayFormatString="dd.MM.yyyy - HH:mm"></PropertiesDateEdit>
                                                            <CellStyle HorizontalAlign="Right"></CellStyle>
                                                        </dx:GridViewDataDateColumn>
                                                        <dx:GridViewDataTextColumn Caption="Oseba vnosa"
                                                            FieldName="tsIDOsebe" ShowInCustomizationForm="True"
                                                            VisibleIndex="10" Width="150px" Visible="false">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                                <dx:ASPxPopupControl ID="ASPxPopupControlContactPerson" runat="server" ContentUrl="ContactPerson_popup.aspx"
                                                    ClientInstanceName="clientPopUpContactPerson" Modal="True" HeaderText="DODAJ KONTAKTNO OSEBO"
                                                    Theme="MetropolisBlue" CloseAction="CloseButton" Width="635px" Height="445px" PopupHorizontalAlign="WindowCenter"
                                                    PopupVerticalAlign="WindowCenter" PopupAnimationType="Fade" AllowDragging="true" ShowSizeGrip="true"
                                                    AllowResize="true">
                                                    <ContentStyle BackColor="#F7F7F7">
                                                        <Paddings PaddingBottom="0px" PaddingLeft="6px" PaddingRight="0px" PaddingTop="0px"></Paddings>
                                                    </ContentStyle>
                                                    <ContentCollection>
                                                        <dx:PopupControlContentControl ID="PopupControlContentControl1" runat="server">
                                                        </dx:PopupControlContentControl>
                                                    </ContentCollection>
                                                </dx:ASPxPopupControl>
                                                <div class="AddEditButtonsWrap">
                                                    <div class="DeleteButtonElements">
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btndeleteContactPerson" runat="server" Text="Izbriši" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnDeleteContactPerson">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/trashForPopUp.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                    </div>
                                                    <div class="AddEditButtonsElements">
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnAddContactPerson" runat="server" Text="Dodaj" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnAddContactPerson">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/addForPopUp.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnEditContactPerson" runat="server" Text="Spremeni" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnEditContactPerson">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/editForPopup.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                    </div>
                                                </div>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxCallbackPanel>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Name="Events" Text="DOGODKI">
                            <ContentCollection>
                                <dx:ContentControl>
                                    <dx:ASPxCallbackPanel ID="EventsCallback" runat="server" ClientInstanceName="clientEventsCallback" OnCallback="EventsCallback_Callback">
                                        <PanelCollection>
                                            <dx:PanelContent>
                                                <dx:ASPxGridView ID="ASPxGridViewEvents" runat="server" AutoGenerateColumns="False"
                                                    EnableTheming="True" EnableCallbackCompression="true" ClientInstanceName="gridEvents"
                                                    Theme="Moderno" Width="100%" KeyboardSupport="true" AccessKey="G"
                                                    KeyFieldName="idDogodek" OnDataBinding="ASPxGridViewEvents_DataBinding"
                                                    Paddings-PaddingTop="0" Paddings-PaddingBottom="0"
                                                    CssClass="gridview-no-header-padding" PreviewFieldName="Opis">
                                                    <ClientSideEvents RowDblClick="PlanPopUpShow" />
                                                    <Settings ShowVerticalScrollBar="True" VerticalScrollableHeight="400"
                                                        ShowHorizontalScrollBar="True" ShowFilterBar="Auto" ShowFilterRow="True"
                                                        ShowFilterRowMenu="True" VerticalScrollBarStyle="Standard"
                                                        ShowPreview="true" />
                                                    <Styles>
                                                        <PreviewRow BackColor="#fafafa" CssClass="no-top-bottom-padding"></PreviewRow>
                                                    </Styles>
                                                    <SettingsPager PageSize="10" ShowNumericButtons="true">
                                                        <PageSizeItemSettings Visible="true" Items="10,20,30" Caption="Zapisi na stran : " AllItemText="Vsi">
                                                        </PageSizeItemSettings>
                                                        <Summary Visible="true" Text="Vseh zapisov : {2}" EmptyText="Ni zapisov" />
                                                    </SettingsPager>
                                                    <SettingsBehavior AllowFocusedRow="true" />
                                                    <Styles Header-Wrap="True">
                                                        <Header Paddings-PaddingTop="5" HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="true"></Header>
                                                        <FocusedRow BackColor="#d1e6fe" Font-Bold="true" ForeColor="#606060"></FocusedRow>
                                                    </Styles>
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn Caption="ID" FieldName="idDogodek" Width="80px"
                                                            ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="1" Visible="false">
                                                        </dx:GridViewDataTextColumn>

                                                        <dx:GridViewDataTextColumn Caption="Stranka"
                                                            FieldName="Stranka" ShowInCustomizationForm="True"
                                                            VisibleIndex="2" Width="25%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Kategorija"
                                                            FieldName="Kategorija" ShowInCustomizationForm="True"
                                                            VisibleIndex="3" Width="15%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Nadrejeni"
                                                            FieldName="OsebeSkrbnik" ShowInCustomizationForm="True"
                                                            VisibleIndex="4" Width="170px" Visible="false">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Skrbnik"
                                                            FieldName="OsebeIzvajalec" ShowInCustomizationForm="True"
                                                            VisibleIndex="5" Width="20%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Status"
                                                            FieldName="StatusDogodek" ShowInCustomizationForm="True"
                                                            VisibleIndex="6" Width="20%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Opis"
                                                            FieldName="Opis" ShowInCustomizationForm="True"
                                                            VisibleIndex="7" Width="170px" Visible="false">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataDateColumn Caption="Datum otvoritve"
                                                            FieldName="DatumOtvoritve" ShowInCustomizationForm="True"
                                                            VisibleIndex="8" Width="10%">
                                                            <PropertiesDateEdit DisplayFormatString="dd.MM.yyyy"></PropertiesDateEdit>
                                                            <CellStyle HorizontalAlign="Right"></CellStyle>
                                                        </dx:GridViewDataDateColumn>
                                                        <dx:GridViewDataDateColumn Caption="Rok"
                                                            FieldName="Rok" ShowInCustomizationForm="True"
                                                            VisibleIndex="9" Width="10%">
                                                            <PropertiesDateEdit DisplayFormatString="dd.MM.yyyy"></PropertiesDateEdit>
                                                            <CellStyle HorizontalAlign="Right"></CellStyle>
                                                        </dx:GridViewDataDateColumn>
                                                        <dx:GridViewDataDateColumn Caption="Datum zad. zaprtja"
                                                            FieldName="DatumZadZaprtja" ShowInCustomizationForm="True"
                                                            VisibleIndex="10" Width="105px" Visible="false">
                                                            <PropertiesDateEdit DisplayFormatString="dd.MM.yyyy"></PropertiesDateEdit>
                                                            <CellStyle HorizontalAlign="Right"></CellStyle>
                                                        </dx:GridViewDataDateColumn>
                                                        <dx:GridViewDataTextColumn Caption="Oseba vnosa"
                                                            FieldName="tsIDOsebe" ShowInCustomizationForm="True"
                                                            VisibleIndex="11" Width="150px" Visible="false">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                                <div class="AddEditButtonsWrap">
                                                    <div class="DeleteButtonElements">
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnDeleteEvent" runat="server" Text="Izbriši" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnDeleteEvents">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/trashForPopUp.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                    </div>
                                                    <div class="AddEditButtonsElements">
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnAddEvent" runat="server" Text="Dodaj" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnAddEvent">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/addForPopUp.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnEditEvent" runat="server" Text="Spremeni" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnEditEvent">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/editForPopup.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                    </div>
                                                </div>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                        <ClientSideEvents EndCallback="function(s,e){ EndCallbackValidation(s,e); }" />
                                    </dx:ASPxCallbackPanel>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Name="Notes" Text="OPOMBE">
                            <ContentCollection>
                                <dx:ContentControl>
                                    <dx:ASPxCallbackPanel ID="NotesCallback" runat="server" ClientInstanceName="clientNotesCallback" OnCallback="NotesCallback_Callback">
                                        <PanelCollection>
                                            <dx:PanelContent>
                                                <dx:ASPxGridView ID="ASPxGridViewNotes" runat="server" AutoGenerateColumns="False"
                                                    EnableTheming="True" EnableCallbackCompression="true" ClientInstanceName="gridNotes"
                                                    Theme="Moderno" Width="100%" KeyboardSupport="true" AccessKey="G"
                                                    KeyFieldName="idOpombaStranka" OnDataBinding="ASPxGridViewNotes_DataBinding"
                                                    Paddings-PaddingTop="0" Paddings-PaddingBottom="0"
                                                    CssClass="gridview-no-header-padding">
                                                    <ClientSideEvents RowDblClick="PlanPopUpShow" />
                                                    <Settings ShowVerticalScrollBar="True" VerticalScrollableHeight="400"
                                                        ShowHorizontalScrollBar="True" ShowFilterBar="Auto" ShowFilterRow="True"
                                                        ShowFilterRowMenu="True" VerticalScrollBarStyle="Standard" />
                                                    <SettingsPager PageSize="10" ShowNumericButtons="true">
                                                        <PageSizeItemSettings Visible="true" Items="10,20,30" Caption="Zapisi na stran : " AllItemText="Vsi">
                                                        </PageSizeItemSettings>
                                                        <Summary Visible="true" Text="Vseh zapisov : {2}" EmptyText="Ni zapisov" />
                                                    </SettingsPager>
                                                    <SettingsBehavior AllowFocusedRow="true" />
                                                    <Styles Header-Wrap="True">
                                                        <Header Paddings-PaddingTop="5" HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="true"></Header>
                                                        <FocusedRow BackColor="#d1e6fe" Font-Bold="true" ForeColor="#606060"></FocusedRow>
                                                    </Styles>
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn Caption="ID" FieldName="idOpombaStranka" Width="80px"
                                                            ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="1"
                                                            Visible="false">
                                                        </dx:GridViewDataTextColumn>

                                                        <dx:GridViewDataTextColumn Caption="Stranka"
                                                            FieldName="Stranka" ShowInCustomizationForm="True"
                                                            VisibleIndex="2" Width="25%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Opomba"
                                                            FieldName="Opomba" ShowInCustomizationForm="True" PropertiesTextEdit-EncodeHtml ="false"
                                                            VisibleIndex="4" Width="65%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>                                                       
                                                        <dx:GridViewDataDateColumn Caption="Datum vpisa"
                                                            FieldName="ts" ShowInCustomizationForm="True"
                                                            VisibleIndex="9" Width="120px" Visible="false">
                                                            <PropertiesDateEdit DisplayFormatString="dd.MM.yyyy - HH:mm"></PropertiesDateEdit>
                                                            <CellStyle HorizontalAlign="Right"></CellStyle>
                                                        </dx:GridViewDataDateColumn>
                                                        <dx:GridViewDataTextColumn Caption="Oseba vnosa"
                                                            FieldName="tsIDOsebe" ShowInCustomizationForm="True"
                                                            VisibleIndex="10" Width="100px" Visible="false">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                                <dx:ASPxPopupControl ID="ASPxPopupControlNotes" runat="server" ContentUrl="Notes_popup.aspx"
                                                    ClientInstanceName="clientPopUpNotes" Modal="True" HeaderText="DODAJ OPOMBO"
                                                    Theme="MetropolisBlue" CloseAction="CloseButton" Width="750px" Height="600px" PopupHorizontalAlign="WindowCenter"
                                                    PopupVerticalAlign="WindowCenter" PopupAnimationType="Fade" AllowDragging="true" ShowSizeGrip="true"
                                                    AllowResize="true">
                                                    <ContentStyle BackColor="#F7F7F7">
                                                        <Paddings PaddingBottom="0px" PaddingLeft="6px" PaddingRight="0px" PaddingTop="0px"></Paddings>
                                                    </ContentStyle>
                                                    <ContentCollection>
                                                        <dx:PopupControlContentControl ID="PopupControlContentControl4" runat="server">
                                                        </dx:PopupControlContentControl>
                                                    </ContentCollection>
                                                </dx:ASPxPopupControl>
                                                <div class="AddEditButtonsWrap">
                                                    <div class="DeleteButtonElements">
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnDeleteNotes" runat="server" Text="Izbriši" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnDeleteNotes">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/trashForPopUp.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                    </div>
                                                    <div class="AddEditButtonsElements">
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnAddNotese" runat="server" Text="Dodaj" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnAddNotes">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/addForPopUp.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnEditNotes" runat="server" Text="Spremeni" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnEditNotes">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/editForPopup.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                    </div>
                                                </div>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxCallbackPanel>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Name="Device" Text="NAPRAVE">
                            <ContentCollection>
                                <dx:ContentControl>
                                    <dx:ASPxCallbackPanel ID="DeviceCallback" runat="server" ClientInstanceName="clientDeviceCallback" OnCallback="DeviceCallback_Callback">
                                        <PanelCollection>
                                            <dx:PanelContent>
                                                <dx:ASPxGridView ID="ASPxGridViewDevice" runat="server" AutoGenerateColumns="False"
                                                    EnableTheming="True" EnableCallbackCompression="true" ClientInstanceName="gridDevice"
                                                    Theme="Moderno" Width="100%" KeyboardSupport="true" AccessKey="G"
                                                    KeyFieldName="idNaprava" OnDataBinding="ASPxGridViewDevice_DataBinding"
                                                    Paddings-PaddingTop="0" Paddings-PaddingBottom="0"
                                                    CssClass="gridview-no-header-padding">
                                                    <ClientSideEvents RowDblClick="PlanPopUpShow" />
                                                    <Settings ShowVerticalScrollBar="True" VerticalScrollableHeight="400"
                                                        ShowHorizontalScrollBar="True" ShowFilterBar="Auto" ShowFilterRow="True"
                                                        ShowFilterRowMenu="True" VerticalScrollBarStyle="Standard" />
                                                    <SettingsPager PageSize="10" ShowNumericButtons="true">
                                                        <PageSizeItemSettings Visible="true" Items="10,20,30" Caption="Zapisi na stran : " AllItemText="Vsi">
                                                        </PageSizeItemSettings>
                                                        <Summary Visible="true" Text="Vseh zapisov : {2}" EmptyText="Ni zapisov" />
                                                    </SettingsPager>
                                                    <SettingsBehavior AllowFocusedRow="true" />
                                                    <Styles Header-Wrap="True">
                                                        <Header Paddings-PaddingTop="5" HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="true"></Header>
                                                        <FocusedRow BackColor="#d1e6fe" Font-Bold="true" ForeColor="#606060"></FocusedRow>
                                                    </Styles>
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn Caption="ID" FieldName="idNaprava" Width="80px"
                                                            ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="1"
                                                            Visible="false">
                                                        </dx:GridViewDataTextColumn>

                                                        <dx:GridViewDataTextColumn Caption="Stranka"
                                                            FieldName="Stranka" ShowInCustomizationForm="True"
                                                            VisibleIndex="2" Width="25%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Koda"
                                                            FieldName="Koda" ShowInCustomizationForm="True"
                                                            VisibleIndex="3" Width="100px" Visible="false">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Naziv"
                                                            FieldName="Naziv" ShowInCustomizationForm="True"
                                                            VisibleIndex="4" Width="25%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Opis"
                                                            FieldName="Opis" ShowInCustomizationForm="True"
                                                            VisibleIndex="5" Width="50%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataDateColumn Caption="Datum vpisa"
                                                            FieldName="ts" ShowInCustomizationForm="True"
                                                            VisibleIndex="9" Width="120px" Visible="false">
                                                            <PropertiesDateEdit DisplayFormatString="dd.MM.yyyy - HH:mm"></PropertiesDateEdit>
                                                            <CellStyle HorizontalAlign="Right"></CellStyle>
                                                        </dx:GridViewDataDateColumn>
                                                        <dx:GridViewDataTextColumn Caption="Oseba vnosa"
                                                            FieldName="tsIDOsebe" ShowInCustomizationForm="True"
                                                            VisibleIndex="10" Width="100px" Visible="false">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                                <dx:ASPxPopupControl ID="ASPxPopupControlDevice" runat="server" ContentUrl="Device_popup.aspx"
                                                    ClientInstanceName="clientPopUpDevice" Modal="True" HeaderText="DODAJ NAPRAVO"
                                                    Theme="MetropolisBlue" CloseAction="CloseButton" Width="635px" Height="355px" PopupHorizontalAlign="WindowCenter"
                                                    PopupVerticalAlign="WindowCenter" PopupAnimationType="Fade" AllowDragging="true" ShowSizeGrip="true"
                                                    AllowResize="true">
                                                    <ContentStyle BackColor="#F7F7F7">
                                                        <Paddings PaddingBottom="0px" PaddingLeft="6px" PaddingRight="0px" PaddingTop="0px"></Paddings>
                                                    </ContentStyle>
                                                    <ContentCollection>
                                                        <dx:PopupControlContentControl ID="PopupControlContentControl2" runat="server">
                                                        </dx:PopupControlContentControl>
                                                    </ContentCollection>
                                                </dx:ASPxPopupControl>
                                                <div class="AddEditButtonsWrap">
                                                    <div class="DeleteButtonElements">
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnDeleteDevice" runat="server" Text="Izbriši" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnDeleteDevice">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/trashForPopUp.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                    </div>
                                                    <div class="AddEditButtonsElements">
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnAddDevice" runat="server" Text="Dodaj" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnAddDevice">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/addForPopUp.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnEditDevice" runat="server" Text="Spremeni" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnEditDevice">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/editForPopup.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                    </div>
                                                </div>
                                            </dx:PanelContent>
                                        </PanelCollection>
                                    </dx:ASPxCallbackPanel>
                                </dx:ContentControl>
                            </ContentCollection>
                        </dx:TabPage>
                        <dx:TabPage Name="Categorie" Text="KATEGORIJE">
                            <ContentCollection>
                                <dx:ContentControl>

                                    <dx:ASPxCallbackPanel ID="CategorieCallback" runat="server" ClientInstanceName="clientCategorieCallback" OnCallback="CategorieCallback_Callback">
                                        <PanelCollection>
                                            <dx:PanelContent>
                                                <dx:ASPxGridView ID="ASPxGridViewCategorie" runat="server" AutoGenerateColumns="False"
                                                    EnableTheming="True" EnableCallbackCompression="true" ClientInstanceName="gridCategorie"
                                                    Theme="Moderno" Width="100%" KeyboardSupport="true" AccessKey="G"
                                                    KeyFieldName="idStrankaKategorija" OnDataBinding="ASPxGridViewCategorie_DataBinding"
                                                    Paddings-PaddingTop="0" Paddings-PaddingBottom="0"
                                                    CssClass="gridview-no-header-padding">
                                                    <ClientSideEvents RowDblClick="PlanPopUpShow" />
                                                    <Settings ShowVerticalScrollBar="True" VerticalScrollableHeight="400"
                                                        ShowHorizontalScrollBar="True" ShowFilterBar="Auto" ShowFilterRow="True"
                                                        ShowFilterRowMenu="True" VerticalScrollBarStyle="Standard" />
                                                    <SettingsPager PageSize="10" ShowNumericButtons="true">
                                                        <PageSizeItemSettings Visible="true" Items="10,20,30" Caption="Zapisi na stran : " AllItemText="Vsi">
                                                        </PageSizeItemSettings>
                                                        <Summary Visible="true" Text="Vseh zapisov : {2}" EmptyText="Ni zapisov" />
                                                    </SettingsPager>
                                                    <SettingsBehavior AllowFocusedRow="true" />
                                                    <Styles Header-Wrap="True">
                                                        <Header Paddings-PaddingTop="5" HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="true"></Header>
                                                        <FocusedRow BackColor="#d1e6fe" Font-Bold="true" ForeColor="#606060"></FocusedRow>
                                                    </Styles>
                                                    <Columns>
                                                        <dx:GridViewDataTextColumn Caption="ID" FieldName="idKategorija" Width="80px"
                                                            ReadOnly="true" ShowInCustomizationForm="True" VisibleIndex="1" Visible="false">
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Koda"
                                                            FieldName="Koda" ShowInCustomizationForm="True"
                                                            VisibleIndex="3" Width="100px" Visible="false">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Stranka"
                                                            FieldName="Stranka" ShowInCustomizationForm="True"
                                                            VisibleIndex="4" Width="50%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataTextColumn Caption="Naziv"
                                                            FieldName="Naziv" ShowInCustomizationForm="True"
                                                            VisibleIndex="5" Width="50%">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                        <dx:GridViewDataDateColumn Caption="Datum vpisa"
                                                            FieldName="ts" ShowInCustomizationForm="True"
                                                            VisibleIndex="6" Width="150px" Visible="false">
                                                            <PropertiesDateEdit DisplayFormatString="dd.MM.yyyy"></PropertiesDateEdit>
                                                            <CellStyle HorizontalAlign="Right"></CellStyle>
                                                        </dx:GridViewDataDateColumn>
                                                        <dx:GridViewDataTextColumn Caption="Oseba vnosa"
                                                            FieldName="tsIDOseba" ShowInCustomizationForm="True"
                                                            VisibleIndex="7" Width="60px" Visible="false">
                                                            <Settings AllowAutoFilter="True" AutoFilterCondition="Contains" />
                                                        </dx:GridViewDataTextColumn>
                                                    </Columns>
                                                </dx:ASPxGridView>
                                                <dx:ASPxPopupControl ID="ASPxPopupControlCategorie" runat="server" ContentUrl="Categorie_popup.aspx"
                                                    ClientInstanceName="clientPopUpCategorie" Modal="True" HeaderText="DODAJ KATEGORIJO"
                                                    Theme="MetropolisBlue" CloseAction="CloseButton" Width="660px" Height="210px" PopupHorizontalAlign="WindowCenter"
                                                    PopupVerticalAlign="WindowCenter" PopupAnimationType="Fade" AllowDragging="true" ShowSizeGrip="true"
                                                    AllowResize="false">
                                                    <ContentStyle BackColor="#F7F7F7">
                                                        <Paddings PaddingBottom="0px" PaddingLeft="6px" PaddingRight="0px" PaddingTop="0px"></Paddings>
                                                    </ContentStyle>
                                                    <ContentCollection>
                                                        <dx:PopupControlContentControl ID="PopupControlContentControl3" runat="server">
                                                        </dx:PopupControlContentControl>
                                                    </ContentCollection>
                                                </dx:ASPxPopupControl>
                                                <div class="AddEditButtonsWrap">
                                                    <div class="DeleteButtonElements">
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnDeleteCategorie" runat="server" Text="Izbriši" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnDeleteCategorie">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/trashForPopUp.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                    </div>
                                                    <div class="AddEditButtonsElements">
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnAddCategorie" runat="server" Text="Dodaj" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnAddCategorie">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/addForPopUp.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                        <span class="AddEditButtons">
                                                            <dx:ASPxButton ID="btnEditCategorie" runat="server" Text="Spremeni" AutoPostBack="false"
                                                                Height="25" Width="90" ClientInstanceName="clientBtnEditCategorie" ClientVisible="false">
                                                                <ClientSideEvents Click="PlanPopUpShow" />
                                                                <Image Url="../../../Images/editForPopup.png"></Image>
                                                            </dx:ASPxButton>
                                                        </span>
                                                    </div>
                                                </div>
                                            </dx:PanelContent>
                                        </PanelCollection>
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
